Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3EEC433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 16:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852056196B
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 16:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhCSQCT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 12:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhCSQBv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 12:01:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B10D761966;
        Fri, 19 Mar 2021 16:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616169711;
        bh=nU73sq9caGUykcwl1bR5K/bF1jndVfw0t83cxdPoGtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hCpXxJMoiKt6DA2Dv6BVYzBFAOVn/5MeXQLKrmP9b/ZiLTrJGfkyeYDUmKeCvOYRP
         Y3A2MdnS/aP0sz6yuYsNZgFC+mJ4sHj0nNI/cDhj8jZ5XPJqVnpeCOFuJD2Vyfu0BS
         kdSASenfKguOh6V7XU/TufysSNhNolWGJ950kMh+WoGd4yYS/nknga1lUuYgCwEgKw
         5a/flwRqn9faRnRGzlTO9lcThds45ZX0Baj700EXw71EMk5MvvblCQLbhrhrKFGVgR
         yv38lqQLtEmC5Jub6JYuBHy1GqXvcQ8EE9sw9qzIks9FS7ufwL0bAvkXtw8fd6h+9p
         hOIQKEEJB6Agw==
Date:   Sat, 20 Mar 2021 01:01:47 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jason Yan <yanaijie@huawei.com>, axboe@kernel.dk, hch@lst.de,
        keescook@chromium.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: do not copy data to user when bi_status is error
Message-ID: <20210319160147.GB3794@redsun51.ssa.fujisawa.hgst.com>
References: <20210318122621.330010-1-yanaijie@huawei.com>
 <20210318151305.GB31228@redsun51.ssa.fujisawa.hgst.com>
 <YFQAKIjt5VzUNYDe@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFQAKIjt5VzUNYDe@T590>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 19, 2021 at 09:36:40AM +0800, Ming Lei wrote:
> On Fri, Mar 19, 2021 at 12:13:05AM +0900, Keith Busch wrote:
> > On Thu, Mar 18, 2021 at 08:26:21PM +0800, Jason Yan wrote:
> > > When the user submitted a request with unaligned buffer, we will
> > > allocate a new page and try to copy data to or from the new page.
> > > If it is a reading request, we always copy back the data to user's
> > > buffer, whether the result is good or error. So if the driver or
> > > hardware returns an error, garbage data is copied to the user space.
> > > This is a potential security issue which makes kernel info leaks.
> > > 
> > > So do not copy the uninitalized data to user's buffer if the
> > > bio->bi_status is not BLK_STS_OK in bio_copy_kern_endio_read().
> > 
> > If we're using copy_kern routines, doesn't that mean it's a kernel
> > request rather than user space?
> 
> It can be a kernel bounce buffer, which will be copied to user space
> later, such as sg_scsi_ioctl(), but sg_scsi_ioctl() checks the request
> result and not copy kernel buffer back in case of error.

Wow, that interface has said it was deprecated since 2006! And there
doesn't appear to be any reason that it's not using blk_rq_map_user()
instead, which already sanitizes bounce buffers copied back to user
space.
