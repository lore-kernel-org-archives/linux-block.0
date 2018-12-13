Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD5FC65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 08:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE9D20811
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 08:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE9D20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbeLMIb6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:31:58 -0500
Received: from verein.lst.de ([213.95.11.211]:39367 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeLMIb6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 03:31:58 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 530DB68D8D; Thu, 13 Dec 2018 09:31:57 +0100 (CET)
Date:   Thu, 13 Dec 2018 09:31:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 6/6] nvme-multipath: disable polling for underlying
 namespace request queue
Message-ID: <20181213083157.GD869@lst.de>
References: <20181213063819.13614-1-sagi@grimberg.me> <20181213063819.13614-7-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213063819.13614-7-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 12, 2018 at 10:38:18PM -0800, Sagi Grimberg wrote:
> Since the multipath device does not support polling (yet) we cannot
> pass requests to the polling queue map as those will not generate
> interrupt so we cannot reap the completion.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

As said before I don't think this is the right place.  We need
to handle the stacking case in the block layer.  Something like this
untested patch below should do the trick:

--
From b810e53e8a9ec6f62202c2ad65e6e56277bcace7 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 13 Dec 2018 09:30:13 +0100
Subject: block: clear REQ_HIPRI if polling is not supported

This prevents a HIPRI bio from being submitted through a stacking
driver that does not support polling and thus won't poll for I/O
completion.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 268d2b8e9843..efa10789ddc0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -921,6 +921,9 @@ generic_make_request_checks(struct bio *bio)
 		}
 	}
 
+	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+		bio->bi_opf &= ~REQ_HIPRI;
+
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
 		if (!blk_queue_discard(q))
-- 
2.19.2

