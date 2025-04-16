Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F781FF1C7
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765215; cv=none; b=Zz7ZjxFFguSZXMl/lFhsCjMsL7QPTpQtQaEQwhB9UGOG6PpJY8dkfcNwY4AOK67UkL7G8dPfRr90jSuxsnx57lnSwJcWDJNdmFZGexm7sAzqCwjxCs0BbtsnCqQ6KsGsuVDeaIqMlSYJYwy8vMy9yufay6/AM1+NnKs7VYz3n78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765215; c=relaxed/simple;
	bh=Cgf3ztYIvwTUzfBavcvlyHRPUbRdvIfXW7B4VyEJqiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ETkkA0xoEiYKEfZkkBg2aAjWhF2DvW/o81xwpqXAafZdHetYQQAlBzzC1ii2lCqHXSWSEN8YzITZaTiwDKgLcjhmKyZddxBWnSALFfs+FLGpzCeD49kJEcov/YmwTvfr8GUMV14yz8tZ/YK3MDRiWrJAuvzjMmZqHm8Nbkb/PvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WZVgTC0c; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WZVgTC0c"
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-af9a7717163so6406718a12.2
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 18:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744765209; x=1745370009; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dhLhuSAM50uIVAVygGan8Ma39tavmo4MC520V/vTBOA=;
        b=WZVgTC0c4yBeZvk7EPZH335fLj7RiQCswlW7NzF7iRFxMVjmftyVtTxOkk5CkOgl70
         635iwrihJsiBzh/B4vpdksW6v2N07Ymleh5ZTpQvGPe0iefNt4lx9/nOppU+9X0esGQE
         x8ZwQUXrzZkEn8o10hm0CAMgYTy0iKfQcA8JClc8qAHs8z+k7szORaUec94SFKX61RL0
         osSo3aql4PUnYG7hvVjyJYaO+CgW5iSxTZaZzKmb6essQua6vSsf99yC6EYjOjjfvsJc
         xbna00rimmwdDaIFSZ8nYJVBK+2TDARgTKi9/JnXYkiVfrlcVHZZmnpo+nO0Ohp+hpQr
         pt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744765209; x=1745370009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhLhuSAM50uIVAVygGan8Ma39tavmo4MC520V/vTBOA=;
        b=YaoD0mzt0f8VMXfqj3D0WovLpK/KhNwA13bSsYNvEpmXsQWEbiiinfv/CxWjWe6NSH
         3UgvrDt8J4OQaJ0oP2bW68NqYBqoMVuW8qmGqWgGL2ZhnNO6ykmHX1dvqRc0PnZTER9R
         Do/WuHlYxo7K7QviQOLQhvMmlzaf5qEckUXj5YyscozWxRtVQFh3hJgvBUsW6l9V3Slk
         FRfaM7z3XwO+/dT61x3ajVSMVEiE39ttRGz1YAqbsyHiSHmJz8FcIjk9bsJv0QKKD1lg
         NjM8UGZF7YVSrc34vvQwgBWq4z4ub+IG2tDNQo0JCrrXjl+P9TCo2EI2r3vxGuW55hLx
         Ahaw==
X-Gm-Message-State: AOJu0YzTvQVm9SfuXN6Rf6micG+nucoVBkfttHnYz0qi+dSDMBZGdG/K
	s6PW24zhcCpQF93hByVYlJPh796ufBCMnP6HSmD63N9RueJkbf+mYNiG4ecuOqn8Zst9pYmMDOQ
	BlCO5A61m9DSbktnV0Hf33OB7QfPE24fRkEQb2EHqdlBsX3U+
X-Gm-Gg: ASbGnctnxe3wi0bAYtR2UWSpvwqIF+/jJp0bazSsDaoeUZxIIWW7yC5R/r7S14SOWbi
	yj6BpAjFC/7mVEoJ/fNHR1PqVnrf9CFKE9ZB1haS4VPSoerTBoHw4ZVJnLCBfC0/D/S33N1i9xK
	AFOP37g65r2Vqfuw1RsVYXNEJXab1eHjYvyhVS/lo4nIosjpgs4M7YiivoKQELmxAlN0/pb6bZE
	sFCQmAbGPMe2yjw3YV/WaPyItiDzmaRMLYH0TZsKpgmY4rnkGxNy8Qzwk8xPifDqN72U5RRGf9b
	StknOOX90A5BBge7ZFMWXxcZR2jvJ1A=
X-Google-Smtp-Source: AGHT+IHMSUQChm2ODZHNSlbY2kPtq+hcH+J4hDdExeN/v+42veb6UrTGSYhbYLYnSQFVz5AVM4Ol4HrV3fQj
X-Received: by 2002:a05:6a21:3943:b0:1f5:709d:e0cb with SMTP id adf61e73a8af0-203ae07e73fmr1670790637.39.1744765208867;
        Tue, 15 Apr 2025 18:00:08 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-73bd230db52sm563876b3a.24.2025.04.15.18.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 18:00:08 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0BBA3340351;
	Tue, 15 Apr 2025 19:00:08 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 098FCE404FA; Tue, 15 Apr 2025 19:00:08 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 15 Apr 2025 18:59:39 -0600
Subject: [PATCH v4 3/4] ublk: mark ublk_queue as const for
 ublk_register_io_buf
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-ublk_task_per_io-v4-3-54210b91a46f@purestorage.com>
References: <20250415-ublk_task_per_io-v4-0-54210b91a46f@purestorage.com>
In-Reply-To: <20250415-ublk_task_per_io-v4-0-54210b91a46f@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

We now allow multiple tasks to operate on I/Os belonging to the same
queue concurrently. This means that any writes to ublk_queue in the I/O
path are potential sources of data races. Try to prevent these by
marking ublk_queue pointers as const in ublk_register_io_buf.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 153f67d92248ad45bddd2437b1306bb23df7d1ae..e2cb54895481aebaa91ab23ba05cf26a950a642f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -211,7 +211,7 @@ struct ublk_params_header {
 static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq);
 
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		struct ublk_queue *ubq, int tag, size_t offset);
+		const struct ublk_queue *ubq, int tag, size_t offset);
 static inline unsigned int ublk_req_build_flags(struct request *req);
 static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
 						   int tag);
@@ -1867,7 +1867,7 @@ static void ublk_io_release(void *priv)
 }
 
 static int ublk_register_io_buf(struct io_uring_cmd *cmd,
-				struct ublk_queue *ubq, unsigned int tag,
+				const struct ublk_queue *ubq, unsigned int tag,
 				unsigned int index, unsigned int issue_flags)
 {
 	struct ublk_device *ub = cmd->file->private_data;
@@ -2043,7 +2043,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 }
 
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		struct ublk_queue *ubq, int tag, size_t offset)
+		const struct ublk_queue *ubq, int tag, size_t offset)
 {
 	struct request *req;
 

-- 
2.34.1

