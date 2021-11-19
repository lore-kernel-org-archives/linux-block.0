Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635A8C433F5
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 01:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C94861A09
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 01:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhKSB6P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Nov 2021 20:58:15 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21683 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbhKSB6O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Nov 2021 20:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637286913; x=1668822913;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aG5LqWTsRucrm11BXz0YXxnhDV4aHDGwps3zTPHMqJE=;
  b=BP4+05P4ndoTbllwHtMTEMkK3nWKcCGrEK3H+kci3Fbue39ffYzBc+CU
   1ljK3yOd2HKV3i8OxPjw/9tukBk9NiFpMOIl+s/5/s5NNHo3/cyjxSysj
   b0KOhWQ3KuS5/obTntJ1D4j6m2Uc+xVaUp1KnNR40uryoHPIFQJZ1QrJG
   k7N4BouMYdWja/p7BnZxXi/ruE7+b9GD6Cj1P5KiEOIidUcsmMroHn7JL
   SOyjktnumQvSeNQ41hjz+jbiTkaQ2e4b5PqtUtolgieV4bdoqcEErQ41b
   ttOBSlPS4WilkW2NZW/rqeQ8aGpRo8raj++/6WFDLEIGwsYQORjmaPR5L
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,246,1631548800"; 
   d="scan'208";a="185023353"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2021 09:55:13 +0800
IronPort-SDR: wKfF/ZQqfDeoeEB8ufnW4SMq3sFW0i4PD64tlcSVDRBTQfGOPYGtRmOVU2B9CvzZJvD8fKSUO2
 6teQU9kdAMFDTvDSVUYH9RHnZyeR0iooupUyV9SWYWQ8PWCldoSyFiLxqDwI+31i1sveOV4jf0
 rywRGplQ0YowFceWrXySyJI22xyyYBD04h7E001GNZKDFQsKGUyaU8H4Di2igVH4hVNfOKhL7D
 rilYzgCWr2e84ZKqfD0fJ8UdKWPFXrkJT33DeA70CAKzmdE4ayUR74tHe6Wc9jEiWV8WIKJiaM
 cWt3MgVVyRO3QkJPPYa2diRv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 17:30:12 -0800
IronPort-SDR: zK3bKQguGjKITmkvrQW1pED8LZ5HK6fEEEwlsvaSVACa0fDKd0NIrSHAG/JS2kr5bbCvf5HmRg
 Nr5ow00DWsGnElcR5lEdQZaKFoz+asQPEhAKUOWyi+/YXNoYnGPkBtHGj7O/M9ucl+Z9G0zDPD
 xDJCQrBMSLDcViOkwvQ3r73dAVfLwfeFBUtPCKhDhnQWvrfErqQz3S04OoMK1TM0b9yqbnHsIs
 FaNlHSJ8iU1/BmHZAG4+N5KbjafAG9KXBqoddG2kBtNJsxqO5R2p1U6G5nqLTW+Gr5oIfZf4A1
 pE0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 17:55:13 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HwKVm3Wqtz1RtVn
        for <linux-block@vger.kernel.org>; Thu, 18 Nov 2021 17:55:12 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637286911; x=1639878912; bh=aG5LqWTsRucrm11BXz0YXxnhDV4aHDGwps3
        zTPHMqJE=; b=VpQNF3zKxOX2dSZG2/BE4JWXNTW1W8qVMBK7MSAE3T8EE0w2411
        4y+8PyG8xkTPPzwX47/PIwGnteq5/IAsGQGjFrlJ1RICr1JMaw0gRAAmi9anFVqN
        5fcD1EozGlszJ9b0xp5i4SHEk8jkRG5Lzq77b6FnKvmsn/bqBlMcSzVVWiDOsitN
        gwv+BmTpUwAbC6Mnom3v6VQrenA1Z7yi/qOzTeatMgmEfGxVBFKcwSmRlOH37msm
        naV775kTDj4nySbJ3K0R8sZ5zAMiMgDJO1EDYCMJ+123gSDAjKiGu+h2eCneVzw+
        dGgCQv3Ox6d3FoHjOefDxyOdMcwQzBUuJIQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Qky4gUof4aIe for <linux-block@vger.kernel.org>;
        Thu, 18 Nov 2021 17:55:11 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HwKVk4Pkyz1RtVl;
        Thu, 18 Nov 2021 17:55:10 -0800 (PST)
Message-ID: <df37d57e-86e1-56dd-54b7-f3d7b96ffd56@opensource.wdc.com>
Date:   Fri, 19 Nov 2021 10:55:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: [PATCH 5.15] block: Add a helper to validate the block size
Content-Language: en-US
To:     Tadeusz Struk <tadeusz.struk@linaro.org>, stable@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+662448179365dddc1880@syzkaller.appspotmail.com,
        xieyongji@bytedance.com
References: <7e6c4c23-f071-f33b-7bd4-da11980d34c6@linaro.org>
 <20211118235738.1128085-1-tadeusz.struk@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211118235738.1128085-1-tadeusz.struk@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/11/19 8:57, Tadeusz Struk wrote:
> From: Xie Yongji <xieyongji@bytedance.com>
> 
> From: Xie Yongji <xieyongji@bytedance.com>
> 
> There are some duplicated codes to validate the block
> size in block drivers. This limitation actually comes
> from block layer, so this patch tries to add a new block
> layer helper for that.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> Link: https://lore.kernel.org/r/20211026144015.188-2-xieyongji@bytedance.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
> ---
>  include/linux/blkdev.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 683aee365420..5b03795ae33b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -54,6 +54,14 @@ struct blk_keyslot_manager;
>   */
>  #define BLKCG_MAX_POLS		6
>  
> +static inline int blk_validate_block_size(unsigned int bsize)
> +{
> +	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  typedef void (rq_end_io_fn)(struct request *, blk_status_t);
>  
>  /*
> 

But where is this used in 5.15 ? I do not see any callers for this.
So why backport it ?

-- 
Damien Le Moal
Western Digital Research
