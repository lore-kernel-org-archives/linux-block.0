Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6A01547C0
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744832780; cv=none; b=SIvZEsagknb0nFq3+60Igd9iq2Ca/p79CTELnfpWFkNQaF4GFRaX8qipFN1N0kqU/C++EFqYIuSlA+pcKtpuUdoQgHjsj/ioEUQ5lKeXxDVSCoeWdivkieis2SqkmIoXqRX4mfK8rQKZfP0I2UZRfsBFqnEwy/BdPaJu5FZB3nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744832780; c=relaxed/simple;
	bh=KZyqYa2QO8C5zOaR5Qlffvttg9elvID00aTwi/drGnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ECdoJds/NNPD6r7vvkxbBINWDGS0fVtq9635qS9U9Rqih8HgTzPSbSnuKFOWXBbj3HnJ7FtE2nTu16e+Kd9L1wwKIvjYH5PcR1GHcXdeDZFg53dhaWV9vM/bnCflwQS5tqTOj2Ze5qPbakStxHvDhT0KldjibOt4zEs+YN0d/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HL1tspZ7; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HL1tspZ7"
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-6e8f06e13a4so11233736d6.0
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744832778; x=1745437578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5FSkTMVQKVF8+T3ftLHZwHo1bf1YTsSlwi8hM6dxAd4=;
        b=HL1tspZ7i2igxAAb8JPRRjmOoVYQki5/VkK8e37jI5nm734wAlXG2AdJSGuc8sTLw/
         4+g2MFlNxFBth1Ic3y/dHajDdmLRZfXqQnib4xhPSqXdu3RmFcfjfBXJine2WcXYI4FH
         7pdQCGtpqCCdRzFUgcQxMxUxig7yF8ncqAs0NGuQVFSELoRpJeUc4q4XzkXPuYyoIYpo
         HKfZCSWjhrAfoQzjX1gbnzP2mJmqTECdy95h/hmxfLqfiJrW/54VAM/V6cOGw6F66xiv
         5ooeSa+3fhXmfHmh3zymeP0RuAShO1bT7SStQnXKevTMsKBSpzbLFFMbMH28dteSWYRH
         xPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744832778; x=1745437578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FSkTMVQKVF8+T3ftLHZwHo1bf1YTsSlwi8hM6dxAd4=;
        b=jXhnPes4/xaFQkQzWzT/EevdAEDhxWTPsHwKprSti4nANlmq7VJ9qIJBz2o59VrAZH
         hlPV9Imto8GL9bWWPy7OaxbuprDnj0qwR11rjcLhY2CDtJF851qy0jWBpVUd9Hrmr/vf
         cEQEprObIx0aMDW2IM34VFmpPuWfigKIF0qa0GWXNPmLA1DcmLv92jLDDW8JrYHamGPE
         zBJzCyWZDM1rB22XjNgcmfqM0BiDrfI7rKAAmCjE/wiLlrjdOiw3FgQ1ziuHKFQ0oPp1
         T1AfPuxXcCRBstspzBNHmLyeYwV9o+heoh6+7Lx/Yy7tBCzQgzyxlw3WRYhLmFvnZ7y1
         uVYQ==
X-Gm-Message-State: AOJu0Yy3CWsm/FAaStNTJ64ahx5n9DaJEG4bU9gUDj9drbdQ+1L9Y+R6
	awYEnCi+lBvzdDbf8tMqypSq1M64ImzUmsEBNf0mXYrJiMghRMeK2USPoLKS19MOiBfpTgYP72F
	PjTlsrs1HBkWjhQ63pxl9GJg8NbiE57QodV0p44aGMwTBqkF8
X-Gm-Gg: ASbGnctKvXjjyVbrzC5ak66gs4nyT6a8PvswqvJromLPTkaVXFC17K2K5HTDZxwSni/
	vB6sKqc0g3AY9pd4IV6TzQNjZcYdjUxH+iV8tuSIKS/494ezr465Q6n6OHCq+3Ut8XmyNks56cX
	SydN4mlSMqa2qFXkELzVoHXvw7yrIkQOXcqpAttx0YhPaFs60vZ7vimTuZD0jfCKUI3/zGtEm8t
	GXTEVdpgH4wB8KnJcgeie8v+BrU2v2UiPxfSMUe7N00S3J/vm4fbeRSOBpTeqlBKX1Sl1xNbQmB
	ZYqNAyauX/KEVla6YrJ4Qd5SufkYTaY=
X-Google-Smtp-Source: AGHT+IEdAOO/a/NWoIVz4hFvCWYt1cOs67Bo6EUpAOIqrH3uPHmMDf4q+6XjtQIc4pDUHkA3q+f3b3HhDEiG
X-Received: by 2002:a05:6214:cae:b0:6e2:485d:fddd with SMTP id 6a1803df08f44-6f2ba8dd00cmr2037156d6.1.1744832777729;
        Wed, 16 Apr 2025 12:46:17 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6f0dea12d3dsm8179116d6.59.2025.04.16.12.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 12:46:17 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9849F34067F;
	Wed, 16 Apr 2025 13:46:16 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 95775E407EC; Wed, 16 Apr 2025 13:46:16 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Wed, 16 Apr 2025 13:46:08 -0600
Subject: [PATCH v5 4/4] ublk: mark ublk_queue as const for
 ublk_handle_need_get_data
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-ublk_task_per_io-v5-4-9261ad7bff20@purestorage.com>
References: <20250416-ublk_task_per_io-v5-0-9261ad7bff20@purestorage.com>
In-Reply-To: <20250416-ublk_task_per_io-v5-0-9261ad7bff20@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

We now allow multiple tasks to operate on I/Os belonging to the same
queue concurrently. This means that any writes to ublk_queue in the I/O
path are potential sources of data races. Try to prevent these by
marking ublk_queue pointers as const in ublk_handle_need_get_data. Also
move a bit more of the NEED_GET_DATA-specific logic into
ublk_handle_need_get_data, to make the pattern in __ublk_ch_uring_cmd
more uniform.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 215ab45b00e10150e58d7f5ea5b5d13e40a1aa79..5f9679c03305576bee586388cab82a6ea5472f8b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1291,7 +1291,7 @@ static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
 	ublk_dispatch_req(ubq, pdu->req, issue_flags);
 }
 
-static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
+static void ublk_queue_cmd(const struct ublk_queue *ubq, struct request *rq)
 {
 	struct io_uring_cmd *cmd = ubq->ios[rq->tag].cmd;
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
@@ -1813,15 +1813,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	mutex_unlock(&ub->mutex);
 }
 
-static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
-		int tag)
-{
-	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
-	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
-
-	ublk_queue_cmd(ubq, req);
-}
-
 static inline int ublk_check_cmd_op(u32 cmd_op)
 {
 	u32 ioc_type = _IOC_TYPE(cmd_op);
@@ -1933,6 +1924,20 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 	return 0;
 }
 
+static int ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
+			 struct io_uring_cmd *cmd,
+			 const struct ublksrv_io_cmd *ub_cmd,
+			 struct request *req)
+{
+	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+		return -EINVAL;
+
+	ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
+	ublk_queue_cmd(ubq, req);
+
+	return 0;
+}
+
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
@@ -2026,10 +2031,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			goto out;
 		break;
 	case UBLK_IO_NEED_GET_DATA:
-		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+		ret = ublk_get_data(
+			ubq, io, cmd, ub_cmd,
+			blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag));
+		if (ret)
 			goto out;
-		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		ublk_handle_need_get_data(ub, ub_cmd->q_id, ub_cmd->tag);
 		break;
 	default:
 		goto out;

-- 
2.34.1

