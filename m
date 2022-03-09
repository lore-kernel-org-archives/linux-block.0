Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B975BC433F5
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 03:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiCIDlO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 22:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiCIDlN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 22:41:13 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E1015F087
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 19:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646797214; x=1678333214;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xmF1sDRZPr3tQorEJq8JDYSDk9Aby1WDJLV6SHWhrzU=;
  b=JerJPlyV1zlHq7jbPzpcMwv4KDZUUtaU2gYB/F/scdGEGBDcQgxxas2O
   mv/rFDS8+mjXUd9RHQEWLp4coUg5BZ3MOiw4JKCGqtBsTuP3FVf4RLyf8
   G/cTuQV0frEsvzE0WaeBS4ejyNb3+9j5CSRYU2KZjHJiP9iJzruu1K7+Y
   YiH5t8nuPY177LSSJYT/O2CdfdTVZOKU1sGnEgnsZ7RMK5TyUwEdzqdp3
   1a0d3rqy1jvaNHltIhiUMuSOXaaoG89idjrl0Yav+fEqWSaLJXJYKZsHz
   Q3Y0Gti54zlj1b0Xz7DP0gUuVi1Xg077paQH0+pkzeiZTXodssRWue+hf
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,166,1643644800"; 
   d="scan'208";a="298963706"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2022 11:40:13 +0800
IronPort-SDR: l8N6ed2u64SIuJQhyAba4DS3XYEDTVW3sbeGLEXvo4Ju6gMAonLvH9C0A3Q3VpIQfsPeP4W/5Z
 RM8jk+hV4YzWQC51ipCgDa0SbmDxTWspiuPSTDahkWuPrTpLg6+v7GhdIr52yrCk0Bv/bIkPQO
 FpkQKloBbwoZOOFThLu6h22l7jwB79jrlW0VAPh+OdgWSs6OsUmw9vGlhPJCvnaclxR5/E+yJs
 +shfYE/4thie121wzmsQekWCdqhVQ2ESNuIx1ABe2UU5V9as2Y7QEBR8Kva6kqgzP3NBlf9J2H
 6MDZ9HWk4rTQom3YQJ3ygprs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 19:11:29 -0800
IronPort-SDR: q5ZS3m3dAjBlCEl9JMn0rTMUF9QEssR4H0w0RshJBiisteBQ1HbbzoZudWnZeBiY/lBv1u41hx
 7ehfEzyOUi/sznqR/bPpnExhEMDgQK5/GlUdvZ2n6MCgT8vsThYVGRRWmFmBJnjdRw2Ums49zB
 uuq8FZP6vaWOO2IZjjiBCXS0v0ooaoU/KZBsiMQdQUJABB5GXoDZR1FTXcJyQZnRNHBFO/07Kk
 MTZfvAGzbDs9zMWo8PqNsD8lkZJudpGin1Q6RS/uWJurdTAxEWA8giBOkZd+y8RUxUsNVJDqH0
 HOI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 19:40:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KCyd930pCz1SVp2
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 19:40:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646797212; x=1649389213; bh=xmF1sDRZPr3tQorEJq8JDYSDk9Aby1WDJLV
        6SHWhrzU=; b=ClFvo+wN+z3SrEssyAGUs8cpcXKConw23LtPlvCLuOO9nA0UHl/
        fH6yLtb9sFVlla9nWli7KjZF6Kosh9xUuZLA5Odzl6ip/OM21X6HeO7Z+FD7Aj4+
        Va9uy/mOfsF9KbT8aBV3svg47xbeFrWYTNALVEBDIyUYawi/DrA+r8IwkWFuvSHO
        LMppjXrJFMmpps4LAklQBKqumJGaRlM2roeCP91/S6237iJxvDz5gbxS/LfqnLQQ
        9bhMQPSkELKFiLHVcRbOj/AhTDIHD1ydudYKSThOwAbRlRpk5JVtyfYU9dqpCwRT
        LVxcElNXwgkAB3JNpZ/PEtIjZaHYWzxWaPA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rK9cgUbziB74 for <linux-block@vger.kernel.org>;
        Tue,  8 Mar 2022 19:40:12 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KCyd56ytNz1Rvlx;
        Tue,  8 Mar 2022 19:40:09 -0800 (PST)
Message-ID: <645d8224-df64-a057-cb9c-82c6cb8b2d5b@opensource.wdc.com>
Date:   Wed, 9 Mar 2022 12:40:08 +0900
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
>  
>  	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> @@ -129,7 +122,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>  				   sizeof(struct nvme_zone_descriptor);
>  
>  	nr_zones = min_t(unsigned int, nr_zones,
> -			 get_capacity(ns->disk) >> ilog2(ns->zsze));
> +			 get_capacity(ns->disk) / ns->zsze);

This will not compile on 32-bits arch. This needs to use div64_u64().

>  
>  	bufsize = sizeof(struct nvme_zone_report) +
>  		nr_zones * sizeof(struct nvme_zone_descriptor);


-- 
Damien Le Moal
Western Digital Research
