Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554B4C433DB
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 16:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 276DA20756
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 16:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391218AbhAZQQO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392774AbhAZQQI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 11:16:08 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBD5C0613D6
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 08:15:28 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id p15so2262433pjv.3
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 08:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CoACkKKaKolb5/db25iF9yoT4NneQU8hJQg65/Y8VcI=;
        b=QFVB49MXc8QZBwwZq/6Iq8/Z6QaLYulINObGkfe4ntl71GZmQlQ2jejdVsCHK5whKY
         rRDxfVGIQkyDHtjCdMRZE7Bx356O55nfJp6UXoYcDs9lrEetLiyHdpKSdtK1nD630ksY
         HVrfz0RM8y7nsYroqou7N5MaI6ipPoKOSvsmkAOUIqUXomrThbu83EMUttOjP10N2/Qc
         ojg9YCoWAncKkUb7J+2WT0xYd/t0cQsHFMlm7hUEyDbqrupSoz8vf4q0HSN590FR5K/E
         ZglcJhfqy7eod4FDpDscmFjL+oIyc9PMwJopjb5EWGmHoZXRaXG2M/PBniAB0MCoryKY
         IFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CoACkKKaKolb5/db25iF9yoT4NneQU8hJQg65/Y8VcI=;
        b=lXJo5hMWSnqH1YXXHRtsOhZNl7e7WnrPMXJ4JOEkbcTkEFR9gGoXRVzNnxW4R7oHEs
         6/w/L7XI89iEYKoiJyz7/FN9SD28NBeSbzybUndGDzzx/PgXFF8nSrzk9Ayyr+8czNZr
         YqQ9hp0w+aeNwVlIwJ0Qv/sN24NF01brvbs8cnyoLW/F0ayncnJYXj4IiGcveMAOpuIu
         q7abhl6JgCEwXFTqNGFpcqENhEdGsU0A+pJgmWikjdj8rR02ZoUEweauau7B3wm6OC4Y
         OxJOHspPvCpTTibUE/1aBfCUa6s3McCHcSEgj0MVl1SI4LpxsYaRkZF30cV29npLGHCH
         sWtQ==
X-Gm-Message-State: AOAM530/ylcVTTLOPrGFoyQv6gSLQcPLRljyIwme3jG7KoUoPUuyfcIo
        PfHxZlcFoQlwyL26NR+CqMXJNsCPE5R/cQ==
X-Google-Smtp-Source: ABdhPJyatNUsl2O743yPGwTjFGdZTMmMi+wvmLPAclwnTKOZFTPTy67lYJXQnSioB1xFlcGYYZPO+g==
X-Received: by 2002:a17:902:467:b029:da:9ac2:24ee with SMTP id 94-20020a1709020467b02900da9ac224eemr6754330ple.22.1611677728265;
        Tue, 26 Jan 2021 08:15:28 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id w14sm2776355pjl.38.2021.01.26.08.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 08:15:27 -0800 (PST)
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 6/6] block, bfq: merge bursts of
 newly-created queues
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
 <20210126105102.53102-7-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a4874bb3-006c-85d9-5015-12443baa1e87@kernel.dk>
Date:   Tue, 26 Jan 2021 09:15:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126105102.53102-7-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/26/21 3:51 AM, Paolo Valente wrote:
> @@ -2809,6 +2853,12 @@ void bfq_release_process_ref(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>  	    bfqq != bfqd->in_service_queue)
>  		bfq_del_bfqq_busy(bfqd, bfqq, false);
>  
> +	if (bfqq->entity.parent &&
> +	    bfqq->entity.parent->last_bfqq_created == bfqq)
> +		bfqq->entity.parent->last_bfqq_created = NULL;
> +	else if (bfqq->bfqd && bfqq->bfqd->last_bfqq_created == bfqq)
> +		bfqq->bfqd->last_bfqq_created = NULL;
> +
>  	bfq_put_queue(bfqq);
>  }
>  
> @@ -2905,6 +2955,13 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
>  	 */
>  	new_bfqq->pid = -1;
>  	bfqq->bic = NULL;
> +
> +	if (bfqq->entity.parent &&
> +	    bfqq->entity.parent->last_bfqq_created == bfqq)
> +		bfqq->entity.parent->last_bfqq_created = new_bfqq;
> +	else if (bfqq->bfqd && bfqq->bfqd->last_bfqq_created == bfqq)
> +		bfqq->bfqd->last_bfqq_created = new_bfqq;
> +
>  	bfq_release_process_ref(bfqd, bfqq);
>  }

Almost identical code constructs makes it seem like this should have a
helper instead.

> @@ -5033,6 +5090,12 @@ void bfq_put_queue(struct bfq_queue *bfqq)
>  	bfqg_and_blkg_put(bfqg);
>  }
>  
> +static void bfq_put_stable_ref(struct bfq_queue *bfqq)
> +{
> +	bfqq->stable_ref--;
> +	bfq_put_queue(bfqq);
> +}
> +
>  static void bfq_put_cooperator(struct bfq_queue *bfqq)
>  {
>  	struct bfq_queue *__bfqq, *next;
> @@ -5089,6 +5152,17 @@ static void bfq_exit_icq(struct io_cq *icq)
>  {
>  	struct bfq_io_cq *bic = icq_to_bic(icq);
>  
> +	if (bic->stable_merge_bfqq) {
> +		unsigned long flags;
> +		struct bfq_data *bfqd = bic->stable_merge_bfqq->bfqd;
> +
> +		if (bfqd)
> +			spin_lock_irqsave(&bfqd->lock, flags);
> +		bfq_put_stable_ref(bic->stable_merge_bfqq);
> +		if (bfqd)
> +			spin_unlock_irqrestore(&bfqd->lock, flags);
> +	}
> +

Construct like this are really painful. Just do:

if (bfqd) {
	unsigned long flags;

	spin_lock_irqsave(&bfqd->lock, flags);
	bfq_put_stable_ref(bic->stable_merge_bfqq);
	spin_unlock_irqrestore(&bfqd->lock, flags);
} else {
	bfq_put_stable_ref(bic->stable_merge_bfqq);
}

which is also less likely to cause code analyzer false warnings. Outside
of that, it needs a comment on why it's ok NOT to grab the lock when
bfqd is zero, because that seems counter-intuitive and more a case of
"well we can't grab a lock for something we don't have". Maybe it's
because bfqd is no longer visible at this point, and it's ok, but it's
definitely not clear just looking at this patch. Even with that, is the
bfqq visible? Should the ref be atomic, and locking happen further down
instead?

-- 
Jens Axboe

