Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEB7C433EF
	for <linux-block@archiver.kernel.org>; Wed, 19 Jan 2022 21:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245634AbiASVDV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jan 2022 16:03:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22615 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245242AbiASVDU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jan 2022 16:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642626200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RclBE4j/l0I/3NwHx38MPLT8IFYI9e2HwkR+3iNqKtg=;
        b=MPPGG3xZWHn+gtMvCtIGWIu1Ho3MDpCUVJYRY6p73SpYtmTy8NuwxWO0+vF/mE6wUZnCut
        VKV+qLjpXhWayFcissGdopdCa54DJE4tIgg9JCuXnxQWz573j3O835qGcwkBcAT3ZsTwZl
        6KkNLgmuklWph/cnwyQ3+TCyepvJTbs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-2sjSrKZsOIWFyMoHV88rGw-1; Wed, 19 Jan 2022 16:03:18 -0500
X-MC-Unique: 2sjSrKZsOIWFyMoHV88rGw-1
Received: by mail-qv1-f70.google.com with SMTP id kk29-20020a056214509d00b0041c9228d334so3954917qvb.23
        for <linux-block@vger.kernel.org>; Wed, 19 Jan 2022 13:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RclBE4j/l0I/3NwHx38MPLT8IFYI9e2HwkR+3iNqKtg=;
        b=SU3AXazY91p9tClVBKaLINrz9nGXH1t7qQ08cGPC50dGs6KGm5IqqFNMpn542IhdKS
         WU4dip/LlNs50xnibcL8t503G+JRHhiBczpkx6TjJ7EY5UQ59gzMDsZRPoyB3VTnpYpY
         QtlkLtjN7scMShjz6202m2XE+Yy9XnM43VAvQLES6kEWLhgC5+yAfiXUVcc3jhY9M3MT
         b6Pk2ZRyWWGIjYvIYQgrnYuGDeBphNKMmAlJgrI2Oc9EwbjR5uSowOPXeaUFii89ufcN
         jbFCHhTXSSNsrHWWh6huCjxWzJ/apog50WTubZrrBFZCqZQTJIeF81G8V0IU4Uw+ph6g
         ouFA==
X-Gm-Message-State: AOAM533DDpQNM7rmsf3zP/b4YuzvUMN5osx6yZOR5JHv1FJFpEk+Lexj
        +eciosav52Lq7zBjqNGqNJsIE4BGqy4fPcSHUtybrPmo7+RvbTlvaIxYbJlCOttUNBm3dLbHiAk
        Hp/BE6/ceoIcpcvH8Junl2Q==
X-Received: by 2002:a37:44cd:: with SMTP id r196mr22696145qka.90.1642626198298;
        Wed, 19 Jan 2022 13:03:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMQlq2CHwYQqUY+ubV1rButdo/mjYgi37vO2ELr0QtyVP0CLAc4/4GF1GPZIaw1sTQfZZXNQ==
X-Received: by 2002:a37:44cd:: with SMTP id r196mr22696123qka.90.1642626198034;
        Wed, 19 Jan 2022 13:03:18 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id p9sm395169qtk.39.2022.01.19.13.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 13:03:17 -0800 (PST)
Date:   Wed, 19 Jan 2022 16:03:16 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jeff Moyer <jmoyer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 0/3] blk-mq/dm-rq: support BLK_MQ_F_BLOCKING for dm-rq
Message-ID: <Yeh8lKeb8Rl96FyN@redhat.com>
References: <20211221141459.1368176-1-ming.lei@redhat.com>
 <YcH/E4JNag0QYYAa@infradead.org>
 <YcP4FMG9an5ReIiV@T590>
 <YcuB4K8P2d9WFb83@redhat.com>
 <Yd1BFpYTBlQSPReW@infradead.org>
 <x49ee5ejfly.fsf@segfault.boston.devel.redhat.com>
 <YeUkZGw4vLqdB17p@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeUkZGw4vLqdB17p@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 17 2022 at  3:10P -0500,
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Jan 11, 2022 at 01:23:53PM -0500, Jeff Moyer wrote:
> > Maybe I have bad taste, but the patches didn't look like cruft to me.
> > :)
> 
> They do to me.  The extend the corner case of request on request
> stacking that already is a bit of mess even more by adding yet another
> special case in the block layer.

Ming's first patch:
https://patchwork.kernel.org/project/dm-devel/patch/20211221141459.1368176-2-ming.lei@redhat.com/
is pure cleanup for the mess that went in this merge cycle.

All that dm-rq context aside, Ming's 1st patch is the correct way to
clean up the block core flags/state (internal vs external, etc).

But the 2nd paragraph of that first patch's header should be moved to
Ming's 2nd patch because it explains why DM needs the new
blk_alloc_disk_srcu() interface, e.g.:
"But dm queue is allocated before tagset is allocated"
(so it confirms it best to explain that in 2nd patch).

But really even Ming's 2nd patch:
https://patchwork.kernel.org/project/dm-devel/patch/20211221141459.1368176-3-ming.lei@redhat.com/
should _not_ need to be debated like this.

Fact is alloc_disk() has always mirrored blk_alloc_queue()'s args.  So
Ming's 2nd patch should be done anyway to expose meaningful control
over request_queue allocation.  If anything, the 2nd patch should just
add the 'alloc_srcu' arg to blk_alloc_disk() and change all but NVMe
callers to pass false.

Put another way: when the 'node_id' arg was added to blk_alloc_queue()
a new blk_alloc_disk_numa_node() wasn't added (despite most block
drivers still only using NUMA_NO_NODE).  This new 'alloc_srcu' flag is
seen to be more niche, but it really should be no different on an
interface symmetry and design level.

> > I'm not sure why we'd prevent users from using dm-mpath on nvmeof.  I
> > think there's agreement that the nvme native multipath implementation is
> > the preferred way (that's the default in rhel9, even), but I don't think
> > that's a reason to nack this patch set.
> > 
> > Or have I missed your point entirely?
> 
> No you have not missed the point.  nvme-multipath exists longer than
> the nvme-tcp driver and is the only supported one for it upstream for
> a good reason.  If RedHat wants to do their own weirdo setups they can
> patch their kernels, but please leave the upstrem code alone.

Patch 3 can be left out if you'd like to force your world view on
everyone... you've already "won", _pretty please_ stop being so
punitive by blocking reasonable change.  We really can get along if
we're all willing to be intellectually honest.

To restate: Ming's patches 1 and 2 really are not "cruft".  They
expose control over request_queue allocation that should be accessible
by both blk_alloc_queue() and blk_alloc_disk().

Mike

