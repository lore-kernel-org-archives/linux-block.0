Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55175C4707A
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 20:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F30E61168
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 20:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhEUUDS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 16:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhEUUDS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 16:03:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7686D61164;
        Fri, 21 May 2021 20:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621627314;
        bh=NhqZP90YMddmYjITtwZRd1OIGLXENWQW1IPKs0b5/PA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2WI/9rihsij5V102pYlp5VCse4F/T+XXmBuW06y9bnq6BcKoxgy7kjVrYPFT1O0zi
         VaKmWFJDzetnkYIbKYl04TzHxj/EwLLY758ONds5bzCSAjqMTm3kajRZaz4BublQLa
         bftEgFdlG1kxrcw9qSQwRBRl/DZCWY4aPufE8190=
Date:   Fri, 21 May 2021 22:01:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Douglas Gilbert <dgilbert@interlog.com>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] zram: fix few sysfs races
Message-ID: <YKgRsCzwp2O2mYcp@kroah.com>
References: <20210423011108.11988-1-mcgrof@kernel.org>
 <YKVwZVcbZBNXUpKm@google.com>
 <20210519202023.GU4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519202023.GU4332@42.do-not-panic.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 19, 2021 at 08:20:23PM +0000, Luis Chamberlain wrote:
> Greg,
> 
> your feedback would be appreciated here.

Appreciated where?  This is a zram patchset, what do I need to mess with
it for?



> 
> On Wed, May 19, 2021 at 01:09:09PM -0700, Minchan Kim wrote:
> > On Fri, Apr 23, 2021 at 01:11:04AM +0000, Luis Chamberlain wrote:
> > > This 2nd series documents the fixes better and includes a bdgrab() fix
> > > for the issue noted by Minchan. A general fix has been proposed for two
> > > of these issues however they are not yet deemed required upstream and so
> > > we just open code individual solutions on the driver.
> > > 
> > > Luis Chamberlain (4):
> > >   zram: fix crashes due to use of cpu hotplug multistate
> > >   zram: avoid disksize setting when device is being claimed
> > >   zram: fix deadlock with sysfs attribute usage and driver removal
> > >   zram: fix possible races between sysfs use and bdev access
> > > 
> > >  drivers/block/zram/zram_drv.c | 473 +++++++++++++++++++++++++++++-----
> > >  1 file changed, 414 insertions(+), 59 deletions(-)
> > 
> > Hi Luis,
> > 
> > First of all, I am sorry too late review. Now I see [3/4] and [4/4] would
> > be not only zram issue since you shed a light in the descriptions.
> > Yeah, that would be helpful if it could be deal with under general
> > layer but looks like arguable or would take some times at least, IIUC.
> > 
> > On the case, yeah, we could fix it for zram first until the issue will
> > bring up further. Anyway, I'd like to see some wrapper rather than annotating
> > for every sysfs files for maintainance point of view.
> > At least, could you introduce one more patch "introduce zram sysfs wrapper"
> > on top of this series to centralize the work?
> > 
> > Thanks for your works!
> 
> Since I did the work for a general fix as an alternative proof of
> concept to the ugliness reflected on those two last patches, I'd like
> instead for Greg to re-consider merging a general fix.
> 
> Greg, can you comment on technical levels why a general core fix is not
> desirable upstream for those two issues?

What issues exactly?

totally confused,

greg k-h
