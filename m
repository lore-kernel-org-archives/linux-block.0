Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C66ECAAA1
	for <linux-block@archiver.kernel.org>; Mon,  5 Sep 2022 03:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbiIEDyi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 4 Sep 2022 23:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbiIEDyd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 4 Sep 2022 23:54:33 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AF260EF
        for <linux-block@vger.kernel.org>; Sun,  4 Sep 2022 20:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662350071; x=1693886071;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CgWI7pXo/iFPZ6k4JkJ0VyK0XDakMC57Y0/q2O6Q7+Y=;
  b=k5pkypB0QzL5wpOf8CJ+WmJly0LsVX3f/nBTzabjowCbMg0sch5eSeht
   /NTCabMQRzu/7SaRCbewv7UrFqXqcAJKL9oWJEhPHJjFJhLXCrMmY2MV0
   JfZUwYlQPlLQmC3U8IgZS5yq7DaeDemrk6CAPIxhqjPFVrbHNr7lKvZT9
   TWUZuyLkFms78GjhBbfiahULc+kJ7xU6QVD2Fk+q8x66D6ar3LEbXvKja
   1ddXN53KOlQZ5Zi98cBG+TjDZRr2kp8waTq9gBi4jUJcbkwYBBpCbrgTA
   d/rLe9ZwbnI5pMXzbls6MoijraJCwH9F2x9MRrIrSVMj0mTTmTdrpkYUX
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,290,1654531200"; 
   d="scan'208";a="210977850"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2022 11:54:22 +0800
IronPort-SDR: Kl+27hp8dYm56cJulUK3a0kelgvewVoHTrMzPtBlGeMC6sNtdjVpJMpjvUgWjOVh5zrwLd5kaz
 nPURMJNTmSLsZSfIslRGtUB/tHFIQXWncCiC9ApJkWZzvgwuW6R4RdIlGPAQgUrjVip3fPb3PS
 6FmoWBIvBjqDJuiNHq7VpQ4Hro/NeV3TyEf6D4q/UTuJFoZZzWFKU9lFf/3SVM0RphjhgQfn6Y
 gdmbhcC/ikPb9QLNhr6wa7VZ/HkigSERZK8iZooTTCLg1hzaUypRANoq6lX/VjJ3b3jSIem6On
 qGzg/QyZLNEs8y77PYsO4rXd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2022 20:14:47 -0700
IronPort-SDR: 2yIYA+c+bbWJlgOwFXUqTyWBuCC/JYv6rOk3o4RacMnAxsQfmUnToh/+/g+AFJbLCIIWUmDzZX
 Py/qRBQUdKiVFY4/WTSplj5/yeMiJQnLJ+MXay/ea9JtyevvdLBby48i1WAwvzeDBRcgzWVBEz
 rQl/yRi2hip95WMW/lYF2zuYxIdc20kuyoz5HnMsXW4RqcAge72Fc5IM3iB5xERdsKM5PWrKBX
 gF9KXq7RT3yKPEcbOlCWtBnITajL/CsPyhAnijAN75UcuZufHaq8WCA2XGafwE5TOhuFR4mvOL
 EoA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2022 20:54:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MLZQQ2Y8pz1Rwrq
        for <linux-block@vger.kernel.org>; Sun,  4 Sep 2022 20:54:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1662350061; x=1664942062; bh=CgWI7pXo/iFPZ6k4JkJ0VyK0XDakMC57Y0/
        q2O6Q7+Y=; b=an25YydaQGwwCDDtb0A16UCvnEVVBD1BNr2csbHOZCAfNePowTA
        2FuyJqosaLx0vu89m8BiXWrQFi3eXYLe0n8FHTvegKd492Efkg36bV0B8znkHTCT
        cm1c8P2QCSA7Q4+udePuHFYg8bJ2bO+WhAfPiD/QJvt2mfPVJ2j41gJuWfoaB4sD
        AuKiV/ckIXpBDG2NSyzRUcP5Hd2u085BNQNZph5AIV7E6jaGMLad4KiFlnClaPGb
        lSvpecyUpyMi7VkH5nw9A3XXTVGS/X6g1nMqmAv2tlT4srwX/6pWYs+HyNK6EKh3
        CyRvQBah66e5r6Q31FUJ4yCCm/mdIDOjutA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OOcxGbU5RJ0o for <linux-block@vger.kernel.org>;
        Sun,  4 Sep 2022 20:54:21 -0700 (PDT)
Received: from [10.225.163.60] (unknown [10.225.163.60])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MLZQN5P4nz1RvLy;
        Sun,  4 Sep 2022 20:54:20 -0700 (PDT)
Message-ID: <ea747f8e-257c-a4f6-6dce-5ea26de4083f@opensource.wdc.com>
Date:   Mon, 5 Sep 2022 12:54:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] block/blk-map: Remove set but unused variable 'added'
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220905022553.77178-1-jiapeng.chong@linux.alibaba.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220905022553.77178-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/5/22 11:25, Jiapeng Chong wrote:
> The variable added is not effectively used in the function, so delete
> it.
> 
> block/blk-map.c:273:16: warning: variable 'added' set but not used.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2049
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  block/blk-map.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 2fbe298d3822..a06919822a73 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -270,7 +270,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>  	while (iov_iter_count(iter)) {
>  		struct page **pages, *stack_pages[UIO_FASTIOV];
>  		ssize_t bytes;
> -		size_t offs, added = 0;
> +		size_t offs = 0;

offs is initialized with the call to iov_iter_get_pages_alloc2() so I do
not think it needs to be initialized to 0 here, unless you have a compiler
or sparse warning. If that is the case, this should be mentioned in the
commit message too.

>  		int npages;
>  
>  		if (nr_vecs <= ARRAY_SIZE(stack_pages)) {
> @@ -306,7 +306,6 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>  					break;
>  				}
>  
> -				added += n;
>  				bytes -= n;
>  				offs = 0;
>  			}

-- 
Damien Le Moal
Western Digital Research

