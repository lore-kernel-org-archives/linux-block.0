Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A89DC433B4
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 08:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EEDF6115B
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 08:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhDHIff (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 04:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230143AbhDHIfd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Apr 2021 04:35:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D093061164;
        Thu,  8 Apr 2021 08:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617870922;
        bh=BEaco4g2a06N1Cu9BMmZSo61MPIxsXW2hodAnCuxAxI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=rOlLpgA32RNua4zMfU9JoxHhhwUwkoV54HuUZW8w8LZVM59n/WaowiIEiP1XdmJv2
         Wxkue8OElnCYw4UIQeuvcn0bULQW/P4D1HnS6CCIF1FMDA1Fg+DJzmGwAR7huKvTMp
         4Ni7JoFltjm4Y42DH4Ka+EOyxeSnkTqccyF4ZBu5zm5lXNkty7Pizy6cj+zGxZiv7U
         UOdbcdN1Ck9n/eApgGSbSjvCyvOPfVRADYxnclEM/LiBEVbSD6IXzC1T8/bNEcUkas
         9GysknsOJwKIG2yqDF6iOlWQEoOHN5oHck5By9Y3NVOL1Qyi8J2rwxmJqXw1rebg1U
         py0z5+0YZkSgA==
Date:   Thu, 8 Apr 2021 10:35:17 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>, keescook@chromium.org,
        dhowells@redhat.com, hch@infradead.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
In-Reply-To: <YG66OWzum5DGcSTn@kroah.com>
Message-ID: <nycvar.YFH.7.76.2104081015340.18270@cbobk.fhfr.pm>
References: <YEvA1dzDsFOuKdZ/@google.com> <20210319190924.GK4332@42.do-not-panic.com> <YFjHvUolScp3btJ9@google.com> <20210322204156.GM4332@42.do-not-panic.com> <YFkWMZ0m9nKCT69T@google.com> <20210401235925.GR4332@42.do-not-panic.com> <YGbNpLKXfWpy0ZZa@kroah.com>
 <87blap4kum.ffs@nanos.tec.linutronix.de> <YG6fpgmYSg/PwOrU@kroah.com> <nycvar.YFH.7.76.2104080957580.18270@cbobk.fhfr.pm> <YG66OWzum5DGcSTn@kroah.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 8 Apr 2021, Greg KH wrote:

> > If there is a driver/subsystem code that can't handle the reverse 
> > operation to modprobe, it clearly can't handle error handling during 
> > modprobe (which, one would hope, is supported), and should be fixed.
> 
> Huh?  No, that's not the issue here, it's the issue of different
> userspace code paths into the module at the same time that it is trying
> to be unloaded.  That has nothing to do with loading the module the
> first time as userspace is not touching those apis yet.

So do you claim that once the first (out of possibly many) 
userspace-visible sysfs entry has been created during module insertion and 
made available to userspace, there is never going to be rollback happening 
that'd be removing that first sysfs entry again?

Thanks,

-- 
Jiri Kosina
SUSE Labs

