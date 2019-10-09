Return-Path: <SRS0=0s1t=YC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855E1ECE58D
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 09:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593C2206C0
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 09:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwpGb6Wt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfJIJTi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:19:38 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:44195 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfJIJTi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Oct 2019 05:19:38 -0400
Received: by mail-lj1-f175.google.com with SMTP id m13so1685908ljj.11;
        Wed, 09 Oct 2019 02:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gHezdtuOX84HjjcVdB2y/eeYNvckhm/8PE2ggyG9ad0=;
        b=DwpGb6Wtg9rlKO83YaTivuO79UFjAwv27ZSDeI6ZYDy0S/OTg6XDV6NMnw/9i0mBXI
         PclwCHKYRRHxIWjVdX1v1Cwjc+jHcQeRNqGdO9Sc6XRTVjOKA4yDs6X4jmj8AxmsFylz
         Z+gTR6i3kwQiA1A2gzFQA3t0LkF+iuDBSabcYQe5tLoFT0Qkn0GQVhj/55Vsoie5Mci0
         X1WzYg3hxtG95noQo5uBxZSQweSijHNZquyUdmc06cqarXssvnQDSl3CbOJ3ALQ2wHNd
         7SNns8fCCy6/OeNdn+ONxUCIsZkED4N+y/1k0KQ82ijgpD0d8xVz6uaZF0ILD3X1QNGl
         HBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gHezdtuOX84HjjcVdB2y/eeYNvckhm/8PE2ggyG9ad0=;
        b=bWa2Y9y2vjQ8X+F+Ybs3hjYru/EhtAx044HMRochQPnKA6ydGhlzpPI6+emuzqJqdG
         r/OvCBh4Xdk0D4B8aeEQSNYGllCzMIPieybd9G+xne7UC2FyUMAVCq7GLgn4Cin9hLfb
         BUU+T+svivEK2JuJDOhL2umVKeZPcK2fVz7kQZdhU3bP3AtQ5e76Vmj0KuYmrcq50rG1
         hTN7cCwFEgl1BxTBlLm//4xdmJhbC6UEvSUqOOzlLAmRXRuFSS34cUAmPEY+y3tC1JZ6
         l0CXEzWyYc0LJxQ0EhJdhgr6eH3jg4g30PgYxEz/m2vCJX4oO8usFgEBvI35ceA2+Zs2
         hEIA==
X-Gm-Message-State: APjAAAXE47GsOKolSSDnapYrz4RDZoD4pTElLT7g5saZETnTUBJKawpn
        yCVdvcdvEU+kkFgm5GHpLXLmdxik
X-Google-Smtp-Source: APXvYqxEEDz/5yMvmCiApmDVA8xzjVd3T4yfSbCxGNiYIJDF81Kx4RJ6wGWTHUUVI+5e6PjXZW5kQw==
X-Received: by 2002:a2e:6f0f:: with SMTP id k15mr1728148ljc.12.1570612774811;
        Wed, 09 Oct 2019 02:19:34 -0700 (PDT)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id m17sm379327lje.0.2019.10.09.02.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 02:19:34 -0700 (PDT)
Subject: Re: [PATCH] io_uring: remove wait loop spurious wakeups
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <936cd758d6c694fe1b8b9de050e24cfecdc2e60d.1570489620.git.asml.silence@gmail.com>
 <e11a0716-eb18-4ce3-9902-3247beafe65a@kernel.dk>
 <d035bb1b-e6f0-77db-a434-1761b0a7a142@gmail.com>
 <62a8a6c7-9c5b-c9a4-9c73-c77db87c6637@kernel.dk>
 <99bfb7aa-6980-fc14-32f7-a479dea63eb4@gmail.com>
 <a1f8de23-fcad-7252-cbd4-8f5e617056cd@kernel.dk>
 <4004b5bc-edf0-cc8f-8efc-7f848c95f0ba@gmail.com>
 <adc20cef-bc8e-2e67-399c-30c2f4af1a93@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <51f54701-7cef-1ba1-e928-f427790ebfe4@gmail.com>
Date:   Wed, 9 Oct 2019 12:19:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <adc20cef-bc8e-2e67-399c-30c2f4af1a93@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/9/2019 5:54 AM, Jens Axboe wrote:
>>>>>> BTW, is there a reason for ref-counting in struct io_kiocb? I understand
>>>>>> the idea behind submission reference, but don't see any actual part
>>>>>> needing it.
>>>>>
>>>>> In short, it's to prevent the completion running before we're done with
>>>>> the iocb on the submission side.
>>>>
>>>> Yep, that's what I expected. Perhaps I missed something, but what I've
>>>> seen following code paths all the way down, it either
>>>> 1. gets error / completes synchronously and then frees req locally
>>>> 2. or passes it further (e.g. async list) and never accesses it after
>>>
>>> As soon as the IO is passed on, it can complete. In fact, it can complete
>>> even _before_ that call returns. That's the issue. Obviously this isn't
>>> true for purely polled IO, but it is true for IRQ based IO.
>>
>> And the idea was to not use io_kiocb after submission. Except when we know,
>> that it won't complete asynchronously (e.g. error), that could be checked
>> with return code, I guess.
> 
> I think you're still missing the point. During the submission it can go
> away, it can be deep in a call chain. So it's not enough to say "we
> won't touch it after completion returns", we need to hold a reference to
> ensure it doesn't go away WHILE being submitted.
> 
> Hope that helps!

Now I get it, thanks Jens!

-- 
Yours sincerely,
Pavel Begunkov
