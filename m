Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77391C5479D
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 22:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbjAIW4c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 17:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjAIW4b (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 17:56:31 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D9FF035
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 14:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673304990; x=1704840990;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=gQo7Jjr0i/IPqE2WEcFW6tO5Q+cCGtDHCzYXA91stGk=;
  b=heAjcICofoViQsFqXFsyKIR9W9/r9Y1kYvzNUatLZqqJt1DawDWpLp8h
   06j+B19lCZFNN+bDjJ4LuwRUsqyfAPgljkHTJnheFmiVehQ1eKehewK7Y
   hCQpPcIoHOora7ZLvLdoq6KOGqqyk7WdMcVfiCP+LwSd245E2xDP7rWWW
   vNyyQiMtRjYNttarRdF1wOxmCZBPB624k6o5TXrAa+QMSk3BZ+Gzd9UMs
   0sOFG5CaUVI4bgGpnE3u1LWM7CfHPxMsfM+2cTf+pOp5gJRl1beIBIv4+
   1mZ24k+g72rdkK18AnJQK3bn4tZ9bp6xoRv7VVa+OIpj+SfiteupvvTNc
   g==;
X-IronPort-AV: E=Sophos;i="5.96,313,1665417600"; 
   d="scan'208";a="220503290"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 06:56:29 +0800
IronPort-SDR: ChjZz4PW8E6jGjylHaqfETInR82vT9CinJrBA/WtExfkGK0HzWrF45NSM4rkmpPYaHNlTf5KaP
 Pmf4lX9Fo71P5siMyVgYi0/Dqc41TBOTQbXOAFQBDwOnDWNtPCO9x+rEsWjoka62i1ipfbGy2r
 QX5z8aDdSjXgaoc6G9OGDc0U+piAKE744m8ixCqG4vPwfeYn3qh3lWFB6dNl2QwB1pv4DzJ2BN
 YS2a8hQ6OP4xcqdtANm6niqU4AIMODsdLsI2Nr+g/aOuXsh1Y1NVO3mu7CLfj0WNtk0v//AsDE
 17g=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 14:14:20 -0800
IronPort-SDR: NyMOzVT4q1RN8GI5O1VyT3ThB05XXOjY8+pd9WJD1Z5gHz+OL1WGdxJsEJI2FZXytZ3B3yXgeU
 IyKyYum4Whs+k5QOZJ9NDrGnrHklFyiEWZFhNSVtnffG2dlYkDXJkRDxa2DKH3rQcF0Lmvbsgk
 Q6zM0dhI6wV3861Lz2+A6wey3RAZFdnqqnSnKSmiWiwm3BwwfY2j3ricEKN86qhKOhoghv+IZL
 7lR7scF1Vo0SaoH/6MvVKnhx1QV/piCRaVpUdKPPUZP1RsOqeTxBEhQXIP+yYzUspJKn/TKYmN
 KG8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 14:56:29 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrTp51XxLz1RwqL
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 14:56:29 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673304988; x=1675896989; bh=gQo7Jjr0i/IPqE2WEcFW6tO5Q+cCGtDHCzY
        XA91stGk=; b=ZcUV3iE+7Kdpe6WDHCAIqfWtke+kjhbIGiwD4Wsj5CpdnhlpljT
        Z70S/7GmaeeqQr2H3T0EJAX9lyHU8Frb44BwM/xg4W3fqdP8LO3DB78lLeXgSN0y
        mFnF+lyPiI98nfr/Rrr30bdao/xeGenvxwXQPZnOFDaSpmwIoyv0HZBdQAzQUFKi
        B3dVm/VVLRvAGxb/CrD96g81k2LCQypk9EglwCrxVBq4Y5CD93R0YDw0IJy8pF7k
        UjnxRqiCcIE4m4vQM6+dUAeWiIEIzwdnOUeGztAhn+M27D0Xg4e3kR5UTOiTS8WZ
        1Ic4cOnj+UsDW/FBHbsO6WXOnmxXGyqAmew==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PRO5W-521CMB for <linux-block@vger.kernel.org>;
        Mon,  9 Jan 2023 14:56:28 -0800 (PST)
Received: from [10.225.163.12] (unknown [10.225.163.12])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrTp41qkLz1RvLy;
        Mon,  9 Jan 2023 14:56:28 -0800 (PST)
Message-ID: <7322a471-f69f-a6b7-59b8-7355d7a8bd7d@opensource.wdc.com>
Date:   Tue, 10 Jan 2023 07:56:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] block: add a BUILD_BUG_ON() for adding more bio flags
 than we have space
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <da48fbb7-ec78-f382-919e-cdf23fa200db@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <da48fbb7-ec78-f382-919e-cdf23fa200db@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 02:47, Jens Axboe wrote:
> We have BIO_FLAG_LAST in the enum for bio specific flags, but it's
> not used to check that we're not exceeding the size of them. Add
> such a check.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/block/bio.c b/block/bio.c
> index 5f96fcae3f75..633d1a2af785 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1785,6 +1785,8 @@ static int __init init_bio(void)
>  {
>  	int i;
>  
> +	BUILD_BUG_ON(BIO_FLAG_LAST > 8 * sizeof_field(struct bio, bi_flags));
> +
>  	bio_integrity_init();
>  
>  	for (i = 0; i < ARRAY_SIZE(bvec_slabs); i++) {
> 

Looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

