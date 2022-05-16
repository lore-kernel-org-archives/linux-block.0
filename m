Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD065C433EF
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 13:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbiEPNpP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 09:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiEPNpN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 09:45:13 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B003587A
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652708711; x=1684244711;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ly4czFqVQuymU0UsfQZVLKQQ8RNhufA9pDuc1/fI/yU=;
  b=XIFKNh/AbwRuKWpT4CuCH9f4H+41rdiUU6OYSwb9493ykRB2VsDHLqZh
   r0IF8apZ8s1Xi+ziVHr/8PdBtJyMeYG0kjSSrHds7ZMHl3F3s6HnCBqTK
   9yN3a7Cte5+uZPRnPvJ/lQ3UuheBTWk3lXRR7/XlsM2egryzCLdtImuTC
   vp7TGPfJQQax+c0IC3KXSFa6n2GcpvWmErm2cQPUZi/HLIakJVtUElug7
   pGHE9e6g3tFkgGdJDJWAhkMUMCKyWtGmDzOJ5FGdS3Cw8Ac2kDJ/rLb8p
   Izl2WnRt0dUcA+8WM+h8+sB++TE9bfD0LPOmywIS7bzRppTiAKKuOPiyC
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,229,1647273600"; 
   d="scan'208";a="205305401"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 21:45:10 +0800
IronPort-SDR: jeQ+A8ZOooHPBwAbKSAq03CK5b7QlatcI0HhtVAN4FCA+XQrPHRAPJ9qJ7w0Gu+pUoubiId8Wq
 ad+GSfqea85cvvK6dK/OOcOlqf/pBchwiGK/ZFBq0F9lqPR9SrJl5pU11hYU4Zc83KCLwttlom
 /wIuTiHsBHfPzjX13vTeX0q9tX8IYZcenJ2ic+r2Hz//z487bRcbEsMK4CDJmuuBjm2YwFZORK
 y8UUJxOi5zbLPxMebHGk6PMCLBMLVDOwiZfIzHbR2T5I4Jttb/QVGHoqCKdMRlZW1YZOYHNv79
 Z9m7jLCjATc4H8k/hJUM0V1w
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:10:53 -0700
IronPort-SDR: KTge3KVC/BGkH4GIUWkL/uhcASgRIgYvmZVQgqM30Ai7npwBc3+WizB5UVKkDPiXoeoZPn6WMu
 K5nehWbzaIVS9xBNGXI5gTGd8BQPLlaEZda1vMdLr3OTC2eSJkxC/opJ6bhjM2MDKmTUu77FFn
 o4+CcLroSAkTAl//MvTTaBuT037ImbzaCkuQDjFAWICf9cXO/2vlNF6GZu3951sFhpJiYpzhKh
 aFXMxPVBShteihVqpthFMyLqqsEAH+okPqfOEInt0ljeP+XwTmc0xoj5bAiJc2fi2lxtAn3WIm
 HKo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:45:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L20qq2pjhz1Rwrw
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 06:45:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652708711; x=1655300712; bh=Ly4czFqVQuymU0UsfQZVLKQQ8RNhufA9pDu
        c1/fI/yU=; b=FkqJw4K70RCrpun1ofTg7AVCXGXqXphbWQfCdNqf/0x+ovbZXYr
        /29CqxBmPR9vfBGW4rS6WcYlQ4DsXUVeM9NKGLLWhk9lEDKGEkoKyRTknor+VHwx
        GtYOwd+hWJB9rusNgDRSg3n/Hpf2Nioxwx+5vDhrQBuOw61WkfNIoxj6yX7nS6LV
        iVzbJ8H90ykeuIOUXDIO5FKxZX4l4eMlfuZ98cRP8jnBTWb8OG4tnUvDVItVDUxT
        Vrq7aGLBNdIU012sSUecd+rgDwDvVIU3XxgQxrR15HM44+6cK7+vU5WTJPZ81prM
        z4xB/OgKVDWfcljxOb2DapL7S2WxM1fJ7Qw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4rZ-rCv1iMZV for <linux-block@vger.kernel.org>;
        Mon, 16 May 2022 06:45:11 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L20qp2mQ5z1Rvlc;
        Mon, 16 May 2022 06:45:10 -0700 (PDT)
Message-ID: <43ae0d52-9ed7-757c-4a01-4b4ca71a00ba@opensource.wdc.com>
Date:   Mon, 16 May 2022 15:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] block: cleanup the VM accounting in submit_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20220516063654.2782792-1-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220516063654.2782792-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/05/16 8:36, Christoph Hellwig wrote:
> submit_bio uses some extremely convoluted checks and confusing comments
> to only account REQ_OP_READ/REQ_OP_WRITE comments.  Just switch to the
> plain obvious checks instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ee18b6a699bdf..48a58c24d452e 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -893,19 +893,11 @@ void submit_bio(struct bio *bio)
>  	if (blkcg_punt_bio_submit(bio))
>  		return;
>  
> -	/*
> -	 * If it's a regular read/write or a barrier with data attached,
> -	 * go through the normal accounting stuff before submission.
> -	 */
> -	if (bio_has_data(bio)) {
> -		unsigned int count = bio_sectors(bio);
> -
> -		if (op_is_write(bio_op(bio))) {
> -			count_vm_events(PGPGOUT, count);
> -		} else {
> -			task_io_account_read(bio->bi_iter.bi_size);
> -			count_vm_events(PGPGIN, count);
> -		}
> +	if (bio_op(bio) == REQ_OP_READ) {
> +		task_io_account_read(bio->bi_iter.bi_size);
> +		count_vm_events(PGPGIN, bio_sectors(bio));
> +	} else if (bio_op(bio) == WRITE) {

I know it is the same value, but for consistency, wouldn't it be better to use
REQ_OP_WRITE here ?

> +		count_vm_events(PGPGOUT, bio_sectors(bio));
>  	}
>  
>  	/*


-- 
Damien Le Moal
Western Digital Research
