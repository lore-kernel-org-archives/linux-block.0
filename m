Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61301C43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 06:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiGVGC6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 02:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGVGC6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 02:02:58 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32FD3545DC
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 23:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658469776; x=1690005776;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F2FZicUUzIZd48xnrFkix3i0nC8BbvV7Y4fYsjqdkdM=;
  b=WGCntpA1d1g8EGg8vl0CEg6744hnybVwUxDIIVODwfJfYWb46MU/dS8U
   mnw9sK0MGOe6sn/qj+p77VdDo/sKLUAH4pF2lDwqADoPv/1qlRmwlaRiT
   I1kQjeeFnAyr0O4Ds2zkqelhIvus/C6JRMVWefnt7U0IbjvClVFfgicqy
   8IM1eOIUOmHRXoDQ2ikla4gVnVeAd+j6kD/7Ni00Ba8RzKxtaxQdfi1sT
   aSP6DJAxmI656hMYwQ3EF1/+JkO8O/Y9UBTV8DK4RONAOKcHGiQUib8Ha
   78u4xE0zl9mnNkgvKAHS4AwiOmYVcz3fOFJDuZc0BXUWtRu2EbybkgQ0X
   A==;
X-IronPort-AV: E=Sophos;i="5.93,184,1654531200"; 
   d="scan'208";a="206616915"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2022 14:02:36 +0800
IronPort-SDR: V+6x7Cub2JdKYr8RobU18hJXS1OIddJtygQFs7TPIcQ4l1bKS3V6qKzVlZyC23ts5/Rhe9fzRU
 KLI7VNQJc+h941ievaMKMdgq+Edk/4BVFzDOfoyCfsFX57nPQrO7suc8DnKx7Kh3N7Rof4b+WZ
 vo8KdGTGfVY1Debm9xrr3/w0uA8GuzVpZM8jAQpYrEHBO4+EuDP4iOrWEx48DSHNams7xlHfFz
 4ZpHU2LDnNp509YBoLfQLOVN/izS+ehojjTo9UhZfnl8oRt6D7VgrFt6LeQXt3zJOZYyMfgjjk
 MbF8e8Kus3uSAg0HMJ/xtQRS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2022 22:18:58 -0700
IronPort-SDR: fV2nIqCKNJTUJxoAoB2PbAmjT+tWh90CLBthB0sVkiTYwzn+JQ/QmQVZTtcPqmsz44g8RSMaeT
 NbdUCoQOvV/BX9qvKDFkBrxEJ8utPlMcT2z7Fktw4MozHexRlNVDomm1/mXlA20F2UPO8ujklx
 p2GNMHxTjyue3TZGVwMqrfD45orgyLXbm6nFJ6qa5WqbEpNdiisZTzJZTxB9zbrxePpfdH+8A/
 S6wTzshWtqy68gbZKNae5GH1+kcHfp/Egt/+Kjgaj1yFcNvokZK//5uQyz9A/MwZhA1cuGYeFf
 vPY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2022 23:02:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LpzP91H39z1Rwnm
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 23:02:37 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658469756; x=1661061757; bh=F2FZicUUzIZd48xnrFkix3i0nC8BbvV7Y4f
        YsjqdkdM=; b=oBQU97n4bO2T2MEk3S/XppwHVWnomwRoIfoVp+ndpqnLWQmgXoT
        pHESvss7T9FaKldotmJWdkYNtUk5RP3C4hPU73wRK+S40YlL3xI6BR3mn/0rIsPe
        vdJkVxlVsJsiPOtKrAZRdgN/n9MiAj2g6NRtDL0AwupKyox0J1cKM2Pku70Tbs6U
        WIcxz0CqOTeBTubdv+fkeat0Yni7cAJwo8qiPAfQamRhBgpId8rYDF6S1grF8ozp
        L9D0VnZPhgkbAvW/O0/Km0eonpYPm5R4YVmYRvaiXfMfS8v3MKfHXdchLaEQ6eKr
        4OJtnXaXwEi8N7xfjd9hlJZioJmudVb7maA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Qu_kWR2Z5dsC for <linux-block@vger.kernel.org>;
        Thu, 21 Jul 2022 23:02:36 -0700 (PDT)
Received: from [10.225.163.125] (unknown [10.225.163.125])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LpzP81vYFz1RtVk;
        Thu, 21 Jul 2022 23:02:36 -0700 (PDT)
Message-ID: <948af158-c3b7-b628-8e4b-c0c5d35ee9ba@opensource.wdc.com>
Date:   Fri, 22 Jul 2022 15:02:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/5] block: move bio_allowed_max_sectors to blk-merge.c
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20220720142456.1414262-1-hch@lst.de>
 <20220720142456.1414262-5-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220720142456.1414262-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/20/22 23:24, Christoph Hellwig wrote:
> Move this helper into the only file where it is used.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/blk-merge.c | 10 ++++++++++
>  block/blk.h       | 10 ----------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 1676a835b16e7..9593a8a617292 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -95,6 +95,16 @@ static inline bool req_gap_front_merge(struct request *req, struct bio *bio)
>  	return bio_will_gap(req->q, NULL, bio, req->bio);
>  }
>  
> +/*
> + * The max size one bio can handle is UINT_MAX becasue bvec_iter.bi_size
> + * is defined as 'unsigned int', meantime it has to aligned to with logical
> + * block size which is the minimum accepted unit by hardware.
> + */
> +static unsigned int bio_allowed_max_sectors(struct request_queue *q)
> +{
> +	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
> +}
> +
>  static struct bio *blk_bio_discard_split(struct request_queue *q,
>  					 struct bio *bio,
>  					 struct bio_set *bs,
> diff --git a/block/blk.h b/block/blk.h
> index c4b084bfe87c9..3026ba81c85f0 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -349,16 +349,6 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
>  		q->last_merge = NULL;
>  }
>  
> -/*
> - * The max size one bio can handle is UINT_MAX becasue bvec_iter.bi_size
> - * is defined as 'unsigned int', meantime it has to aligned to with logical
> - * block size which is the minimum accepted unit by hardware.
> - */
> -static inline unsigned int bio_allowed_max_sectors(struct request_queue *q)
> -{
> -	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
> -}
> -
>  /*
>   * Internal io_context interface
>   */


-- 
Damien Le Moal
Western Digital Research
