Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF01C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 18:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B56B217FA
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 18:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbeLPSjl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 13:39:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730686AbeLPSjl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 13:39:41 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B8AFC049580;
        Sun, 16 Dec 2018 18:39:41 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A780119C7C;
        Sun, 16 Dec 2018 18:39:38 +0000 (UTC)
Date:   Sun, 16 Dec 2018 13:39:37 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 3/4] blk-mq: deal with shared queue mapping reliably
Message-ID: <20181216183937.GA25476@redhat.com>
References: <20181216022517.26650-1-ming.lei@redhat.com>
 <20181216022517.26650-4-ming.lei@redhat.com>
 <20181216161650.GD9957@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216161650.GD9957@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 16 Dec 2018 18:39:41 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 16 2018 at 11:16am -0500,
Christoph Hellwig <hch@lst.de> wrote:

> On Sun, Dec 16, 2018 at 10:25:16AM +0800, Ming Lei wrote:
> > This patch sets map->nr_queues as zero explictly if there is zero
> > queues for such queue type, then blk_mq_map_swqueue() can become
> > more robust to deal with shared mappings.
> 
> This looks a lot more clumsy than what we had before, can you explain
> what additional robustnes it buys us?

It enables nvme IO to complete on my testbed with for-4.21/block
changes, this NUMA layout is what triggered Ming's work:

# numactl --hardware
available: 2 nodes (0-1)
node 0 cpus: 0 2 4 6 8 10 12 14
node 0 size: 128605 MB
node 0 free: 128092 MB
node 1 cpus: 1 3 5 7 9 11 13 15
node 1 size: 128997 MB
node 1 free: 128529 MB
node distances:
node   0   1
  0:  10  21
  1:  21  10

Without the aggregate changes from this patchset (1-3 anyway) I get IO
hangs in blkdev_fsync().

With that in mind, Jens needs these fixes (or something comparable)
ASAP.

Tested-by: Mike Snitzer <snitzer@redhat.com>
