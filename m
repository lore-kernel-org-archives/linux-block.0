Return-Path: <SRS0=14Po=UQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A28C31E44
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 08:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E4120848
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 08:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfFQIpG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:45:06 -0400
Received: from verein.lst.de ([213.95.11.211]:34464 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfFQIpG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jun 2019 04:45:06 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6715C68AFE; Mon, 17 Jun 2019 10:44:33 +0200 (CEST)
Date:   Mon, 17 Jun 2019 10:44:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        PDL-MPT-FUSIONLINUX <mpt-fusionlinux.pdl@broadcom.com>,
        linux-hyperv@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] megaraid_sas: set virt_boundary_mask in the scsi
 host
Message-ID: <20190617084433.GA7969@lst.de>
References: <20190605190836.32354-1-hch@lst.de> <20190605190836.32354-11-hch@lst.de> <cd713506efb9579d1f69a719d831c28d@mail.gmail.com> <20190608081400.GA19573@lst.de> <98f6557ae91a7cdfe8069fcf7d788c88@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98f6557ae91a7cdfe8069fcf7d788c88@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 14, 2019 at 01:28:47AM +0530, Kashyap Desai wrote:
> Is there any changes in API  blk_queue_virt_boundary? I could not find
> relevant code which account for this. Can you help ?
> Which git repo shall I use for testing ? That way I can confirm, I didn't
> miss relevant changes.

Latest mainline plus the series (which is about to get resent).
blk_queue_virt_boundary now forced an unlimited max_hw_sectors as that
is how PRP-like schemes work, to work around a block driver merging
bug.  But we also need to communicate that limit to the DMA layer so
that we don't set a smaller iommu segment size limitation.

> >From your above explanation, it means (after this patch) max segment size
> of the MR controller will be set to 4K.
> Earlier it is possible to receive single SGE of 64K datalength (Since max
> seg size was 64K), but now the same buffer will reach the driver having 16
> SGEs (Each SGE will contain 4K length).

No, there is no more limit for the size of the segment at all,
as for PRPs each PRP is sort of a segment from the hardware perspective.
We just require the segments to not have gaps, as PRPs don't allow for
that.

That being said I think these patches are wrong for the case of megaraid
or mpt having both NVMe and SAS/ATA devices behind a single controller.
Is that a valid configuration?
