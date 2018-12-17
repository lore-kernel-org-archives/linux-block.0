Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40286C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 10:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F33B20675
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 10:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeLQK51 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:57:27 -0500
Received: from verein.lst.de ([213.95.11.211]:33579 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbeLQK51 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 05:57:27 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E949D68DD3; Mon, 17 Dec 2018 11:57:25 +0100 (CET)
Date:   Mon, 17 Dec 2018 11:57:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH V2 2/4] blk-mq: fix shared queue mapping
Message-ID: <20181217105725.GA5826@lst.de>
References: <20181217104248.5828-1-ming.lei@redhat.com> <20181217104248.5828-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217104248.5828-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 17, 2018 at 06:42:46PM +0800, Ming Lei wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Even though poll_queues are zero, nvme's mapping for HCTX_TYPE_POLL still
> may be setup via blk_mq_map_queues() which cause different mapping compared
> with HCTX_TYPE_DEFAULT's mapping built from managed irq affinity.
> 
> This mapping will cause hctx->type to be over-written in blk_mq_map_swqueue(),
> then the whole mapping may become broken, for example, one same ctx can be
> mapped to different hctxs with same hctx type. This bad mapping has caused
> IO hang in simple dd test, as reported by Mike.
> 
> This patch sets map->nr_queues as zero explictly if there is zero
> queues for such queue type, also maps to correct hctx if .nr_queues of the
> queue type is zero.
> 
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> 
> (don't handle zero .nr_queues map in blk_mq_map_swqueue())
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I actually think we should split this into three patches:

 1) skip zero-queue maps in blk_mq_map_swqueue
 2) skip zero-queue maps in blk_mq_map_queue
 3) don't duplicate maps in nvme

sorry for misleading you with my quick WIP patch.

I can send send patches for my two with a proper changelogs, but
I'll leave blk_mq_map_swqueue to you as I don't full understand
the rationale, even if it looks sensible to me.
