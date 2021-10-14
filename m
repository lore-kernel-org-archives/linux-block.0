Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E22C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 18:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B27D611C7
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 18:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbhJNSn7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:43:59 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:43714 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhJNSn6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 14:43:58 -0400
Received: by mail-pl1-f178.google.com with SMTP id y1so4757379plk.10
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 11:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ovXCrvO478l2YM2UTGTdlvZHc8SxJCoPpZEiNVXdoE=;
        b=U13sokadc1Ze7LOLk80N6PWcZX+NZ2BnZnrgbSYJAJBxP3k0L0vGT5cdCWdfkqQ6lf
         QDOfn8V/0VVgfQLFveE2fWRb1KUpsXv4ryrFshFbTJMlJNuGbEeKRhiQFXJHEyJsblsO
         UyNmXBAY8/25xVFi/MnjPstkefSjW5t7BS2vpHUpd17S3sHcgBPW1yKcVHPFEKvvLTTm
         1EpFnFrEMdLL59EiHEY4wuw5wtAYzYIHOlRNKvY9kE7bm34stqwaY3DcmLjGLtog4S2O
         flXRskSfxweoxAB9nzhIuzvJbG/2vr6WNAyBekPdZ57EpC8hPoKhH0oUAnGbOHC5QCX0
         FJJw==
X-Gm-Message-State: AOAM5324rF4apNcVOexbG6kvcJgTt+xiFmGEF0zJ/RKYYt3WXqMEZNwA
        X9FdYxghhbQvQDuiN6Xo6c7aTnPxcDo=
X-Google-Smtp-Source: ABdhPJwF4OB4VZC94xReJCoQ+1y9fiXGUl92GsbfLAbcIkMzO4PMLDlqN5DFdFTl19MclYgxXTL/sA==
X-Received: by 2002:a17:90a:428e:: with SMTP id p14mr22391733pjg.229.1634236913312;
        Thu, 14 Oct 2021 11:41:53 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:689a:4b1f:cd10:549b])
        by smtp.gmail.com with ESMTPSA id g4sm2974962pgs.42.2021.10.14.11.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 11:41:52 -0700 (PDT)
Subject: Re: [PATCH 4/9] sbitmap: test bit before calling test_and_set_bit()
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-5-axboe@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a345227d-5b93-e78b-3078-b8056007b671@acm.org>
Date:   Thu, 14 Oct 2021 11:41:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211013165416.985696-5-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 9:54 AM, Jens Axboe wrote:
> If we come across bits that are already set, then it's quicker to test
> that first and gate the test_and_set_bit() operation on the result of
> the bit test.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   lib/sbitmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index c6e2f1f2c4d2..11b244a8d00f 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -166,7 +166,7 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
>   			return -1;
>   		}
>   
> -		if (!test_and_set_bit_lock(nr, word))
> +		if (!test_bit(nr, word) && !test_and_set_bit_lock(nr, word))
>   			break;
>   
>   		hint = nr + 1;

Hi Jens,

Are numbers available about how much this change improves performance? 
I'm asking this since my understanding is that this patch only helps if 
bit 'nr' is set after find_next_zero_bit() finished and before 
test_and_set_bit() is called. Isn't that a very short time window? Am I 
perhaps missing something?

Thanks,

Bart.


