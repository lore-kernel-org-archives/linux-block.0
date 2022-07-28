Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4C8C04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 03:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiG1DWs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 23:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiG1DWr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 23:22:47 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D9752442
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 20:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658978566; x=1690514566;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1akqneWlsZLozCUh+myPMpEWIgDgWs2xBscRax+3MdE=;
  b=bcfPAVdtEEtiX+bU886B6ocwpKqAvaVZ+6e1PjKX20CB0aQ5IyZESiiJ
   SgJVc+0Az1UHgW73FMTsPd1P6rRNEVSrUpidLoXfPmWdWIff7kbFntwNA
   RLosM1YAAqfRCEMinNPf3P8BVBTQ2uZo9LPX7ognnrf6RXqEY5XqlueEW
   u7NwwdX1RwpiIO1Nh9elKoB4UijpW6WO7CJQlI+qzMh1OyPHKPrRZx5Eh
   DGU5iND1vAHTbYxfD6aajYgmvFLnlNOly6fL81TTNDin5lPMmu+vpnwao
   fj2iQDklk5bKcCP6eR7j+bJmZRYkQ1nntQaqUx7RXrnwgGjqjs8zhBH6l
   g==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="205666957"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:22:46 +0800
IronPort-SDR: M9mtFTkpEe2GYBhirWO2/zTkJH2Bk/6RZg6+AT1O2EhCbUkFSbA3nM8uc9SKvxn69KPzEWOf6U
 x3kuYyeH5Z1UOn8SAh1wwMEuWWesyqd+2Ku8BqbDxhaPHZsmfcA3Z4DR/2VVks+Xl86zTSCrBQ
 GUqVX85O7Lb1MiwBSk4kx7blWrFtrTx6DaXBwXWzRN2kcdNL+yEZe10ISjObTjS0l5hXOaZ/2B
 8ESdgBxd/A2Z4x8IRxV3rjx5qUcPQH3u9o54IL3Ap68bNARKXQE7sOdB0UFWUkav0FRaHL98Db
 2RBQXCv+LcXViuQTDOQfWkAi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:43:56 -0700
IronPort-SDR: fu2Lql3m6jPEJa4WRpoXWfg53QVGuQgnweT89gEeP5PC93XiMTzCdXbeUWrQsY83t0QAmSH8WT
 y9nt9BAJUZBYND0aQ8mj30080Nz9Lqhrfz/CqVZjHhHLNJuu0fLwJBKb243J+pInUlc38F1Ddj
 N/OO6UatImI7LiyGLrSt42pyK0Z+JIui8EtiPiM8Oyaigewz1VTih+fXUaIzacueufbvOKKkpN
 qNi21a70ckhShK5cNRJRpvdWDB7Dj+zO5ro6nPIibwyzynQFBt7xe95EgY1P35cUuluN+lScBD
 +E4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:22:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtbYx48gVz1RwqM
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 20:22:45 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658978564; x=1661570565; bh=1akqneWlsZLozCUh+myPMpEWIgDgWs2xBsc
        Rax+3MdE=; b=lDWWQ49HXa/nHiKyzPaHVx17tMGDCgpioodaJiZbRmZn8e2qwQ6
        AOf4ST+N/DS3Wypk80No9fiPitfB6vD8UUY/syMxHTakzR3Mob+xOb0IFjk69pzm
        1zcmGZiWGzjEta59mbYffTSXrlHIS6K7Kwh4qDzefhqN6Vi1sNfUntjqLCVF7K4P
        5wfNexMBmyah5BjGLllp4LtWVHrfbkG2aUYi9q23XSz31pzEtNYeOdAGONHC1nTZ
        gg0RmAc0dO/Momc9aHDAlleS45qv5cM81cTbpG7cHC0bhWJuJHQiPBEQjHKXR4yY
        0H3sm1n1I6FxBA5nnR6oQS/Kae66v5WJDew==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lb4sSes7GXtr for <linux-block@vger.kernel.org>;
        Wed, 27 Jul 2022 20:22:44 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtbYt2Q7Fz1RtVk;
        Wed, 27 Jul 2022 20:22:42 -0700 (PDT)
Message-ID: <65a336f0-ecd7-e9d5-2646-37cf9f157d53@opensource.wdc.com>
Date:   Thu, 28 Jul 2022 12:22:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 09/11] dm-table: allow non po2 zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        bvanassche@acm.org, jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162255eucas1p2945c6dca42b799bb3b4abf3edb83dde8@eucas1p2.samsung.com>
 <20220727162245.209794-10-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-10-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/28/22 01:22, Pankaj Raghav wrote:
> As the block layer now supports non po2 zoned devices, allow dm to
> support non po2 zoned device.

Please rephrase "non po2 zoned devices" here and in the title to correctly
refer to the zone size of zoned devices. Because "non po2 zoned devices"
means absolutely nothing. Let's be clear please.

> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/md/dm-table.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 332f96b58252..534fddfc2b42 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -250,7 +250,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>  	if (bdev_is_zoned(bdev)) {
>  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>  
> -		if (start & (zone_sectors - 1)) {
> +		if (!bdev_is_zone_aligned(bdev, start)) {
>  			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
>  			       dm_device_name(ti->table->md),
>  			       (unsigned long long)start,
> @@ -267,7 +267,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>  		 * devices do not end up with a smaller zone in the middle of
>  		 * the sector range.
>  		 */
> -		if (len & (zone_sectors - 1)) {
> +		if (!bdev_is_zone_aligned(bdev, len)) {
>  			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
>  			       dm_device_name(ti->table->md),
>  			       (unsigned long long)len,
> @@ -1642,8 +1642,8 @@ static int validate_hardware_zoned_model(struct dm_table *t,
>  		return -EINVAL;
>  	}
>  
> -	/* Check zone size validity and compatibility */
> -	if (!zone_sectors || !is_power_of_2(zone_sectors))
> +	/* Check zone size validity */

The comment is not super useful now given the trivial test.

> +	if (!zone_sectors)
>  		return -EINVAL;
>  
>  	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {


-- 
Damien Le Moal
Western Digital Research
