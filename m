Return-Path: <SRS0=GZIg=6R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E509C3A5A9
	for <linux-block@archiver.kernel.org>; Sun,  3 May 2020 03:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74ECB20738
	for <linux-block@archiver.kernel.org>; Sun,  3 May 2020 03:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhxdGCKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgECDVa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 May 2020 23:21:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42874 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726737AbgECDV3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 May 2020 23:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588476088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1fWFQicEz2MSa6VdFZAVUeoDhsbDOvsURYiktFptHL0=;
        b=AhxdGCKOsJqAVLx030a9zNthjNZ112ayPolnylcBM1lk/84+tV16gdjErLZmIDrGrNSAyH
        fX0E/Ulz5yjuG5D2g6YIbpxrCz880mc/z3gM/CkSdMIT87ATLvq7alUQVUFdgWOi3eCQGK
        aNDwVM3bzxFrhY5oRMzJJz+tUmw/F3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-52JMrZwDMjCLp3-cPGw5Rg-1; Sat, 02 May 2020 23:21:26 -0400
X-MC-Unique: 52JMrZwDMjCLp3-cPGw5Rg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A7E58005B7;
        Sun,  3 May 2020 03:21:25 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4031860612;
        Sun,  3 May 2020 03:21:18 +0000 (UTC)
Date:   Sun, 3 May 2020 11:21:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     axboe@kernel.dk, tom.leiming@gmail.com, bvanassche@acm.org,
        linux-block@vger.kernel.org
Subject: Re: [RESEND v4 4/6] block: alloc map and request for new hardware
 queue
Message-ID: <20200503032112.GA1128091@T590>
References: <cover.1588080449.git.zhangweiping@didiglobal.com>
 <fbf27d4283954c9bd3e65422cc962a4e60a0ae5c.1588080449.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbf27d4283954c9bd3e65422cc962a4e60a0ae5c.1588080449.git.zhangweiping@didiglobal.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 28, 2020 at 09:29:59PM +0800, Weiping Zhang wrote:
> Alloc new map and request for new hardware queue when increse
> hardware queue count. Before this patch, it will show a
> warning for each new hardware queue, but it's not enough, these
> hctx have no maps and reqeust, when a bio was mapped to these
> hardware queue, it will trigger kernel panic when get request
> from these hctx.
> 
> Test environment:
>  * A NVMe disk supports 128 io queues
>  * 96 cpus in system
> 
> A corner case can always trigger this panic, there are 96
> io queues allocated for HCTX_TYPE_DEFAULT type, the corresponding kernel
> log: nvme nvme0: 96/0/0 default/read/poll queues. Now we set nvme write
> queues to 96, then nvme will alloc others(32) queues for read, but
> blk_mq_update_nr_hw_queues does not alloc map and request for these new
> added io queues. So when process read nvme disk, it will trigger kernel
> panic when get request from these hardware context.
> 

map and request is supposed to be allocated via __blk_mq_alloc_rq_map() called
from blk_mq_map_swqueue(), so why is such issue triggered?

The reason could be that only queue type of HCTX_TYPE_DEFAULT is handled
in __blk_mq_alloc_rq_map(), and looks all queue types should have been covered
here.

Could you test the following patch and see if the issue can be fixed?
Then we can save one intermediate variable if it helps.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 12dee4ecd5cc..7e77e27b613e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2742,19 +2742,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	 * If the cpu isn't present, the cpu is mapped to first hctx.
 	 */
 	for_each_possible_cpu(i) {
-		hctx_idx = set->map[HCTX_TYPE_DEFAULT].mq_map[i];
-		/* unmapped hw queue can be remapped after CPU topo changed */
-		if (!set->tags[hctx_idx] &&
-		    !__blk_mq_alloc_rq_map(set, hctx_idx)) {
-			/*
-			 * If tags initialization fail for some hctx,
-			 * that hctx won't be brought online.  In this
-			 * case, remap the current ctx to hctx[0] which
-			 * is guaranteed to always have tags allocated
-			 */
-			set->map[HCTX_TYPE_DEFAULT].mq_map[i] = 0;
-		}
-
 		ctx = per_cpu_ptr(q->queue_ctx, i);
 		for (j = 0; j < set->nr_maps; j++) {
 			if (!set->map[j].nr_queues) {
@@ -2763,6 +2750,19 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 				continue;
 			}
 
+			/* unmapped hw queue can be remapped after CPU topo changed */
+			hctx_idx = set->map[j].mq_map[i];
+			if (!set->tags[hctx_idx] &&
+			    !__blk_mq_alloc_rq_map(set, hctx_idx)) {
+				/*
+				 * If tags initialization fail for some hctx,
+				 * that hctx won't be brought online.  In this
+				 * case, remap the current ctx to hctx[0] which
+				 * is guaranteed to always have tags allocated
+				 */
+				set->map[j].mq_map[i] = 0;
+			}
+
 			hctx = blk_mq_map_queue_type(q, j, i);
 			ctx->hctxs[j] = hctx;
 			/*


Thanks,
Ming

