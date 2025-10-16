import { AppError } from "../../../shared/errors/AppError";
import { PaginationParams } from "../../../shared/interfaces/PaginationParams";
import { PaginationResponse } from "../../../shared/interfaces/PaginationResponse";
import { TimeRequestDTO, TimeRequestDTOImpl } from "../dtos/TimeRequestDTO";
import { TimeResponseDTO } from "../dtos/TimeResponseDTO";
import { TimeUpdateDTO, TimeUpdateDTOImpl } from "../dtos/TimeUpdateDTO";
import { TimeRepository } from "../repositories/TimeRepository";

export class TimeService {
    private timeRepository: TimeRepository;

    constructor() {
        this.timeRepository = new TimeRepository();
    }

    async createTime(timeData: TimeRequestDTO): Promise<TimeResponseDTO> {
        const timeDTO = new TimeRequestDTOImpl(timeData);
        const time = await this.timeRepository.createTime(timeDTO);
        return time.toResponse();
    }

    async getTimeById(id: number): Promise<TimeResponseDTO> {
        const time = await this.timeRepository.findTimeById(id);

        if (!time) {
            throw new AppError("Time não encontrado", 404);
        }

        return time.toResponse();
    }

    async listTimesPaginated(
        params: PaginationParams & { curso_id?: number }
    ): Promise<PaginationResponse<TimeResponseDTO>> {
        const result = await this.timeRepository.listTimesPaginated(params);

        return {
            data: result.data.map((time) => time.toResponse()),
            pagination: result.pagination,
        };
    }

    async updateTime(
        id: number,
        timeData: TimeUpdateDTO
    ): Promise<TimeResponseDTO> {
        const timeDTO = new TimeUpdateDTOImpl(timeData);
        const time = await this.timeRepository.updateTime(id, timeDTO);
        return time.toResponse();
    }

    async deleteTime(id: number): Promise<void> {
        await this.timeRepository.deleteTime(id);
    }

    async listTimesByCurso(curso_id: number): Promise<TimeResponseDTO[]> {
        const times = await this.timeRepository.listTimesByCurso(curso_id);
        return times.map((time) => time.toResponse());
    }
}

