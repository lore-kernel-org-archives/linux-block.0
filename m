Return-Path: <SRS0=2dDp=UK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34C5C4321A
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 06:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69A520896
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 06:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403886AbfFKGm1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 02:42:27 -0400
Received: from verein.lst.de ([213.95.11.211]:48527 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390485AbfFKGm1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 02:42:27 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 25AC968B02; Tue, 11 Jun 2019 08:41:59 +0200 (CEST)
Date:   Tue, 11 Jun 2019 08:41:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: How to resolve an issue in swiotlb environment?
Message-ID: <20190611064158.GA20601@lst.de>
References: <20190610123222.GA20985@lst.de> <Pine.LNX.4.44L0.1906101423200.1560-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1906101423200.1560-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Alan,

thanks for the explanation.  It seems like what usb wants is to:

 - set sg_tablesize to 1 for devices that can't handle scatterlist at all
 - set the virt boundary as-is for devices supporting "basic" scatterlist,
   although that still assumes they can rejiggle them because for example
   you could still get a smaller than expected first segment ala (assuming
   a 1024 byte packet size and thus 1023 virt_boundary_mask):

        | 0 .. 511 | 512 .. 1023 | 1024 .. 1535 |

   as the virt_bondary does not guarantee that the first segment is
   the same size as all the mid segments.
 - do not set any limit on xhci

But that just goes back to the original problem, and that is that with
swiotlb we are limited in the total dma mapping size, and recent block
layer changes in the way we handle the virt_boundary mean we now build
much larger requests by default.  For SCSI ULDs to take that into
account I need to call dma_max_mapping_size() and use that as the
upper bound for the request size.  My plan is to do that in scsi_lib.c,
but for that we need to expose the actual struct device that the dma
mapping is perfomed on to the scsi layer.  If that device is different
from the sysfs hierchary struct device, which it is for usb the ULDD
needs to scsi_add_host_with_dma and pass the dma device as well.  How
do I get at the dma device (aka the HCDs pci_dev or similar) from
usb-storage/uas?
