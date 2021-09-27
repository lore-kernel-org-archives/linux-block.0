Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A688BC433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 12:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851FC6103B
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 12:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhI0MPl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:15:41 -0400
Received: from verein.lst.de ([213.95.11.211]:46465 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234073AbhI0MPk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 08:15:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0A23467373; Mon, 27 Sep 2021 14:04:42 +0200 (CEST)
Date:   Mon, 27 Sep 2021 14:04:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/4] block: drain file system I/O on del_gendisk
Message-ID: <20210927120441.GA25223@lst.de>
References: <20210922172222.2453343-1-hch@lst.de> <20210922172222.2453343-4-hch@lst.de> <YUvZi2a0KjxEkiHo@T590> <20210923052705.GA5314@lst.de> <YUwhPy1J8lzHQF77@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUwhPy1J8lzHQF77@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 23, 2021 at 02:39:59PM +0800, Ming Lei wrote:
> > > After blk_mq_unfreeze_queue() returns, blk_try_enter_queue() will return
> > > true, so new FS I/O from opened bdev still won't be blocked, right?
> > 
> > It won't be blocked by blk_mq_unfreeze_queue, but because the capacity
> > is set to 0 it still won't make it to the driver.
> 
> One bio could be made & checked before set_capacity(0), then is
> submitted after blk_mq_unfreeze_queue() returns.
> 
> blk_mq_freeze_queue_wait() doesn't always imply RCU grace period, for
> example, the .q_usage_counter may have been in atomic mode before
> calling blk_queue_start_drain() & blk_mq_freeze_queue_wait().

True, but this isn't really a new issue as we never had proper quiesce
behavior.  I have a bunch of ideas of how to make this actually solid,
but none of them looks like 5.15 material.

