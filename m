Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95C012C49A;
	Fri, 10 May 2024 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350773; cv=none; b=RZchVjo76oJrfWg/9vaukRdP3kMhZCt3pSmv86rU8kpSrU3xXvumPSSct8dCBP9rtWwkodaX8Cr/sMvGDzCHMn23QJaEId4PF7VSgpTxvferKhFZtcX0Ta3w+mecBU+BK3zcRCBZHi6S6w2QhjXl/q80hlNDPjMj3cNZbG9GnXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350773; c=relaxed/simple;
	bh=newQCvWV+mjWNXmeoKW+7Ew4D+G40srMa+qnHqyJpPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZvNM7qxRITzWjugp510zv7oG4RrYGX2Du15ABqDmSZlfSR52fgacsWJ8yXDIKsJpS3eHRv0PM2qYnGF6Kf5DDDa5Ra9hYpZv8CHG+Aof3YB/rbJ+FjFm4YankEvFLoFyV3h9Dh5P+wvz8f2I9HZpHtpwBaWwJxO0acGvndydBKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a599c55055dso543918666b.0;
        Fri, 10 May 2024 07:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715350770; x=1715955570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/vuO/zF0nk4/qRM0ktl9UYaYpOxkO1/l3hwbHep5lU=;
        b=bhdP7Kemw5T9BreQtxSgeVuCIIFR7lXiF1OqyDq844+2zWws3qzFjStiPV/u5WCfHQ
         AJECFrZGYQHZu82fZyQL5rShSydyfVXJt7LS7WJkrc1eVDiH6QnHoZkWZrlyGu/jDmrp
         8AaMG0H5eAsvgy/ZbxTBZnrtIlyKAzbj5/oiFvxq+C5IPFGu1FQQT1Lm1sJw+5o72u8+
         yF9fwsw3fnBKHfAPhR20x9DEntMUZbyibUsr7MfrW2H6So5e/El4zu/dwCSbDQKk7mQJ
         hx2YEyU/dcOjbcLVPdtGevSnUTagSpxW1o2kC/mcCj2kM+HEavwxGwLDW7Be8f6UHNeo
         7yNw==
X-Forwarded-Encrypted: i=1; AJvYcCXvlWSJu2imlzkNfRqcB5wl/4g/7qzIZ75nhx2lgaFVPuqqCZQKb+CBu8K+Tt68FT/VGvB3rtzeedjnPzRlzSjmyNpSB+fiERZ5CuhnKv/uE0Osoyrl3xxNZoLYGX3O294JN9Zf6XWFQ4I=
X-Gm-Message-State: AOJu0YxVNi71i54q2LL/O7a0s6T1C5CaGXBA5Fsaflzrzf03bVHu3kzU
	R+V8hcgm9+chaJJUeoa8P6Wgvr8HLCRrqwd2pnWCkVNAQqyJ+RnB/V3Ssg==
X-Google-Smtp-Source: AGHT+IGnjR4KZ126pgrTPbaO/0dubCriY4THPHAO1wgEiXaH5zk5Wi8UgRlR0jdf5cY7TcpgoTkozQ==
X-Received: by 2002:a17:907:2d86:b0:a5a:423:a69f with SMTP id a640c23a62f3a-a5a2d53b9bemr222480766b.9.1715350769984;
        Fri, 10 May 2024 07:19:29 -0700 (PDT)
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cdb5sm189508866b.29.2024.05.10.07.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 07:19:29 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: paulmck@kernel.org,
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] block: Annotate a racy read in blk_do_io_stat()
Date: Fri, 10 May 2024 07:19:18 -0700
Message-ID: <20240510141921.883231-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

KCSAN has reported a potential data race in blk_mq subsystem where
reading the rq->flag.

	BUG: KCSAN: data-race in __blk_mq_end_request / blk_mq_check_inflight

	read-write to 0xffff888120514d1c of 4 bytes by interrupt on cpu 6:
	__blk_mq_end_request (block/blk-mq.c:700 block/blk-mq.c:1040)
	scsi_end_request (drivers/scsi/scsi_lib.c:667)
	scsi_io_completion (drivers/scsi/scsi_lib.c:1068)
	scsi_finish_command (drivers/scsi/scsi.c:199)
	scsi_complete (drivers/scsi/scsi_lib.c:?)
	blk_done_softirq (block/blk-mq.c:? block/blk-mq.c:1134)
	handle_softirqs (./arch/x86/include/asm/jump_label.h:27
			 ./include/linux/jump_label.h:207
			 ./include/trace/events/irq.h:142 kernel/softirq.c:555)
	__irq_exit_rcu (kernel/softirq.c:617 kernel/softirq.c:639)
	irq_exit_rcu (kernel/softirq.c:651)
	common_interrupt (arch/x86/kernel/irq.c:247)
	asm_common_interrupt (./arch/x86/include/asm/idtentry.h:693)
	cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
	cpuidle_enter (drivers/cpuidle/cpuidle.c:388)
	do_idle (kernel/sched/idle.c:155 kernel/sched/idle.c:236
		 kernel/sched/idle.c:332)
	cpu_startup_entry (kernel/sched/idle.c:429)
	start_secondary (arch/x86/kernel/smpboot.c:313)
	common_startup_64 (arch/x86/kernel/head_64.S:421)

	read to 0xffff888120514d1c of 4 bytes by task 9106 on cpu 51:
	blk_mq_check_inflight (block/blk.h:356 block/blk-mq.c:94)
	14:06:18 bt_iter (block/blk-mq-tag.c:292)
	sbitmap_for_each_set (./include/linux/sbitmap.h:284
			 ./include/linux/sbitmap.h:302)
	blk_mq_queue_tag_busy_iter (block/blk-mq-tag.c:? block/blk-mq-tag.c:533)
	blk_mq_in_flight (block/blk-mq.c:109)
	diskstats_show (block/genhd.c:?)
	seq_read_iter (fs/seq_file.c:?)
	proc_reg_read_iter (fs/proc/inode.c:299)
	vfs_read (fs/read_write.c:396 fs/read_write.c:476)
	ksys_read (fs/read_write.c:619)
	__x64_sys_read (fs/read_write.c:627)
	x64_sys_call (arch/x86/entry/syscall_64.c:33)
	do_syscall_64 (arch/x86/entry/common.c:?)
	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

	value changed: 0x00022382 -> 0x00022182

Discussing it with Jens Axboe and Pavel Begunkov, they suggested we just
want to annotated this with data_race(), since disk statistic reading
isn't critical, and it will not be a big deal if this bit is not stable.

Suggested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 block/blk.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk.h b/block/blk.h
index d9f584984bc4..57a1d73a0718 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -353,7 +353,8 @@ int blk_dev_init(void);
  */
 static inline bool blk_do_io_stat(struct request *rq)
 {
-	return (rq->rq_flags & RQF_IO_STAT) && !blk_rq_is_passthrough(rq);
+	/* Disk stats reading isn’t critical, let it race */
+	return (data_race(rq->rq_flags) & RQF_IO_STAT) && !blk_rq_is_passthrough(rq);
 }
 
 void update_io_ticks(struct block_device *part, unsigned long now, bool end);
-- 
2.43.0

