Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC43CC433F5
	for <linux-block@archiver.kernel.org>; Wed, 29 Dec 2021 17:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbhL2RqI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Dec 2021 12:46:08 -0500
Received: from verein.lst.de ([213.95.11.211]:38348 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231784AbhL2RqH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Dec 2021 12:46:07 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 930F068AFE; Wed, 29 Dec 2021 18:46:03 +0100 (CET)
Date:   Wed, 29 Dec 2021 18:46:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCHv2 3/3] nvme-pci: fix queue_rqs list splitting
Message-ID: <20211229174602.GC28058@lst.de>
References: <20211227164138.2488066-1-kbusch@kernel.org> <20211227164138.2488066-3-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227164138.2488066-3-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +			rq_list_move(rqlist, &requeue_list, req, prev, next);
> +
> +			req = prev;
> +			if (!req)
> +				continue;

Shouldn't this be a break?

> +			*rqlist = next;
> +			prev = NULL;
> +		} else
> +			prev = req;
> +	}

I wonder if a restart label here would be a little cleaner, something
like:


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 992ee314e91ba..29b433fd12bdd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -999,9 +999,11 @@ static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
 
 static void nvme_queue_rqs(struct request **rqlist)
 {
-	struct request *req, *next, *prev = NULL;
+	struct request *req, *next, *prev;
 	struct request *requeue_list = NULL;
 
+restart:
+	prev = NULL;
 	rq_list_for_each_safe(rqlist, req, next) {
 		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 
@@ -1009,9 +1011,9 @@ static void nvme_queue_rqs(struct request **rqlist)
 			/* detach 'req' and add to remainder list */
 			rq_list_move(rqlist, &requeue_list, req, prev, next);
 
+			if (!prev)
+				break;
 			req = prev;
-			if (!req)
-				continue;
 		}
 
 		if (!next || req->mq_hctx != next->mq_hctx) {
@@ -1019,9 +1021,9 @@ static void nvme_queue_rqs(struct request **rqlist)
 			req->rq_next = NULL;
 			nvme_submit_cmds(nvmeq, rqlist);
 			*rqlist = next;
-			prev = NULL;
-		} else
-			prev = req;
+			goto restart;
+		}
+		prev = req;
 	}
 
 	*rqlist = requeue_list;
