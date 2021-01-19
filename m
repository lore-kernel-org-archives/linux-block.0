Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710D2C433E6
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 06:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D4A723102
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 06:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbhASGXx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jan 2021 01:23:53 -0500
Received: from verein.lst.de ([213.95.11.211]:50691 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbhASGQ0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jan 2021 01:16:26 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B5D076736F; Tue, 19 Jan 2021 07:15:36 +0100 (CET)
Date:   Tue, 19 Jan 2021 07:15:36 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Message-ID: <20210119061536.GB21250@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com> <20210112042623.6316-5-chaitanya.kulkarni@wdc.com> <20210112074805.GA24443@lst.de> <BL0PR04MB65145CE93F2AAF66158A3D71E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com> <20210118182515.GC11082@lst.de> <2c3a1a515bd3913f46ecf81a157e35ff56a1fb70.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c3a1a515bd3913f46ecf81a157e35ff56a1fb70.camel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 19, 2021 at 04:28:00AM +0000, Damien Le Moal wrote:
> What about something like this below to add to Chaitanya series ?
> This adds the queue limit zone_write_granularity which is set to the physical
> block size for scsi, and for NVMe/ZNS too since that value is limited to the
> atomic block size. Lightly tested with both 512e and 4kn SMR drives.

For ZNS it should just be the logic block size, the atomic size is not
the right thing use here.

> +	if (blk_queue_is_zoned(q)) {
> +		if (limits->zone_write_granularity < limits-
> >logical_block_size)

Overly long line here, and your mailer wrapped it as a punishment :)

That being said I don't think the normal path to set the block size
should affect it.  Just add the manual call and leave the non-zoned
path alone.

> +EXPORT_SYMBOL(blk_queue_zone_write_granularity);

EXPORT_SYMBOL_GPL for all zoned stuff.
