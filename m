Received: from mail-wr1-f98.google.com (mail-wr1-f98.google.com [209.85.221.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEEF2868B5
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250721; cv=none; b=RZGeKGII+PmMKadYCtLusxSfDVgz6fWGEXjVX6MNxT7/PIDd9TcSi6xkGDlZq9pY4LoK1mx1ipXm04g9c/svGV1oos8Rxx4XrS33/89ALfbbLxMatXsnO5459fbHmRmWjZ0ZscTIqwCLwJDw15dVWe+VN15spXoirmEqwtJZrBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250721; c=relaxed/simple;
	bh=5e89GXt6DhKyASePnDrD7cthV1505P8u/yKg4DMfB4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCG31xguoUOcJK/xoR5AJtzFm9mX1DeNNdfizCOgTZCAWGg8Ecl78WJYVIT6NqhOIhHdpYTj0LxKPxxkkg2glPbPXTRjfvgRQwGQ0qv5MG1na0FkZAtcF4lTaeIlS0y/OKHvLiFrgM6Y3lUYS+2BcWTHdhfypqWJV4Tk9qodROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ce2+7RrS; arc=none smtp.client-ip=209.85.221.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ce2+7RrS"
Received: by mail-wr1-f98.google.com with SMTP id ffacd0b85a97d-42702037a01so199959f8f.3
        for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761250716; x=1761855516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96BiLrpc0TjSBBUxSZ5BCVjSp2BMxOcWJzQbIZwxLNw=;
        b=Ce2+7RrSDt64qEdAiiM7W8oVRbhsCRxQmw6H+uO9r++8Jr5zF+3c14fhcDeUAUICoY
         8pm039TwNICcmH3sYwyzHtfckVKK9jwA+KS7HWIhMfpEOi90tFh3SNTKj0uwDp376Fmh
         uQThz9o+7YgS/FO7HkZ+AIQL91Ce3Uztgwh3JFnHZ1cPq7PwFpCz76sO63MRY2A0Rf9s
         3hfu8oOr6voaDXiwXUrsQrXwVRZWsqMBubzlBHs2bzloDsRe1q+kJS7P0MndMMgC+d7q
         5LLoD6TlqlHtfsxfzQ5Qnlgt/b1Poh1nlMV0zX/ImVmCMgsN0/UXAx4tuCiX52RkCuQ+
         7sCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250716; x=1761855516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96BiLrpc0TjSBBUxSZ5BCVjSp2BMxOcWJzQbIZwxLNw=;
        b=xSJjRfy4i4OPU+j2rEa2QAN6L2h1NdztxmC7Atjt13AKNj6Kco39MG8ZCO+qTS05Nz
         5fFA7qYAWSpG/O1i5BOjzoqAr7smz41tZrFEwGgoqX9/548OH+g8LpiD644yjTYMsa0V
         zyGrHF3wvqs6UWq66nCABaw8Ne4vIxahluWBOw4gJUo+vKqMeT6zYVSr7BdU45/8htjS
         NtourwtNL18wxK+46fgo50GRsamPHjxB4OADj8m9/oNjgGpCdR5MrGJXJzgBr/+6Wgqs
         43FQSD7n75ZXrRdO+QB0E33tycu4E85Oroig7hGBmV1W9al/qzJoh7CQpg+EKLqYzAuj
         6wMA==
X-Forwarded-Encrypted: i=1; AJvYcCV3ufNBDcRXEV8eL0gCLVjGHRCytvan+dnxh0GZTAgn7wisd9JulP0GrCUFG1UcSe3S0zCdJTQiUEQbew==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQAsUxNhcJYdJ78LZq0E/ZkaTahjEQIE2TrBJ146UgkpdEHv91
	9UWXu80EYW03jGYphvY1LIH8CVY38RMFmiAuZEO+RCxNskhu9U99jGTParybKgKZcH5U4uv8Cgo
	luWrY82aVCr41Fbeb4UyKPZ75H68gJC2KXIxTA86NudESo8Cqow2w
X-Gm-Gg: ASbGncu/ueD/t2OkFEqRXrSCzny05dI4cTR7L/LojNdNBOmTNSNAhaFeqxzvwL//jsC
	RDm5SvEcFsbA5XaKULCPvz1SxCOYg0Vr9yhvu2rf160cRI8yENn1zxml+1JL4owORfP9ZTPMUQh
	F1/JxblPwdKuB3gSq2w5fMJgreeOM4ankAtv1Dr4wAJM2oxPLBqTGXpSNvcCclA8OdQTI/mQrX9
	S7a1UKF9G8dL2nLiE/8W8AWSS8D6nHyvV0YpwaHQXdyo78Il/TJnkfZHwVTUzYOgn1IFUHmESpk
	HA/eCG+sZ5ahGh5LSFtnpgPWd7TMqgx0KwgNGo1uuBcaAoMR1mZDO1JOtYU+1CdCSUrEujiqQxj
	+CeP6uWsqYNo+Cdxd
X-Google-Smtp-Source: AGHT+IHWadkx9kp6MhgZHi2KvIKXfztJZsFFBsc7zE5C/VRcCJIv9FwFI0VQ0GJaihcf27tHQSLLkNs29ZhV
X-Received: by 2002:a05:6000:290e:b0:426:ff0e:b563 with SMTP id ffacd0b85a97d-4284e52d956mr4357297f8f.3.1761250716288;
        Thu, 23 Oct 2025 13:18:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-429898e70easm248962f8f.38.2025.10.23.13.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:18:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id EBE47340772;
	Thu, 23 Oct 2025 14:18:33 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E9B1BE41B1D; Thu, 23 Oct 2025 14:18:33 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/3] io_uring: expose io_should_terminate_tw()
Date: Thu, 23 Oct 2025 14:18:28 -0600
Message-ID: <20251023201830.3109805-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251023201830.3109805-1-csander@purestorage.com>
References: <20251023201830.3109805-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A subsequent commit will call io_should_terminate_tw() from an inline
function in include/linux/io_uring/cmd.h, so move it from an io_uring
internal header to include/linux/io_uring.h. Callers outside io_uring
should not call it directly.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/io_uring.h | 14 ++++++++++++++
 io_uring/io_uring.h      | 13 -------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 85fe4e6b275c..c2a12287b821 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -1,13 +1,27 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef _LINUX_IO_URING_H
 #define _LINUX_IO_URING_H
 
+#include <linux/io_uring_types.h>
 #include <linux/sched.h>
 #include <linux/xarray.h>
 #include <uapi/linux/io_uring.h>
 
+/*
+ * Terminate the request if either of these conditions are true:
+ *
+ * 1) It's being executed by the original task, but that task is marked
+ *    with PF_EXITING as it's exiting.
+ * 2) PF_KTHREAD is set, in which case the invoker of the task_work is
+ *    our fallback task_work.
+ */
+static inline bool io_should_terminate_tw(struct io_ring_ctx *ctx)
+{
+	return (current->flags & (PF_KTHREAD | PF_EXITING)) || percpu_ref_is_dying(&ctx->refs);
+}
+
 #if defined(CONFIG_IO_URING)
 void __io_uring_cancel(bool cancel_all);
 void __io_uring_free(struct task_struct *tsk);
 void io_uring_unreg_ringfd(void);
 const char *io_uring_get_opcode(u8 opcode);
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 46d9141d772a..78777bf1ea4b 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -556,23 +556,10 @@ static inline bool io_allowed_run_tw(struct io_ring_ctx *ctx)
 {
 	return likely(!(ctx->flags & IORING_SETUP_DEFER_TASKRUN) ||
 		      ctx->submitter_task == current);
 }
 
-/*
- * Terminate the request if either of these conditions are true:
- *
- * 1) It's being executed by the original task, but that task is marked
- *    with PF_EXITING as it's exiting.
- * 2) PF_KTHREAD is set, in which case the invoker of the task_work is
- *    our fallback task_work.
- */
-static inline bool io_should_terminate_tw(struct io_ring_ctx *ctx)
-{
-	return (current->flags & (PF_KTHREAD | PF_EXITING)) || percpu_ref_is_dying(&ctx->refs);
-}
-
 static inline void io_req_queue_tw_complete(struct io_kiocb *req, s32 res)
 {
 	io_req_set_res(req, res, 0);
 	req->io_task_work.func = io_req_task_complete;
 	io_req_task_work_add(req);
-- 
2.45.2

