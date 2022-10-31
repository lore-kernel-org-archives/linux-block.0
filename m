Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C13FA3741
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 23:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJaXf2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJaXf1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 19:35:27 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F0114085
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 16:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IMGz2SAB3D5nzXU64vkTX3aNECs06DRf93jVZC3ofJw=; b=PL3hesQLfFrGAb19UiaLAXh+uO
        4oagQKQ9xE6kROcwq2005y3ygCUbjDdPY78dLC/9kYLomjQ2m1GWdXLr8aSJbvEgtQkQciwzIrdFs
        wVqFsOXw4IDuWOsQTTnBYlEaQnqICaVyg1NW63kuAL+rvzooDFNBt3/Be7XXebZff/AGeZGfeWrfN
        qqbE6+9z4SdXNQULvkD7ZQQYN+r64NW75XDUuq0LkAxQo6FDoGfLZjp/lLYNzGff9HK2n6ZgKe353
        e1QEjMyPi2crbL9vgOzfvIj6lmQYYTOPDvE4arJoL4j2bWpAvnde/zZA6Ak+nZAcxvCLULg6pRwBo
        4kupn2Sw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1opeJQ-00Goid-2i;
        Mon, 31 Oct 2022 23:35:25 +0000
Date:   Mon, 31 Oct 2022 23:35:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: UAF in blk_add_rq_to_plug()?
Message-ID: <Y2BbvIdYGM/4L66H@ZenIV>
References: <Y2BIad98er4QsbZY@ZenIV>
 <1a46585b-878b-a3b7-3090-36bddba86dbd@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a46585b-878b-a3b7-3090-36bddba86dbd@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 31, 2022 at 04:42:11PM -0600, Jens Axboe wrote:
> On 10/31/22 4:12 PM, Al Viro wrote:
> > static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
> > {
> >         struct request *last = rq_list_peek(&plug->mq_list);
> > 
> > Suppose it's not NULL...
> > 
> >         if (!plug->rq_count) {
> >                 trace_block_plug(rq->q);
> >         } else if (plug->rq_count >= blk_plug_max_rq_count(plug) ||
> >                    (!blk_queue_nomerges(rq->q) &&
> >                     blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
> > ... and we went here:
> >                 blk_mq_flush_plug_list(plug, false);
> > All requests, including the one last points to, might get fed ->queue_rq()
> > here.  At which point there seems to be nothing to prevent them getting
> > completed and freed on another CPU, possibly before we return here.
> > 
> >                 trace_block_plug(rq->q);
> >         }
> > 
> >         if (!plug->multiple_queues && last && last->q != rq->q)
> > ... and here we dereference last.
> > 
> > Shouldn't we reset last to NULL after the call of blk_mq_flush_plug_list()
> > above?
> 
> There's no UAF here as the requests aren't freed. We could clear 'last'
> to make the code more explicit, and that would avoid any potential
> suboptimal behavior with ->multiple_queues being wrong.

Umm...
Suppose ->has_elevator is false and so's ->multiple_queues.
No ->queue_rqs(), so blk_mq_flush_plug_list() grabs rcu_read_lock() and
hit blk_mq_plug_issue_direct().
blk_mq_plug_issue_direct() picks the first request off the list
and passes it to blk_mq_request_issue_directly(), which passes it
to __blk_mq_request_issue_directly().  There we grab a tag and
proceed to __blk_mq_issue_directly(), which feeds request to ->queue_rq().

What's to stop e.g. worker on another CPU from picking that sucker,
completing it and calling blk_mq_end_request() which completes all
bio involved and calls blk_mq_free_request()?

If all of that manages to happen before blk_mq_flush_plug_list()
returns to caller...  Sure, you probably won't hit in on bare
metal, but if you are in a KVM and this virtual CPU happens to
lose the host timeslice... I've seen considerably more narrow
race windows getting hit on such setups.

Am I missing something subtle here?  It's been a long time since
I've read through that area - as the matter of fact, I'm trying
to refresh my memories of the bio_submit()-related code paths
at the moment...
