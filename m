Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46364C43141
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 21:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAF12073A
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 21:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SiI6YWhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfKOVVd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:21:33 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35958 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfKOVVd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 16:21:33 -0500
Received: by mail-io1-f68.google.com with SMTP id s3so11988158ioe.3
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2019 13:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kcG3/ivhGg/12uQy6G0koIqgnAWM5ejtynpeCPT3V3w=;
        b=SiI6YWhKakRxxjHiXzqGOf+xJJtOV2PCI6Ua0wueawHFeCLYQ4E8vVhzTFIzbnhruT
         4IOVoflOwqaPLiU1t6tsva221bBZn5CcagUMsv79ZHSo0PHaIfcDm1PzgiiUMBvpzpkN
         tBKzliXQT4Bsup99Um5/tAbBFMNR32LEeYGcseiwlg1G6jzUWa6Qibpu89zMZQ2ssF5o
         IxOnMve0kfADbwPEM/mpTDE/bWe9BzziQYd16TloTXB79yCjdS+w1OVzmM+JcxwqQFwc
         OAeJDwbwDt/Vvm5FfNad8a3qaAV5fGJm3TUTcZHRicBHee+3RakzizSOIIi/i8iy5Aq8
         lsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kcG3/ivhGg/12uQy6G0koIqgnAWM5ejtynpeCPT3V3w=;
        b=rGMnJ+glxzSuKp3HXQw/1mP87dy9fW0aObBX7aQRyT8dMKSGa0Mg7AKTU+tplLwALQ
         yPga//0BGmKjSsSXMhi/0Vg1fsRsEjUACslde4n6dqqzqIoitCizB22FTXESLzQILDa2
         5F3g88X0Sfc5U0dCXwBZLdISTkbYLw08Es+qNj6kS+j1cu6FWdmML4m5BJb5uTybyKDh
         xJmVfmXVzvgS63e80tAeYgxrNiA9VFY+sF8UGffG4LORA60Kl+ZWHqSLkrYBjSR/WceW
         lm3cqcPOGaKT9f4HQUFibPwp2N3+QlWsbN/ThbrjjZ1mMEzLb1OvUgfgqxLy3ZZhRmu9
         8tIQ==
X-Gm-Message-State: APjAAAUAdl0ZjbBvAzobEAy1Hlf1JWVY+P03dnPeoc1W5ggSGO3MnJNG
        w+2Md0UO2JWlzXGqMhzTDF4ZEA==
X-Google-Smtp-Source: APXvYqw4zFqE5boYxX7JYt9GqcXkA6g5z3YTQ8Vp5fdqCzb9RLN8CGIB1etwJPbsgUTrW2UDwJ9E4g==
X-Received: by 2002:a02:8c5:: with SMTP id 188mr2721465jac.63.1573852891117;
        Fri, 15 Nov 2019 13:21:31 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w12sm1883349ilk.61.2019.11.15.13.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 13:21:30 -0800 (PST)
Subject: Re: [GIT PULL] Fixes for 5.4-rc8/final
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        io-uring@vger.kernel.org
References: <749566df-9390-2b57-ca8e-7f3b6493eae8@kernel.dk>
 <CAHk-=wjm-UQpZS2T03z2iVxCQUUQN5BGvzVguDStQw2WddM46Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ca72afaf-e344-6859-327e-e72cd4364747@kernel.dk>
Date:   Fri, 15 Nov 2019 14:21:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjm-UQpZS2T03z2iVxCQUUQN5BGvzVguDStQw2WddM46Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/15/19 2:17 PM, Linus Torvalds wrote:
> On Fri, Nov 15, 2019 at 11:40 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> - Fix impossible-to-hit overflow merge condition, that still hit some
>>    folks very rarely (Junichi)
> 
> Hmm. This sounded intriguing, so I looked at it.
> 
> It sounds like the 32-bit "bi_size" overflowed, which is one of the
> things that bio_full() checks for.
> 
> However.
> 
> Looking at the *users* of bio_full(), it's not obvious that everything
> is ok. For example, in __bio_add_pc_page(), the code does that
> 
>          if (((bio->bi_iter.bi_size + len) >> 9) > queue_max_hw_sectors(q))
>                  return 0;
> 
> *before* checking for the overflow condition.
> 
> So it could cause that bio_try_merge_pc_page() to be done despite the
> overflow, and happily that path ends up having the bio_full() test
> later anyway, but it does look a bit worrisome.
> 
> There's also __bio_add_page(), which does have a WARN_ON_ONCE(), but
> then goes on and does the bi_size update regardless. Hmm.. It does
> look like all callers either check bio_full() before, or do it with a
> newly allocated bio.

We'll go over these asap. As a note, the 'pc' variants are not for
normal file system IO, they are only for requests submitted through some
sort of packet command, generally ioctls and such. Should of course be
correct, but it's not as critical as the normal IO path.

-- 
Jens Axboe

