Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850C4C433F5
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 03:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiCIDpi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 22:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiCIDpi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 22:45:38 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07FC75618
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 19:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646797480; x=1678333480;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Cix+ZQn+HfYI1JZBoqYQ0IX5sNeZqeJolFM7SyZjKtA=;
  b=hW1/Jx1CaOOmfjkUxstC9qznXJ2zWStfzyp7TtWdHSUK34hqMn/V6eFW
   2sAZbfWcMbzhxthS7krKkIcUENg/ucsmhZJFwEz4XfENzry6jUozsY+zr
   DNPP2j8hXWGSZSNqRVzT+PE/U6PIOwvn7xQISbo0xgIRDRnWW8oHAV+r2
   zNBcRt7pzlbK8j56C9mP7MmI1MBLSbX2g4K56Ze0bE/Jg7QC4udNc3IJF
   Kf9UURM1jhuJzvvIfHcBYTVLZYxzZXRwhdUchoa1PjaeznkdSBUsZ1fxK
   bdH4BM34kwmVwKIfuNTIC2eECg4ckyadHf701RbLzJNgZgE0znqSZOdA6
   w==;
X-IronPort-AV: E=Sophos;i="5.90,166,1643644800"; 
   d="scan'208";a="195774461"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2022 11:44:40 +0800
IronPort-SDR: 108y/8ZisQUcxeEUasf41QPGgrMhvX/RBvsxQhc2IwKgQRA4/pvwfDLGR/TS+QRNb+thD7Z45f
 l6IESERRbtw10iq2qxWkWRWxtCFQuwhe/nt3rooN3g50RuWN+SmAvDsa2vzbZIC7E41KzM53TZ
 h56+gMR5L8gAhmpvIFtGS0rodCnICb60t10DYFH4pvErSbo7dM8Hw5bG4smAowK5GCSLAxYMWr
 RSiUkiH/NuzPuci4EJ2c8bH8dPKmM8elA2E15lRFUtwKzWmMdPFzlazFXa5bbnD5TabLu7pqyn
 t1ECqZwhRD/tJouLbKTwBe6d
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 19:16:55 -0800
IronPort-SDR: iETX2cvT0wG5A8k1rSPxA+Q1pAQk0IikjjPQByO7mT5lUf9QGQYP+xg0Ram296G644M1guRUMu
 Jj2iXcB25yRkctrMcBpmkCqsHiFr754Qpnw8LgMbDnorzDz8AyWYLPAk517ZG8cRQfVEEgyQyJ
 6nuLIDYD9K56yNs7wZzO9noF4xvBZLC/X01KWLNfKzWDiwmXPQE0I/zbD2Q6evZ0y6cu0hQsuQ
 k6RJUtleTwCZZ1uOmn0ihC056Vjaq51IU7U3jfs1kA8AYu9Zxy1GJjoQHvwyovoTdGaobJopTk
 J9M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 19:44:39 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KCykG3PCXz1SVp6
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 19:44:38 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646797477; x=1649389478; bh=Cix+ZQn+HfYI1JZBoqYQ0IX5sNeZqeJolFM
        7SyZjKtA=; b=mObchIuXkiqWIlWO8v0uyQ/V7SPyVQX5BpMrQ8ymJs9emec9wT4
        ByGtV2BS08JRE7gVALFPDJr4LZnt9teCndJIJFrbaWvagx4wWIuKQ/KOcqp6rxfb
        TMrn30NNq5buWo6hu61q9F8U8HXiqN28DspqIB6C9VThtQNX2oc2nvT0t9Hxcy4b
        XmE5h0+Bl3XTUISLEZ/rrGPBxysknJQYur3kFbQINuu00c/L88vXl0SVSee/Vbpk
        NlwHMPXiW7d8GO3QnF3bhx8A71rTAadHDrl0628So0lpq5f6DWd1Ry/3V7pDlr0g
        dOY/oKPTZSvI7MpR2h4mfwiEruceMIBvX+g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gWXWiPWD4gql for <linux-block@vger.kernel.org>;
        Tue,  8 Mar 2022 19:44:37 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KCykC1htcz1Rvlx;
        Tue,  8 Mar 2022 19:44:35 -0800 (PST)
Message-ID: <06580b24-426c-77ef-a338-e5e97f5ebee1@opensource.wdc.com>
Date:   Wed, 9 Mar 2022 12:44:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/6] nvme: zns: Allow ZNS drives that have non-power_of_2
 zone size
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        jiangbo.365@bytedance.com
Cc:     Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165421eucas1p20575444f59702cd5478cb35fce8b72cd@eucas1p2.samsung.com>
 <20220308165349.231320-2-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220308165349.231320-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/9/22 01:53, Pankaj Raghav wrote:
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

Doing this will allow a non power of 2 zone sized device to be seen by
the block layer. This will break functions such as blkdev_nr_zones() but
this patch is not changing this functions, and other using bit shift
calculations.

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


-- 
Damien Le Moal
Western Digital Research
