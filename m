Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753934AbcJFITi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Oct 2016 04:19:38 -0400
Date: Thu, 6 Oct 2016 10:25:08 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 6/8] blk-mq: Rework blk_mq_realloc_hw_ctxs()
Message-ID: <20161006082507.GB23960@agordeev.lab.eng.brq.redhat.com>
References: <cover.1475241231.git.agordeev@redhat.com>
 <7459c980dd965b5f7b91e3bf1c3114d658535229.1475241231.git.agordeev@redhat.com>
 <259f9d8c-e552-7565-5e05-88a1c8430317@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <259f9d8c-e552-7565-5e05-88a1c8430317@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Oct 06, 2016 at 12:47:26AM +0300, Sagi Grimberg wrote:
> 
> >@@ -1908,33 +1909,36 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> > 		if (node == NUMA_NO_NODE)
> > 			node = set->numa_node;
> >
> >-		hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),
> >-					GFP_KERNEL, node);
> >-		if (!hctxs[i])
> >+		hctx = kzalloc_node(sizeof(*hctx), GFP_KERNEL, node);
> >+		if (!hctx)
> > 			break;
> >
> >-		if (blk_mq_init_hctx(q, set, hctxs[i], i, node)) {
> >-			kfree(hctxs[i]);
> >-			hctxs[i] = NULL;
> >+		if (blk_mq_init_hctx(q, set, hctx, i, node)) {
> >+			kfree(hctx);
> > 			break;
> > 		}
> >-		blk_mq_hctx_kobj_init(hctxs[i]);
> >+
> >+		blk_mq_hctx_kobj_init(hctx);
> >+		hctxs[i] = hctx;
> > 	}
> > 	for (j = i; j < q->nr_hw_queues; j++) {
> >-		struct blk_mq_hw_ctx *hctx = hctxs[j];
> >+		hctx = hctxs[i];
> 
> Didn't you mean hctx[j]?

Surely, I did.
Thanks!
