Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A979BC2BA1A
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 10:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895FF2071E
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 10:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgDXKgB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:36:01 -0400
Received: from verein.lst.de ([213.95.11.211]:34298 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgDXKgA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 06:36:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 538C968CEE; Fri, 24 Apr 2020 12:35:58 +0200 (CEST)
Date:   Fri, 24 Apr 2020 12:35:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V8 04/11] blk-mq: assign rq->tag in
 blk_mq_get_driver_tag
Message-ID: <20200424103558.GC28156@lst.de>
References: <20200424102351.475641-1-ming.lei@redhat.com> <20200424102351.475641-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424102351.475641-5-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 24, 2020 at 06:23:44PM +0800, Ming Lei wrote:
> Especially for none elevator, rq->tag is assigned after the request is
> allocated, so there isn't any way to figure out if one request is in
> being dispatched. Also the code path wrt. driver tag becomes a bit
> difference between none and io scheduler.
> 
> When one hctx becomes inactive, we have to prevent any request from
> being dispatched to LLD. And get driver tag provides one perfect chance
> to do that. Meantime we can drain any such requests by checking if
> rq->tag is assigned.
> 
> So only assign rq->tag until blk_mq_get_driver_tag() is called.
> 
> This way also simplifies code of dealing with driver tag a lot.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
