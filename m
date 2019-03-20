Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E63FC4360F
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 15:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FDE21873
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 15:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553094966;
	bh=Q2uqz0abO13IbpvyBS4N4DFeCsQZY/7NG+N/1M9GJIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xKerxpf5NknBMWORTBTBAQCAHtD2tFr1jEGK3XsIzbtO6itARhPxqT7+rMQQRJtPB
	 bhkejggfvZwpe7UeQXZ4vm5CwfE9SqvCAFc32ij7drcLl2Epqk0wVv+JhKcDiVKvJ9
	 vVQr9BWXqLxQiUoprThhQcx9aeFJHFZYmkUp1nEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfCTPQF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:16:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfCTPQF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 11:16:05 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4F8B2184D;
        Wed, 20 Mar 2019 15:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553094964;
        bh=Q2uqz0abO13IbpvyBS4N4DFeCsQZY/7NG+N/1M9GJIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2tNDJgMnHex4iEG+T/GCfI1RJTZEC60vP3Gm3eTGdjJ2W+YzMBKO07KWK5n5b/pWj
         X55MCttyl/snF6KukqXoUf0CzF0kFcuXA7Ax4Lqc7gerhoPtDHTHw33aDJGXd0H0Sr
         R1L7kdAgSR3MLgnnRX72R+wHz0S6Y77v1Scev/RM=
Date:   Wed, 20 Mar 2019 16:16:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: Revert commit 310ca162d77
Message-ID: <20190320151601.GA31992@kroah.com>
References: <20190320125806.GD9485@quack2.suse.cz>
 <20190320151231.GA31247@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320151231.GA31247@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 20, 2019 at 04:12:31PM +0100, Greg KH wrote:
> On Wed, Mar 20, 2019 at 01:58:06PM +0100, Jan Kara wrote:
> > Hello,
> > 
> > commit 310ca162d77 "block/loop: Use global lock for ioctl() operation." has
> > been pushed to multiple stable trees. This patch is a part of larger series
> > that overhauls the locking inside loopback device upstream and for 4.4,
> > 4.9, and 4.14 stable trees only this patch from the series is applied. Our
> > testing now has shown [1] that the patch alone makes present deadlocks
> > inside loopback driver more likely (the openqa test in our infrastructure
> > didn't hit the deadlock before whereas with the new kernel it hits it
> > reliably every time). So I would suggest we revert 310ca162d77 from 4.4,
> > 4.9, and 4.14 kernels.
> 
> Ugh, ok.
> 
> > Another option would be to backport other locking fixes for the loop
> > device but honestly I don't think that's a stable material - never heard
> > of real users hitting problems, only syzkaller could, and we are still
> > fixing up some small glitches resulting from that rework...
> 
> I tried to backport a number of the loop fixes, and odds are I am the
> one that grabbed this.  There are other loop locking fixes in the stable
> releases, I don't know if I can just revert this one, let me check...

Nope, does not revert cleanly due to the other loop fixes I added after
this one.

So either I back out _all_ of the loop patches, or we leave what we have
now, or we add the proper fixes to get things working.  I'd like to have
this all work properly, so why not just have me backport the needed
fixes that are upstream?

thanks,

greg k-h
