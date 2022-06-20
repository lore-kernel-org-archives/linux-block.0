Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBBEC43334
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 23:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243417AbiFTXoq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 19:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbiFTXoo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 19:44:44 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C2A13E28
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 16:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655768683; x=1687304683;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bIzG1pN07Tjah466x26XFthu1PMURnf0Jj1EoTmL1vY=;
  b=qj8YxB1XL2FBYFPOhnzOqNGhLN+PiTSNGRKw3JB07SnquHfXfFJ8jLDa
   ZHvwYh2+f5VXM6QsvVp+ueAlokWF9aNlcTVHMnSih/KteVpaD4b8M0EaW
   9mcz5QE+m7yf34Vado5RVqj5lodnvon3yzPjh9YU3+TpZOScjHRs3kyFf
   xEXL8VXJ1Xn/GijQLuUX2UBf6IWjnK2PV3TaD7sLAkzpqAZUswoNRzYG3
   DfrK++qf8DwZJGcvON//RLHiM4errEhQvH4T1D8qMwEFHTMumBhmtyccw
   EcuFboPwbvmcnMu0z+FZFgvDxAbfGPJWnpCMWsxiEj2+W9/gpJAGChwaZ
   g==;
X-IronPort-AV: E=Sophos;i="5.92,207,1650902400"; 
   d="scan'208";a="202363649"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 07:44:43 +0800
IronPort-SDR: ggkHAY0OGywp92nVt7KWKZig/zYbyJNGMJ8ZJrHIZ96+kX7QlH4ZGCWakCgkve7moXj0/NVXIR
 uHnhCBKU3wYU5ythOpLQpI0eeBJMpNg7Mnl31tjmXT7E8rSuxDKhlRhTtMrBXa3Ahqv3m3dgpt
 mxi5UlprlVV/FgfHyC9kWKnwPnwAPtExcMQSrNVhy9jwQ1XVVlMAXCcXoREqELuMHHlKaN2aPd
 j9maRnEmu8wggGwhYLfEnL7ecU+v3DX0Z32DV5BqpAheURl5P4v/0dsgdqrXHRtwFiRdJmEpqk
 zbqEGLcryaBl5i9WHBuODQvm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 16:07:13 -0700
IronPort-SDR: kvVZr1KkJvxYg03lmESQPpR3FApsQ1sHP0+gxwQ8W6n6Kfb2f5LJc52kyYyX7GSb/iLm4vayyL
 4BsvkOR6MthUmVAkJleG2/ck/hba1kYSlYZ6YSQaj4NC1G19GxRPvN0+sA85kegyzJ62x5YHz0
 iezlIqOJ0YAs1KgSKnoaQRm/jkwHgix7zhpNenwauXgXI2pgYUOY6xuieLPB4QzNjWzOkUoGvw
 a7gMxYmPoS43AvQDpFDxZhdC0lmY/jFFaJPLWrd3YjCJPSx5MIukdiyeHg9HYOMRp/dImz3+jc
 /jA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 16:44:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRmTQ4hj3z1SVny
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 16:44:42 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655768682; x=1658360683; bh=bIzG1pN07Tjah466x26XFthu1PMURnf0Jj1
        EoTmL1vY=; b=MZs2+V6b7iEgTUVuR7vUeKnZigYEK8V124xcmj/lyTT/gZtPtuy
        ATRLh+3OYgYnpiWC2432J8liyEbk6Bll5llsDk3AxpgxNHlELxGLsuy8sj4j88JX
        TM6dxaCwHIP2N6prrYAJ1oiSAohThDLuiAXsoPlMKzqiNrmDV6U/XlrnN4UQe7nn
        rATeofVwKfzOeD06N6Dtz7iZ5jJM3VQ/VCo2QBHuDCAEeWliXpExlwOjRyZBrXHG
        m/YQseARre6KijaKA/WI292Mnay2qf9pVErwbm3uQmu4nympvvbZpCbMmr9myLdM
        DVpzK0ZZvHdwKq13/t4rvrGjLqMsh/428dw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5JlEsqldoMCN for <linux-block@vger.kernel.org>;
        Mon, 20 Jun 2022 16:44:42 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRmTN5Wszz1Rvlc;
        Mon, 20 Jun 2022 16:44:40 -0700 (PDT)
Message-ID: <49fcbf1a-bd64-1870-d1aa-14d3cee38475@opensource.wdc.com>
Date:   Tue, 21 Jun 2022 08:44:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/8] block: fix default IO priority handling again
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20220620160726.19798-1-jack@suse.cz>
 <20220620161153.11741-1-jack@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220620161153.11741-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/22 01:11, Jan Kara wrote:
> Commit e70344c05995 ("block: fix default IO priority handling")
> introduced an inconsistency in get_current_ioprio() that tasks without
> IO context return IOPRIO_DEFAULT priority while tasks with freshly
> allocated IO context will return 0 (IOPRIO_CLASS_NONE/0) IO priority.
> Tasks without IO context used to be rare before 5a9d041ba2f6 ("block:
> move io_context creation into where it's needed") but after this commit
> they became common because now only BFQ IO scheduler setups task's IO
> context. Similar inconsistency is there for get_task_ioprio() so this
> inconsistency is now exposed to userspace and userspace will see
> different IO priority for tasks operating on devices with BFQ compared
> to devices without BFQ. Furthemore the changes done by commit
> e70344c05995 change the behavior when no IO priority is set for BFQ IO
> scheduler which is also documented in ioprio_set(2) manpage:
> 
> "If no I/O scheduler has been set for a thread, then by default the I/O
> priority will follow the CPU nice value (setpriority(2)).  In Linux
> kernels before version 2.6.24, once an I/O priority had been set using
> ioprio_set(), there was no way to reset the I/O scheduling behavior to
> the default. Since Linux 2.6.24, specifying ioprio as 0 can be used to
> reset to the default I/O scheduling behavior."
> 
> So make sure we default to IOPRIO_CLASS_NONE as used to be the case
> before commit e70344c05995. Also cleanup alloc_io_context() to
> explicitely set this IO priority for the allocated IO context to avoid
> future surprises. Note that we tweak ioprio_best() to maintain
> ioprio_get(2) behavior and make this commit easily backportable.
> 
> Fixes: e70344c05995 ("block: fix default IO priority handling")
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/blk-ioc.c        | 2 ++
>  block/ioprio.c         | 4 ++--
>  include/linux/ioprio.h | 2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index df9cfe4ca532..63fc02042408 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -247,6 +247,8 @@ static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
>  	INIT_HLIST_HEAD(&ioc->icq_list);
>  	INIT_WORK(&ioc->release_work, ioc_release_fn);
>  #endif
> +	ioc->ioprio = IOPRIO_DEFAULT;
> +
>  	return ioc;
>  }
>  
> diff --git a/block/ioprio.c b/block/ioprio.c
> index 2fe068fcaad5..2a34cbca18ae 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -157,9 +157,9 @@ static int get_task_ioprio(struct task_struct *p)
>  int ioprio_best(unsigned short aprio, unsigned short bprio)
>  {
>  	if (!ioprio_valid(aprio))
> -		aprio = IOPRIO_DEFAULT;
> +		aprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM);
>  	if (!ioprio_valid(bprio))
> -		bprio = IOPRIO_DEFAULT;
> +		bprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM);
>  
>  	return min(aprio, bprio);
>  }
> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
> index 3f53bc27a19b..3d088a88f832 100644
> --- a/include/linux/ioprio.h
> +++ b/include/linux/ioprio.h
> @@ -11,7 +11,7 @@
>  /*
>   * Default IO priority.
>   */
> -#define IOPRIO_DEFAULT	IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM)
> +#define IOPRIO_DEFAULT	IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0)
>  
>  /*
>   * Check that a priority value has a valid class.


-- 
Damien Le Moal
Western Digital Research
