Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF9BC10F05
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 15:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37C121873
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 15:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553094756;
	bh=cgey03YGMsaWzYa5SArv5hvqi4kZuGNAoXv+ly7VTmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XUf58BQ2sc5Je4qGHUl82QaYCRwlqlp7zkb8HMWrtHGG3pWNGCLOB9i8yi/7e4/zQ
	 DgdgTXe7tYfdeYqycwC89n/Utv/Q79V7rUGtLvPqJhVwZdGuKo1S1AsiS/Vsn3mQC/
	 vkSqJ6onU2oxFBXIis9VQpLvSlTN0VTknMcaS9p0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfCTPMf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfCTPMe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 11:12:34 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D12AC2184D;
        Wed, 20 Mar 2019 15:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553094754;
        bh=cgey03YGMsaWzYa5SArv5hvqi4kZuGNAoXv+ly7VTmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3IPKlYueZ3ybYTH2vqMBuXDNfzG6zUlG70z3mLEZGAWs0QThz2omqqFsUwk3SUwO
         wM1RFoiXQU4vYmF7ts1KzBZAvPXqYkclQCkFG5ytbspifRrv2/6MjSxzIAI68nlxJr
         5HsRuIvw1710NN1z5K+o678b10EImgBdslbufVFM=
Date:   Wed, 20 Mar 2019 16:12:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: Revert commit 310ca162d77
Message-ID: <20190320151231.GA31247@kroah.com>
References: <20190320125806.GD9485@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320125806.GD9485@quack2.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 20, 2019 at 01:58:06PM +0100, Jan Kara wrote:
> Hello,
> 
> commit 310ca162d77 "block/loop: Use global lock for ioctl() operation." has
> been pushed to multiple stable trees. This patch is a part of larger series
> that overhauls the locking inside loopback device upstream and for 4.4,
> 4.9, and 4.14 stable trees only this patch from the series is applied. Our
> testing now has shown [1] that the patch alone makes present deadlocks
> inside loopback driver more likely (the openqa test in our infrastructure
> didn't hit the deadlock before whereas with the new kernel it hits it
> reliably every time). So I would suggest we revert 310ca162d77 from 4.4,
> 4.9, and 4.14 kernels.

Ugh, ok.

> Another option would be to backport other locking fixes for the loop
> device but honestly I don't think that's a stable material - never heard
> of real users hitting problems, only syzkaller could, and we are still
> fixing up some small glitches resulting from that rework...

I tried to backport a number of the loop fixes, and odds are I am the
one that grabbed this.  There are other loop locking fixes in the stable
releases, I don't know if I can just revert this one, let me check...

And yes, I did get some loop bugreports from the Android kernel team as
they are using loop devices in large numbers on the new Android release
for something.  So I think they have already backported a number of
these fixes to their trees, which made me want to push these out to more
people.

Also, given that syzbot has a reproducer for 310ca162d77, are we worst
off if we revert it?

thanks,

greg k-h
