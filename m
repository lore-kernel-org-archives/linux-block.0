Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1227C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94723610FC
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhJLSbG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:31:06 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:39459 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhJLSbF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:31:05 -0400
Received: by mail-pj1-f54.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso2541998pjb.4
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=40W6nYibFs9kUjsxlid/33I8M5Qw16iLU8zsyfu+Ct4=;
        b=hD3CsphW7E5cHePRSnRUch4afzgk2TVub7JkG7U8+bVQPwPRh8qYS4tTiB0ADaqPiZ
         RMNO3LcZBt0jJhHc9UqS2Sd/c5MXwgyRQyzcuCVxcL114KyioeZ0MP/DcvhProxVa0Rk
         PADVhqUMzSNIhbJYdr4JWw4LHSth7f6ucqGuhnDJdjrZm1uTzhssTuTiLm1oeARFGL7z
         5DON4JNkQjvxQfx5XQI5hczvEyXiVWqY2DQ6X3sveZWW6XJtymU+xz/Cln2fg2IZxmPg
         ksFWYtVg1b1pzBIGe/pWWw91v/Pq+5E5ri+0Xsh0eZdJorLbCW2rXA2yFeXn4GlM5g3Y
         JV7Q==
X-Gm-Message-State: AOAM530zVMX4pRk6PwEtObFfkgxQ8FB1u/fGPhQFyn/OMN+kTXgY5+dJ
        NRRAX4uXtUum2JIcQp5cZMdZ/tLneNE=
X-Google-Smtp-Source: ABdhPJzmMP27Qo6UvhnR6qmwzfyRuSlFElsIqUq7+ovqBpdJf5/HyGyQHz38VoVAAxTF7uEMx0+xuw==
X-Received: by 2002:a17:902:8f8a:b0:13d:abff:19cf with SMTP id z10-20020a1709028f8a00b0013dabff19cfmr31666285plo.15.1634063342423;
        Tue, 12 Oct 2021 11:29:02 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8c1a:acb2:4eff:5d13])
        by smtp.gmail.com with ESMTPSA id u2sm11445534pfi.120.2021.10.12.11.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 11:29:01 -0700 (PDT)
Subject: Re: [PATCH 2/9] sbitmap: add helper to clear a batch of tags
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-3-axboe@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f7532d88-74a2-9f3e-2a95-29e6508e889f@acm.org>
Date:   Tue, 12 Oct 2021 11:29:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211012181742.672391-3-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/21 11:17 AM, Jens Axboe wrote:
> +void sbitmap_queue_clear_batch(struct sbitmap_queue *sbq, int offset,
> +				int *tags, int nr_tags)
> +{
> +	struct sbitmap *sb = &sbq->sb;
> +	unsigned long *addr = NULL;
> +	unsigned long mask = 0;
> +	int i;
> +
> +	smp_mb__before_atomic();
> +	for (i = 0; i < nr_tags; i++) {
> +		const int tag = tags[i] - offset;
> +		unsigned long *this_addr;
> +
> +		/* since we're clearing a batch, skip the deferred map */
> +		this_addr = &sb->map[SB_NR_TO_INDEX(sb, tag)].word;
> +		if (!addr) {
> +			addr = this_addr;
> +		} else if (addr != this_addr) {
> +			atomic_long_andnot(mask, (atomic_long_t *) addr);
> +			mask = 0;
> +			addr = this_addr;
> +		}
> +		mask |= (1UL << SB_NR_TO_BIT(sb, tag));
> +	}
> +
> +	if (mask)
> +		atomic_long_andnot(mask, (atomic_long_t *) addr);
> +
> +	smp_mb__after_atomic();
> +	sbitmap_queue_wake_up(sbq);
> +	sbitmap_update_cpu_hint(&sbq->sb, raw_smp_processor_id(),
> +					tags[nr_tags - 1] - offset);
> +}
> +
>   void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
>   			 unsigned int cpu)
>   {

How does replacing the sbitmap_queue_clear() implementation by calling 
sbitmap_queue_clear_batch() affect performance? I'm wondering whether it 
is possible to prevent code duplication without affecting performance 
negatively.

Thanks,

Bart.
