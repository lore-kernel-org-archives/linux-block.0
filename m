Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25F1C6FA82
	for <linux-block@archiver.kernel.org>; Sun, 25 Sep 2022 22:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiIYWzU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Sep 2022 18:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiIYWzS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Sep 2022 18:55:18 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2CE1EACC
        for <linux-block@vger.kernel.org>; Sun, 25 Sep 2022 15:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664146516; x=1695682516;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x2YbQXgRBgGLdhgg+0qdqVm+nwP0pOEuZfWlKM5zf7Q=;
  b=f9g5q+CyacetcDq73VshVxWX8d8sTzBOwGEaKufKkzsHKORtfyWH9im7
   OpxmRLfzXIGwWdmDb8raNm2PwFELRRB3b+uuH/g55RhevhWdFQqowiqj0
   Qg6QIv6SD3dvagXP/KHiWGjpN0biAf+nsLqqKACdxLYkiE0ZVjZK2ZDzU
   lGIKlRX2Lyte3cXWa7IoXh6uYS5Ry0dzTkqOfzXn/4uRC8l47D2HAI4Im
   KPMl1RTMIdNSgoYTl9VZX/bQUzXdZISpqOKmcslD5wqldwz14HFgFXd26
   HGBOEwh/YxSnCt6kOLdGanZiSP+/sX9XjC0MZ2wF/Fg5R7ePi2XkU3rsp
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,345,1654531200"; 
   d="scan'208";a="324337792"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2022 06:55:16 +0800
IronPort-SDR: PjpVmQV2dJXHXwsBbULKobVHIycyTXKiUo0ik8CDe4eQ2AEsWWIIiQqJnfsH02gipiCboVv5P8
 nXZXA5ixYLn42BPAqDfmkOWm3NZh+L/ksDt2fWAouVncXYcW9Eb2fHfoNghJsLNrBjMDH0gEel
 SGFeySJvhnv/7db7Ipig07Q4oiUlEIu95VCED22fBwLSI7151JnoB1xPESldwKBtyS6+zRLDDv
 y1+J11jCa0u3NnHDOmodDikAwRd7nrS1EXm5fC9573zLHi3DKtmsuGy7haq+CRPHRCyEQpZXdg
 z/yJ8qi9FQDm3L74geRAkmQR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2022 15:09:43 -0700
IronPort-SDR: qJc8nW9DZutzD/0pGBg5hZ3oKcKUq6r5+tZVO6yAgCOAPF2N6p1dZrEFsAVteA8nKyC+BzLqrv
 4gBHk1JVkZ0cUKPfJixIik725x9ZcEOIQAHzYxPVQCiw1/rgSYbcEZUXYdGx6RlCG6nNYr9v+k
 6druri3zq/eCj1skSAAO6+EX+S3AI4Wc2QWaPpRhM7PZjb5xwzvcNMRLGPDiERmF5vCSMyT1FF
 Y2M9cX+CUg/qCIBwfAMNkmnp3udCkVYMLN544dQ6Jgy9sBoM1apD2Quok9oER/zgWdrL5kMzzO
 tPM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2022 15:55:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MbLnb5jDSz1Rwrq
        for <linux-block@vger.kernel.org>; Sun, 25 Sep 2022 15:55:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664146515; x=1666738516; bh=x2YbQXgRBgGLdhgg+0qdqVm+nwP0pOEuZfW
        lKM5zf7Q=; b=DGgOiG4NJcbLvclB6n45vIfG7JhSGBpAFYir+mth2fgJGV22x1T
        KNQ3D8tSrQl0p0U5f+cs3E6ufAUFqhqLiqaVaO4935NU6P2t7sTs3x+e6hN8O2d0
        URfIokS4omzZ8lISEzJW7IiVIpLgChIm/XLEkgUquZ1WgTG8BMxEDnYA4j9JrdXG
        hDby9MEuD7FmX/2VQAV5nJB6w0/F+pekvO3uZW8CmWPxvF85QS6yhflUWx0f37bU
        DiEXJcoxci/BFzG1QGuxAKD6HIfI9AbRS3MTVEFItFXfjj8DIuNW3qCsascIoJLD
        N0ZoyyIG6yd4MQn+8wEkUOAHDRs/pEZXUmA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9ZDVTAkI7Bug for <linux-block@vger.kernel.org>;
        Sun, 25 Sep 2022 15:55:15 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MbLnZ4P6Dz1RvLy;
        Sun, 25 Sep 2022 15:55:14 -0700 (PDT)
Message-ID: <736c593b-a8cb-0e68-c895-cb89bc29b68e@opensource.wdc.com>
Date:   Mon, 26 Sep 2022 07:55:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] block: modify blk_mq_plug() to allow only reads for
 zoned block devices
To:     Pankaj Raghav <p.raghav@samsung.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     gost.dev@samsung.com
References: <20220925185348.120964-1-p.raghav@samsung.com>
 <CGME20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef@eucas1p1.samsung.com>
 <20220925185348.120964-2-p.raghav@samsung.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220925185348.120964-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/26/22 03:53, Pankaj Raghav wrote:
> Modify blk_mq_plug() to allow plugging only for read operations in zoned
> block devices as there are alternative IO paths in the linux block
> layer which can end up doing a write via driver private requests in
> sequential write zones.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   block/blk-mq.h | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 8ca453ac243d..005343df64ca 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -305,14 +305,15 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
>    * change can cause write BIO failures with zoned block devices as these
>    * require sequential write patterns to zones. Prevent this from happening by
>    * ignoring the plug state of a BIO issuing context if it is for a zoned block
> - * device and the BIO to plug is a write operation.
> + * device and the BIO to plug is not a read operation.
> + *
>    *
>    * Return current->plug if the bio can be plugged and NULL otherwise
>    */
>   static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>   {
> -	/* Zoned block device write operation case: do not plug the BIO */
> -	if (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio)))
> +	/* Allow plugging only for read operations in zoned block devices */

nit: s/in/with

> +	if (bdev_is_zoned(bio->bi_bdev) && bio_op(bio) != REQ_OP_READ)
>   		return NULL;
>   
>   	/*

Otherwise, looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

