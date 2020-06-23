Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94234C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 14:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6446420781
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 14:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592924378;
	bh=/Qkci1EEnMCWNpzEwR13xM7o3TscwH9pyJgzBww5lv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AVrjjBxZHix+bM8MeftXptzCxgb9G5SeQe+QYqQGZnfbojfuJb7f7Mx9PO0mVgfap
	 g7OHyGrbDDMrga+KIsABGaJeyUaPSjYJPoZigVq06YJfy0TZ56/IcD48K+n+L05U7a
	 lmZJorYfue2omGEfKjZKKprAGBN4qrjaRl/UQ+yE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbgFWO7h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:59:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732887AbgFWO7h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 10:59:37 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D12920723;
        Tue, 23 Jun 2020 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592924377;
        bh=/Qkci1EEnMCWNpzEwR13xM7o3TscwH9pyJgzBww5lv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1e47alOJYPzSlqwRXo9pkqSlo+vYqR5JzNXKOTIptcly8djVuf7hlRw9DHD/zIkjI
         8DVDrzswRdL7os0bUJTD/MtBbt5wC1fUTuYJx2IjUtofnGwF6g/LxSH8qFZzMY7/4P
         8I+QvPwFym98s5b2clUJ9vVBFASKmTrKUz/gc1Lw=
Date:   Tue, 23 Jun 2020 07:59:34 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set
 support
Message-ID: <20200623145934.GC1288900@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623112551.GB117742@localhost.localdomain>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 23, 2020 at 11:25:53AM +0000, Niklas Cassel wrote:
> On Tue, Jun 23, 2020 at 01:53:47AM -0700, Sagi Grimberg wrote:
> > >   static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> > > @@ -1930,6 +1950,15 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
> > >   	if (ns->lba_shift == 0)
> > >   		ns->lba_shift = 9;
> > > +	switch (ns->head->ids.csi) {
> > > +	case NVME_CSI_NVM:
> > > +		break;
> > > +	default:
> > > +		dev_warn(ctrl->device, "unknown csi:%d ns:%d\n",
> > > +			ns->head->ids.csi, ns->head->ns_id);
> > > +		return -ENODEV;
> > > +	}
> > 
> > Not sure we need a switch-case statement for a single case target...
> 
> I would consider it two cases. A supported CSI or a non-supported CSI
> (which means any CSI value != NVME_CSI_NVM).
> 
> However, a follow up patch (patch 5/5 in this series) adds another case
> to this switch-case statement (NVME_CSI_ZNS).
> 
> I guess this patch could have used an if-else statement, and patch 5/5
> replaced the if-statement with a switch-case.
> However, since a patch in the same series actually adds another case,
> I think that it is more clear this way.
> (A switch-case with only two cases added, in a patch that is not the last
> one in the series, suggests (at least to me), that it will most likely be
> extended in a following patch.)

Yeah, this patch is laying the foundation for future command sets.
