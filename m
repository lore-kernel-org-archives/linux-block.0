Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DB9C25B07
	for <linux-block@archiver.kernel.org>; Wed, 10 Aug 2022 17:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbiHJRRh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Aug 2022 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiHJRRK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Aug 2022 13:17:10 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1518C440
        for <linux-block@vger.kernel.org>; Wed, 10 Aug 2022 10:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660151796; x=1691687796;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tLjnPCdY0CPud0gZoWqOOs4dR6XNnOxfEo9SNWG799Y=;
  b=hry9KbZ3nh++on7C53N52aXTrO/7ddOOzO3YbtsRARX/lvMz5vz2e8Hf
   FzCU1lYMJxt9bbYZVCP8IJ+QWcZWr0dyyPjqDL8Aj1OcVOBSN3Ys/yvCw
   kjQilgSObIggiYRj7tvssgOtscw/TTIJAn5peMOLmCw+wVO0Iz7b3KaaK
   PytreFUoq3/RCqOu3sQ7/cOk87PDg2zrDNdHPZsW4KJHLYNvQ2pAI7T/4
   TYueN/74DUqm5NCQVk7Gy15jwoHgT3gH1IPVcoGfN1f+BufnRuToKnOV3
   qZ57E19oLijb0r4FVbFBWyWdGfisw+1VaT2viou837BeVWUUuE96jv2Z7
   A==;
X-IronPort-AV: E=Sophos;i="5.93,227,1654531200"; 
   d="scan'208";a="206863123"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2022 01:10:45 +0800
IronPort-SDR: AeoTvYHKQvJP21euScUmWO0uEVWPC1bnzKb0PoBqRBesNgbfm+686UH3HsK1jJCYJTRVGdhXI2
 yyGcto6e5y2GI30NcFUJFqHDoPZxvwhGbjt4KkHPpap4abcAtyFqEcSwe5V9rWfI4L8okOELnj
 KYwsLrDTFud+LdHXVtbZLHdqEwackc07yNjfeSfYOx43NxtNq6u13DZ2A3A5TNW9jmgMLQItb7
 VdMojHr9qa4nQCiLafkxy75ti9z14F05iRbZceAK5OkyOYqTHGWIY6U9nvJTFG/Ul8yjkH/eqs
 75HX9ttHkGOaI5F48JAlX8Ny
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 09:26:20 -0700
IronPort-SDR: bphYTK9QqbOE1n8jeRI496v6AH+AEqn2nM3jpTodX68DsYAKcf93nNZjtPqGejeeiS2NI8edvF
 gJP9loSLKa6haY3pUjtpNV4xC3B5ErvmObC41FQAZRePAfT7licgdmPMGHYIIhD8YLUSjL5syT
 VvJjREW+bFXmbImaPusfxBCNUd4KUCZHmA/z5dfKM51Nz8O4XLkJmD247+x6LD93scbCsvW6Ha
 Dt71FGs0wHBJUMACUfR0dJvt/rrlKuM9z+PrD65o99tawrOAYrQKzeRwk0/kDB1BMHceFzYPqC
 UWw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 10:10:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2xKJ0qdRz1Rws0
        for <linux-block@vger.kernel.org>; Wed, 10 Aug 2022 10:10:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660151443; x=1662743444; bh=tLjnPCdY0CPud0gZoWqOOs4dR6XNnOxfEo9
        SNWG799Y=; b=mTBmzjOr4h1LBCukLQPRjySe6bu7paraQ9i+Drxv3pb2NYIa8R8
        KTyqSPOkdKaLIoYzm6b2MdvfM49mbNBEJ9ml+HiWAcTD5KT3IsAvbuB5cWM2wDDX
        MlULNVXPmpcJfh5MRYGWgstx5yPIdF4N2yD9/xktCVu1B7Nzcu+5V+uNf1X6RY4N
        OJIUZIJiDTF8Xp4MTZ3sZ1EWOy8VnGApB3av9ZYl2B5hhXpR6a6PQh/+0ZDgFrhI
        Xtbe+yqFDVua6mE8E0yixb8VyM94Ijv/Zxv1saGPMO+fJ0mguEQh/mueK4Qq3Ymq
        MuqL0Zsd4YSx8YTmtq3M3x4acKdxLmwHq5Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TgEdviOumBrq for <linux-block@vger.kernel.org>;
        Wed, 10 Aug 2022 10:10:43 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2xKG5Ytmz1RtVk;
        Wed, 10 Aug 2022 10:10:42 -0700 (PDT)
Message-ID: <4a045887-6d44-661d-24d2-4f0cf039a058@opensource.wdc.com>
Date:   Wed, 10 Aug 2022 10:10:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v9 08/13] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, bvanassche@acm.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094811eucas1p17a2ac191899bba7938de6b9e3a55352f@eucas1p1.samsung.com>
 <20220803094801.177490-9-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220803094801.177490-9-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/08/03 2:47, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> dm-zoned relies on the assumption that the zone size is a
> power-of-2(po2) and the zone capacity is same as the zone size.
> 
> Ensure only po2 devices can be used as dm-zoned target until a native
> non po2 support is added.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/md/dm-zoned-target.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
> index 95b132b52f33..9325bf5dee81 100644
> --- a/drivers/md/dm-zoned-target.c
> +++ b/drivers/md/dm-zoned-target.c
> @@ -792,6 +792,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
>  				return -EINVAL;
>  			}
>  			zone_nr_sectors = bdev_zone_sectors(bdev);
> +			if (!is_power_of_2(zone_nr_sectors)) {
> +				ti->error = "Zone size is not a power-of-2 number of sectors";
> +				return -EINVAL;
> +			}
>  			zoned_dev->zone_nr_sectors = zone_nr_sectors;
>  			zoned_dev->nr_zones = bdev_nr_zones(bdev);
>  		}
> @@ -804,6 +808,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
>  			return -EINVAL;
>  		}
>  		zoned_dev->zone_nr_sectors = bdev_zone_sectors(bdev);
> +		if (!is_power_of_2(zoned_dev->zone_nr_sectors)) {
> +			ti->error = "Zone size is not a power-of-2 number of sectors";
> +			return -EINVAL;
> +		}
>  		zoned_dev->nr_zones = bdev_nr_zones(bdev);
>  	}
>  


-- 
Damien Le Moal
Western Digital Research
