Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E505C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 17:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F5D2098B
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 17:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592326900;
	bh=EKyYHXK56kGXUHZvZEG6MdiO03J4tJGKnPinUlkYWWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sqRaTwEVENv39bFuxfVzEjtRDxFMn6Z7SWNYhqghFDCSYcfXkZ9s1uZpaFVFItERS
	 bjcKulJKLD9Qu4eTf2nCP12WVu8f4ylsheS6Yu4o5NP1be+yLl6PI12n7CBFqQYZEJ
	 l9AGwY1r/+DbCZQKDedzuCPHSmWgrMaNWzbLlJjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgFPRBj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbgFPRBj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 13:01:39 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D019E208E4;
        Tue, 16 Jun 2020 17:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592326898;
        bh=EKyYHXK56kGXUHZvZEG6MdiO03J4tJGKnPinUlkYWWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjhgnnDoC0n2mREAdtWxwM7yLVLHZpLio6Cc2TqswBr0RJX6OtIQiOkSZiFvhA+74
         eaFCNmfDRXiOjwZQOxeq/rPkOL4lz20M8kbRzQyGOlQ2MYmsnIbPg/R6DkqHGoQVyJ
         Sz4nq+YZmJ2v5qGUmGa4ZnVzQ9BlhkROF2tCFBXc=
Date:   Tue, 16 Jun 2020 10:01:35 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH 3/5] nvme: implement I/O Command Sets Command Set support
Message-ID: <20200616170135.GC521206@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-4-keith.busch@wdc.com>
 <yq1ftavm29u.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1ftavm29u.fsf@ca-mkp.ca.oracle.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 16, 2020 at 11:58:59AM -0400, Martin K. Petersen wrote:
> > @@ -1113,8 +1126,9 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
> >  	status = nvme_submit_sync_cmd(ctrl->admin_q, &c, data,
> >  				      NVME_IDENTIFY_DATA_SIZE);
> >  	if (status) {
> > -		dev_warn(ctrl->device,
> > -			"Identify Descriptors failed (%d)\n", status);
> > +		if (ctrl->vs >= NVME_VS(1, 3, 0))
> > +			dev_warn(ctrl->device,
> > +				"Identify Descriptors failed (%d)\n", status);
> 
> Not a biggie but maybe this should be a separate patch?

Actually I think we can just get rid of this check before the warning.
We only call this function if the version is >= 1.3 or if multi-css was
selected. Both of those require this identification be supported.
 
> > @@ -1808,7 +1828,8 @@ static bool nvme_ns_ids_equal(struct
> > nvme_ns_ids *a, struct nvme_ns_ids *b) { return uuid_equal(&a->uuid,
> > &b->uuid) && memcmp(&a->nguid, &b->nguid, sizeof(a->nguid)) == 0 &&
> > -		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) == 0; +
> > memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) == 0 && +
> > a->csi == b->csi; }
> 
> No objection to defensive programming. But wouldn't this be a broken
> device?

It could be a broken device, but I think it's checking against mistaken
identify, like if we're racing with namespace management commands
deleting and recreating namespaces that the driver is still bound to.
