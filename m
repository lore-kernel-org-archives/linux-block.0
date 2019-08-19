Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BCCC3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 17:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666EE22CF6
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 17:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfHSR0i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:26:38 -0400
Received: from guest-port.merlins.org ([173.11.111.148]:44134 "EHLO
        mail1.merlins.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfHSR0i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 13:26:38 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1hzlQS-0007yT-Sp by authid <merlin>; Mon, 19 Aug 2019 10:26:36 -0700
Date:   Mon, 19 Aug 2019 10:26:36 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     o1bigtenor@gmail.com, linux-block@vger.kernel.org,
        Linux-RAID <linux-raid@vger.kernel.org>
Subject: Re: 5.1.21 Dell 2950 terrible swraid5 I/O performance with swraid on top of Perc 5/i raid0/jbod
Message-ID: <20190819172636.GG5431@merlins.org>
References: <20190819070823.GH12521@merlins.org> <5DCAD3D8-07B6-4A5D-A3C1-A1DF4055C5BD@linaro.org> <20190819164053.GF5431@merlins.org> <68ADE81A-2A48-4E95-91F6-60826FFDAF6F@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ADE81A-2A48-4E95-91F6-60826FFDAF6F@linaro.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 19, 2019 at 07:05:42PM +0200, Paolo Valente wrote:
> > newmagic:~# hdparm -t /dev/md2
> > /dev/md2:
> > HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
> >  Timing buffered disk reads:   2 MB in  5.76 seconds = 355.42 kB/sec
> > 
> > I think things hang a bit less, which I suppose it good, but the system is
> > still unusable overall.
> 
> Ok, I'm sorry it didn't help.  Unless someone spots the problem
> somewhere outside BFQ, I'm willing to analyze this apparently tough
> scenario, as an opportunity to improve BFQ.  If fine for you, just
> contact me offline.

I'm sure there is something very wrong somewhere, and that it's not BFQ's
fault. I just haven't been able to pinpoint the problem.

I ended up finding an H700 card with cables that should fit, so I'm going to
try this first, and see what happens, thanks o1bigtenor for the suggestion.

Linux-raid folks, the original post still has a warning likely worth looking
into:
[14852.341924] WARNING: CPU: 0 PID: 2530 at drivers/md/md.c:8180 md_write_inc+0x15/0x40 [md_mod]
which in turn put the array in dirty mode.

Best,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
