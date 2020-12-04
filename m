Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB6CC4167B
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 14:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C59922B3B
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 14:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgLDOkv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 09:40:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgLDOkv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Dec 2020 09:40:51 -0500
Date:   Fri, 4 Dec 2020 23:40:03 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607092810;
        bh=uvtPoUqekE4ysrPkcwN2m2pvmLXmJsPsKTH0pCoQOwU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7lh3BQP018ZryVSybF2HF+vDP9xIgie2+3oUbLevvAPt1bI5uCSFT3O857/mw6tH
         2dAaMkiSlJXFlsnh7E0zL6i1ElPKE7r97FFgtt6lG/FG7sgDmFmSvksH0gtqds8JXZ
         euyKyTB+IFz5FZVtcc5dVttsZdsYwdKPCl9uNPPLPWjGb6fLqdwH+pLhxMwvIbUEUU
         z1BaIEGceWAPgxjSoh8MfssdXWvYRWhotdB6/h+0AkWnbw/4Qhf4XxNZ+6czkvqrIK
         4tpPwkUiWg/9BcaCRZXxvJjLDifRCK+bJJWSL3x6AuAEW5DzAaRTdAjKcR6ixo9jAi
         klEnMtskQGb3w==
From:   Keith Busch <kbusch@kernel.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     SelvaKumar S <selvakuma.s1@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "selvajove@gmail.com" <selvajove@gmail.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
Message-ID: <20201204144003.GA8868@redsun51.ssa.fujisawa.hgst.com>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <CH2PR04MB6522F1188557C829285ED5E8E7F10@CH2PR04MB6522.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR04MB6522F1188557C829285ED5E8E7F10@CH2PR04MB6522.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 04, 2020 at 11:25:12AM +0000, Damien Le Moal wrote:
> On 2020/12/04 20:02, SelvaKumar S wrote:
> > This patchset tries to add support for TP4065a ("Simple Copy Command"),
> > v2020.05.04 ("Ratified")
> > 
> > The Specification can be found in following link.
> > https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
> > 
> > This is an RFC. Looking forward for any feedbacks or other alternate
> > designs for plumbing simple copy to IO stack.
> > 
> > Simple copy command is a copy offloading operation and is  used to copy
> > multiple contiguous ranges (source_ranges) of LBA's to a single destination
> > LBA within the device reducing traffic between host and device.
> > 
> > This implementation accepts destination, no of sources and arrays of
> > source ranges from application and attach it as payload to the bio and
> > submits to the device.
> > 
> > Following limits are added to queue limits and are exposed in sysfs
> > to userspace
> > 	- *max_copy_sectors* limits the sum of all source_range length
> > 	- *max_copy_nr_ranges* limits the number of source ranges
> > 	- *max_copy_range_sectors* limit the maximum number of sectors
> > 		that can constitute a single source range.
> 
> Same comment as before. I think this is a good start, but for this to be really
> useful to users and kernel components alike, this really needs copy emulation
> for drives that do not have a native copy feature, similarly to what write zeros
> handling for instance: if the drive does not have a copy command (simple copy
> for NVMe or XCOPY for scsi), then the block layer should issue read/write
> commands to seamlessly execute the copy. Otherwise, this will only serve a small
> niche for users and will not be optimal for FS and DM drivers that could be
> simplified with a generic block layer copy functionality.
> 
> This is my 10 cents though, others may differ about this.

Yes, I agree that copy emulation support should be included with the
hardware enabled solution.
