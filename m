Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2372C43334
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 23:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244770AbiFTX5j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 19:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244396AbiFTX5g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 19:57:36 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD02A13D12
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 16:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655769454; x=1687305454;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rPt55KiAEOcZ/zYSh8nvDYWJlWw4X2z0r9IjDzGvi6k=;
  b=huq7XztlQHQuXm5fH38xzADz4LH1XXupwQKnU6Uw2MfN8i2gTP1SuPdJ
   Op46fwhe1yAOm9Fr3RKHRBVidzVbI70cELsJxUCaJZn9zXgIxlfa7D1QP
   fVGnnMKeyFjD9es6rc90QrVHKLW4KaMvS+h8usW6F+xupCS6ctFl6KjE8
   tPMwuppKSqwliDYSYeNAwiNBswr6rouHVI8Z1NUFB5gJ7GbgGLESqbYHb
   hkW898f5FGJPa5mFl3aIKcNeODAO7X72TkUSskrqKMvzPvJqq38eL2L5s
   VPQmYAYfiG67trCEmFqLb4pCL3lMlt0RZY3IBtvuw65I6lEQHEey9rsUn
   A==;
X-IronPort-AV: E=Sophos;i="5.92,207,1650902400"; 
   d="scan'208";a="204423182"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 07:57:34 +0800
IronPort-SDR: 2xiOTyA8bM56V+i0hHZ8Romhq/PLiiMZfj8ZroQ4HqxFnjkXt08hH3oO1/bozq6EOTMFDdRLZP
 R3cqBjBl7KJ/kbbGekLSTBrVGwa8yc3vGFy9OugUZZRaoMvEQpKDarLsHb0mxa2jWZoXObiZTG
 rAOSSDj4Ih8cGawv2XFtZH/qxTsCBCZk8me0L/FsAFl8xZIaOQ2D2TyAlqy0Wi1n3N8OdSLTlg
 41pxN3BNG1/eI6IXZA2h/GAcOdpp9CWHUibv3Bx2pbJYOsrNXjarEqNYzKG1HdEl57tMc0cmT1
 yFRvAEUflccYGL/WxO8eqs/a
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 16:20:04 -0700
IronPort-SDR: UiatvOXUPb/DW5kMNyCvTM/kGfrIX7LnpDRF1kHRO25r2x9o1WdeZzf+yezS9+TRzaX5yrVOCP
 NnOx3fnYp1WIW7TRUGxtSU8KeSGoNYXaZoRNeEegQ+h/zg7qZpn0ITLMstsATo5LvzDZ30HLgv
 +pIYPZumKYYdu22drgj79NxxVgpNRZJDh/fXfFl5t3G+10ops0CRNOQLmMea8FBh7V67qB+NSW
 Gich6CELw9xro8znagynG7zXO6jZc74raSLfcrXt1giXjzWLC6R6439Rk+urGcRZrG975Ep8v2
 pMk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 16:57:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRmmD6h93z1SHwl
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 16:57:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655769452; x=1658361453; bh=rPt55KiAEOcZ/zYSh8nvDYWJlWw4X2z0r9I
        jDzGvi6k=; b=jlNAiHY63YYshfA2+fiXIWBdnlclb31VWHUEPEVMaEAXCLoL96v
        xHlAL56QOtKTKaO+8+7XkvYD1VnT1xZ/MzpzieAmKc8lMCbPvO2tlaA1GF7riHhy
        40Q7hewVqIrnjmx+IGEE3CGo0oxJovaYW4R7uToUGYTO8KVv6iEhGY8G6phxMP/c
        8tiHHo3The/JE7HTx/Nr3ZdUCbyo5kUV35scbb9DDmsPONwn2Q5gVyh6FKpzz6rh
        0hUx6tz+AIgX6rEhxZVfOY/xRZjhUfNtWVg4iEGL9lTzG6K8lcGV/eeLCAfuchhm
        v1oRXaUFxOXiwkSz6N4jicxjKukBd1Bp96w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3RLnU_uGDJ8q for <linux-block@vger.kernel.org>;
        Mon, 20 Jun 2022 16:57:32 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRmmB75TDz1Rvlc;
        Mon, 20 Jun 2022 16:57:30 -0700 (PDT)
Message-ID: <7124bdba-e295-83d4-6346-9e9420062a0f@opensource.wdc.com>
Date:   Tue, 21 Jun 2022 08:57:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/8] block: Fix handling of tasks without ioprio in
 ioprio_get(2)
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20220620160726.19798-1-jack@suse.cz>
 <20220620161153.11741-4-jack@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220620161153.11741-4-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/22 01:11, Jan Kara wrote:
> ioprio_get(2) can be asked to return the best IO priority from several
> tasks (IOPRIO_WHO_PGRP, IOPRIO_WHO_USER). Currently the call treats
> tasks without set IO priority as having priority
> IOPRIO_CLASS_BE/IOPRIO_BE_NORM however this does not really reflect the
> IO priority the task will get (which depends on task's nice value).
> 
> Fix the code to use the real IO priority task's IO will use. For this we
> do some factoring out to share the code converting task's CPU priority
> to IO priority and we also have to modify code for
> ioprio_get(IOPRIO_WHO_PROCESS) to keep returning IOPRIO_CLASS_NONE
> priority for tasks without set IO priority as a special case to maintain
> userspace visible API.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/ioprio.c         | 49 ++++++++++++++++++++++++++++++++++++------
>  include/linux/ioprio.h | 19 +++-------------
>  2 files changed, 45 insertions(+), 23 deletions(-)
> 
> diff --git a/block/ioprio.c b/block/ioprio.c
> index b5cf7339709b..a4c19ce0de4c 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -138,6 +138,27 @@ SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
>  	return ret;
>  }
>  
> +/*
> + * If the task has set an I/O priority, use that. Otherwise, return
> + * the default I/O priority.
> + */
> +int __get_task_ioprio(struct task_struct *p)
> +{
> +	struct io_context *ioc = p->io_context;
> +	int prio;
> +
> +	if (ioc)
> +		prio = ioc->ioprio;
> +	else
> +		prio = IOPRIO_DEFAULT;
> +
> +	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
> +		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
> +					 task_nice_ioprio(p));
> +	return prio;
> +}
> +EXPORT_SYMBOL_GPL(__get_task_ioprio);
> +
>  static int get_task_ioprio(struct task_struct *p)
>  {
>  	int ret;
> @@ -145,10 +166,29 @@ static int get_task_ioprio(struct task_struct *p)
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
> +static int get_task_raw_ioprio(struct task_struct *p) { int ret;

The "int ret;" declaration is on the wrong line, so is the curly bracket.

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
> @@ -156,11 +196,6 @@ static int get_task_ioprio(struct task_struct *p)
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

This function could be declared as inline now...

>  
> @@ -181,7 +216,7 @@ SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
>  			else
>  				p = find_task_by_vpid(who);
>  			if (p)
> -				ret = get_task_ioprio(p);
> +				ret = get_task_raw_ioprio(p);
>  			break;
>  		case IOPRIO_WHO_PGRP:
>  			if (!who)
> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
> index 519d51fc8902..24e648dc4fb3 100644
> --- a/include/linux/ioprio.h
> +++ b/include/linux/ioprio.h
> @@ -46,24 +46,11 @@ static inline int task_nice_ioclass(struct task_struct *task)
>  		return IOPRIO_CLASS_BE;
>  }
>  
> -/*
> - * If the calling process has set an I/O priority, use that. Otherwise, return
> - * the default I/O priority.
> - */
> +int __get_task_ioprio(struct task_struct *p);
> +
>  static inline int get_current_ioprio(void)
>  {
> -	struct io_context *ioc = current->io_context;
> -	int prio;
> -
> -	if (ioc)
> -		prio = ioc->ioprio;
> -	else
> -		prio = IOPRIO_DEFAULT;
> -
> -	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
> -		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(current),
> -					 task_nice_ioprio(current));
> -	return prio;
> +	return __get_task_ioprio(current);

The build bot complained about this one, but I do not understand why.
Could it be because you do not have declared __get_task_ioprio() as "extern" ?

Also, to reduce refactoring changes in this patch, you could introduce
__get_task_ioprio() and make the above change in patch 2. No ?

>  }
>  
>  extern int set_task_ioprio(struct task_struct *task, int ioprio);


-- 
Damien Le Moal
Western Digital Research
