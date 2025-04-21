Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7154A1D88A6
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 23:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745279204; cv=none; b=jZ1hjp7qUD3jbpKVE83igr1dO5seWuC0u6yUEZVmREFGtXmS3gpeRYuSRIZka3RG+rhkKIxdebbLlGpjHiO7ELvI9BBP04mV9NqbBZ/tHG1Vd3NGRUmKEl+fPZnka8tWoVOiFCwYR1/j1Zox8Jj2jrbElvfNf+QxwFHSog/mLF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745279204; c=relaxed/simple;
	bh=q5mjSTIJWpmEc9qqwXdalHq7CRhz2UnhwrElR9uav0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JpfALnIdnbFKi9AAb2qFURdoplXhbVLaMkGG8H3poG9571s77DVLNx+5HgP46ZQspFcB+VISVl/Pr9zycsgmmCw438H0k1fLtpNKCsbQeoeT7k7qEDs71AEihXtHqKl3KGrJQ+/+jHYiqy+zNDGTfdoK8/A9HatMPtini/Ggf64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TcmQQAWX; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TcmQQAWX"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-22438c356c8so47381395ad.1
        for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 16:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745279201; x=1745884001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4GUkXOvvMryrdPEMzkdmHqVlgNQDZjj0ozZX+g8EDM=;
        b=TcmQQAWXSKWQbWiK6t+FVZiC41B1sDDcgEMv+NOtdjlT2hvPVIZNcGLKLgsE4OoMIC
         NMCR+7c3fzZ9EzzlJA8ZTFvP0cmCWRpSj6c/V7a4fDhwAIyRPeshlR+SnO+DyBVqPNib
         TVaaO15EvBZSOnBgMCpP9LAu6AhXOh46zxvzni4Hf2Wby3XXCw7RzqllHCH4XYO1f/tD
         hEimnwPT0dasVhoEZPPBSS4eoCNFsTO3W0YhmY5pG+CPZNa25O+bfxSVJx8nKn0fXJJo
         fSSYOwYTDYKsiq/gyv0O7yiKCnWzzaFwJTQkQzyzBRnMbv3tObbgw72V+cyxDaaA1O1w
         conA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745279201; x=1745884001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4GUkXOvvMryrdPEMzkdmHqVlgNQDZjj0ozZX+g8EDM=;
        b=ofd19nFBTgAh+y7RPeC9Up9qTHsfMsHJ9rfT/M4WxOhHMYVb8KBxpFtd9Zx0OlrUDN
         rHoLF9rItcz388K/Cmu/XVSMZM/bzWtM1Xs/9yy0pplbEvkJXsAgcVnj8zaiIvtIfUF5
         54vwiaVBHs/Z+8adnw6/AX/TrZnulnCYHlF1CXEL74jHuiynEXq1cshYlhfJ7dVA6h7N
         TIpiVCNJmKO38GNugzsU91RmUQgMJbNbx0r1D9/QFlV2/caXahBsHGh4xUufR3N21220
         Xy1S09Ox9o6h2rNIPqhnbxrL4OAq5Fy+mIb0ARf7aZXYnnn1QgYn6DomJ+bO/z4PvtKm
         6MHQ==
X-Gm-Message-State: AOJu0YxYO4weC3L0ZwD0XJygAl4m5U1lq/DJTwHTukToZLcEXHaoyoau
	WxYly4Y6wTusSKQMS49o5CcoTKqMeWbgHHcOmSG4CyRydT5nCFgqA0sflD1TTA3heh7Kbz41aWk
	uTsx5cquwJ1Zz+/TYWepWcrn3uiwRZdMA
X-Gm-Gg: ASbGncvKjIC/yGZrlvio832/eXyJpv8nOzieS01EIGj1GC4KO2ZoR+epcU3+CZKFFRB
	vpwGgoImIJ6cxghdvqs5dcwCmip0fnRHnHlOgg625c1I7X/Jr1hDIIewBiQPfdUngTO4l8LCz+R
	LdsYI205Tjufvu7d1lU/VAa4mFOsWhgUkXWGVsw/4uf3hHYu1m6qclppIOn/BPCuUWkx7OggjvZ
	yUr7pF/npPCNFJAkCmy+1mBXKxFkiRuUey1R7oX2oTIwDed6uumOXtvUxEgexJPrXWQBqK1l24E
	/wOYY92DINU=
X-Google-Smtp-Source: AGHT+IEjreakm61T+7xrh1VhMYjV3lcdyEoVMupNRN3tj8cOZ1VRhh+pFqFyOv2HR/V3r7iIFgzg3cC/svHj
X-Received: by 2002:a17:902:ce11:b0:223:5ca1:3b0b with SMTP id d9443c01a7336-22c5361105amr228202925ad.40.1745279201593;
        Mon, 21 Apr 2025 16:46:41 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22c50bed629sm4303475ad.43.2025.04.21.16.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 16:46:41 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id F2E8E340644;
	Mon, 21 Apr 2025 17:46:40 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id EC02CE4055F; Mon, 21 Apr 2025 17:46:40 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Mon, 21 Apr 2025 17:46:42 -0600
Subject: [PATCH 3/4] ublk: factor out ublk_get_data
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250421-ublk_constify-v1-3-3371f9e9f73c@purestorage.com>
References: <20250421-ublk_constify-v1-0-3371f9e9f73c@purestorage.com>
In-Reply-To: <20250421-ublk_constify-v1-0-3371f9e9f73c@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
X-Mailer: b4 0.14.2

Move all the logic for the UBLK_IO_NEED_GET_DATA opcode into its own
function. This also allows us to mark ublk_queue pointers as const for
that operation, which can help prevent data races since we may allow
concurrent operation on one ublk_queue in the future.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a617ffde412936d3c37a3ded08a79e3557f4f56f..f5d4593d5941931efa7bc7d2106830cd2981f4bd 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1241,7 +1241,7 @@ static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
 	ublk_dispatch_req(ubq, pdu->req, issue_flags);
 }
 
-static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
+static void ublk_queue_cmd(const struct ublk_queue *ubq, struct request *rq)
 {
 	struct io_uring_cmd *cmd = ubq->ios[rq->tag].cmd;
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
@@ -1864,15 +1864,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	}
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
@@ -2032,6 +2023,22 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 	return 0;
 }
 
+static int ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
+			 struct io_uring_cmd *cmd,
+			 const struct ublksrv_io_cmd *ub_cmd)
+{
+	struct blk_mq_tags *tags = ubq->dev->tag_set.tags[ub_cmd->q_id];
+	struct request *req = blk_mq_tag_to_rq(tags, ub_cmd->tag);
+
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
@@ -2097,10 +2104,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			goto out;
 		break;
 	case UBLK_IO_NEED_GET_DATA:
-		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+		ret = ublk_get_data(ubq, io, cmd, ub_cmd);
+		if (ret)
 			goto out;
-		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		ublk_handle_need_get_data(ub, ub_cmd->q_id, ub_cmd->tag);
 		break;
 	default:
 		goto out;

-- 
2.34.1

