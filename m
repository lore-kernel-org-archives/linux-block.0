Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82858C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 05:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357124AbiDTFIj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 01:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359377AbiDTFIh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 01:08:37 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186C727147
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 22:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650431150; x=1681967150;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o8q20WkD5Ikqc8y1E534ZjoNOqKW8XEoRrj9gEj3rTM=;
  b=YGRns/XlfXMG/8TD8aF6gtlIddqZ2VV6rK3QIxUlSfrhDgfq54uOpk3x
   RGr/0rWTFFpe3iaVjFeIZJJuxL+D338sVOwArVCaKVd79v2L+tTo7RNCC
   dKocyKPwChOd2Hnka1Nq9OSnqlXlnegex3VePZa0DlOg35jbHZE2yvktf
   yeEXIenHp78U1snKp7g6zUMnIA6z3JwahvZu60r462HTekI5I2GNylMrK
   dL0yCD6yLhAu1egkBvR+l1bA5qzBZ+NMVAW8cWQGfbYY0AxQhlbjTERKE
   YFMUL4dZQ3mPnggrpWCBGIe/NCcu7/V7ZleqxwqnBtrI8cn6JWmfYB9RV
   A==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="199225793"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 13:05:49 +0800
IronPort-SDR: oRTaWlpyRl3gujth8dzjnfKqy0wy6k3oD0e1PA7LQCCWJSV65bjutFch8MDeRDuQB3SF4YW3/v
 rd5j+HIaWUaJ1ZBJb16qeS3eVHLYjA7zca4N2r3JVaMTR7nox44yA7mAWzUikudrujHOldH/Mj
 8vnNEAVTbvCD2GXD4Qt8+dza8zG0H3Ygy5e58v+MrWnmBIBuh59o2tCU/NZCmnbAsvmoNKaLgj
 HpvpMbZyTyb2402CIUTC542PTQb4lO845WUV77zPV3SLKKZgECoxL//jcA0LPjvZPZThKcXy01
 jxruaUFJZG3iL5YjbHmu4k/P
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 21:36:51 -0700
IronPort-SDR: CrRZUL4Hh0qYUPy3hBwrlt1blYYBFwl/U7qSKW8orCMTk60982G4FJ7zykxG3afWI3oMeW8n5e
 6RMZfcNhHy4jnPoDEbrmbJvl2pK/rsuQAg1LXSkH0tiFk2i3Ew75ofErmklLsEa3QxV4iWyguX
 eUHJZqxarlCYCXHUgIPVkAwSildAWRwfCjlqz9ZVKS5KCEiIQEft+O3rypx92Y3CrbF0uW1era
 vvTwfizUuuLF2Z5dEglKYNXduovTua4qqGLAoEkAU+DW4bqTA5KrWhjfbsU781grN/uaUcG0qs
 D6U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 22:05:48 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjpXW5n0yz1SHwl
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 22:05:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650431147; x=1653023148; bh=o8q20WkD5Ikqc8y1E534ZjoNOqKW8XEoRrj
        9gEj3rTM=; b=MmU8cEHFcM5IQwPklrmJq9CcqLCfcNdmkE15qGnnyVn7884Th9h
        M26eCxd/Hq3A0ybr4O3ALbYTN9a8Y1Df3498FxSnXcpH3jydiYjGM7u9of32ECD3
        qWXzA7KBGYVHkFOpihzU5FQzufiTKypZwtW7GQdZqOpEWqR7V/Jpmu3sC6C3m4f1
        mYKYhfq9RHXfAvtUhfCcNTjsWQ7mSH/AbeayITUnmfuRqP/6gRpJh3UIWLRV5AuF
        eHekQ7VKC/FySlh/2GiyZH9+jbqoYBslIYNQQY69ESaFu/qg/TnU9D4kAe0xg9gp
        EU8DcTVT1qEYZQbYEwyw5DXfmsLgDKg/tNg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QpGDGgxgd58t for <linux-block@vger.kernel.org>;
        Tue, 19 Apr 2022 22:05:47 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjpXV3n7Tz1Rvlx;
        Tue, 19 Apr 2022 22:05:46 -0700 (PDT)
Message-ID: <1e5b6fa5-2bfe-408b-209f-0d10ab1040fb@opensource.wdc.com>
Date:   Wed, 20 Apr 2022 14:05:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 3/4] block: null_blk: Cleanup messages
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>
References: <20220420005718.3780004-1-damien.lemoal@opensource.wdc.com>
 <20220420005718.3780004-4-damien.lemoal@opensource.wdc.com>
 <8413d847-fbdb-b209-1062-88439b24ccc4@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8413d847-fbdb-b209-1062-88439b24ccc4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/22 12:57, Chaitanya Kulkarni wrote:
> On 4/19/22 17:57, Damien Le Moal wrote:
>> Use the pr_fmt() macro to prefix all null_blk pr_xxx() messages with
>> "null_blk:" to clarify which module is printing the messages. Also add
>> a pr_info() message in null_add_dev() to print the name of a newly
>> created disk.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
> 
> why not [1] to keep #define pr_fmt at one place in header file
> instead of duplicating it in zoned.c main.c  ?
> 
> irrespective of that, looks good.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> 
> -ck
> 
> 
> [1]
> 
> diff --git a/drivers/block/null_blk/null_blk.h 
> b/drivers/block/null_blk/null_blk.h
> index 78eb56b0ca55..450849fb3038 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -167,4 +167,8 @@ static inline size_t null_zone_valid_read_len(struct 
> nullb *nullb,
>   }
>   #define null_report_zones      NULL
>   #endif /* CONFIG_BLK_DEV_ZONED */
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt)    "null_blk: " fmt
> +
>   #endif /* __NULL_BLK_H */

Right, could do that. Jens ? Do you want an update for this ?

-- 
Damien Le Moal
Western Digital Research
