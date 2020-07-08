Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448E0C433E0
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 22:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208092078B
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 22:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sNJT1RSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgGHWuu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHWuu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 18:50:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BA1C061A0B
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 15:50:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u18so113383pfk.10
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 15:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u+VHc+GZVc+r9DZfoB4mu5+Tk0bAWj/53Ghcr9mH3UY=;
        b=sNJT1RSxpdvc6P56GS41fE9nFIBa9CEesX052iD6fop87EI8QKVwZX2aXMx6KdyiU9
         4KtsZVmdmWN7U6MhvWocTgchRPH7G2mwkuGfmyUjOuxuoRRicfE/h0BFhxXXabzJ7IXe
         y9M0XkpIwb4RwVI7gJoJ8Mp36hGdT5MajCO25KiacTs84DDddJ7+krbNLHGmPnstHkoj
         1sdwkiC8g8fFb0BMDqZRaGpzPr3hspgPQToeo7XVphuqUf+TNev7qlR2UXhe2IQtnTq7
         iKmOInmw89OrSM6uvS+vv7XhtOOB8eJ7WWPq2aRzS6P7QWrhq3y8o07R7a9s1RoJrl8I
         7/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u+VHc+GZVc+r9DZfoB4mu5+Tk0bAWj/53Ghcr9mH3UY=;
        b=BCf9Oxk4evlfUmLtERCIust1VGg7NH2C4P/QeQJaA0t6EFglFkzSMF9bFATMAfE3F5
         Qb0NUFilixNCyMRoXYxsLWD0ItivBEuzm1utr+cZPwJxGSRLqnS9y31xi9PzzS7vRaFS
         Fl0qKtBqP6+U2h3E+8PB5sGRAL+uO9CKR1+hYglWBEu/q21JQMAOiafMhM8UDj39/OjG
         H+U0euBKP8o8/3rsKHmHwa5mfyvRFNCtO4sEVo+lReVE73l9tLQU9n3JL5G/ltaxqERM
         r3EbnM1Yrr6G8rPjmDEnLdRJhgrm7e2IY3PWjai/yzhUiHYzHbUWFIBaQWhA03BmG8dp
         MVJA==
X-Gm-Message-State: AOAM530pdqyh7snHKOrK6G23wQXsx1ZPdVrFVrKJCNFuQDCe9JaXYXHo
        xZEwc/xOqKAUlBKcmUTVnLWgYg==
X-Google-Smtp-Source: ABdhPJxmJGt2ghc7WgMi8H9rvJ9itotdSlot2cMWh5dZ/HTWwJXxXspeJHF+CX5qQwO8OcgLdLLnfg==
X-Received: by 2002:a63:a744:: with SMTP id w4mr50070676pgo.81.1594248649263;
        Wed, 08 Jul 2020 15:50:49 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id u26sm702440pfn.54.2020.07.08.15.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 15:50:48 -0700 (PDT)
Subject: Re: [PATCH 1/2] fs: Abstract calling the kiocb completion function
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
References: <20200708222637.23046-1-willy@infradead.org>
 <20200708222637.23046-2-willy@infradead.org>
 <983baa4b-55c6-0988-9e43-6860937957b4@kernel.dk>
 <20200708224034.GX25523@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5331c3ef-f755-f4ed-f0be-c10da418dc80@kernel.dk>
Date:   Wed, 8 Jul 2020 16:50:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708224034.GX25523@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/8/20 4:40 PM, Matthew Wilcox wrote:
> On Wed, Jul 08, 2020 at 04:37:21PM -0600, Jens Axboe wrote:
>> On 7/8/20 4:26 PM, Matthew Wilcox (Oracle) wrote:
>>> diff --git a/crypto/af_alg.c b/crypto/af_alg.c
>>> index b1cd3535c525..590dbbcd0e9f 100644
>>> --- a/crypto/af_alg.c
>>> +++ b/crypto/af_alg.c
>>> @@ -1045,7 +1045,7 @@ void af_alg_async_cb(struct crypto_async_request *_req, int err)
>>>  	af_alg_free_resources(areq);
>>>  	sock_put(sk);
>>>  
>>> -	iocb->ki_complete(iocb, err ? err : (int)resultlen, 0);
>>> +	complete_kiocb(iocb, err ? err : (int)resultlen, 0);
>>
>> I'd prefer having it called kiocb_complete(), seems more in line with
>> what you'd expect in terms of naming for an exported interface.
> 
> Happy to make that change.  It seemed like you preferred the opposite
> way round with is_sync_kiocb() and init_sync_kiocb() already existing.
> 
> Should I switch register_kiocb_completion and unregister_kiocb_completion
> to kiocb_completion_register or kiocb_register_completion?

I prefer the latter here, as per the other email. But as long as kiocb_
is the prefix, I don't really care that much. The latter is how you'd
say it to, while the former sounds a bit yoda'ish.

-- 
Jens Axboe

