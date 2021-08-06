Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0802FC4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 06:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D8461164
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 06:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhHFGfw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 02:35:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54588 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhHFGfv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Aug 2021 02:35:51 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8006223A4;
        Fri,  6 Aug 2021 06:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628231735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2bB2yS4V99IZITU8iThfrjPKq0hHxHHv8PEmoSddKs8=;
        b=0rCSLgq5KvGNjxZe18T2x5As53FS/n5fQp9veSlBx0+OPJdqpRLMD672cYYOPBcrbbmp8Y
        GAYr97WXrTyXD2281MY7gByTLM5i+y8xa5I5jUu/6kv3acI6UwVac59y1/YELI4owV9OV0
        fxIQhyZ1RNVER61kFXbXr3VUKaQrjRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628231735;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2bB2yS4V99IZITU8iThfrjPKq0hHxHHv8PEmoSddKs8=;
        b=gLVAygpStWv47ae+zEEjzvGahnv/RLLhjFwGwMQFIsXVKlYhT8KjAF1PlAoSLE1OlN6Yk6
        3fJC57KQ6dz3cVCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 845DC136D9;
        Fri,  6 Aug 2021 06:35:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id riq/HjfYDGEOBgAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 06 Aug 2021 06:35:35 +0000
Subject: Re: [PATCH v2 2/4] block: fix ioprio interface
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <20210806051140.301127-1-damien.lemoal@wdc.com>
 <20210806051140.301127-3-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <6fdc9b02-d03f-a63f-cefb-1d00ac42b885@suse.de>
Date:   Fri, 6 Aug 2021 08:35:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806051140.301127-3-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/6/21 7:11 AM, Damien Le Moal wrote:
> An iocb aio_reqprio field is 16-bits (u16) but often handled as an int
> in the block layer. E.g. ioprio_check_cap() takes an int as argument.
> With such implicit int casting function calls, the upper 16-bits of the
> int argument may be left uninitialized by the compiler, resulting in
> invalid values for the IOPRIO_PRIO_CLASS() macro (garbage upper bits)
> and in an error return for functions such as ioprio_check_cap().
> 
> Fix this by masking the result of the shift by IOPRIO_CLASS_SHIFT bits
> in the IOPRIO_PRIO_CLASS() macro. The new macro IOPRIO_CLASS_MASK
> defines the 3-bits mask for the priority class.
> 
> While at it, cleanup the following:
> * Apply the mask IOPRIO_PRIO_MASK to the data argument of the
>    IOPRIO_PRIO_VALUE() macro to ignore upper bits of the data value.
> * Remove unnecessary parenthesis around fixed values in the macro
>    definitions in include/uapi/linux/ioprio.h.
> * Update the outdated mention of CFQ in the comment describing priority
>    classes and instead mention BFQ and mq-deadline.
> * Change the argument name of the IOPRIO_PRIO_CLASS() and
>    IOPRIO_PRIO_DATA() macros from "mask" to "ioprio" to reflect the fact
>    that an IO priority value should be passed rather than a mask.
> * Change the ioprio_valid() macro into an inline function, adding a
>    check on the maximum value of the class of a priority value as
>    defined by the IOPRIO_CLASS_MAX enum value. Move this function to
>    the kernel side in include/linux/ioprio.h.
> * Remove the unnecessary "else" after the return statements in
>    task_nice_ioclass().
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   include/linux/ioprio.h      | 15 ++++++++++++---
>   include/uapi/linux/ioprio.h | 19 +++++++++++--------
>   2 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
> index ef9ad4fb245f..9b3a6d8172b4 100644
> --- a/include/linux/ioprio.h
> +++ b/include/linux/ioprio.h
> @@ -8,6 +8,16 @@
>   
>   #include <uapi/linux/ioprio.h>
>   
> +/*
> + * Check that a priority value has a valid class.
> + */
> +static inline bool ioprio_valid(unsigned short ioprio)

Wouldn't it be better to use 'u16' here as type, as we're relying on the 
number of bits?

> +{
> +	unsigned short class = IOPRIO_PRIO_CLASS(ioprio);
> +
> +	return class > IOPRIO_CLASS_NONE && class < IOPRIO_CLASS_MAX;
> +}
> +
>   /*
>    * if process has set io priority explicitly, use that. if not, convert
>    * the cpu scheduler nice value to an io priority
> @@ -25,10 +35,9 @@ static inline int task_nice_ioclass(struct task_struct *task)
>   {
>   	if (task->policy == SCHED_IDLE)
>   		return IOPRIO_CLASS_IDLE;
> -	else if (task_is_realtime(task))
> +	if (task_is_realtime(task))
>   		return IOPRIO_CLASS_RT;
> -	else
> -		return IOPRIO_CLASS_BE;
> +	return IOPRIO_CLASS_BE;
>   }
>   
>   /*
> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
> index 77b17e08b0da..abc40965aa96 100644
> --- a/include/uapi/linux/ioprio.h
> +++ b/include/uapi/linux/ioprio.h
> @@ -5,12 +5,15 @@
>   /*
>    * Gives us 8 prio classes with 13-bits of data for each class
>    */
> -#define IOPRIO_CLASS_SHIFT	(13)
> +#define IOPRIO_CLASS_SHIFT	13
> +#define IOPRIO_CLASS_MASK	0x07
>   #define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
>   
> -#define IOPRIO_PRIO_CLASS(mask)	((mask) >> IOPRIO_CLASS_SHIFT)
> -#define IOPRIO_PRIO_DATA(mask)	((mask) & IOPRIO_PRIO_MASK)
> -#define IOPRIO_PRIO_VALUE(class, data)	(((class) << IOPRIO_CLASS_SHIFT) | data)
> +#define IOPRIO_PRIO_CLASS(ioprio)	\
> +	(((ioprio) >> IOPRIO_CLASS_SHIFT) & IOPRIO_CLASS_MASK)
> +#define IOPRIO_PRIO_DATA(ioprio)	((ioprio) & IOPRIO_PRIO_MASK)
> +#define IOPRIO_PRIO_VALUE(class, data)	\
> +	(((class) << IOPRIO_CLASS_SHIFT) | ((data) & IOPRIO_PRIO_MASK))
>   
>   /*
>    * These are the io priority groups as implemented by CFQ. RT is the realtime
> @@ -23,14 +26,14 @@ enum {
>   	IOPRIO_CLASS_RT,
>   	IOPRIO_CLASS_BE,
>   	IOPRIO_CLASS_IDLE,
> -};
>   
> -#define ioprio_valid(mask)	(IOPRIO_PRIO_CLASS((mask)) != IOPRIO_CLASS_NONE)
> +	IOPRIO_CLASS_MAX,
> +};
>   
>   /*
>    * 8 best effort priority levels are supported
>    */
> -#define IOPRIO_BE_NR	(8)
> +#define IOPRIO_BE_NR	8
>   
>   enum {
>   	IOPRIO_WHO_PROCESS = 1,
> @@ -41,6 +44,6 @@ enum {
>   /*
>    * Fallback BE prioritye@su
>    */
> -#define IOPRIO_NORM	(4)
> +#define IOPRIO_NORM	4
>   
>   #endif /* _UAPI_LINUX_IOPRIO_H */
> 
Other than that:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
