Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D827FC432C2
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 18:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B6B21655
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 18:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443194AbfIYScA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Sep 2019 14:32:00 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57811 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2439936AbfIYSb7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Sep 2019 14:31:59 -0400
Received: (qmail 5400 invoked by uid 500); 25 Sep 2019 14:31:58 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Sep 2019 14:31:58 -0400
Date:   Wed, 25 Sep 2019 14:31:58 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        USB list <linux-usb@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: reeze while write on external usb 3.0 hard disk [Bug 204095]
In-Reply-To: <20190925170741.GA5235@lazy.lzy>
Message-ID: <Pine.LNX.4.44L0.1909251429370.4444-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 25 Sep 2019, Piergiorgio Sartor wrote:

> On Mon, Aug 26, 2019 at 07:38:33PM +0200, Piergiorgio Sartor wrote:
> > On Tue, Aug 20, 2019 at 06:37:22PM +0200, Piergiorgio Sartor wrote:
> > > On Tue, Aug 20, 2019 at 09:23:26AM +0200, Christoph Hellwig wrote:
> > > > On Mon, Aug 19, 2019 at 10:14:25AM -0400, Alan Stern wrote:
> > > > > Let's bring this to the attention of some more people.
> > > > > 
> > > > > It looks like the bug that was supposed to be fixed by commit
> > > > > d74ffae8b8dd ("usb-storage: Add a limitation for
> > > > > blk_queue_max_hw_sectors()"), which is part of 5.2.5, but apparently
> > > > > the bug still occurs.
> > > > 
> > > > Piergiorgio,
> > > > 
> > > > can you dump the content of max_hw_sectors_kb file for your USB storage
> > > > device and send that to this thread?
> > > 
> > > Hi all,
> > > 
> > > for both kernels, 5.1.20 (working) and 5.2.8 (not working),
> > > the content of /sys/dev/x:y/queue/max_hw_sectors_kb is 512
> > > for USB storage devices (2.0 and 3.0).
> > > 
> > > This is for the PC showing the issue.
> > > 
> > > In an other PC, which does not show the issus at the moment,
> > > the values are 120, for USB2.0, and 256, for USB3.0.
> > 
> > Hi again,
> > 
> > any news on this?
> > 
> > Is there anything I can do to help?
> > 
> > Should I report this somewhere else too?
> > 
> > Currently this is quite a huge problem for me,
> > since the only working external storage is an
> > old 1394 HDD...
> 
> Hi all,
> 
> I'm now on kernel 5.2.16, from Fedora, and still I
> see the same issue.
> 
> I guess it is not a chipset quirk, since there
> are two involved here.
> For the USB 2.0 I've (with "lspci"):
> 
> USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])
> 
> For USB 3.0 I've:
> 
> USB controller: ASMedia Technology Inc. ASM1042 SuperSpeed USB Host Controller (prog-if 30 [XHCI])
> 
> Any idea on how to proceed?
> 
> Thanks a lot.

One thing you can try is git bisect from 5.1.20 (or maybe just 5.1.0)  
to 5.2.8.  If you can identify a particular commit which caused the
problem to start, that would help.

Alan Stern

