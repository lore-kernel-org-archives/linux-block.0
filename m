Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C5AC43461
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 08:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F081D61164
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 08:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhDHIJp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 04:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhDHIJn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Apr 2021 04:09:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 319BC6113D;
        Thu,  8 Apr 2021 08:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617869371;
        bh=EDBOgrUz8VxB1uH7uiMgZNQY00iTLS1DGawWaDEVVV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dhubm0mZjAVfKGnoEMUKJH9bsuP7aQ1qJc1cVA4oG9EPb+nc3utqhekOZTTNkscGZ
         deKb7EXi6GalWYbQeka1ZPREp27OX8u5JLe8HWDLqHCANUxQH7oVAMhbbXEyCbXcks
         y2ZuW94O+Nr44DIedN5arz7Ns/UJkjqQyMvNZSK8=
Date:   Thu, 8 Apr 2021 10:09:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>, keescook@chromium.org,
        dhowells@redhat.com, hch@infradead.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <YG66OWzum5DGcSTn@kroah.com>
References: <YEvA1dzDsFOuKdZ/@google.com>
 <20210319190924.GK4332@42.do-not-panic.com>
 <YFjHvUolScp3btJ9@google.com>
 <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com>
 <YGbNpLKXfWpy0ZZa@kroah.com>
 <87blap4kum.ffs@nanos.tec.linutronix.de>
 <YG6fpgmYSg/PwOrU@kroah.com>
 <nycvar.YFH.7.76.2104080957580.18270@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2104080957580.18270@cbobk.fhfr.pm>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 08, 2021 at 10:01:23AM +0200, Jiri Kosina wrote:
> On Thu, 8 Apr 2021, Greg KH wrote:
> 
> > Removing a module from a system has always been "let's try it and see!"
> > type of operation for a very long time.  
> 
> Which part of it?
> 
> If there is a driver/subsystem code that can't handle the reverse 
> operation to modprobe, it clearly can't handle error handling during 
> modprobe (which, one would hope, is supported), and should be fixed.

Huh?  No, that's not the issue here, it's the issue of different
userspace code paths into the module at the same time that it is trying
to be unloaded.  That has nothing to do with loading the module the
first time as userspace is not touching those apis yet.

> If there is a particular issue in kernel dynamic linker that causes crash 
> on module removal, we'd better off fixing it. Is there one such that makes 
> you claim module removal unsupported?

The linker has nothing to do with this, it's userspace tasks touching
code paths.

thanks,

greg k-h
