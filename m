Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5615C433F5
	for <linux-block@archiver.kernel.org>; Thu, 26 May 2022 01:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiEZBsV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 May 2022 21:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiEZBsU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 May 2022 21:48:20 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03EB8DDD2
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 18:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653529698; x=1685065698;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FME4v/EvPahQmZZ4OvbyPPXbKI1vSzlssNTi3dekI9U=;
  b=nBC6cOWnnZ9E7Ba/YXj1XU8tAIx2JycPIliyeexS5ygvirLaULBrGwmz
   KZPhDwgb5pKm64EVydFP3+3s0pgpGJL1Rzbnnhe8a8peCBV2UOJ57Sc7f
   KOGLfu5EINoKdbz8dQw7DEiSBf6YM245pRRDquJO3BNMwRep1HsSjtGN1
   x/A+SUxeRbjTnv3WFySFcxm03gZ1I9yxXzicS1lz4Y4WSNjT0W1b1UP9D
   s2wbrFdoo3CFmJntUbavC6qr0qNU1lOSMjqY5AmYnvOSPqvvwN+tMGBB5
   Eda/qtKBGlEWA5yADK+1g3tArl0JY4dhk1Wh5HJsMErq3CiU2gLYrKrZF
   A==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; 
   d="scan'208";a="305693463"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2022 09:48:17 +0800
IronPort-SDR: TOuNNJuEPlrQA5wazG1s1BJd9JruX8u2OiUbspiwMX+dlKvjef/fjhM2wqLUSL5QvnCidWGkZo
 V3Ow0WJJICv+sM+ZnxxAQmHQnJ2rZdqGFf+c9RfO64GsNzTCkuUsfKyGIMRY35BPza8N40ae4d
 Rs14eo8xFkbf2nH2FbBA0c8rmKn4a2u3ZUy8o5WxP0NZ5nI4ocfYEuE/cPX5i7piNI5puZ6zqW
 XS1+HGVLXWtL/r5WygLlom8I1surQHHAZrYy1BomExYKjDMtkqNL1qwkIU+82SPPEi99NnwPSt
 6HtV/fF6V/WRll0/D4Pn3J/J
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 18:12:11 -0700
IronPort-SDR: xn1iSVmDXCdIf3oB4Ipp92xVQbSth9sUddIAIkYrR/GYER5p3pR/OolY3OCN+SHWMO0s47qmE+
 td1MHrMXMqYYzGjcYODDJ3/Wrj7HZ/mn0qlh/Trq9Kg/SB3F1zDejr7wrRr6uUVQ7AsVIX0EwO
 xKoF9hzbJsXindE/qvf7sZEj/ANIDZxP0aPf8QKGqvEmQYdG15SS9tFH2ezx0qeE/Dlyl9CFGj
 q6w1MoFMEms/KB3W4HZuRopxWl8co+0Go5F+3M087XNFTaXFQnHhwleZhiXBcleisCFnY8ql/L
 xNQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 18:48:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L7rRz6w9Lz1SVny
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 18:48:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653529695; x=1656121696; bh=FME4v/EvPahQmZZ4OvbyPPXbKI1vSzlssNT
        i3dekI9U=; b=Fx0wKIHJ+JDiE1SD2WiE4srfh71/huzJ3xospp7ZZaUzHD7ihGk
        RQHUhJsRjvtR6YeYvOPp5jIPH0hjuJAND3dEGFfww7Lcw/sx3Lvbri0zlM/WZ2Zw
        KnMQHfTxQS+ZtJ6PY1lHBDazZg04KnXIYvL5UuMSip6PLOX9YcGMmSAiFFXUj3un
        9xYPgc8IWHI0f03PFXqa9H1u6zfE9BowxTwDd6G3VUGPS1PSLa/Lp6YGgv/kn6GT
        xES39eNzj/Iz92JsAAQMeLCbaHsxKO/YUvPW7Oq7/cUOoUNcVVdAno7R1FeQYaDH
        2VFVfmssDJFjNcmnk3X9tBinhyRPc5JbVkA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qxuzdRDGJsqL for <linux-block@vger.kernel.org>;
        Wed, 25 May 2022 18:48:15 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L7rRx5hf6z1Rvlc;
        Wed, 25 May 2022 18:48:13 -0700 (PDT)
Message-ID: <e87bd23a-1316-0396-0bb0-658c6105eaab@opensource.wdc.com>
Date:   Thu, 26 May 2022 10:48:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCHv4 1/9] block: fix infiniate loop for invalid zone append
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, ebiggers@kernel.org, pankydev8@gmail.com,
        Keith Busch <kbusch@kernel.org>
References: <20220526010613.4016118-1-kbusch@fb.com>
 <20220526010613.4016118-2-kbusch@fb.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220526010613.4016118-2-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/05/26 10:06, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 

s/infiniate/infinite in the patch title.

> Returning 0 early from __bio_iov_append_get_pages() for the
> max_append_sectors warning just creates an infinite loop since 0 means
> success, and the bio will never fill from the unadvancing iov_iter. We
> could turn the return into an error value, but it will already be turned
> into an error value later on, so just remove the warning. Clearly no one
> ever hit it anyway.
> 
> Fixes: 0512a75b98f84 ("block: Introduce REQ_OP_ZONE_APPEND")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/bio.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index a3893d80dccc..e249f6414fd5 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1228,9 +1228,6 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
>  	size_t offset;
>  	int ret = 0;
>  
> -	if (WARN_ON_ONCE(!max_append_sectors))
> -		return 0;
> -
>  	/*
>  	 * Move page array up in the allocated memory for the bio vecs as far as
>  	 * possible so that we can start filling biovecs from the beginning

Otherwise looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
