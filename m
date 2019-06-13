Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57C1C31E49
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B9720449
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfFMQfr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:35:47 -0400
Received: from verein.lst.de ([213.95.11.211]:36383 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730709AbfFMHja (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 03:39:30 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D867268B02; Thu, 13 Jun 2019 09:39:00 +0200 (CEST)
Date:   Thu, 13 Jun 2019 09:39:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Christoph Hellwig <hch@lst.de>, Oliver Neukum <oneukum@suse.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: How to resolve an issue in swiotlb environment?
Message-ID: <20190613073900.GC12093@lst.de>
References: <20190612120653.GA25285@lst.de> <Pine.LNX.4.44L0.1906121038210.1557-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1906121038210.1557-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 12, 2019 at 10:43:11AM -0400, Alan Stern wrote:
> Would it be okay to rely on the assumption that USB block devices never 
> have block size < 512?  (We could even add code to the driver to 
> enforce this, although refusing to handle such devices at all might be 
> worse than getting an occasional error.)

sd.c only supports a few specific sector size, and none of them is
< 512 bytes:

	if (sector_size != 512 &&
	    sector_size != 1024 &&
	    sector_size != 2048 &&
	    sector_size != 4096) {
	    	...
		sdkp->capacity = 0;
