Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348F5C31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 17:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186C42063F
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 17:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfFMRQn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:16:43 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:60582 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727727AbfFMRQd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 13:16:33 -0400
Received: (qmail 4216 invoked by uid 2102); 13 Jun 2019 13:16:32 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Jun 2019 13:16:32 -0400
Date:   Thu, 13 Jun 2019 13:16:32 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Christoph Hellwig <hch@lst.de>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>
cc:     Oliver Neukum <oneukum@suse.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: How to resolve an issue in swiotlb environment?
In-Reply-To: <20190613073900.GC12093@lst.de>
Message-ID: <Pine.LNX.4.44L0.1906131306580.1307-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 13 Jun 2019, Christoph Hellwig wrote:

> On Wed, Jun 12, 2019 at 10:43:11AM -0400, Alan Stern wrote:
> > Would it be okay to rely on the assumption that USB block devices never 
> > have block size < 512?  (We could even add code to the driver to 
> > enforce this, although refusing to handle such devices at all might be 
> > worse than getting an occasional error.)
> 
> sd.c only supports a few specific sector size, and none of them is
> < 512 bytes:
> 
> 	if (sector_size != 512 &&
> 	    sector_size != 1024 &&
> 	    sector_size != 2048 &&
> 	    sector_size != 4096) {
> 	    	...
> 		sdkp->capacity = 0;

Great!  So all we have to do is fix vhci-hcd.  Then we can remove all 
the virt_boundary_mask stuff from usb-storage and uas entirely.

(I'm assuming wireless USB isn't a genuine issue.  As far as I know, it 
is pretty much abandoned at this point.)

Valentina and Shua: Adding SG support to vhci-hcd shouldn't be too
hard.  It ought to be possible even without changing the network
protocol.

Alan Stern

