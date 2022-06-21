Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03384C43334
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 13:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiFUNCZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351171AbiFUNCM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 09:02:12 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AB72A971
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 06:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655816529; x=1687352529;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q0CAZkx4vK88rx1+2pA1S/8KFNv8s1oA34lTuj8y+8g=;
  b=XSrdLIhNsUA1FSOAF0ZSL/QJ5zWTCPiOOrQsmFQcKpbgJ8pORs941mtp
   gF6ybZfQtCzUhiibfkDUv50DBWt+fXyCRsfFMujmaEnDrTIWvYCErhL4x
   TVuEIVpJehdDthmrHWpOApMsw2lkii6hkaz+IXId1nxxDCLpADoKK3vVE
   ABsZpD9tY/CW9qe9w3/dLI8boe1Bijjx/b44o+hkWmRwiEaa+IcxJOcAk
   mBS9hu7TFw5/umIpGdhDD8eDSFJ0r7IyZli5F5UQqNK7c5+PMr5DL3/ig
   tHhvJ9+OGNAnJAlz3AeGjEsdd8CEUM5KORPlyKEGpAaDuicFYCDqOWbnT
   g==;
X-IronPort-AV: E=Sophos;i="5.92,209,1650902400"; 
   d="scan'208";a="308039798"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 21:02:08 +0800
IronPort-SDR: zx/VVxzjlXn7vZ9xbUGZFaZ499nhzWQ8j7uwEr4EC8kujgizPBbFRLlmCaRZ3hhGR3ZWVcF1Ch
 FbkFqyMsdqFjgNTwUGYrOMIjGE3wejYiiJjjfRBh5LbNp0eASIjc288XEAwMhOzrELo1ryLsCU
 Dmad/3LPuUZ0mC15KjA5uHyxMrAor9ajIaV7lH9l3FsjSgMJ0uA63cKCnnYeL0qn14bOnQnJ4G
 +ATuPAAeExZNiDOh+x0vJTpaGFhuYkWqWjkqxoHPpmyV08XR9U63qISffTY7D3qI/JaI6N5Quy
 b4v0mf2285gRbf2AgOK7buYl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2022 05:20:15 -0700
IronPort-SDR: lPfYB1QqXJz0aMx7DWnjQeoGQLL8s77lttYgILLtSUhh5T4PZGVbp0RBs5mMA9rZ0K2IpBzJ86
 +O2g6V9LbNtelVED8Bq9Ln8EJcwGCzxbcJrWnjJ50HPe2VjkUIcUqhv/SzPqhG+n8hmhFJ1m1i
 kL5sybLd80B6Zt4/hGu7zQ+uiM2FuD+QVC2+iqCu39+tiLgGxHBGdWEz45nQhAICyjRZK8ynYr
 AgRNfx88G5r4gMKgmqAPOEYfG5vyME2kKag/l6lQbYbIH0xn5IO21O+M85lmvcuLHQ2X2dNzZE
 aKE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2022 06:02:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LS69X1vzrz1Rwnx
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 06:02:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655816527; x=1658408528; bh=q0CAZkx4vK88rx1+2pA1S/8KFNv8s1oA34l
        Tuj8y+8g=; b=Y8CavilvGSz2x9mStGVALpu7a6EewrvhIVzUN/5Vdp4gcdq7znL
        KAdAKGBl4vsFY80Nw1wpzloriSihPXcq+4RYcQthLGgQ3eTfy97IYMsNLbw5bUXM
        12ARgkjvJRO4XtxJk7fVRSTYmhNz+HxILMpnE9c5Az88s6+fAn5gjAdpLe/CzYwD
        GNAAAMQNuA9oMUleLTV13pnZPnpUMK7s61fuYt1hoO7zCBnLUE2/kJZZVeFLb9d9
        FaIgmmg/6PQ+AYm9skza1IhBAAzWcosiACB1IkG8irrw67dl3Le9uHhgLZ4vPz6K
        U9gkrMjQKoxItzyCrmb7kXE5vALR+2INGqQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GI5Ydv5aJIcQ for <linux-block@vger.kernel.org>;
        Tue, 21 Jun 2022 06:02:07 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LS69V6tT7z1RtVk;
        Tue, 21 Jun 2022 06:02:06 -0700 (PDT)
Message-ID: <4c0129fe-66ee-4036-c8c1-c19f188f5db6@opensource.wdc.com>
Date:   Tue, 21 Jun 2022 22:02:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/9] block: Fix handling of tasks without ioprio in
 ioprio_get(2)
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20220621102201.26337-1-jack@suse.cz>
 <20220621102455.13183-5-jack@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220621102455.13183-5-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/22 19:24, Jan Kara wrote:
> ioprio_get(2) can be asked to return the best IO priority from several
> tasks (IOPRIO_WHO_PGRP, IOPRIO_WHO_USER). Currently the call treats
> tasks without set IO priority as having priority
> IOPRIO_CLASS_BE/IOPRIO_BE_NORM however this does not really reflect the
> IO priority the task will get (which depends on task's nice value).
> 
> Fix the code to use the real IO priority task's IO will use. We have to
> modify code for ioprio_get(IOPRIO_WHO_PROCESS) to keep returning
> IOPRIO_CLASS_NONE priority for tasks without set IO priority as a
> special case to maintain userspace visible API.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


> ---
>  block/ioprio.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/block/ioprio.c b/block/ioprio.c
> index 8c46f672a0ba..32a456b45804 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -171,10 +171,31 @@ static int get_task_ioprio(struct task_struct *p)
>  	ret = security_task_getioprio(p);
>  	if (ret)
>  		goto out;
> -	ret = IOPRIO_DEFAULT;
> +	task_lock(p);
> +	ret = __get_task_ioprio(p);
> +	task_unlock(p);
> +out:
> +	return ret;
> +}
> +
> +/*
> + * Return raw IO priority value as set by userspace. We use this for
> + * ioprio_get(pid, IOPRIO_WHO_PROCESS) so that we keep historical behavior and
> + * also so that userspace can distinguish unset IO priority (which just gets
> + * overriden based on task's nice value) from IO priority set to some value.
> + */
> +static int get_task_raw_ioprio(struct task_struct *p)
> +{
> +	int ret;
> +
> +	ret = security_task_getioprio(p);
> +	if (ret)
> +		goto out;
>  	task_lock(p);
>  	if (p->io_context)
>  		ret = p->io_context->ioprio;
> +	else
> +		ret = IOPRIO_DEFAULT;
>  	task_unlock(p);
>  out:
>  	return ret;
> @@ -182,11 +203,6 @@ static int get_task_ioprio(struct task_struct *p)
>  
>  static int ioprio_best(unsigned short aprio, unsigned short bprio)
>  {
> -	if (!ioprio_valid(aprio))
> -		aprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM);
> -	if (!ioprio_valid(bprio))
> -		bprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM);
> -
>  	return min(aprio, bprio);
>  }
>  
> @@ -207,7 +223,7 @@ SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
>  			else
>  				p = find_task_by_vpid(who);
>  			if (p)
> -				ret = get_task_ioprio(p);
> +				ret = get_task_raw_ioprio(p);
>  			break;
>  		case IOPRIO_WHO_PGRP:
>  			if (!who)


-- 
Damien Le Moal
Western Digital Research
