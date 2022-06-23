Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDC3C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 22:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiFWWsj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 18:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiFWWsh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 18:48:37 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BCB52E62
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 15:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656024513; x=1687560513;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WMlE72jM23u8NWaac9uOsgczh2jP+sydx5NiZ6s3d3U=;
  b=dFQqISoODhK7at9qMmEZh2/HQVHoFDm0lWT77sEy+z8ppT0dJ5zgclk6
   UQCkZYGyjzvt6Qk8CWCUr+8pr92+PeCrTYMlC8ZLValXiUh4jQYjE7q9d
   3OwejwWKHBe9GU+JL1Z17sIWT3INeA+9Y0waqgw2LMPZ4x1K1o6UvZejW
   gf9Qe40pDM0tEMvsupQDyYXnqbhQkvLwm3qEByiu5BDUQvJv1Y9vnL9pd
   EZCCvnluD7ypI3LkABNUKhpar6Sdiopfy+trBw04sQx5tMLcGfpkChPMb
   Wv+i37zXLobXDBBPzm3zLHlCdYZkCBJWh2AGDQt+2YnUZYVl2W3vk3hKt
   w==;
X-IronPort-AV: E=Sophos;i="5.92,217,1650902400"; 
   d="scan'208";a="203962054"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2022 06:48:30 +0800
IronPort-SDR: SgyGik3FgcNJA0s+nzhl+PLZX9k4z6LxWpU9hoU988EsoMN5RFeU18/Dmk9gf+O4qQBSerSwtz
 ZPk87ze/oXnDSRzFmKJRedpcBXb1p8heWlXDK3RSO7/0F4OqCigk/OfE1mCoSBcBcoU9/qVipH
 prfeckDqKzpKwjcj2NwQEXByCDjSbFic5jowcS9IPUYlOSsekJr2hXUWyNQtybohFNjkgCrA3o
 FqtyxUaGvZREeoHJrin3h6N09FFl3XxqXXgbq1NCRcWacNQ8S3mDVbaBMCarWeU3dLO/2UVybt
 z93Hu8CanFiQ5Um79S/KAZSo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 15:10:59 -0700
IronPort-SDR: oawuIpMB2cwJ3OhZM0g9DwoHP19qHlptJqRLHzn3bvDsHny+Fy4oKh81+kWdQEsZpoLvoy0+s2
 70K0uU4UbEQsZybFElX4MZyVRFxlKzL9Ucwk/PbmdaM3FAIgwbMjQWeu4g/+ULC8zM9gNwFxvy
 tG5saujFPjJ2MOgFda41DYy9IwAkxceJPEb6+yVl6O6T4N/pCwamM4hf0rcGa5gKia/60C3/Bx
 3e8mJlYqnPQc9tP5KVI1i7Owt1jpFY7yCQzN8FKQSiQIRXzB42ZjqAp10zlYxcBUz2XTtXoXqJ
 ba8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 15:48:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LTb5C2GLHz1RwqM
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 15:48:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656024510; x=1658616511; bh=WMlE72jM23u8NWaac9uOsgczh2jP+sydx5N
        iZ6s3d3U=; b=GNRKy1pm3zNSrg/szwXJHRS2r5h/npu9qlHPvs+tHAW9RMmG/HC
        BM9UV8SKX3gclDG21J+iXIfBNCFKcMyb/wLQqcT8mGgis0bujozK+pamXrkIooGX
        5l/z35HvgKsbEuRHmUToxF/I7XLrJRIDmchNiPrItPepy8Q4SW6z/KLEyXs5vS+B
        OV4UYGqRy+bRw66IC2v8OWNnWKHNUgMOEUrmTBqySuDr0RFytmA1UKIYEtFcaDSU
        LUb/l1gx3vgWynvh459AAjTW8wX7wMYBZgVQsKVx8KNy1hQKy5Y0wAD9XQNa4Lr1
        1wozJT4p/rvTSmNsgmjWxvQatxWE0HEgK1A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AWJKSTmE1xSc for <linux-block@vger.kernel.org>;
        Thu, 23 Jun 2022 15:48:30 -0700 (PDT)
Received: from [10.225.163.93] (unknown [10.225.163.93])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LTb596Vqsz1RtVk;
        Thu, 23 Jun 2022 15:48:29 -0700 (PDT)
Message-ID: <c7de3cfd-ec60-05ab-d05c-a9c356ba6cf6@opensource.wdc.com>
Date:   Fri, 24 Jun 2022 07:48:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 51/51] fs/zonefs: Fix sparse warnings in tracing code
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220623180528.3595304-52-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220623180528.3595304-52-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/22 03:05, Bart Van Assche wrote:
> Since __bitwise types are not supported by the tracing infrastructure, store
> the operation type as an int in the tracing event.
> 
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Naohiro Aota <naohiro.aota@wdc.com>
> Cc: Johannes Thumshirn <jth@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  fs/zonefs/trace.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h
> index 21501da764bd..8707e1c3023c 100644
> --- a/fs/zonefs/trace.h
> +++ b/fs/zonefs/trace.h
> @@ -32,15 +32,15 @@ TRACE_EVENT(zonefs_zone_mgmt,
>  	    TP_fast_assign(
>  			   __entry->dev = inode->i_sb->s_dev;
>  			   __entry->ino = inode->i_ino;
> -			   __entry->op = op;
> +			   __entry->op = (__force int)op;
>  			   __entry->sector = ZONEFS_I(inode)->i_zsector;
>  			   __entry->nr_sectors =
>  				   ZONEFS_I(inode)->i_zone_size >> SECTOR_SHIFT;
>  	    ),
>  	    TP_printk("bdev=(%d,%d), ino=%lu op=%s, sector=%llu, nr_sectors=%llu",
>  		      show_dev(__entry->dev), (unsigned long)__entry->ino,
> -		      blk_op_str(__entry->op), __entry->sector,
> -		      __entry->nr_sectors
> +		      blk_op_str((__force enum req_op)__entry->op),
> +		      __entry->sector, __entry->nr_sectors
>  	    )
>  );
>  

How do you get the warning ? I always run sparse and have not seen any
warning... Looks good anyway, will apply.

-- 
Damien Le Moal
Western Digital Research
