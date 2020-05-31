package com.taoge.filesystem.repository;

import com.taoge.filesystem.entity.UploadFile;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FileRepository extends JpaRepository<UploadFile,Integer> {
}
