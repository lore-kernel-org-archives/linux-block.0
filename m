Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A24CD379F
	for <linux-block@archiver.kernel.org>; Fri, 15 Sep 2023 20:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbjIOUYN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbjIOUXy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2023 16:23:54 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3092106
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2023 13:23:49 -0700 (PDT)
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
        by cmsmtp with ESMTP
        id hAJqqzmdPDKaKhFLxqITyc; Fri, 15 Sep 2023 20:23:49 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFLwqWddLl7rxhFLwqtMtz; Fri, 15 Sep 2023 20:23:48 +0000
X-Authority-Analysis: v=2.4 cv=QJB7+yHL c=1 sm=1 tr=0 ts=6504bd54
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=MRXkqwc6AAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=Mw5oN-FQwNtlLNIY7psA:9
 a=QEXdDO2ut3YA:10 a=tmQuKXRa9JHWtioalwAU:22 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dRKiLGohBO+l2o2LcNabfrL4Za7Tt/SCkLsJLXnqc/s=; b=XoYtOhMDah9gcug71RnUEpxyGR
        37eNPy3kq5IFwpQbDJz4MgcSY//yxuoGzx2mxtZ4Y7md7RgTSmdpidy25q2CVTDo0V31M3C+ep5+l
        sIgRWv83wwXabhWaDa1i+uwqPOEbBKyd63eqVnplD+wVRHcIKC76rF0Q/iHjODGpWPubcRPvXLACu
        MeisaMFzEI2aNaNDeA5hz7LdTkPayrNw02CyXNHkCDCkZhJGCXw5HdgTv0GenubQ2ZkiCDAIDmtkb
        Xm5CwnNuJdtN00tFCmrfHbVS6SqYFSEcZbVP+UUKzv4EPDA0t7s1gXsGmvjGXg1udhvWnW9dzIsp3
        m02ryiPA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:34976 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFLu-002GXj-10;
        Fri, 15 Sep 2023 15:23:47 -0500
Message-ID: <c2c552ff-c650-1e69-b552-f6f872605526@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:24:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drbd: Annotate struct fifo_buffer with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Philipp Reisner <philipp.reisner@linbit.com>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915200316.never.707-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915200316.never.707-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qhFLu-002GXj-10
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:34976
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 59
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfA8wo94342V0g2LY0RtcPUCns2Hvaem/lJOIJgvPsYBRB0nvW4HZw3a39V5cIQuo7IHMeHpgjBtyhuIRl9h4qTb7nnZCjac45P9TbBbKSagHvgfhQYbD
 KObGOJzzAT9SMAgBpjRxPwST/0I095n9pyj2xCLUrZh3jfF7qTbb4jDNTrA3UZvEXEIJ7lHrKNFAanr1yBxLllB/dVpdC5SGtsIXXICoUu0Gvvv42uBi3Eor
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 9/15/23 14:03, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct fifo_buffer.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
> Cc: "Christoph Böhmwalder" <christoph.boehmwalder@linbit.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: drbd-dev@lists.linbit.com
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/block/drbd/drbd_int.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
> index a30a5ed811be..7eecc53fae3d 100644
> --- a/drivers/block/drbd/drbd_int.h
> +++ b/drivers/block/drbd/drbd_int.h
> @@ -553,7 +553,7 @@ struct fifo_buffer {
>   	unsigned int head_index;
>   	unsigned int size;
>   	int total; /* sum of all values */
> -	int values[];
> +	int values[] __counted_by(size);
>   };
>   extern struct fifo_buffer *fifo_alloc(unsigned int fifo_size);
>   
