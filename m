Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97CBC433EF
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 23:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiCIXjr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Mar 2022 18:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiCIXjq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Mar 2022 18:39:46 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AD495A1F
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 15:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646869125; x=1678405125;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JMGoeshEilmr9wN9LzBTTFszPTSbN9GXN6C+EEWgFW8=;
  b=M3fNdGr4L2iCf1JT+rTxcODThndPX4yWyUtZcnTFZ4BPzU93Wh6V2Oj7
   JMAE8O5wXCpOYa3VG2vyFrA116FfTWUvMW+CaP9j2iznd6hF7FbNRiq0Q
   BbTkaI4BM1b0+GGycWgkiOixXW5KoBiK4HMWru3aNW7ukiQP6wCm4ShO4
   5YsA/XUxdEv02BrVXkSObgfW9UFgYbVjUvSeO4FK6B40Spi25P/kSyoXD
   ak4w8w9jiORwyOBMQGLDpLNplDnu+H7ohIlDvHhdskRI8ciVka9FJyVmK
   fSMUTbEGG3ECeMdOSoPxcJ5XfWt+A9z5JXbzptLaUAMzReo1jvOsLAb8k
   g==;
X-IronPort-AV: E=Sophos;i="5.90,169,1643644800"; 
   d="scan'208";a="199742223"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2022 07:38:44 +0800
IronPort-SDR: tVj8yoXafkJYBSmv2fwJHvGNmOI9V2R376lVdV5K5LWfr9ChEPMC3xUcNLWH6vjVhm50SU5t2L
 xnkZVJJyXo8SbetUfazTK46R68Gmhk5klwbE0zzurSksaswJ0DBWNX5C544zv7cgJNwGqk76dU
 kZDU+VhfI/tVKOZOrpoNXC2oKxbPLUtzkR+/18gtsZPkK+vxuw7rOkvZV2ev37HeECksHPcPwG
 MEgSbIKus1YLAHP7GvwzlCkFK19S0ZqIyu1h/3PubFq5M1K+5xclLaXNz7I5H2PdA+/yQ19a2T
 6na6v3VmroMytxtjLNDtPuR+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 15:10:00 -0800
IronPort-SDR: ZoPzK5REygzZ3jOuyFy1O/EPB/wjHIk1DPr2FO88bETgKi4o3mGNJbVrHYR4XE7mwli7hGbEoi
 8LnFDRTGl55IH8Ffkj4tQzjsBdw1zYrctNWgWOHBkv8XzzzgXajN9kD88ziBO9v6N4k0PqvrZk
 4toV/RZ8b5ZowBdwbi8L0+uVkMsRds1cBvu6KSu6LK5skJI3mqUBQPatyWOa+VibGxXZQfiTna
 IoOO3HVyKCTnYXQCwFqxr314RGBjIosU+hwNjTcaTDx0gtoB+2/+QwnZNhO70epfUm83CyroOg
 aJw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 15:38:46 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KDTD55cdnz1SVp2
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 15:38:45 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646869125; x=1649461126; bh=JMGoeshEilmr9wN9LzBTTFszPTSbN9GXN6C
        +EEWgFW8=; b=kLjKIP1MxWW/DJ3drnywQr67Y4/LcbTmN0vZRzkCpuyqazCF+no
        Ysm12LdNMwDOn6roqTB92gj038q7xUYLvX2/mIBn3nZsIRhr+ie/vt3o1Oh81CQh
        kJLZ303tMzlcniXyfkzup0bexSuMUqUsafSvtjCg0YYMcdtGROmLyRp8V3s3+Kno
        D2FKGf5UVzh+yiPBV3EroIzemzuv+1FXCSqsm87mdWNUpJfeoiZGDbbEQbdeKkoQ
        1sl3GLEdBjdz7AuIPMfvaPk7tust9feoOyOUnJGvCu1kfbYwKShgozAS/g4pR1wB
        MpuW4PE6MJ4uXQal1iwqYJ/Yrc+scCBFrqg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HjWqI3JhQRHQ for <linux-block@vger.kernel.org>;
        Wed,  9 Mar 2022 15:38:45 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KDTD42XX9z1Rvlx;
        Wed,  9 Mar 2022 15:38:44 -0800 (PST)
Message-ID: <1dd210d4-a3d7-30d4-341a-d7b308679008@opensource.wdc.com>
Date:   Thu, 10 Mar 2022 08:38:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] null-blk: replace deprecated ida_simple_xxx()
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, damien.lemoal@wdc.com, ming.lei@redhat.com,
        shinichiro.kawasaki@wdc.com
References: <20220309220222.20931-1-kch@nvidia.com>
 <20220309220222.20931-2-kch@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220309220222.20931-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/10/22 07:02, Chaitanya Kulkarni wrote:
> Like various places in kernel replace deprecated ida_simple_get() and
> ida_simple_remove with ida_alloc() and ida_free().
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/null_blk/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 05b1120e6623..e077be800606 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1724,7 +1724,7 @@ static void null_del_dev(struct nullb *nullb)
>  
>  	dev = nullb->dev;
>  
> -	ida_simple_remove(&nullb_indexes, nullb->index);
> +	ida_free(&nullb_indexes, nullb->index);
>  
>  	list_del_init(&nullb->list);
>  
> @@ -2044,7 +2044,7 @@ static int null_add_dev(struct nullb_device *dev)
>  	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
>  
>  	mutex_lock(&lock);
> -	nullb->index = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
> +	nullb->index = ida_alloc(&nullb_indexes, GFP_KERNEL);

Do we need error check here ? Not entirely sure if ida_free() tolerates
being passed a failed ida_alloc() nullb_indexes... A quick look at
ida_free() does not show anything obvious, so it may be worth checking
in detail.

>  	dev->index = nullb->index;
>  	mutex_unlock(&lock);
>  


-- 
Damien Le Moal
Western Digital Research
