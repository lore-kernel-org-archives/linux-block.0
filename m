Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118FE20E31C
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661092; cv=none; b=UiAEZgWu1mYJkvN2cgpq2M+yDXlWkbbH4l8IwZoMiELx5PrNSM4riacqTryguD9Z9/T1C2iYhJcnB5iuCbGAmXTWwdPOoFkz6UVXvRK7s+lC0bnSaByb95jdr4Bz1GeYO+re/PNzVCg/GUTAOhPcxs+lGS72nXt/H7RKZsF0xD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661092; c=relaxed/simple;
	bh=O5LwPvfpq0YjRitfoT/GodeSOREFQSeNsNbJMNj4XeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fI0nKFNIBRi1tsKw4iUQsTgkZdDArkB00ifTOjZTSSonH0NHK6RQi3/ECXpIOIfdA6EaIMDjOEZtuIQtPx8LsvfZ5kQ/BbiljcUKk0jql99f7EcJWkgQ8sEhOkbvvlvP1CRgKPZPqe4/3FJbcVSBa19hJcmpbSieIX/BFR17oVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Lm6+4W4T; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Lm6+4W4T"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a08ced9a36so734935ad.2
        for <linux-block@vger.kernel.org>; Mon, 05 Jan 2026 16:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661089; x=1768265889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bChEZ5QV1bk69mFc450SD6apMVEjUAARVBTDyWj0adc=;
        b=Lm6+4W4TK61xv2pilsDlpzNY3E1QC7x7PJUyuSLv+vQwUmV+54CPtxK2EhV1od7poi
         76KgRPtcktif04Fg66whjB7VtBXfgtwY6eIJnJe19HWroMXfyeiwIMJFMRjNsDE/2GPh
         +7pRyYdHV4/d1hkQ3k4anRdOLtITaKsj4h2ezV01+B2k28bis84Rre+82rMpP6IMScrd
         90AoZnGeCCh7NvnFq4oesboH0cfantCQcQNYX8X0uBJLYoSo1g4E+1OofoXMaep6YmgK
         Sj4YlYRFbjqDnuxMnZMNp4fN9Nq9+XwFusYFFHEipVhu/6m+cYie330Z5id4oKA7bF10
         kFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661089; x=1768265889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bChEZ5QV1bk69mFc450SD6apMVEjUAARVBTDyWj0adc=;
        b=xKbp3Jv0cFReqjbeS8Tcdo8dO2TSGR9VxjBsYegq70IOsjwhPWbwRkD5wFAg65J6FC
         y6yxmzmY6zeLXi637cYgDIrwB/J4QRtYb9Ap9im8YkQidcaJ7MWkqVzvJ59mXMErlcdL
         i70TMCduCcIhw/dTnm3gKkBg6EQjEydkA2V6MEW3TgysmmtVSzWXRjYNW6QS/nUw5nu+
         BGJ4Iu5Kcg1QfxhwGYAfGYm5h1aQF0Yb4bkndtNtlv6zjYt+ISyy5g9Io6M6rKZVYiA+
         SLwctuWmxOqdIYnxhtZOC81mfxxJVnea7iMxH6UTlEO6RLAR7YxOmb8TwTqK1lhsjB68
         u6Bw==
X-Gm-Message-State: AOJu0Yz13YazxprVXtJgJXeq8peZ6vfDyOmypIWBtxsuMO/chSH/FSu6
	HlvmsNgzPTGMHHubtr4M/BF9Nv/WmHEus1jEE7gvc9T7ykFayCbzd/287uMBqcRq8lDd5CvvuJR
	N8ma9x4JQdOJV2L4MDdjmYAGWTqyH67bPDoDv
X-Gm-Gg: AY/fxX6DjTzEq/AE1geG5wJCXZ8qHz3A9ueKJFkOYsil+9G6lZiC42DwTcvSwUc4NVD
	M5XikLfzHh+SdbkmkOPQpjnK4fNwNkg1EzQbJ7VDWuEgzhl5bY9M8HUN8Z7kdCl486sPdlTIR65
	eJ+zOuY/jR+BYCVnPQ6dK1yGMQzsyUpk/J3Bje8ZFr59sII3Noea2XMeRgnDD0OxIPEV/i0AUpW
	drkaw9QHORfZo4AH3KEqUp00hPbqwoFqE8O6+h+RMO1Df7oZELYpbn/rwHSla8e+NtXoVLuRM8j
	7ddc7DgG51zp2axhEqHT0G7EdBxNhWhYjKe+cIHiJCM/tmvEBTQzX6CcwOl/STL6yzY2qYHm1Ty
	K3PaI7EuAQ2mc3kKyKs78q4MKnqfhpQWJXCGWPtA0XA==
X-Google-Smtp-Source: AGHT+IEt7v5piZcP5t5FBeU95eBGQgO16vibqCKp8Tght51rRbRk0ygbQXPn5D5FjMvVvssdzo/+nh0s9KFs
X-Received: by 2002:a17:903:3204:b0:2a0:8963:c13e with SMTP id d9443c01a7336-2a3e2e402e1mr8732335ad.7.1767661089054;
        Mon, 05 Jan 2026 16:58:09 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cae5cbsm842285ad.39.2026.01.05.16.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:09 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7FBDE3401CC;
	Mon,  5 Jan 2026 17:58:08 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 6FAC9E44554; Mon,  5 Jan 2026 17:58:08 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 04/19] ublk: set UBLK_IO_F_INTEGRITY in ublksrv_io_desc
Date: Mon,  5 Jan 2026 17:57:36 -0700
Message-ID: <20260106005752.3784925-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260106005752.3784925-1-csander@purestorage.com>
References: <20260106005752.3784925-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Indicate to the ublk server when an incoming request has integrity data
by setting UBLK_IO_F_INTEGRITY in the ublksrv_io_desc's op_flags field.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 3 +++
 include/uapi/linux/ublk_cmd.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 066c6ae062a0..2b0a9720921d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1120,10 +1120,13 @@ static inline unsigned int ublk_req_build_flags(struct request *req)
 		flags |= UBLK_IO_F_NOUNMAP;
 
 	if (req->cmd_flags & REQ_SWAP)
 		flags |= UBLK_IO_F_SWAP;
 
+	if (blk_integrity_rq(req))
+		flags |= UBLK_IO_F_INTEGRITY;
+
 	return flags;
 }
 
 static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 {
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index a54c47832fa2..c1103ad5925b 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -412,10 +412,12 @@ struct ublksrv_ctrl_dev_info {
  *
  * ublk server has to check this flag if UBLK_AUTO_BUF_REG_FALLBACK is
  * passed in.
  */
 #define		UBLK_IO_F_NEED_REG_BUF		(1U << 17)
+/* Request has an integrity data buffer */
+#define		UBLK_IO_F_INTEGRITY		(1UL << 18)
 
 /*
  * io cmd is described by this structure, and stored in share memory, indexed
  * by request tag.
  *
-- 
2.45.2

