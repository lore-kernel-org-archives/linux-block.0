Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0698C47082
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 18:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8947C6143D
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 18:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbhFHShe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 14:37:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59812 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbhFHSfg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 14:35:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0FB331FD33;
        Tue,  8 Jun 2021 18:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623177222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+sidGPMJtxePCU+W1GlOUflISPthftJtgdHFE3a10Vc=;
        b=VENu8TkFmtmqG2FSpasHMyxjnc38szsS2bE7ArgOz916Ycc0eJIWJHvq+PcI+Xu4n+tMN1
        poYoqKB5Z7DlnyeXukFclNPPL1eEuY8DyQmkEc3Vkftv4BgdsJxb5ss75SFyR7HS06MEIE
        eE8RUT9dxExBdgqb4OdQ9WECehCfPdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623177222;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+sidGPMJtxePCU+W1GlOUflISPthftJtgdHFE3a10Vc=;
        b=+sDJXuq2YBntI4tpOK9blrVd1wMdP6CW59wLXll9phenwpi2tnV1JD2jdbGLICepo2MrRg
        eJLi/Xse4M/5n4BA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 0A600A3B87;
        Tue,  8 Jun 2021 18:33:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id F03AB516FED7; Tue,  8 Jun 2021 20:33:41 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] blk-mq: Do not lookup ctx with invalid index
Date:   Tue,  8 Jun 2021 20:33:39 +0200
Message-Id: <20210608183339.70609-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

cpumask_first_and() returns >= nr_cpu_ids if the two provided masks do
not share a common bit. Verify we get a valid value back from
cpumask_first_and().

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Hi,

 Supported: Yes, External
 CPU: 11 PID: 7264 Comm: kworker/u64:1 Kdump: loaded Tainted: G           O  KX    5.3.18-53-default #1 SLE15-SP3
 Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
 NIP:  c0000000006b6ab0 LR: c0000000006b6ea0 CTR: c0000000006ad740
 REGS: c0000003dbdbb570 TRAP: 0380   Tainted: G           O  KX     (5.3.18-53-default)
 MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44002244  XER: 00000001
 CFAR: c0000000006b6e9c IRQMASK: 0
 GPR00: c0000000006b6ea0 c0000003dbdbb800 c000000001752a00 c0000003f7b8dd40
 GPR04: 8009fffc21e76a80 0000000000000000 0000000000000001 0000000000000001
 GPR08: 00000003fb950000 0000000000000000 0000000000000000 c008000000b77840
 GPR12: 0000000000002000 c00000001ec60200 c0000000001727f8 c0000000631152c0
 GPR16: 0000000000000190 0000000000000600 0000000000001f00 0000000000000000
 GPR20: 0000000000000004 0700000048000000 c0000000ff0b0470 3000000004000000
 GPR24: c0000003e2dc6868 0000000000000001 0000000000000000 c0000003f7b8dd40
 GPR28: 0000000000000000 c0000003f7b8dda0 0000000000000000 c0000003dbdbb8e0
 NIP [c0000000006b6ab0] blk_mq_put_tag+0x20/0x90
 LR [c0000000006b6ea0] blk_mq_get_tag+0x380/0x3b0
 Call Trace:
 [c0000003dbdbb800] [c0000000006b63e4] __blk_mq_get_tag+0x44/0xf0 (unreliable)
 [c0000003dbdbb820] [c0000000006b6ea0] blk_mq_get_tag+0x380/0x3b0
 [c0000003dbdbb8b0] [c0000000006ad8c4] blk_mq_alloc_request_hctx+0x184/0x230
 [c0000003dbdbb930] [c008000000b60edc] nvme_alloc_request+0x54/0xe0 [nvme_core]
 [c0000003dbdbb960] [c008000000b63dbc] __nvme_submit_sync_cmd+0x74/0x290 [nvme_core]
 [c0000003dbdbb9f0] [c008000000ec18f0] nvmf_connect_io_queue+0x148/0x1f0 [nvme_fabrics]
 [c0000003dbdbbae0] [c008000000f97254] nvme_fc_connect_io_queues+0x2d8/0x36c [nvme_fc]
 [c0000003dbdbbbc0] [c008000000f959fc] nvme_fc_connect_ctrl_work+0xa34/0xb90 [nvme_fc]
 [c0000003dbdbbc80] [c000000000167d54] process_one_work+0x2c4/0x5c0
 [c0000003dbdbbd10] [c000000000168330] worker_thread+0x2e0/0x6b0
 [c0000003dbdbbdb0] [c00000000017299c] kthread+0x1ac/0x1c0
 [c0000003dbdbbe20] [c00000000000cda8] ret_from_kernel_thread+0x5c/0x74

We allocate a tag in blk_mq_get_tag() but then we find out the
BLK_MQ_S_INACTIVE is set and call blk_mq_put_tag()

 found_tag:
         /*
          * Give up this allocation if the hctx is inactive.  The caller will
          * retry on an active hctx.
          */
         if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state))) {
                 blk_mq_put_tag(tags, data->ctx, tag + tag_offset);
                 return BLK_MQ_NO_TAG;
         }

and if my dissasembly works (unfortuantly, I dont have access to the
correct binaries, so we are looking at my own compiled version), the
load for ctx->cpu crashes.

 c0000000006b7870 <blk_mq_put_tag>:
 c0000000006b7870:       0a 01 4c 3c     addis   r2,r12,266
 c0000000006b7874:       90 b5 42 38     addi    r2,r2,-19056
 c0000000006b7878:       a6 02 08 7c     mflr    r0
 c0000000006b787c:       ad f0 9b 4b     bl      c000000000076928 <_mcount>
 c0000000006b7880:       a6 02 08 7c     mflr    r0
 c0000000006b7884:       78 2b a9 7c     mr      r9,r5
 c0000000006b7888:       10 00 01 f8     std     r0,16(r1)
 c0000000006b788c:       e1 ff 21 f8     stdu    r1,-32(r1)
 c0000000006b7890:       80 00 a4 80     lwz     r5,128(r4)    // XXX this is problably crashing
 c0000000006b7894:       04 00 83 80     lwz     r4,4(r3)
 c0000000006b7898:       40 20 89 7f     cmplw   cr7,r9,r4
 c0000000006b789c:       44 00 9c 41     blt     cr7,c0000000006b78e0 <blk_mq_put_tag+0x70>

I figured the only way the data->ctx could be invalid is, when
cpumask_first_and() returns an invalid index.

This seems to be a nasty corner case. The cpumask changes and we hit
the queue in inactive state. Not sure this is really happening.

The patch has not yet verified if it really helps. I thought the check
might be a good thing independent if it really fixes the above crash or
not.

Thanks,
Daniel

 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4261adee9964..50f97bc97895 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -469,6 +469,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
+	if (cpu >= nr_cpu_ids)
+		goto out_queue_exit;
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	if (!q->elevator)
-- 
2.29.2

