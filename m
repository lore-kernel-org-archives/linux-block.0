Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1739CC352A1
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 10:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiK3KSr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 05:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbiK3KSn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 05:18:43 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7235D2098D
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 02:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669803521; x=1701339521;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nkhEcFf6zloYmV+imKMFZB6KSD9/YcZF1kBKubH/t0Y=;
  b=TVOZKBnwsHV+/8T3DUnbpQ8vZAz6Z+HF+VcI4XhJ7brKHHj3PvZwpTnz
   AS2UfelQ0XSjcQt4Qqq2FKXgHVdzdgy9J2DVlEZekv/k6cDAetpZ7XVBt
   1u28QDkoSrcRzXyEXlVapp+Z9zK9Wwlhik27+YUnS6pSHp3o42CsA/AbK
   1yxef8FfbOQJjnioKfSOIr1D11Ge3gj9Y5SkiRlZX0bk+Y7Vj2XjoJPuS
   TbnVLhYTbgn8WXNsLDJWc0n6jzOROFKPu40e225h97yMZJlgrpXAm5cwu
   oG8B1max0qhRKnCtm+frMtT3t4hVNXy51MSqp2lEBXq4tbb/tNpGPO1k0
   g==;
X-IronPort-AV: E=Sophos;i="5.96,206,1665417600"; 
   d="scan'208";a="222699061"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2022 18:18:40 +0800
IronPort-SDR: JDIzZ3a1DqexnZbzU9q+7TXjxuzzcXUDYCQivtsqvkI783+/Cn6ORhdvVF7su1DsVU0yJjpx2L
 Nc2LVl+5+jqXBg9D8/UkNWwGITggC9vlJPrRcGaS4Hqd+QrJbrr7so8P1Aut9jSx9aSN05/RS8
 cf4sL28paHeguzrO5MoO2RWXbKv1bhmsH/kdnDyIgaXX5EfI9dtKYhBgfIuxdhBqswZkudDx02
 Xuztg+oqAbARFQCYYyw3G93ov51SDWGz6/7YSn2BH2sAeiB7RiUxzdt1mmGWhoczoeA0Fu0zdr
 N28=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Nov 2022 01:37:19 -0800
IronPort-SDR: nKDL6syxNYIurxyWasGELPsWdaF5zYl488NS3SFVDXJYzAW6lVHDk5KFBki0MrO5pAyldhbmES
 82xMDtiv4HIYsE/hHHiFoKSFdbIthUIEvNaixwKsfO7GtbGyJrCgTPmgsSh+zeqHnFSZBXp3KG
 PTbpP/JZsVxIjblQ0dUuYokD1AwUsK202hKeBzxsTD+UZvhVCUdxFyIEzApD9dp4fPYYmhkvdz
 9e3LdN8hHAliT5f8Od7nRfmnI9nqj37La4nuu5m8/hGeJQzxiBrJqvpCEZIOU4C2SI4jYttOtV
 0Q0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Nov 2022 02:18:41 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NMZt81KZLz1Rwt8
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 02:18:40 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669803519; x=1672395520; bh=nkhEcFf6zloYmV+imKMFZB6KSD9/YcZF1kB
        KubH/t0Y=; b=Iv8f7KnH1Fmhnwz/b4g0BFJnTj89nFGAKLoQgE/xF8FbdN6b1lZ
        /5ZUwTvAq8gJ+Wa6W/7N4367dYlRQ1FcUQwhQM/WLRgKDuQeUBtpDpVYAHJdt3AV
        Uwsn29gx7Zx32vzf20pMsmg+ZqOwf02G3EyE7wkQkRyeMLiDMmVGqrcqqcNPujiR
        /77LoML7ZcJBFU72dBW2u5Fl6imo/UdWo1YNDI8ypTjvvBIXyiGrc5uhUeUySuLN
        OSQObsxHWGBBZgwBVkR8pqeQTN8umcqgJo4UkIj2OpAXV1CABMET/2Vp9hGd9qsQ
        oTKtiH8fGD1vOZq6Vp8+Dj4FCGnaW4pygvQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7Qauk6Rhxaa3 for <linux-block@vger.kernel.org>;
        Wed, 30 Nov 2022 02:18:39 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NMZt64vjfz1RvLy;
        Wed, 30 Nov 2022 02:18:38 -0800 (PST)
Message-ID: <fde23932-d8a4-5a14-9298-7022edbb20de@opensource.wdc.com>
Date:   Wed, 30 Nov 2022 19:18:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] null_blk: support readonly and offline zone conditions
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20221130094121.2321485-1-shinichiro.kawasaki@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221130094121.2321485-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/22 18:41, Shin'ichiro Kawasaki wrote:

[...]

> @@ -627,6 +631,12 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_op op,
>  
>  	null_lock_zone(dev, zone);
>  
> +	if (zone->cond == BLK_ZONE_COND_READONLY ||
> +	    zone->cond == BLK_ZONE_COND_OFFLINE) {
> +		ret = BLK_STS_IOERR;
> +		goto unlock;
> +	}
> +
>  	switch (op) {
>  	case REQ_OP_ZONE_RESET:
>  		ret = null_reset_zone(dev, zone);
> @@ -648,6 +658,7 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_op op,
>  	if (ret == BLK_STS_OK)
>  		trace_nullb_zone_op(cmd, zone_no, zone->cond);
>  
> +unlock:
>  	null_unlock_zone(dev, zone);
>  
>  	return ret;
> @@ -674,10 +685,103 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_op op,
>  	default:
>  		dev = cmd->nq->dev;
>  		zone = &dev->zones[null_zone_no(dev, sector)];
> -

I would prefer keeping this blank line after the "return BLK_STS_IOERR" below.

> +		if (zone->cond == BLK_ZONE_COND_OFFLINE)
> +			return BLK_STS_IOERR;
>  		null_lock_zone(dev, zone);
>  		sts = null_process_cmd(cmd, op, sector, nr_sectors);
>  		null_unlock_zone(dev, zone);
>  		return sts;
>  	}
>  }
> +
> +/*
> + * Set specified condition COND_READONLY or COND_OFFLINE to a zone.

May be "Set a zone in the read-only or offline condition."

> + */
> +static int null_set_zone_cond(struct nullb_device *dev, struct nullb_zone *zone,
> +			      enum blk_zone_cond cond)
> +{
> +	enum blk_zone_cond old_cond;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(cond != BLK_ZONE_COND_READONLY &&
> +			 cond != BLK_ZONE_COND_OFFLINE))
> +		return -EINVAL;
> +
> +	null_lock_zone(dev, zone);
> +
> +	/*
> +	 * When current zone condition is readonly or offline, handle the zone
> +	 * as full condition to avoid failure of zone reset or zone finish.
> +	 */
> +	old_cond = zone->cond;
> +	if (zone->cond == BLK_ZONE_COND_READONLY ||
> +	    zone->cond == BLK_ZONE_COND_OFFLINE)
> +		zone->cond = BLK_ZONE_COND_FULL;
> +
> +	/*
> +	 * If readonly condition is requested again to zones already in readonly

If the...

> +	 * condition, reset the zones to restore back normal empty condition.
> +	 * Do same if offline condition is requested for offline zones.

Do the same if the...

> +	 * Otherwise, set desired zone condition to the zones. Finish the zones

Otherwise, set the specified zone condition. Finish...

> +	 * beforehand to free up zone resources.
> +	 */
> +	if (old_cond == cond) {
> +		ret = null_reset_zone(dev, zone);

This will not restore conventional zones since reset will be an error for
these... So you need to do the reset "manually":

You could simply do:

		/* Restore the zone to a usable condition */
		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
			zone->cond = BLK_ZONE_COND_NOT_WP;
			zone->wp = (sector_t)-1;
		} else {
			zone->cond = BLK_ZONE_COND_EMPTY;
			zone->wp = zone->start;
		}

Then the hunk above that set the zone to FULL is not needed, and the
variable "old_cond" is also not needed as the "if" above can be:

	if (zone->cond == cond)

> +	} else {
> +		ret = null_finish_zone(dev, zone);

Do the finish only for seq zones. Otherwise, setting a conventional zone
to read only or offline will always fail.

> +		if (!ret) {
> +			zone->cond = cond;
> +			zone->wp = (sector_t)-1;
> +		}
> +	}
> +
> +	if (ret)
> +		zone->cond = old_cond;

There should never be any failure with this. So we should not need this.

> +
> +	null_unlock_zone(dev, zone);
> +	return ret;
> +}
> +
> +/*
> + * Identify a zone from the sector written to configfs file. Then set zone
> + * condition to the zone.
> + */
> +ssize_t zone_cond_store(struct nullb_device *dev, const char *page,
> +			size_t count, enum blk_zone_cond cond)
> +{
> +	unsigned long long sector;
> +	unsigned int zone_no;
> +	int ret;
> +
> +	if (!dev->zoned) {
> +		pr_err("null_blk device is not zoned\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!dev->zones) {
> +		pr_err("null_blk device is not yet powered\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = kstrtoull(page, 0, &sector);
> +	if (ret < 0)
> +		return ret;
> +
> +	zone_no = null_zone_no(dev, sector);
> +

Remove the blank line here.

> +	if (zone_no >= dev->nr_zones) {
> +		pr_err("Sector out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	if (dev->zones[zone_no].type == BLK_ZONE_TYPE_CONVENTIONAL) {
> +		pr_err("Can not change condition of conventional zones\n");

Why ? Conventional zones can go read-only or offline too. At least on
ZBC/ZAC SMR HDDs, they can. So allowing this to happen with null_blk is
desired too.

> +		return -EINVAL;
> +	}
> +
> +	ret = null_set_zone_cond(dev, &dev->zones[zone_no], cond);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}

-- 
Damien Le Moal
Western Digital Research

