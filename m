Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9EAC00140
	for <linux-block@archiver.kernel.org>; Wed, 10 Aug 2022 17:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiHJRRj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Aug 2022 13:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbiHJRRT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Aug 2022 13:17:19 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37C0832F8
        for <linux-block@vger.kernel.org>; Wed, 10 Aug 2022 10:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660151804; x=1691687804;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZrG3QXHf6OeZyZRRDOE430GTJ+vsvuzlYkLafNLMIzY=;
  b=EVHlBgBJEtNScjTRIFrTcr31jIdf7wx3kRwXNPOMltrmP+obZLxAmhCW
   4hy57Ja32+Jqov1Ti/hWyVAduICMSDYKAzBJtv/kB7FPTYn0/CUxcL3GP
   bRz2+2gcmf86A3toVuVAM5SLcY5Qwx8UhjWCrcIhyDq3vPyg8W+6vN0g/
   sSAZmkL+EpZjBmmpPtvoOZS15zqzHXrfFumzb7RHR7wbf/GaxAo9nr545
   C257wB6JDLIa9EuzBMoQJof5EvgvsyNFv9kEGyP5VIQhKNh431UNbK7Lw
   sLEprAEtnhKwWmHRPwx5eA65PiXvA+6Xuuob9HDT7x9uOTsaiOFHKRtO6
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,227,1654531200"; 
   d="scan'208";a="213385566"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2022 01:16:44 +0800
IronPort-SDR: mkFZyRWMp6CWKLRSieos/KMug8p4sn5dNhETP1alISJ+V06a9C/s53jZXnCEXOmP/zq0n5SDSk
 vlTLpPRLHew8I9HtmUS1Ytl33lU2VNeaZUmHMlJnvcC2JFN5mYHqENAXzxFAnLwhb2/Jc1Qhtf
 8l4RPrgUWY88Ldsgt0Q6so450jWCH2Hv/lZfVsOqDlJ4vu/9KiKBbU6IpaHplNvm+8JdsZGU3c
 zUXGEZkqzoTJwVDf+nf+64xpbm2osu4ePWxqfLbjrOebMWHPVQd/gCILKt88ucDGhSsDnW+UG7
 GqOaDUVevF6+MIutWI8k8rcW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 09:37:40 -0700
IronPort-SDR: 3EBELi3VRHU81Rf//Qcrnb1eKC+ShcDwEvwap1unP2tLIzeIJMdkRskyoo4ACKTaRTg6mYjdsQ
 quTC4pWl70fU4g8eNehLP2IvGmoHXaI4UsIr/zIbXMfZw/OW6S6WHEI83jHuXBw/Kd2NtfVgFu
 n0hmJuZZCO7hbOuo/sSAFQr3BTCW82s6goXKMLYpc5EY6K9g70C/POWRC9Evk/6cFYSSTMGtWR
 Hg7beQsLm+3NAG4hN5yzSo5YzXv44b56Ztoh5oL6fxu0H7I/EioJwLRolGZgVIq6N8Bm8mWUfI
 hYY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 10:16:47 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2xSF1ZWZz1Rws0
        for <linux-block@vger.kernel.org>; Wed, 10 Aug 2022 10:16:45 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660151804; x=1662743805; bh=ZrG3QXHf6OeZyZRRDOE430GTJ+vsvuzlYkL
        afNLMIzY=; b=q8E5j2biq7+aqtAPZCbX3uzABdCPq3/W5AC6e3lSgeyurt33e66
        2TKqgrRhJBz924jF27EslwtHBD+j9JFqfG7kSTu2r9qKbwG3fQ9f5MLkt0bGDFzL
        7J8aO0Jt4kYGSI9+bBsk00OqjgLIM4+Ir8bqlCCzhVKjT7bhrPKe0TqbywLC98ru
        q+eF4mGZgxDhd1iVzqOwjZj9Bm32j8o9mkFInce7Iwe/IPJ0E9Hcmc75Q+0bD+86
        s8pe4eRc+n6iu+kkii5juFTDKLjw4Rb7R0KaF5tUz1k+c/VMdnMVczCqTmOibpQN
        5AAE9asQpxtUlD4zvMoDqsvew5bHTZH27wA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pZd7fI9faWmS for <linux-block@vger.kernel.org>;
        Wed, 10 Aug 2022 10:16:44 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2xSC1pJVz1RtVk;
        Wed, 10 Aug 2022 10:16:43 -0700 (PDT)
Message-ID: <3ee96421-94b2-12d8-9aa2-83d4f7027694@opensource.wdc.com>
Date:   Wed, 10 Aug 2022 10:16:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v9 12/13] dm: introduce DM_EMULATED_ZONES target type
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, bvanassche@acm.org
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094815eucas1p2dfab477daf4f2eb05342d756fdf7f14d@eucas1p2.samsung.com>
 <20220803094801.177490-13-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220803094801.177490-13-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/08/03 2:48, Pankaj Raghav wrote:
> Introduce a new target type DM_EMULATED_ZONES for targets with
> a different zone number of sectors than the underlying device zone
> number of sectors.

"zone number of sectors" is strange. "number of sectors per zone (aka zone
size)" is simpler and clear.

> 
> This target type is introduced as the existing zoned targets assume
> that the target and the underlying device have the same zone
> number of sectors. The new target: dm-po2zone will use this new target
> type as it emulates the zone boundary that is different from the
> underlying zoned device.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

With that text fixed, looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/md/dm-table.c         | 13 ++++++++++---
>  include/linux/device-mapper.h |  9 +++++++++
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 31eb1d29d136..b37991ea3ffb 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1614,13 +1614,20 @@ static bool dm_table_supports_zoned_model(struct dm_table *t,
>  	return true;
>  }
>  
> -static int device_not_matches_zone_sectors(struct dm_target *ti, struct dm_dev *dev,
> +/*
> + * Callback function to check for device zone sector across devices. If the
> + * DM_TARGET_EMULATED_ZONES target feature flag is not set, then the target
> + * should have the same zone sector as the underlying devices.
> + */
> +static int check_valid_device_zone_sectors(struct dm_target *ti, struct dm_dev *dev,
>  					   sector_t start, sector_t len, void *data)
>  {
>  	unsigned int *zone_sectors = data;
>  
> -	if (!bdev_is_zoned(dev->bdev))
> +	if (!bdev_is_zoned(dev->bdev) ||
> +	    dm_target_supports_emulated_zones(ti->type))
>  		return 0;
> +
>  	return bdev_zone_sectors(dev->bdev) != *zone_sectors;
>  }
>  
> @@ -1645,7 +1652,7 @@ static int validate_hardware_zoned_model(struct dm_table *t,
>  	if (!zone_sectors)
>  		return -EINVAL;
>  
> -	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {
> +	if (dm_table_any_dev_attr(t, check_valid_device_zone_sectors, &zone_sectors)) {
>  		DMERR("%s: zone sectors is not consistent across all zoned devices",
>  		      dm_device_name(t->md));
>  		return -EINVAL;
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 04c6acf7faaa..83e20de264c9 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -294,6 +294,15 @@ struct target_type {
>  #define dm_target_supports_mixed_zoned_model(type) (false)
>  #endif
>  
> +#ifdef CONFIG_BLK_DEV_ZONED
> +#define DM_TARGET_EMULATED_ZONES	0x00000400
> +#define dm_target_supports_emulated_zones(type) \
> +	((type)->features & DM_TARGET_EMULATED_ZONES)
> +#else
> +#define DM_TARGET_EMULATED_ZONES	0x00000000
> +#define dm_target_supports_emulated_zones(type) (false)
> +#endif
> +
>  struct dm_target {
>  	struct dm_table *table;
>  	struct target_type *type;


-- 
Damien Le Moal
Western Digital Research
