Return-Path: <SRS0=4fFE=5D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE71EC10DCE
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 10:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F1D20768
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 10:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="fsL2pmew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCRKzO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:55:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33611 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRKzO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Mar 2020 06:55:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so29710520wrd.0
        for <linux-block@vger.kernel.org>; Wed, 18 Mar 2020 03:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5uNbTrGtkzfD5hFJe/LQk7sXA0d54ynuEUZ1151Ru/0=;
        b=fsL2pmewC3L5NgSvdBQBCfTTEk42o5B1A56GE/xf4JyHIyY0aEn2afZXKRzOxwQ0Vw
         Tl9HgVJL6aPrkxCzribUFNGZAMnJOhb1o3KjVob687WEr4Si569AT8ohYcEXqyG4TtQD
         CacZ23EAO8N8RzNNv1EdyZy60/GA5DQbdpUoLyo5JhWGdkpsqdELcA+f5RRB2s61oV/D
         eA2tybeu5D+edrEJdpGUrRS2Hu12jOPesmySrQnI4TuccT8RpiCq8uxz3QPHicMuxxFX
         a8LpkKB2gJDo0fui+u/b/M5ZrHhOj27u98D1pxFINhhYWzU3Q/9l9IqqpmIb1lv0gQwu
         trUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5uNbTrGtkzfD5hFJe/LQk7sXA0d54ynuEUZ1151Ru/0=;
        b=t2A7CSiuP/3lIL+xezaFG3ADTkoBOvyWP7LCUHMdfLuT+eY80BqWJZaFhBS0uC1uXf
         d2fWO/S+LRSDfBjGX8TwHGvoKGM2v7rhwv2J7OQluye1QYHRe+Wbj26qXxkdMvd/CDin
         uYWKj3I1x/OD4VNWcATT8lNpp2PFe5AYeIoHoNzMy8OXgCgtFI/SwBtfDLJtq5+2xyTO
         fI4Z7MRp+rE2C4CkydOZmMXfNUdujrHFy0i5xobSC9nX4BKoUmaLZ7MxZS4CxFHeZwXO
         ZjejA7LFVEfRYQ448nO3R1ZIHsNY7JtYVw1Xzur8SebhoydJ0+JMI6MiL2WYBAaNnkqS
         6WnA==
X-Gm-Message-State: ANhLgQ15b9cOGNgKYv6qgncEgWQYpnlebOasmT1UpwuCN/iX4ROFnAmY
        zp/7/fKSjYnP1xEZJfTpl6ea5iKsyrw19Q==
X-Google-Smtp-Source: ADFU+vvNfjuhU4TzZzybTyYMRz5Ab0f5gKJezkyOcqD+WhPYpc47RFFPCRWi5jZ9lichKadQjRhdoA==
X-Received: by 2002:adf:a49b:: with SMTP id g27mr4905863wrb.113.1584528911241;
        Wed, 18 Mar 2020 03:55:11 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4870:6500:9021:4ceb:9602:c3c9? ([2001:16b8:4870:6500:9021:4ceb:9602:c3c9])
        by smtp.gmail.com with ESMTPSA id x206sm3096468wmg.17.2020.03.18.03.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 03:55:10 -0700 (PDT)
Subject: Re: [PATCH V2] block: Prevent hung_check firing during long sync IO
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200318034336.6212-1-ming.lei@redhat.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <3f8eb43f-4ad7-11f1-380c-c11969fe19ad@cloud.ionos.com>
Date:   Wed, 18 Mar 2020 11:55:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200318034336.6212-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On 3/18/20 4:43 AM, Ming Lei wrote:
> submit_bio_wait() can be called from ioctl(BLKSECDISCARD), which
> may take long time to complete, as Salman mentioned, 4K BLKSECDISCARD
> takes up to 100 second on some devices. Also any block I/O operation
> that occurs after the BLKSECDISCARD is submitted will also potentially
> be affected by the hung task timeouts.
> 
> Another report is that task hang can be observed when running mkfs
> over raid10 which takes a small max discard sectors limit because
> of chunk size.

Could you point the link about the raid10 task hang? And we have observed
task hang with raid5, not sure it is related or not.

Our set up is md/raid5 -> 100+ LVs (fs is created on top of one LV), run heavy
IOs on LVs and dbench on the LV with fs, then dbench hangs with 'D' state.

> 
> So prevent hung_check from firing by taking same approach used
> in blk_execute_rq(), and the wake-up interval is set as half the
> hung_check timer period, which keeps overhead low enough.
> 
> Cc: Salman Qazi <sqazi@google.com>
> Cc: Jesse Barnes <jsbarnes@google.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Link: https://lkml.org/lkml/2020/2/12/1193
> Reported-by: Salman Qazi <sqazi@google.com>
> Reviewed-by: Jesse Barnes <jsbarnes@google.com>
> Reviewed-by: Salman Qazi <sqazi@google.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- fix checkpatch warning
> 	- add reviewed-by
> 	- add comment log for covering one recent report on task hung on
> 	  raid10
> 
>   block/bio.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 94d697217887..0985f3422556 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -17,6 +17,7 @@
>   #include <linux/cgroup.h>
>   #include <linux/blk-cgroup.h>
>   #include <linux/highmem.h>
> +#include <linux/sched/sysctl.h>
>   
>   #include <trace/events/block.h>
>   #include "blk.h"
> @@ -1019,12 +1020,21 @@ static void submit_bio_wait_endio(struct bio *bio)
>   int submit_bio_wait(struct bio *bio)
>   {
>   	DECLARE_COMPLETION_ONSTACK_MAP(done, bio->bi_disk->lockdep_map);
> +	unsigned long hang_check;
>   
>   	bio->bi_private = &done;
>   	bio->bi_end_io = submit_bio_wait_endio;
>   	bio->bi_opf |= REQ_SYNC;
>   	submit_bio(bio);
> -	wait_for_completion_io(&done);
> +
> +	/* Prevent hang_check timer from firing at us during very long I/O */
> +	hang_check = sysctl_hung_task_timeout_secs;
> +	if (hang_check)
> +		while (!wait_for_completion_io_timeout(&done,
> +					hang_check * (HZ/2)))
> +			;
> +	else
> +		wait_for_completion_io(&done);
>   
>   	return blk_status_to_errno(bio->bi_status);
>   }
> 

I hope the change could resolve our issue as well.

Acked-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Thanks,
Guoqing
