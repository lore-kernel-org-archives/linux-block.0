Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFC9C433DB
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 14:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A937965081
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 14:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbhCPOiw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:38:52 -0400
Received: from casper.infradead.org ([90.155.50.34]:34912 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbhCPOil (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 10:38:41 -0400
X-Greylist: delayed 1491 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Mar 2021 10:38:38 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rP6CC9aFyoPKSVnxzeAObDkX6GZ6Hhe9Q4ri+l1u2pA=; b=cH/w8vwNvLgG0SrRl2Nt+Fypv4
        QOXU8VhtVPS06zEJcVM/wsZRBm/HxFuL7D91SfEotUGCMU+/gi+VzHXFtP6PNZre6qRjHKndk/wf6
        z8AARNbhLCbMiMuvUhhhoyBo69Wo/Hwzj9NiIzU03/c5iR56Vx/eTWIhLr9nKcrcON+tphU0DDoim
        RJAaD6OXJH80dt+vLa6fUU3+FlwPldkltU1TStVILQpXKNqpFuu6ErwPUWUDdYmOo9b2kWDe+el9d
        nYJbWOCmcKwi1+QcVMtubksLCQqN413h1M3QvRxLihBxoVPaLGaE53BZY2nYC3pBwGh9162n2v8Ca
        9j8ywUOA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMARq-0009xZ-QS; Tue, 16 Mar 2021 14:13:29 +0000
Date:   Tue, 16 Mar 2021 14:13:26 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz?lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH -next 1/5] block: add disk sequence number
Message-ID: <20210316141326.GA37773@infradead.org>
References: <20210315200242.67355-1-mcroce@linux.microsoft.com>
 <20210315200242.67355-2-mcroce@linux.microsoft.com>
 <20210315201824.GB2577561@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315201824.GB2577561@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 15, 2021 at 08:18:24PM +0000, Matthew Wilcox wrote:
> On Mon, Mar 15, 2021 at 09:02:38PM +0100, Matteo Croce wrote:
> > From: Matteo Croce <mcroce@microsoft.com>
> > 
> > Add a sequence number to the disk devices. This number is put in the
> > uevent so userspace can correlate events when a driver reuses a device,
> > like the loop one.
> 
> Should this be documented as monotonically increasing?  I think this
> is actually a media identifier.  Consider (if you will) a floppy disc.
> Back when such things were common, it was possible with personal computers
> of the era to have multiple floppy discs "in play" and be prompted to
> insert them as needed.  So shouldn't it be possible to support something
> similar here -- you're really removing the media from the loop device.
> With a monotonically increasing number, you're always destroying the
> media when you remove it, but in principle, it should be possible to
> reinsert the same media and have the same media identifier number.

And we have some decent infrastructure related to media changes,
grep for disk_events.  I think this needs to plug into that
infrastructure instead of duplicating it.
