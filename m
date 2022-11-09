Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DD8C433FE
	for <linux-block@archiver.kernel.org>; Wed,  9 Nov 2022 05:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiKIFZL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Nov 2022 00:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKIFZK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Nov 2022 00:25:10 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A97C1929E
        for <linux-block@vger.kernel.org>; Tue,  8 Nov 2022 21:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667971508; x=1699507508;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=28a+02Fgq8pMYphunQyvKZP+AeC/smNTgaI5o8P+Zn8=;
  b=fEgKlztUwJYNvsYjdMFlUpmh11JdHCCo5pRyMY/McB9QSz6LglpGT9hT
   JLi0DskzhyhpTVO3X2MRyHTgSjMKfxH6g8mGyOjnqoppN2oUOuyGstZgF
   SC4r+Gt0QXiugOFIm2GxskGTMxCelOpmeKEywe6lz0sGtOoU1qwXlJeNb
   kvFVHQsPctvBXHqWHI6X3IBplT61RHkxHRCLQTwbyWA6QAsWft0bLFlBj
   XJNktKV18znpD2NruE/NlnL8+SGliGxROyXThnW2RvJX+QxmBSpFrhbq2
   jFhpIZvMeEfgoEkN8tpJKaudMGxQrApgBWunNYW936Trie+PReGoGHDhv
   A==;
X-IronPort-AV: E=Sophos;i="5.96,149,1665417600"; 
   d="scan'208";a="220988815"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2022 13:25:08 +0800
IronPort-SDR: 58jr8dmrQdBWk3yq6DZXcN9VWq523b8164dSeMueaKPAh/1nHMFqxTNhNTWame0iR0JiCIUCCW
 56mBZteeP8WR9z4k/qwo4RpLgazm2ChgEEE8mjT0HlTNA/4RJHdOo1vPAtlMtKQp9XW/8eJQfP
 KHW25PP4UdSakn4fjrfpQGMHSyb1IIV2mBFs+t9TEPuWyucWS2jEDRwRZuWpSVXLUL05+hCDNj
 etdUJAqzijaC2pf9UzjwZclGhzog+XZxq/qP7lksgX05xAwlOfjwhtRezgU+3L9PAMtcmXKDqW
 t3g=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2022 20:44:12 -0800
IronPort-SDR: hw51oRBeKQ8oW8+3IgnwUxxqRc3cvZhy/G1giXTaP1ISbEwBaX2nMRqY/qVI7F+K/6EnCJhg6w
 Ju9cfj58kmBT72TYNPf77ckV81d1f06EdPylTMBelRnCR59Cvl9zVME3A+HGwGbTfNTi5BWgL/
 K2Hggm5Yfii5ZWi38GM4mvFUXhL5odTICcZgMi9B6eW42cRseXZnyIUYWkHnweAc5pmYEuJC1l
 DdKslvsWE8/yqiWp3k1EP2/3NcmH/0SM0Vt6+LxV4QhrifnzA7vp/RyKRsKyjzKquwfmvnbxd4
 fhI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2022 21:25:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N6YM737Bbz1RvTp
        for <linux-block@vger.kernel.org>; Tue,  8 Nov 2022 21:25:07 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667971506; x=1670563507; bh=28a+02Fgq8pMYphunQyvKZP+AeC/smNTgaI
        5o8P+Zn8=; b=TzfKQgkLBgjC8Dv/OQFB1PW+/AVAyIk8aPKdOAM1O8Z1o21E/1y
        ri2pjjYeTvQ1QkCZC3daQWjIuc0XrKitdHeNX3xeGjkhqSqZ0iDGcPbpiYjAv8Fd
        Ty/9iatMZgK3+GB1OlF+qeLWbhqz/kElZXyLZrKWN3QE5g35UiaowLYr6M9rXhie
        WRWqwQCtB80tx9vheE3HMC3yARw/P06pKSActNB9U0NpUTWh0Wodpw2Sb/F4IHPR
        YOdw8s5suRqE52/qHNhbQEaEqmHgn1ujNIpiGY8LzujkqYlQU1qgI+hJHDIP5PJM
        mWM50/2OJ8QMoBl9rDmOiU3X7rNQHZzHbbQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id coEJUGNHQKCS for <linux-block@vger.kernel.org>;
        Tue,  8 Nov 2022 21:25:06 -0800 (PST)
Received: from [10.225.163.37] (unknown [10.225.163.37])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N6YM55mGmz1RvLy;
        Tue,  8 Nov 2022 21:25:05 -0800 (PST)
Message-ID: <89bc8261-b9de-f488-6091-3d1baa29fd80@opensource.wdc.com>
Date:   Wed, 9 Nov 2022 14:25:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v6 1/2] virtio-blk: use a helper to handle request queuing
 errors
Content-Language: en-US
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org
References: <20221109044632.3121790-1-dmitry.fomichev@wdc.com>
 <20221109044632.3121790-2-dmitry.fomichev@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221109044632.3121790-2-dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/9/22 13:46, Dmitry Fomichev wrote:
> Define a new helper function, virtblk_fail_to_queue(), to
> clean up the error handling code in virtio_queue_rq().
> 
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

(you forgot to add my Rb tag that I sent...)

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/block/virtio_blk.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 19da5defd734..3efe3da5f8c2 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -315,6 +315,19 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
>  		virtqueue_notify(vq->vq);
>  }
>  
> +static blk_status_t virtblk_fail_to_queue(struct request *req, int rc)
> +{
> +	virtblk_cleanup_cmd(req);
> +	switch (rc) {
> +	case -ENOSPC:
> +		return BLK_STS_DEV_RESOURCE;
> +	case -ENOMEM:
> +		return BLK_STS_RESOURCE;
> +	default:
> +		return BLK_STS_IOERR;
> +	}
> +}
> +
>  static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
>  					struct virtio_blk *vblk,
>  					struct request *req,
> @@ -327,10 +340,8 @@ static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
>  		return status;
>  
>  	vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
> -	if (unlikely(vbr->sg_table.nents < 0)) {
> -		virtblk_cleanup_cmd(req);
> -		return BLK_STS_RESOURCE;
> -	}
> +	if (unlikely(vbr->sg_table.nents < 0))
> +		return virtblk_fail_to_queue(req, -ENOMEM);
>  
>  	blk_mq_start_request(req);
>  
> @@ -364,15 +375,7 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  			blk_mq_stop_hw_queue(hctx);
>  		spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
>  		virtblk_unmap_data(req, vbr);
> -		virtblk_cleanup_cmd(req);
> -		switch (err) {
> -		case -ENOSPC:
> -			return BLK_STS_DEV_RESOURCE;
> -		case -ENOMEM:
> -			return BLK_STS_RESOURCE;
> -		default:
> -			return BLK_STS_IOERR;
> -		}
> +		return virtblk_fail_to_queue(req, err);
>  	}
>  
>  	if (bd->last && virtqueue_kick_prepare(vblk->vqs[qid].vq))

-- 
Damien Le Moal
Western Digital Research

