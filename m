Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D931AC43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 14:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBB420652
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 14:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fc0E0NNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfD3OUr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 10:20:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32904 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfD3OUq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 10:20:46 -0400
Received: by mail-io1-f65.google.com with SMTP id u12so12390656iop.0
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2019 07:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pGJDbTifmKOXHUXSOgXNr5O3AzGnlOGhobGhD+Vxa/s=;
        b=fc0E0NNjHm1VrOynn1PfvncvadlC9M6jrHsEN01IjXc7jFd4EakRWg1w2dhTQTxfW0
         SfQtQBvtgKdOexiXCjui1zSVXAeT3zgb/hxGkrSHbjLPTMfxspotypyIswEgDqa4DUAw
         KhcZWhDMfop4qNu8bh/7XElmF8PuC9zVqQQkh8K4uWikmz7gaOJ6RsWIF7HpV81+eSbV
         XsKfi7647gi0t8HZToVlZdN0BU0VaVSTwc1zfARsh4wAA6JicMlBjMdvsienld0xFPyw
         qSjfXVmg8YTyyscSlkTK3crriTIA0ToGwMUyiAfx5n/2wQFaOUDeOWVxooUvweRcDyVk
         LgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pGJDbTifmKOXHUXSOgXNr5O3AzGnlOGhobGhD+Vxa/s=;
        b=qJwSPAUyZGKJE+1pgQi2aM/O2jgzX88puOp66dOOkgUgUHP3/8MK9TvqMGN3VYFLyL
         5+rXUQcfPNJ8xsj4PUkykwpRg7ou00vYg/nxzwVWG7n/v/X2iq7GIQx5bYCb7jeUNqaT
         g5+UKKBUjqstC1O6hHxLrET+iWucOdGbf5LhYjUCLtQ8TGd0N1pQDYrGWgkKftedNmY4
         b/7tAJ6bovmyDg+pa+1kVA+IalgI+c5tr7JVa2QQGf49mno73TuZS1q+mJ+KUA88Oskl
         zS/4OZEYniWWgiuFkhXWrN2aSUOAwtVFjygXT2ywZRwuAhnpoBGkOwopYnOZknO8IbtP
         gfLQ==
X-Gm-Message-State: APjAAAWua1y3cumxhdqe00OuJ+qxWVdZSVPFaJyHz4BDn+noA0AffyRP
        DYbtVOHZGkF+rsh/ljtgjG19Rw==
X-Google-Smtp-Source: APXvYqx8h2B08Z9UhHjfFHDvdvn4FbUMsLsrFFz1DYs4slmy+QXvci+IiMviVShW+rAQ+8J+4bnaEQ==
X-Received: by 2002:a5d:9d0a:: with SMTP id j10mr10029789ioj.196.1556634045871;
        Tue, 30 Apr 2019 07:20:45 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 3sm1735564itk.1.2019.04.30.07.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 07:20:44 -0700 (PDT)
Subject: Re: [PATCH] bcache: remove redundant LIST_HEAD(journal) from
 run_cache_set()
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        juha.aatrokoski@aalto.fi, shhuiw@foxmail.com
References: <20190430140225.21642-1-colyli@suse.de>
 <0ded62e9-6135-6da1-312d-1ceb6160c93b@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <54478019-5427-266e-42c2-0d606c6e5ec3@kernel.dk>
Date:   Tue, 30 Apr 2019 08:20:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0ded62e9-6135-6da1-312d-1ceb6160c93b@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/30/19 8:05 AM, Coly Li wrote:
> On 2019/4/30 10:02 下午, Coly Li wrote:
>> Commit 95f18c9d1310 ("bcache: avoid potential memleak of list of
>> journal_replay(s) in the CACHE_SYNC branch of run_cache_set") forgets
>> to remove the original define of LIST_HEAD(journal), which makes
>> the change no take effect. This patch removes redundant variable
>> LIST_HEAD(journal) from run_cache_set(), to make Shenghui's fix
>> working.
>>
>> Reported-by: Juha Aatrokoski <juha.aatrokoski@aalto.fi>
>> Cc: Shenghui Wang <shhuiw@foxmail.com>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> ---
>>  drivers/md/bcache/super.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>> index 0ffe9acee9d8..1b63ac876169 100644
>> --- a/drivers/md/bcache/super.c
>> +++ b/drivers/md/bcache/super.c
>> @@ -1800,7 +1800,6 @@ static int run_cache_set(struct cache_set *c)
>>  	set_gc_sectors(c);
>>  
>>  	if (CACHE_SYNC(&c->sb)) {
>> -		LIST_HEAD(journal);
>>  		struct bkey *k;
>>  		struct jset *j;
>>  
>>
> 
> Hi Jens,
> 
> Please take this fix for the Linux v5.2 bcache series. It fixes a
> problem from
> [PATCH 18/18] bcache: avoid potential memleak of list of
> journal_replay(s) in the CACHE_SYNC branch of run_cache_set
> which is already in your for-next branch.
> 
> Thanks to Juha for cache this bug, and thank you in advance for taking
> care of this.

Applied, but please add Fixes: lines patches like that, it's not enough
to simply mention it in the commit message.

-- 
Jens Axboe

