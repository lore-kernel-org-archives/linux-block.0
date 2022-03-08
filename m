Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10075C433F5
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 17:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiCHRQA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 12:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245043AbiCHRQA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 12:16:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5545052E7B
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 09:15:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F21DB81B84
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 17:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311DAC340EB;
        Tue,  8 Mar 2022 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646759700;
        bh=KninmeaAD8/vz9+6gRl1fhd8YtvRnTJ+KZv7zIAHyxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oW/BkI88BEhE3mMuycvPLAqH2Nt58dlnmQeSwlt5n1zAUThxtRFizMmaC1r9iJVEa
         sAYEgFCxXyX9VkbJ2Q+HysDuS1SS0R7YEmmEX0Fl04p7UN1/lbto8aFEQi/c04QpHI
         mYVXWvxugWDh5iYzO7DcodREzEGOMr1NZKNXRcXuWEU/6n45NJnkIt1UkyExwIwBJd
         YBmwg89Ke8ZhmOtQoBeMIoaBKzfWI/W1y+LZ6JmgI7986hNzQvxiOJsh7AHzCY2HFP
         Sr6+jfBUBqAdCuJGqjeRWjD3bw3o8vpbCLH/9da8FCYjUAuNji7kroK58TQwG8N+rw
         PQ9jcfZFGUa/A==
Date:   Tue, 8 Mar 2022 09:14:57 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
        jiangbo.365@bytedance.com, Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/6] nvme: zns: Allow ZNS drives that have non-power_of_2
 zone size
Message-ID: <20220308171457.GB3501708@dhcp-10-100-145-180.wdc.com>
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165421eucas1p20575444f59702cd5478cb35fce8b72cd@eucas1p2.samsung.com>
 <20220308165349.231320-2-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308165349.231320-2-p.raghav@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 08, 2022 at 05:53:44PM +0100, Pankaj Raghav wrote:
> Remove the condition which disallows non-power_of_2 zone size ZNS drive
> to be updated and use generic method to calculate number of zones
> instead of relying on log and shift based calculation on zone size.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/nvme/host/zns.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 9f81beb4df4e..ad02c61c0b52 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  	}
>  
>  	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
> -	if (!is_power_of_2(ns->zsze)) {
> -		dev_warn(ns->ctrl->device,
> -			"invalid zone size:%llu for namespace:%u\n",
> -			ns->zsze, ns->head->ns_id);
> -		status = -ENODEV;
> -		goto free_data;
> -	}
>  
>  	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> @@ -129,7 +122,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>  				   sizeof(struct nvme_zone_descriptor);
>  
>  	nr_zones = min_t(unsigned int, nr_zones,
> -			 get_capacity(ns->disk) >> ilog2(ns->zsze));
> +			 get_capacity(ns->disk) / ns->zsze);
>  
>  	bufsize = sizeof(struct nvme_zone_report) +
>  		nr_zones * sizeof(struct nvme_zone_descriptor);
> -- 

The zns report zones realigns the starting sector using an expected pow2
value, so I think you need to update that as well with something like
the following:

@@ -197,7 +189,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
 	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
 
-	sector &= ~(ns->zsze - 1);
+	sector = sector - sector % ns->zsze;
 	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
 		memset(report, 0, buflen);
 
