Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E18C433F5
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 20:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8EC461AA7
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 20:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhKQUvT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 15:51:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235365AbhKQUvP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 15:51:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51EF961AA7;
        Wed, 17 Nov 2021 20:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637182096;
        bh=i+WAz1KfP/0IAzi9nX2DnJaE0z5nZ3hbAFivo8z9j9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnG6EAhyIpYxAk1ZLwq3vSaOgWCxyb5TX4jAYcUuF9rGBWLIsBBzfkj+ffQ1bVLXa
         sokOT1sw4DJJrMHgAYHwhOZyUo1vLurCG4cuRHIDwi/fUPyC8v+hLR8Hg923jUDUhQ
         bGHpy79RGyUw2sfSFjuKIdy7jOfFdm6Pg1eMsQBZDKmgIJ22fgsfdLXBeAl1SHu493
         QGiJ+1EKboqrcqi7PK6F+IZUPLyX1jgp7+t9Txp0vo2WG+mP6wfbevjIxLGRTmWRlT
         ik300KF9gb+Uj1D92gbXU3HKmUkxRLMA0ayEmT4lCMnqnHvOxbtUdtQ8WcoheBVMGa
         HEZ5V40UUJPYA==
Date:   Wed, 17 Nov 2021 12:48:14 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        hch@infradead.org
Subject: Re: [PATCH 1/4] block: add mq_ops->queue_rqs hook
Message-ID: <20211117204814.GB3295649@dhcp-10-100-145-180.wdc.com>
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-2-axboe@kernel.dk>
 <YZS7XPMlvMEP5yfp@T590>
 <942f12f8-a334-f90b-481b-ff3b36fb1102@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <942f12f8-a334-f90b-481b-ff3b36fb1102@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 17, 2021 at 08:43:02AM -0700, Jens Axboe wrote:
> On 11/17/21 1:20 AM, Ming Lei wrote:
> > On Tue, Nov 16, 2021 at 08:38:04PM -0700, Jens Axboe wrote:
> >> If we have a list of requests in our plug list, send it to the driver in
> >> one go, if possible. The driver must set mq_ops->queue_rqs() to support
> >> this, if not the usual one-by-one path is used.
> >>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >> ---
> >>  block/blk-mq.c         | 17 +++++++++++++++++
> >>  include/linux/blk-mq.h |  8 ++++++++
> >>  2 files changed, 25 insertions(+)
> >>
> >> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >> index 9b4e79e2ac1e..005715206b16 100644
> >> --- a/block/blk-mq.c
> >> +++ b/block/blk-mq.c
> >> @@ -2208,6 +2208,19 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
> >>  	int queued = 0;
> >>  	int errors = 0;
> >>  
> >> +	/*
> >> +	 * Peek first request and see if we have a ->queue_rqs() hook. If we
> >> +	 * do, we can dispatch the whole plug list in one go. We already know
> >> +	 * at this point that all requests belong to the same queue, caller
> >> +	 * must ensure that's the case.
> >> +	 */
> >> +	rq = rq_list_peek(&plug->mq_list);
> >> +	if (rq->q->mq_ops->queue_rqs) {
> >> +		rq->q->mq_ops->queue_rqs(&plug->mq_list);
> >> +		if (rq_list_empty(plug->mq_list))
> >> +			return;
> >> +	}
> >> +
> > 
> > Then BLK_MQ_F_TAG_QUEUE_SHARED isn't handled as before for multiple NVMe
> > NS.
> 
> Can you expand? If we have multiple namespaces in the plug list, we have
> multiple queues. There's no direct issue of the list if that's the case.
> Or maybe I'm missing what you mean here?

If the plug list only has requests for one namespace, I think Ming is
referring to the special accounting for BLK_MQ_F_TAG_QUEUE_SHARED in
__blk_mq_get_driver_tag() that normally gets called before dispatching
to the driver, but isn't getting called when using .queue_rqs().
