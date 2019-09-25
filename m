Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ED5C432C2
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 17:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EDA2146E
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 17:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408161AbfIYRIH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:08:07 -0400
Received: from mx009.vodafonemail.xion.oxcs.net ([153.92.174.39]:60396 "EHLO
        mx009.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407544AbfIYRIH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Sep 2019 13:08:07 -0400
Received: from vsmx002.vodafonemail.xion.oxcs.net (unknown [192.168.75.192])
        by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTP id 5D2D2605B16;
        Wed, 25 Sep 2019 17:08:04 +0000 (UTC)
Received: from lazy.lzy (unknown [87.157.113.162])
        by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTPA id B4A926066CF;
        Wed, 25 Sep 2019 17:07:47 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
        by lazy.lzy (8.15.2/8.14.5) with ESMTPS id x8PH7gAS005723
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 25 Sep 2019 19:07:42 +0200
Received: (from red@localhost)
        by lazy.lzy (8.15.2/8.15.2/Submit) id x8PH7fiP005722;
        Wed, 25 Sep 2019 19:07:41 +0200
Date:   Wed, 25 Sep 2019 19:07:41 +0200
From:   Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>,
        USB list <linux-usb@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: reeze while write on external usb 3.0 hard disk [Bug 204095]
Message-ID: <20190925170741.GA5235@lazy.lzy>
References: <20190817095422.GA4200@lazy.lzy>
 <Pine.LNX.4.44L0.1908191009490.1506-100000@iolanthe.rowland.org>
 <20190820072326.GD28968@lst.de>
 <20190820163722.GA2991@lazy.lzy>
 <20190826173833.GA4166@lazy.lzy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826173833.GA4166@lazy.lzy>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-VADE-STATUS: LEGIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 26, 2019 at 07:38:33PM +0200, Piergiorgio Sartor wrote:
> On Tue, Aug 20, 2019 at 06:37:22PM +0200, Piergiorgio Sartor wrote:
> > On Tue, Aug 20, 2019 at 09:23:26AM +0200, Christoph Hellwig wrote:
> > > On Mon, Aug 19, 2019 at 10:14:25AM -0400, Alan Stern wrote:
> > > > Let's bring this to the attention of some more people.
> > > > 
> > > > It looks like the bug that was supposed to be fixed by commit
> > > > d74ffae8b8dd ("usb-storage: Add a limitation for
> > > > blk_queue_max_hw_sectors()"), which is part of 5.2.5, but apparently
> > > > the bug still occurs.
> > > 
> > > Piergiorgio,
> > > 
> > > can you dump the content of max_hw_sectors_kb file for your USB storage
> > > device and send that to this thread?
> > 
> > Hi all,
> > 
> > for both kernels, 5.1.20 (working) and 5.2.8 (not working),
> > the content of /sys/dev/x:y/queue/max_hw_sectors_kb is 512
> > for USB storage devices (2.0 and 3.0).
> > 
> > This is for the PC showing the issue.
> > 
> > In an other PC, which does not show the issus at the moment,
> > the values are 120, for USB2.0, and 256, for USB3.0.
> 
> Hi again,
> 
> any news on this?
> 
> Is there anything I can do to help?
> 
> Should I report this somewhere else too?
> 
> Currently this is quite a huge problem for me,
> since the only working external storage is an
> old 1394 HDD...

Hi all,

I'm now on kernel 5.2.16, from Fedora, and still I
see the same issue.

I guess it is not a chipset quirk, since there
are two involved here.
For the USB 2.0 I've (with "lspci"):

USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])

For USB 3.0 I've:

USB controller: ASMedia Technology Inc. ASM1042 SuperSpeed USB Host Controller (prog-if 30 [XHCI])

Any idea on how to proceed?

Thanks a lot.

bye,

-- 

piergiorgio
