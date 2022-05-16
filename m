Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC44C433F5
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 10:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiEPKNS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 06:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239637AbiEPKNQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 06:13:16 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DCDB7CD
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 03:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652695995; x=1684231995;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1RftvAYIAb2hGvwjDVgp5ayxfciX1CwkYmKbbeEZ82U=;
  b=JkWKLdnbtZSZFQFqQWt8MsDvSN88PDcv84V1jUIEQxXBMU8fTffuSZH+
   BpMNggbZ4044pSPNb/sgA/WuYV6PRfBi0hVJ3W5ESySTV/pWG6Y2Kn/C7
   sBjo7RfKkZhhs0CnqR1VoyukPlyBsyqgvX+wM6eAu6z4XRFQuuo+bW7D6
   d5IXMxcPGNzjsKPzyWVlwul8A5W80eaEY5JvHcMs72kjMlARNmvFUj05T
   mLAF8J/WOUgyxiv3f1Q4Unay5cOoH8TwDDLz109PPxnTmwOhK6n2s8qZo
   7SzANAhcC/dEia7CloWJGhmJDK1owGWRsbh4HB5oujSC8qnQHmEJTKxUl
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,229,1647273600"; 
   d="scan'208";a="304642156"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 18:13:14 +0800
IronPort-SDR: ENQQXIu0/kBN8rtiwhonHw9m2Xq/SvrILpIRTAiZPs3fdshGSnWPzd1pA1f6eeG1pkJgC6DDIG
 lc20EQAN6vcbWOHAZ8sP8ZpRDNv1D1AW36GyaxESu8rUxPLAcoCVb0mftUU1wprXwO/sC32BRa
 etrTAFbz8KwJrXUinhV4IXi2/JNIyiavYDYLY9Yh84ElfwScc0s0gKkH+VXxn6Qe6OhFeolL4K
 zpFeGxUAx68H9S8ndvP1G1xnzi1P4NIAfbi2EPXn34+yqDz6J/wuTQVf0FAP9SBBPAGGZiB54q
 nL14bMjGkHHwAGUiFekA74ti
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 02:38:55 -0700
IronPort-SDR: 1NwBQ35zrY/8kKTGiwH3QxuzzHtGRWsbXO4Kch2HK1g2Fyy7mDcwLSKy827cxEC+rI7bd+3Wvo
 7IcHY7e7RaxBWFLzkKsUn+3EeiA4vx6ZeU8I0Fpj5m61dBdYgqk2BnBkHGzOfrP5m86+273rTw
 vN0+uiDWnnugPYAj6Tv4xQsGaKvK/b7t5GCmQt0SYXPELgJcu4yw98LQnOmT2ES/i/lsri7UJ0
 5lJeH7LlFAk7HUxYBN//7qyBa/LTOEhvjnOBnIMrkMATJWpTuqXazzT2rYkqzl3DTK4GpwFpJq
 q+0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 03:13:15 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L1w7F5MBzz1SHwl
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 03:13:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652695993; x=1655287994; bh=1RftvAYIAb2hGvwjDVgp5ayxfciX1CwkYmK
        bbeEZ82U=; b=hDNjDejrH6XgfPJHLk+RImbyg66Qv/CMuxIAG9JdhojyQxMYw+9
        ENNISSeYhpjDjvUvZNiYze9qWTy0kpz7wNugIz+sBlaig3vROOXnNOR57/BZ9eLV
        PouRGcAv8w9yxZ9URAIfb6lvnvP6gcz8MmQ4uP/SUJlwWOjOq1H/upd5ld4H6abP
        YiB3zesMBA5hLuMNa8DIXAimA4ELq+iGG1v/pgpZo3I0fHWbS14vKGVeKZZvYhOm
        8lC1UoOlm3OOjIMV9dK6KLVttj8ht+8C5soBw3tTn4J5OM1AoC+Bhx5wr2ERbYG5
        AwXoWtt9RreIPerCTaBUYxqIbZvWl3Lc7Lw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZLbAELd7owRN for <linux-block@vger.kernel.org>;
        Mon, 16 May 2022 03:13:13 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L1w7D1CLVz1Rvlc;
        Mon, 16 May 2022 03:13:11 -0700 (PDT)
Message-ID: <9e3cd199-4333-5db2-c201-d0d2d2a05e86@opensource.wdc.com>
Date:   Mon, 16 May 2022 12:13:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] block: ensure direct io is a block size
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Kernel Team <kernel-team@fb.com>,
        Keith Busch <kbusch@kernel.org>
References: <20220513161339.1580042-1-kbusch@fb.com>
 <20220513161339.1580042-3-kbusch@fb.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220513161339.1580042-3-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/05/13 18:13, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> If the iterator has an offset, filling a bio to the max bvecs may result
> in a size that isn't aligned to the block size. Mask off bytes for the
> bio being constructed.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/bio.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 4259125e16ab..b42a9e3ff068 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1144,6 +1144,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  {
>  	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
>  	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
> +	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>  	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
>  	struct page **pages = (struct page **)bv;
>  	bool same_page = false;
> @@ -1160,6 +1161,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
>  
>  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> +	if (size > 0)
> +		size = size & ~(queue_logical_block_size(q) - 1);

I think that __bio_iov_append_get_pages() needs the same change. And given that
both __bio_iov_append_get_pages() and __bio_iov_iter_get_pages() start with
iov_iter_get_pages(), should we do that and check the size in the single caller:
bio_iov_iter_get_pages() ?

> +
>  	if (unlikely(size <= 0))
>  		return size ? size : -EFAULT;
>  


-- 
Damien Le Moal
Western Digital Research
