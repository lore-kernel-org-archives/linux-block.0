Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66D3C433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 06:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380269AbiFQGMN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 02:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbiFQGML (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 02:12:11 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904AC39150
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 23:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655446330; x=1686982330;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EL0OFV/UiqDMNfEqXjfHFETPeL++FywuFfi93t89YZY=;
  b=ZYU5DfqdPaHKb+IyH2waMC+WyV2LJpQTf1fIJ/0YuQpFNF9UG2iTJuPd
   +VaEo4oJF/0BOmWtz2RbHvffY2D2Tb4D3gxPT3rT9PljifZNZPXBu9EXy
   vof6ptUHI1Zc4WgpUiPwW8453Rg1JU0O4S3Bp5N9kcz4+3wQX2JoAEczd
   CwX8jbxzS2l+rfJD0n9/UiYlyfbf8fhOtf+tT7BpFQ768yZkiQG6el6w/
   Lvm/ZSjly563cRnuUzuKtf9m4CM5I/zVkZIFPaKdlID6X7G77sXDxNYnc
   O4SGVew64/bHsHfayDvuzyk5ttuHH9vGQ8dbDwU1kEtAXfArIr3rFiawd
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="307708020"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 14:12:08 +0800
IronPort-SDR: NrRQxx9aJNB4xem6PA5xgZOkcJ07RUV1aeKrNuq4jBMaTTNhNVZFdeJzk0ChWjiE62Do698MDs
 TU3WsDTFl7fLVR9Th/TiZjV8JD8CNrI3AJNvEtu9Qiru20XkhzhCp6Ov3PE+8lFpdjRLQsdsqC
 EEp5YRlOY0gaaLA6GDeziQRcSoEssn2aCiLRCSxXMbQRsds6jNZX2YafCb0SvgBGv0AJfaOj2P
 m9zKGvxPV0hS4/lJskxNtK9BnGogce+fpkZtm3Pf2psyv2WtFoh1H1cCC9RjVe25SvOPD+pTfx
 ie9rQuaajR+bGYKvekKl8Z9d
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 22:34:43 -0700
IronPort-SDR: iz/XwTP0ER8tMffoKthz7rtQO1WitKa/kHieTT9DyHdZk+bLEM9CYuumDFqL5aVEizaLqZSAjD
 AFcHCG2eyeSGylA8Mr/uaqNJxBOrSOUfr9Z+8y5rWvA7qvS9HAYS8uxo4kaJauuVt3UgR+oBfs
 sIu/Lhvb40hdS0CRwradJBe076pPsvIZUdEfTWcbuWF3pGhVLecEtZAIRLuRCblLhV51jBWB4k
 +Y9GHC2gbHaKFm4RZkKktlEm20LwlpX7PQ1Od+0KkR2YCQ3mS2VX0FVgkkAVuAI/4dJLWpJqbh
 26o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 23:12:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPTGH6Lk4z1SVp9
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 23:12:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655446326; x=1658038327; bh=EL0OFV/UiqDMNfEqXjfHFETPeL++FywuFfi
        93t89YZY=; b=tg8Y4ZUqrYrSlCX1cfdQJQbXeni8cm3sgQribFQQrVng5yMSI7m
        UWVClsoZoRcApXJcrFisgwLEc5MbO3Hddn99eQWULl2Ald/eUzEXmRngp4zLO9o7
        WwHDzongAD4JVNwn5NTaP1S4FzJGJwi82emZbD2xYuddYBtS1z2GRVcwtGFFsvvC
        Di8Meiu+/c0T97Y1SweNA5t8g9JW1txEoFm8PHiGPz3rZ4r1qs9fwxIKKQgu0dns
        EeI8qnoj3VzSMtdlcN1ZzuL2P0E7H3SRLwY/ICtw/h0EiqmO9EiEiOOibtFQJ78E
        yaZKSfyMAIwv2BKgxiIh53uhj0ZUKj+W8vw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BQZHFjx4gSb0 for <linux-block@vger.kernel.org>;
        Thu, 16 Jun 2022 23:12:06 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPTGB6TbPz1Rvlc;
        Thu, 16 Jun 2022 23:12:02 -0700 (PDT)
Message-ID: <e0dc08fd-cd00-240d-edc4-5799d51aa5a8@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 15:12:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 13/13] dm: add non power of 2 zoned target
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        snitzer@redhat.com, axboe@kernel.dk
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org,
        jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        gost.dev@samsung.com, dsterba@suse.com, jaegeuk@kernel.org,
        linux-nvme@lists.infradead.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615102011eucas1p220368db4a186181b1927dea50a79e5d4@eucas1p2.samsung.com>
 <20220615101920.329421-14-p.raghav@samsung.com>
 <63b0cfb6-eb24-f058-e502-2637039c5a98@opensource.wdc.com>
 <0b819562-8b16-37b6-9220-28bf1960bccb@samsung.com>
 <0c4f30f2-c206-0201-31e3-fbb9edbdf666@opensource.wdc.com>
 <4746a000-2220-211e-1bd6-79c15c18a85c@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4746a000-2220-211e-1bd6-79c15c18a85c@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/22 14:45, Pankaj Raghav wrote:
> On 2022-06-17 01:49, Damien Le Moal wrote:
>>>> Why do you need to change dm_set_zones_restrictions() at all ?
>>>>
>>> When the device mapper is created, the q->limits gets inherited from the
>>> underlying device. The chunk sectors of the target and the device will
>>> be the same but we want the chunk sector of the target to be different
>>> (rounded to po2) compared to the underlying device's chunk sector. This
>>> needs to be done only for the dm-po2z target and not for other targets
>>> that uses npo2 zoned devices (like dm-linear). So to perform this
>>> operation in a target independent way in dm-zone.c, I chose to always
>>> revalidate npo2 zoned device and update the chunk sector and nr_zones in
>>> dm_zone_revalidate_cb based on the zone information from the target.
>>> This allows to set the limits correctly for dm-po2z target.
>>
>> But DM revalidate will be called for the target AFTER it is setup (after
>> its gendisk is added). So how can DM revalidate see the incorrect zone
>> size ? If that is the case, then the target constructor is broken or
>> missing something. DM revalidate zone is generic and only allocates the
>> zone bitmaps for the target device. There should be not need at all to
>> touch that function.
>>
> I think this is a cleaner approach using features flag and io_hints
> instead of messing with the revalidate zone function:
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 135c0cc190fb..c97a71e0473f 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1618,6 +1618,9 @@ static int device_not_matches_zone_sectors(struct
> dm_target *ti, struct dm_dev *
>  	if (!blk_queue_is_zoned(q))
>  		return 0;
> 
> +	if(dm_target_supports_emulated_zone_size(ti->type))
> +		return 0;
> +

This should be in validate_hardware_zoned_model(), not here.

>  	return blk_queue_zone_sectors(q) != *zone_sectors;
>  }
> 
> diff --git a/drivers/md/dm-zoned-npo2-target.c
> b/drivers/md/dm-zoned-npo2-target.c
> index dad135964e09..b203be808f09 100644
> --- a/drivers/md/dm-zoned-npo2-target.c
> +++ b/drivers/md/dm-zoned-npo2-target.c
> @@ -187,6 +187,12 @@ static int dmz_npo2_end_io(struct dm_target *ti,
> struct bio *bio,
>  	return DM_ENDIO_DONE;
>  }
> 
> +static void dmz_npo2_io_hints(struct dm_target *ti, struct queue_limits
> *limits)
> +{
> +	struct dmz_npo2_target *dmh = ti->private;
> +	limits->chunk_sectors = dmh->zsze_po2;
> +}
> +
>  static int dmz_npo2_map(struct dm_target *ti, struct bio *bio)
>  {
>  	struct dmz_npo2_target *dmh = ti->private;
> @@ -233,12 +239,13 @@ static int dmz_npo2_iterate_devices(struct
> dm_target *ti,
>  static struct target_type dmz_npo2_target = {
>  	.name = "zoned-npo2",
>  	.version = { 1, 0, 0 },
> -	.features = DM_TARGET_ZONED_HM,
> +	.features = DM_TARGET_ZONED_HM | DM_TARGET_EMULATED_ZONE_SIZE,
>  	.map = dmz_npo2_map,
>  	.end_io = dmz_npo2_end_io,
>  	.report_zones = dmz_npo2_report_zones,
>  	.iterate_devices = dmz_npo2_iterate_devices,
>  	.module = THIS_MODULE,
> +	.io_hints = dmz_npo2_io_hints,
>  	.ctr = dmz_npo2_ctr,
>  };
> 
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index c2a3758c4aaa..9f3a4d98a22a 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -283,6 +283,15 @@ struct target_type {
>  #define dm_target_supports_mixed_zoned_model(type) (false)
>  #endif
> 
> +#ifdef CONFIG_BLK_DEV_ZONED
> +#define DM_TARGET_EMULATED_ZONE_SIZE	0x00000400

Make it general: DM_TARGET_EMULATED_ZONES

> +#define dm_target_supports_emulated_zone_size(type) \
> +	((type)->features & DM_TARGET_EMULATED_ZONE_SIZE)
> +#else
> +#define DM_TARGET_EMULATED_ZONE_SIZE	0x00000000
> +#define dm_target_supports_emulated_zone_size(type) (false)
> +#endif
> +
>  struct dm_target {
>  	struct dm_table *table;
>  	struct target_type *type;
> 


-- 
Damien Le Moal
Western Digital Research
