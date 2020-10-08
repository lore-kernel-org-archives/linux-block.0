Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0610C433E7
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 21:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9F1207DE
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 21:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgJHViF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 17:38:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43476 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbgJHViE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Oct 2020 17:38:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id g12so8136161wrp.10
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2020 14:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1yeFlTcreSlGkiCgTiA+N43zzqnDkmGGiL0r+MFHngE=;
        b=ZeSX2Kx7ptWLVuFYtkIX+/OYXXDG2Xz+qyT2ykCQ59rMQGvS9z3PlBvXbGf7g+cABl
         DwmOTR+uiwzqKJ+znoRfWaiJapESxTfxjkMGJTgZPlClRqcrU5Ag2AiOq2hNKJ2HPhud
         7QhahLV+Y548fDq+1bJQbZX291jr7RU+6d1iA/5CTHX76/i0/8yT8fTuVqC9WgdvtcDo
         kB15D3PfF8NJkXc6gu0fxWKv59OHXOW1UzYcsEtx9tm7sSn3Xc4jONOPIyxVtzcEoKV+
         uKRo8EeL4Bt6xBk2shIUZLvJeZhBe3FiEJI8TNYyJ1ze+cWX93OSCT25CdDJuGNCMoEu
         GnSw==
X-Gm-Message-State: AOAM530RZRkgkRoSHohqLsO3CTASM7XSgcpgam9xsnpk4PSMOKnlsof6
        RT/w5P8N3to5mGTrVmqUW81gl9295Hk=
X-Google-Smtp-Source: ABdhPJxjtmnkWPtb+aZEYtdphdkDtgnQjVqWUsbqDT22lqTeh5YIyOLuZgsxRXYWvY7s/GMwm51VVg==
X-Received: by 2002:adf:f7ca:: with SMTP id a10mr11278684wrq.321.1602193081489;
        Thu, 08 Oct 2020 14:38:01 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:68d6:3fd5:5a8b:9959])
        by smtp.gmail.com with ESMTPSA id q2sm8977106wrw.40.2020.10.08.14.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 14:38:00 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     Yi Zhang <yi.zhang@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: re-introduce blk_mq_complete_request_sync
Date:   Thu,  8 Oct 2020 14:37:50 -0700
Message-Id: <20201008213750.899462-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In nvme-tcp and nvme-rdma, the timeout handler in certain conditions
needs to complete an aborted request. The timeout handler serializes
against an error recovery sequence that iterates over the inflight
requests and cancels them.

However, the fact that blk_mq_complete_request may defer to a different
core that serialization breaks.

Hence re-introduce blk_mq_complete_request_sync and use that in the
timeout handler to make sure that we don't get a use-after-free
condition.

This was uncovered by the blktests:
--
$ nvme_trtype=tcp ./check nvme/012

[ 2152.546343] run blktests nvme/012 at 2020-10-08 05:59:03
[ 2152.799640] loop: module loaded
[ 2152.835222] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 2152.860697] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 2152.937889] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:e544149126a24145abeeb6129b0ec52c.
[ 2152.952085] nvme nvme0: creating 12 I/O queues.
[ 2152.958042] nvme nvme0: mapped 12/0/0 default/read/poll queues.
[ 2152.969948] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420
[ 2154.927953] XFS (nvme0n1): Mounting V5 Filesystem
[ 2154.942432] XFS (nvme0n1): Ending clean mount
[ 2154.948183] xfs filesystem being mounted at /mnt/blktests supports timestamps until 2038 (0x7fffffff)
[ 2215.193645] nvme nvme0: queue 7: timeout request 0x11 type 4
[ 2215.199331] nvme nvme0: starting error recovery
[ 2215.203890] nvme nvme0: queue 7: timeout request 0x12 type 4
[ 2215.204483] block nvme0n1: no usable path - requeuing I/O
[ 2215.214976] block nvme0n1: no usable path - requeuing I/O
[ 2215.215495] nvme nvme0: Reconnecting in 10 seconds...
[ 2215.215502] ------------[ cut here ]------------
[ 2215.215505] refcount_t: underflow; use-after-free.
[ 2215.215617] WARNING: CPU: 6 PID: 45 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0xf0
[ 2215.215745] RSP: 0018:ffffb71b80837dc8 EFLAGS: 00010292
[ 2215.215750] RAX: 0000000000000026 RBX: 0000000000000000 RCX: ffff93f37dcd8d08
[ 2215.215753] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff93f37dcd8d00
[ 2215.215755] RBP: ffff93f37a812400 R08: 00000203c5221fce R09: ffffffffa7fffbc4
[ 2215.215758] R10: 0000000000000477 R11: 000000000002835c R12: ffff93f37a8124e8
[ 2215.215761] R13: ffff93f37a2b0000 R14: ffffb71b80837e70 R15: ffff93f37a2b0000
[ 2215.215765] FS:  0000000000000000(0000) GS:ffff93f37dcc0000(0000) knlGS:0000000000000000
[ 2215.215768] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2215.215771] CR2: 00005637b4137028 CR3: 000000007c1be000 CR4: 00000000000006e0
[ 2215.215773] Call Trace:
[ 2215.215784]  blk_mq_check_expired+0x109/0x1b0
[ 2215.215797]  blk_mq_queue_tag_busy_iter+0x1b8/0x330
[ 2215.215801]  ? blk_poll+0x300/0x300
[ 2215.215806]  blk_mq_timeout_work+0x44/0xe0
[ 2215.215814]  process_one_work+0x1b4/0x370
[ 2215.215820]  worker_thread+0x53/0x3e0
[ 2215.215825]  ? process_one_work+0x370/0x370
[ 2215.215829]  kthread+0x11b/0x140
[ 2215.215834]  ? __kthread_bind_mask+0x60/0x60
[ 2215.215841]  ret_from_fork+0x22/0x30
[ 2215.215847] ---[ end trace 7d137e36e23c0d19 ]---
--

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Fixes: 236187c4ed19 ("nvme-tcp: fix timeout handler")
Fixes: 0475a8dcbcee ("nvme-rdma: fix timeout handler")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Yi, would appreciate your Tested-by tag

 block/blk-mq.c           | 7 +++++++
 drivers/nvme/host/rdma.c | 2 +-
 drivers/nvme/host/tcp.c  | 2 +-
 include/linux/blk-mq.h   | 1 +
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f8e1e759c905..2d154722ef39 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -729,6 +729,13 @@ bool blk_mq_complete_request_remote(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_mq_complete_request_remote);
 
+void blk_mq_complete_request_sync(struct request *rq)
+{
+	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
+	rq->q->mq_ops->complete(rq);
+}
+EXPORT_SYMBOL_GPL(blk_mq_complete_request_sync);
+
 /**
  * blk_mq_complete_request - end I/O on a request
  * @rq:		the request being processed
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9e378d0a0c01..45fc605349da 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1975,7 +1975,7 @@ static void nvme_rdma_complete_timed_out(struct request *rq)
 	nvme_rdma_stop_queue(queue);
 	if (!blk_mq_request_completed(rq)) {
 		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
-		blk_mq_complete_request(rq);
+		blk_mq_complete_request_sync(rq);
 	}
 	mutex_unlock(&ctrl->teardown_lock);
 }
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8f4f29f18b8c..629b025685d1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2177,7 +2177,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
 	if (!blk_mq_request_completed(rq)) {
 		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
-		blk_mq_complete_request(rq);
+		blk_mq_complete_request_sync(rq);
 	}
 	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 90da3582b91d..f90c258b5075 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -491,6 +491,7 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 void blk_mq_complete_request(struct request *rq);
+void blk_mq_complete_request_sync(struct request *rq);
 bool blk_mq_complete_request_remote(struct request *rq);
 bool blk_mq_queue_stopped(struct request_queue *q);
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
-- 
2.25.1

