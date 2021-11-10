Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51C8C433F5
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 00:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75ED861184
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 00:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhKJA6c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 19:58:32 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:44871 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhKJA6c (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 19:58:32 -0500
Received: by mail-pl1-f171.google.com with SMTP id q17so1538719plr.11
        for <linux-block@vger.kernel.org>; Tue, 09 Nov 2021 16:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g0UmEhkyzW50PsOVupKVH2jmgWKtA1NXZOMiliwKSfY=;
        b=q+gNGM1WRG8ItUXaFAqlexIwPz6mrjELN2lmizJIgazk4RR/Lm2WKTZ3yKiOwYi4sa
         mMRX9P30i1VAgDO1zgAFQfioKmDBlPZYxtZ4KOnBOXrZ+UqGffPqnefXKidYlJXkYfX4
         WdTaSpHJN/9CpsMRRtf6y7dtmVON7tbEQu1axUHmh9pllLJP0/iDtkXNPRRFeElnMCxd
         OWB9Pm1L+VnEZjABfmVoG7GAGsZMwveupwUMMkVV9sQyFg0nR0LeyrSZd9JS8MZ2WPDI
         Z3sD/A8LFS421O7nn0qGs6MU+Fsnygm36T8LGgpjKlCT2EykkzMkyAhrV9lYc/ewjy+k
         7TiQ==
X-Gm-Message-State: AOAM530AHMX9ApmsrK7eLYSCDst+RqbpZP1QGEBI/m+Wzxv+RTWq9PYd
        zXsf+xnGobwJYsvTW5m49J2yYhUFoja/0g==
X-Google-Smtp-Source: ABdhPJxhA5EonHNAULqZ2EXMz5vUPAGromWOgF2keAACX7ZUCA+2kI7C+mQw35kYAj1ZyxcPvnJtmw==
X-Received: by 2002:a17:90b:11c1:: with SMTP id gv1mr12449706pjb.208.1636505745049;
        Tue, 09 Nov 2021 16:55:45 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:a582:6939:6a97:9cbf])
        by smtp.gmail.com with ESMTPSA id 17sm20871773pfp.14.2021.11.09.16.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 16:55:44 -0800 (PST)
Subject: Re: [PATCH] block: use enum type for blk_mq_alloc_data->rq_flags
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1a4b790b-8074-1f67-24f5-662400b2976e@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8469d29e-2855-d7df-bd5c-40af06748f2a@acm.org>
Date:   Tue, 9 Nov 2021 16:55:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1a4b790b-8074-1f67-24f5-662400b2976e@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/9/21 2:10 PM, Jens Axboe wrote:
> kernel test robot reports that we now trigger some sparse warnings:
> 
> block/blk-mq.h:169:32: sparse: sparse: restricted req_flags_t degrades to integer
> block/blk-mq.h:169:32: sparse: sparse: restricted req_flags_t degrades to integer
> block/blk-mq.h:169:32: sparse: sparse: restricted req_flags_t degrades to integer
> 
> which is due to ->rq_flags being an unsigned int, rather than the
> stronger type req_flags_t enum.
> 
> Change the type to req_flags_t to silence this warning.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
