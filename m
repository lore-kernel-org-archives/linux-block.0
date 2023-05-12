Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F21EC77B7F
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 03:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjELDzR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 May 2023 23:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbjELDzO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2023 23:55:14 -0400
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 May 2023 20:55:09 PDT
Received: from out-61.mta0.migadu.com (out-61.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B48525E
        for <linux-block@vger.kernel.org>; Thu, 11 May 2023 20:55:09 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683863196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gmJ3ZYMqZfyZixcLEJEp93dEs+G0q6dpVSOG6V02o5o=;
        b=VKGgqJTplHMHUpOOs6XEbp1+9r+mDHRPPVEVfPkfdH7mE1cpxDcCRA6yKXt+bd3FqYCZvr
        Dd7DekYWmL4mcUSfywtz6+kmUqtMPhbOek//MrqB5c5rGLvOVQbOWvTadxdJjkBc1afeZk
        OMFBGIW1OIJTvHGs8ZhB6bimATyP7qU=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     hch@infradead.org, linux-block@vger.kernel.org
Subject: [PATCH] block/rnbd: replace REQ_OP_FLUSH with REQ_OP_WRITE
Date:   Fri, 12 May 2023 11:46:31 +0800
Message-Id: <20230512034631.28686-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since flush bios are implemented as writes with no data and
the preflush flag per Christoph's comment [1].

And we need to change it in rnbd accordingly. Otherwise, I
got splatting when create fs from rnbd client.

[  464.028545] ------------[ cut here ]------------
[  464.028553] WARNING: CPU: 0 PID: 65 at block/blk-core.c:751 submit_bio_noacct+0x32c/0x5d0
[ ... ]
[  464.028668] CPU: 0 PID: 65 Comm: kworker/0:1H Tainted: G           OE      6.4.0-rc1 #9
[  464.028671] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
[  464.028673] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
[  464.028717] RIP: 0010:submit_bio_noacct+0x32c/0x5d0
[  464.028720] Code: 03 0f 85 51 fe ff ff 48 8b 43 18 8b 88 04 03 00 00 85 c9 0f 85 3f fe ff ff e9 be fd ff ff 0f b6 d0 3c 0d 74 26 83 fa 01 74 21 <0f> 0b b8 0a 00 00 00 e9 56 fd ff ff 4c 89 e7 e8 70 a1 03 00 84 c0
[  464.028722] RSP: 0018:ffffaf3680b57c68 EFLAGS: 00010202
[  464.028724] RAX: 0000000000060802 RBX: ffffa09dcc18bf00 RCX: 0000000000000000
[  464.028726] RDX: 0000000000000002 RSI: 0000000000000000 RDI: ffffa09dde081d00
[  464.028727] RBP: ffffaf3680b57c98 R08: ffffa09dde081d00 R09: ffffa09e38327200
[  464.028729] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa09dde081d00
[  464.028730] R13: ffffa09dcb06e1e8 R14: 0000000000000000 R15: 0000000000200000
[  464.028733] FS:  0000000000000000(0000) GS:ffffa09e3bc00000(0000) knlGS:0000000000000000
[  464.028735] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  464.028736] CR2: 000055a4e8206c40 CR3: 0000000119f06000 CR4: 00000000003506f0
[  464.028738] Call Trace:
[  464.028740]  <TASK>
[  464.028746]  submit_bio+0x1b/0x80
[  464.028748]  rnbd_srv_rdma_ev+0x50d/0x10c0 [rnbd_server]
[  464.028754]  ? percpu_ref_get_many.constprop.0+0x55/0x140 [rtrs_server]
[  464.028760]  ? __this_cpu_preempt_check+0x13/0x20
[  464.028769]  process_io_req+0x1dc/0x450 [rtrs_server]
[  464.028775]  rtrs_srv_inv_rkey_done+0x67/0xb0 [rtrs_server]
[  464.028780]  __ib_process_cq+0xbc/0x1f0 [ib_core]
[  464.028793]  ib_cq_poll_work+0x2b/0xa0 [ib_core]
[  464.028804]  process_one_work+0x2a9/0x580

[1]. https://lore.kernel.org/all/ZFHgefWofVt24tRl@infradead.org/

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-proto.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
index ea7ac8bca63c..da1d0542d7e2 100644
--- a/drivers/block/rnbd/rnbd-proto.h
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -241,7 +241,7 @@ static inline blk_opf_t rnbd_to_bio_flags(u32 rnbd_opf)
 		bio_opf = REQ_OP_WRITE;
 		break;
 	case RNBD_OP_FLUSH:
-		bio_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
+		bio_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 		break;
 	case RNBD_OP_DISCARD:
 		bio_opf = REQ_OP_DISCARD;
-- 
2.35.3

