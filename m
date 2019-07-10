Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FFFC74A35
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 20:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C176820693
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 20:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Mmfi0qp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfGJUX1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:23:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41724 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfGJUX0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 16:23:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so1609743pff.8
        for <linux-block@vger.kernel.org>; Wed, 10 Jul 2019 13:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o1YmXPRGN//hDN7KqUenwIQ//LlVBLcFiHdehSMolY8=;
        b=Mmfi0qp9PGAtfot4WORspXWju3tJUNIpEix+/dIpKBoNejdfb68pw2inKXASjH8r9v
         ujwAQ07R4ttA3ZXCdi/RZJcXQilNfFrxiifv3ZQv1PyVOGmNQX49iAoSeZ1RNoG/HG+R
         HyZTSPcGkxhhKSZ43J5cuOJJHq2Pu7DgPyXMW7NN4F2gOiHjzR0kYUfOUEjCQncUa9tl
         psnIt3gG+8swGJ4Ys5IxcNhdmOQ80df2fUbAjXr2fr6MnErFmfHC4AIRUlB+WmRZkVt8
         6ofKc3Yvu+GF9WJMl29wS+ahMlhmdR52B/3dcjAJmxWJIvgRQ1GXqLBBL/GVSmGNvLL6
         51Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o1YmXPRGN//hDN7KqUenwIQ//LlVBLcFiHdehSMolY8=;
        b=qAeYLmNha1PP2sLFwAFpi/n/GIAAGXC8OM+OfsVfJXHiu9clV9gRPgDRtE27FB7iQb
         8dQslxiVwcwrDwuEcr9IxtZYGy0EZ7u4Kh4jHupB4FSm3KeeKlrsDdH41+oj/7tpk8pl
         +49QyqLPuljEgzVjsOVDvpk8zdj3C8PQWWnrweLSyxbqs5Kyu84GsNwZxf3UMu7OPH/m
         rSvxoaBs0fTWd4/GfzVwirFUIrZNxQCAHXbs60vA21EnfAd4D98wEK/HwMvdEl5dEymI
         UOVI93z0raWlDHpMis75CZ3cDtaRZQ4dkVsdOOCsPp04JSr/tLNSyUI/4tPv+7WqznpK
         EW3g==
X-Gm-Message-State: APjAAAVd2cvEW1XpblwXnk9F3SZzoi64FocnKMPXIaQda+EeVqLhl5jq
        YCuijdPNdEyBB00N4F1u3anoNSaS2O8NkQ==
X-Google-Smtp-Source: APXvYqzI/DfUY3RW0dnLnYIBqsrTYNKtQX7K4ThakPWNilxNfj0bH4i50X+zyV3vWkEhaaa20l30pw==
X-Received: by 2002:a63:79ca:: with SMTP id u193mr97915pgc.91.1562790206010;
        Wed, 10 Jul 2019 13:23:26 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id b6sm3326979pgq.26.2019.07.10.13.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 13:23:25 -0700 (PDT)
Subject: Re: [PATCH 1/2] wait: add wq_has_multiple_sleepers helper
To:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org
References: <20190710195227.92322-1-josef@toxicpanda.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bbe73e4e-9270-46ac-16d7-39a40485fe53@kernel.dk>
Date:   Wed, 10 Jul 2019 14:23:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710195227.92322-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/10/19 1:52 PM, Josef Bacik wrote:
> rq-qos sits in the io path so we want to take locks as sparingly as
> possible.  To accomplish this we try not to take the waitqueue head lock
> unless we are sure we need to go to sleep, and we have an optimization
> to make sure that we don't starve out existing waiters.  Since we check
> if there are existing waiters locklessly we need to be able to update
> our view of the waitqueue list after we've added ourselves to the
> waitqueue.  Accomplish this by adding this helper to see if there are
> more than two waiters on the waitqueue.
> 
> Suggested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   include/linux/wait.h | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index b6f77cf60dd7..89c41a7b3046 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -126,6 +126,27 @@ static inline int waitqueue_active(struct wait_queue_head *wq_head)
>   	return !list_empty(&wq_head->head);
>   }
>   
> +/**
> + * wq_has_multiple_sleepers - check if there are multiple waiting prcesses
> + * @wq_head: wait queue head
> + *
> + * Returns true of wq_head has multiple waiting processes.
> + *
> + * Please refer to the comment for waitqueue_active.
> + */
> +static inline bool wq_has_multiple_sleepers(struct wait_queue_head *wq_head)
> +{
> +	/*
> +	 * We need to be sure we are in sync with the
> +	 * add_wait_queue modifications to the wait queue.
> +	 *
> +	 * This memory barrier should be paired with one on the
> +	 * waiting side.
> +	 */
> +	smp_mb();
> +	return !list_is_singular(&wq_head->head);
> +}
> +
>   /**
>    * wq_has_sleeper - check if there are any waiting processes
>    * @wq_head: wait queue head

This (and 2/2) looks good to me, better than v1 for sure. Peter/Ingo,
are you OK with adding this new helper? For reference, this (and the
next patch) replace the alternative, which is an open-coding of
prepare_to_wait():

https://lore.kernel.org/linux-block/20190710190514.86911-1-josef@toxicpanda.com/

-- 
Jens Axboe

