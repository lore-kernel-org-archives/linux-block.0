Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E497DC2BA1A
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 10:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA060206D7
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 10:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgDXKiz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:38:55 -0400
Received: from verein.lst.de ([213.95.11.211]:34307 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgDXKiz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 06:38:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6055868CEE; Fri, 24 Apr 2020 12:38:51 +0200 (CEST)
Date:   Fri, 24 Apr 2020 12:38:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200424103851.GD28156@lst.de>
References: <20200424102351.475641-1-ming.lei@redhat.com> <20200424102351.475641-8-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424102351.475641-8-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 24, 2020 at 06:23:47PM +0800, Ming Lei wrote:
> Before one CPU becomes offline, check if it is the last online CPU of hctx.
> If yes, mark this hctx as inactive, meantime wait for completion of all
> in-flight IOs originated from this hctx. Meantime check if this hctx has
> become inactive in blk_mq_get_driver_tag(), if yes, release the
> allocated tag.
> 
> This way guarantees that there isn't any inflight IO before shutdowning
> the managed IRQ line when all CPUs of this IRQ line is offline.

Can you take a look at all my comments on the previous version here
(splitting blk_mq_get_driver_tag for direct_issue vs not, what is
the point of barrier(), smp_mb__before_atomic and
smp_mb__after_atomic), as none seems to be addressed and I also didn't
see a reply.
