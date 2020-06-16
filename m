Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970EBC433DF
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 14:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D03207C4
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 14:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgFPOS6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:18:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:48780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgFPOS6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 10:18:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 14ACFABE4;
        Tue, 16 Jun 2020 14:19:01 +0000 (UTC)
Date:   Tue, 16 Jun 2020 16:18:55 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Keith Busch <keith.busch@wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Aravind Ramesh <aravind.ramesh@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 2/5] null_blk: introduce zone capacity for zoned device
Message-ID: <20200616141855.4opiywhfbo7sa7nu@beryllium.lan>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-3-keith.busch@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615233424.13458-3-keith.busch@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 16, 2020 at 08:34:21AM +0900, Keith Busch wrote:
> From: Aravind Ramesh <aravind.ramesh@wdc.com>
> 
> Allow emulation of a zoned device with a per zone capacity smaller than
> the zone size as as defined in the Zoned Namespace (ZNS) Command Set
> specification. The zone capacity defaults to the zone size if not
> specified and must be smaller than the zone size otherwise.
> 
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>

Just a little nitpick.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

> ---
>  drivers/block/null_blk.h       |  2 ++
>  drivers/block/null_blk_main.c  |  9 ++++++++-
>  drivers/block/null_blk_zoned.c | 17 +++++++++++++++--
>  3 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
> index 81b311c9d781..7eadf190528c 100644
> --- a/drivers/block/null_blk.h
> +++ b/drivers/block/null_blk.h
> @@ -44,11 +44,13 @@ struct nullb_device {
>  	unsigned int nr_zones;
>  	struct blk_zone *zones;
>  	sector_t zone_size_sects;
> +	sector_t zone_capacity_sects;
>  
>  	unsigned long size; /* device size in MB */
>  	unsigned long completion_nsec; /* time in ns to complete a request */
>  	unsigned long cache_size; /* disk cache size in MB */
>  	unsigned long zone_size; /* zone size in MB if device is zoned */
> +	unsigned long zone_capacity; /* zone cap in MB if device is zoned */

Maybe also use zone capacity in the comment instead of the abbreviation?

