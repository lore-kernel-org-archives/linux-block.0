Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7536C433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 09:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E14B214F1
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 09:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgFZJSB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 05:18:01 -0400
Received: from verein.lst.de ([213.95.11.211]:51068 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgFZJSA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 05:18:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB65168CFC; Fri, 26 Jun 2020 11:17:58 +0200 (CEST)
Date:   Fri, 26 Jun 2020 11:17:58 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Message-ID: <20200626091758.GA27903@lst.de>
References: <20200625122152.17359-1-javier@javigon.com> <20200625122152.17359-4-javier@javigon.com> <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io> <20200625194835.5hojuvdwtjxtso2l@MacBook-Pro.localdomain> <CY4PR04MB3751E7721E5D5E15065B0ED2E7930@CY4PR04MB3751.namprd04.prod.outlook.com> <20200626091113.GB26616@lst.de> <CY4PR04MB3751E3DF3A1BD1FC77E6C101E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751E3DF3A1BD1FC77E6C101E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 26, 2020 at 09:15:14AM +0000, Damien Le Moal wrote:
> On 2020/06/26 18:11, hch@lst.de wrote:
> > On Fri, Jun 26, 2020 at 01:14:30AM +0000, Damien Le Moal wrote:
> >> As long as you keep ZNS namespace report itself as being "host-managed" like
> >> ZBC/ZAC disks, we need the consistency and common interface. If you break that,
> >> the meaning of the zoned model queue attribute disappears and an application or
> >> in-kernel user cannot rely on this model anymore to know how the drive will behave.
> > 
> > We just need a way to expose to applications that new feature are
> > supported.  Just like we did with zone capacity support.  That is why
> > we added the feature flags to uapi zone structure.
> > 
> >> Think of a file system, or any other in-kernel user. If they have to change
> >> their code based on the device type (NVMe vs SCSI), then the zoned block device
> >> interface is broken. Right now, that is not the case, everything works equally
> >> well on ZNS and SCSI, modulo the need by a user for conventional zones that ZNS
> >> do not define. But that is still consistent with the host-managed model since
> >> conventional zones are optional.
> > 
> > That is why we have the feature flag.  That user should not know the
> > underlying transport or spec.  But it can reliably discover "this thing
> > support zone capacity" or "this thing supports offline zones" or even
> > nasty thing like "this zone can time out when open" which are much
> > harder to deal with.
> > 
> >> For this particular patch, there is currently no in-kernel user, and it is not
> >> clear how this will be useful to applications. At least please clarify this. And
> > 
> > The main user is the ioctl.  And if you think about how offline zones are
> > (suppose to) be used driving this from management tools in userspace
> > actually totally make sense.  Unlike for example open/close all which
> > just don't make sense as primitives to start with.
> 
> OK. Adding a new BLKZONEOFFLINE ioctl is easy though and fits into the current
> zone management plumbing well, I think. So the patch can be significantly
> simplified (no need for the new zone management op function with flags).

Yes, I'm all for reusing the existing plumbing and style as much as
possible.
