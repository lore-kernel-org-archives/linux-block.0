Received: from mta0.migadu.com (out-59.mta0.migadu.com [91.218.175.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69442AFA2
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113288; cv=none; b=caqbrMOnM9GxIDDfjkr/eXclw6JhE7DJXFgXq0CdGRnCO6M9efNdf8M2SIe0XpUtE6VEPOv9pJ36V9PB1cMbxyAD3myVxzerqKIf9sm8+UF3LOM2KiQoL8BiMgfPTqA4xK07Fb0aZK/DQDgAdhu9ONBz5POaWipZr1HovfGdf84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113288; c=relaxed/simple;
	bh=egOw4vLABie73eGacUBq33g4WECXQSwyvK7mJNyI9wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Thb3h7r9GheE6zc5eu7HLzVvM6iMLcAiV8Ws94xofLEcdeVuo1aR97O7yJpxda+zKlwEXuoC89+BAi99YJJ+iyvIp5t/EbfVDMXKObWDbslKsnVlOFWXAtmxwrr1C1KK+srWWauQZ3mbMre7s+DcK2hPpT7h7cDM/PZKpRSXTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mht8uyH+; arc=none smtp.client-ip=91.218.175.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mht8uyH+"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=egOw4vLABie73eGacUBq33g4WECXQSwyvK7mJNyI9wQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789113284; v=1; x=1789718084;
 b=mht8uyH+WPRRXfQyNUfKfiFuJvLa8JNgyBGGItV5BxTfrM8Uj7ytd8qr2HSK1zkVcmsMSTN0
 cwF6Ld2N+CTGhOD9AVTK02+U8LBglu9UJc4Wmszp8Jme1IGAVyOruPNbVbx6/CK5a1/FrRg4Aa7
 l7VMSdlFDRnpvbyHGk2/J3RY=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 8eaaa7b1d2be2cb2;
	Fri, 11 Sep 2026 07:54:44 +0000
X-Mizu-Trace-ID: 8eaaa7b1d2be2cb2
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: axboe@kernel.dk,
	James.Bottomley@HansenPartnership.com,
	mkp@kernel.org,
	hch@lst.de,
	tom.leiming@gmail.com,
	bvanassche@acm.org
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	John Garry <john.garry@linux.dev>
Subject: [PATCH] blk-mq: cleanup terminal request when it could not be queued
Date: Fri, 11 Sep 2026 08:54:15 +0100
Message-ID: <20260911075415.634921-1-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko points out that the SCSI midlayer error handling misses some
cleanup for when a request could not be queued and won't be requeued [0].
Specifically, clearing the SCSI cmd flags member is missing. Normally that
would be cleared in the non-error path in scsi_end_request() (which also
calls __blk_mq_end_request()).

Callchain blk_mq_cleanup_rq() -> scsi_cleanup_rq() does all the necessary
cleanup, so call that in blk_mq_dispatch_rq_list() for when there was an
error in the dispatch and the rq will be ended.

Note that dm-rq code calls blk_mq_cleanup_rq() for a cloned rq (or SCSI rq)
for when the clone could not be queued and will be retried, but that path
does not use the sched code (and blk_mq_dispatch_rq_list()).

[0] https://lore.kernel.org/linux-scsi/20260729161243.C918D1F00A3A@smtp.kernel.org/

Suggesested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: John Garry <john.garry@linux.dev>
---
Maybe SCSI should be doing this cleanup directly, as we now create some
confusion on who should do the cleanup - blk-mq or the driver.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a26a11c73ee3..eb3a481211d0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2126,6 +2126,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			blk_mq_handle_dev_resource(rq, list);
 			goto out;
 		default:
+			blk_mq_cleanup_rq(rq);
 			blk_mq_end_request(rq, ret);
 		}
 	} while (!list_empty(list));
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index af27fd3df8d4..1ea65b5eb25c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1960,13 +1960,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 			cmd->result = DID_NO_CONNECT << 16;
 		else
 			cmd->result = DID_ERROR << 16;
-		/*
-		 * Make sure to release all allocated resources when
-		 * we hit an error, as we will never see this command
-		 * again.
-		 */
-		if (req->rq_flags & RQF_DONTPREP)
-			scsi_mq_uninit_cmd(cmd);
+		/* blk-mq will cleanup our resources as the rq will end */
 		scsi_run_queue_async(sdev);
 		break;
 	}
-- 
2.43.0

