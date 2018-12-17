Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6FCC43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 07:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B314217F4
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 07:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbeLQHGG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:06:06 -0500
Received: from verein.lst.de ([213.95.11.211]:60661 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbeLQHGG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 02:06:06 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8B38568DD3; Mon, 17 Dec 2018 08:06:04 +0100 (CET)
Date:   Mon, 17 Dec 2018 08:06:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 1/4] nvme-pci: correct mapping for poll queue(s)
Message-ID: <20181217070604.GA1694@lst.de>
References: <20181216022517.26650-1-ming.lei@redhat.com> <20181216022517.26650-2-ming.lei@redhat.com> <20181216161159.GB9957@lst.de> <20181217010051.GA1223@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217010051.GA1223@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 17, 2018 at 09:00:52AM +0800, Ming Lei wrote:
> On Sun, Dec 16, 2018 at 05:11:59PM +0100, Christoph Hellwig wrote:
> > On Sun, Dec 16, 2018 at 10:25:14AM +0800, Ming Lei wrote:
> > > If we don't have poll queue, its mapping should share default type's,
> > > instead of setting up one new mapping via blk_mq_map_queues().
> > 
> > No, if we don't have poll queues nr_maps should be 2.  I've already
> > posted a patch for that for nvme-pci which got it wrong (my fault..)
> 
> This patch doesn't touch nr_maps.
> 
> The issue is that if poll_queues/write_queues are zero, all three mapping
> should be same, however they aren't actually because we still use blk_mq_map_queues()
> to build a new mapping for poll queue.

In Jens' for-4.21 we only support polling with explicit poll queues,
and thus an explicit poll map.  Which means nr_maps must be 3 if you
support poll maps, and < 3 if you don't.  As said, the only user actually
got that wrong (my fault), but the fix is already queue up in the nvme
tree and on its way to Jens.
