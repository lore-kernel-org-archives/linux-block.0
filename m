Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DB1C31E4D
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 14:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153CC21721
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 14:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfFNOoy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:44:54 -0400
Received: from netrider.rowland.org ([192.131.102.5]:43409 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728074AbfFNOoy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 10:44:54 -0400
Received: (qmail 26355 invoked by uid 500); 14 Jun 2019 10:44:53 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Jun 2019 10:44:53 -0400
Date:   Fri, 14 Jun 2019 10:44:53 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     shuah <shuah@kernel.org>
cc:     Christoph Hellwig <hch@lst.de>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Oliver Neukum <oneukum@suse.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: How to resolve an issue in swiotlb environment?
In-Reply-To: <41caad16-3fa1-413b-0d49-594d48b88de4@kernel.org>
Message-ID: <Pine.LNX.4.44L0.1906141043530.24571-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 13 Jun 2019, shuah wrote:

> > Great!  So all we have to do is fix vhci-hcd.  Then we can remove all
> > the virt_boundary_mask stuff from usb-storage and uas entirely.
> > 
> > (I'm assuming wireless USB isn't a genuine issue.  As far as I know, it
> > is pretty much abandoned at this point.)
> > 
> > Valentina and Shua: Adding SG support to vhci-hcd shouldn't be too
> > hard.  It ought to be possible even without changing the network
> > protocol.
> > 
> 
> I will start taking a look at this. Is there a target release in plan
> to drop virt_boundary_mask stuff?

Not yet.  But since it doesn't do what we want anyway, this should be 
fixed quickly.

Alan Stern

