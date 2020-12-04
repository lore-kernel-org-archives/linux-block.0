Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CD8C433FE
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 09:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32527225AB
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 09:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgLDJ20 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 04:28:26 -0500
Received: from verein.lst.de ([213.95.11.211]:33890 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbgLDJ20 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Dec 2020 04:28:26 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C436E6736F; Fri,  4 Dec 2020 10:27:42 +0100 (CET)
Date:   Fri, 4 Dec 2020 10:27:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH V4 2/9] nvmet: add ZNS support for bdev-ns
Message-ID: <20201204092742.GA8955@lst.de>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com> <20201202062227.9826-3-chaitanya.kulkarni@wdc.com> <20201202090715.GA2952@lst.de> <BYAPR04MB4965E50D3DCEFE4A0970631286F10@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965E50D3DCEFE4A0970631286F10@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 04, 2020 at 03:13:40AM +0000, Chaitanya Kulkarni wrote:
> >> +	if (!bdev_is_zoned(nvmet_bdev(req)))
> >> +		return NVME_SC_SUCCESS;
> >> +
> >> +	return nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, NVME_NIDT_CSI_LEN,
> >> +					&nvme_cis_zns, off);
> >> +}
> > This looks weird.  We can want to support the command set identifier in
> > general, so this should go into common code, and just look up the command
> > set identifier in the nvmet_ns structure.
> 
> ZNS is the only user for this, so I've added to the zns code. I'll move to
> 
> admin-cmd.

CSI is a generic feature, ZNS is just the first thing that requires it.

> > This will change the limit when a new namespaces is added.  I think we need
> > to just pick the value of the first namespaces and refuse adding a new
> > one if the limit is lower to not completely break hosts.
> 
> But that will force users to add ns with highest zasl first no matter what.
> 
> Isn't there should be a way to update the host with async event
> 
> so that host can refresh the ctrl->zasl when ns addition async notification
> 
> is generated ?

I'd rather not go too dynamic and change capabilities down dynamically.
I think that will cause all kinds of fun problems with I/Os already
queue up in the block layer while the limit changes.
