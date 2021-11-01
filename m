Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B540C433EF
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 16:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6220A61184
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 16:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhKAQnL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 12:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbhKAQmp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 12:42:45 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C185FC0432C5
        for <linux-block@vger.kernel.org>; Mon,  1 Nov 2021 09:36:27 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r194so22260251iod.7
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 09:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iw/AN/Q4GUbUCrWKPx9vacyXbhM+mVMikRdbUfeY4mo=;
        b=N9zsNguL/bf7ZwVYNYNgm7HAk7EwAy7LPqqgOzW4Uo5HozmExlieObiqGqh8vOw3Rj
         CaSA9F0e4DbplVnqbOx1cvDG7IYjyV5QcrzuKCAK3/8S9f7Of0ozEMjPpbsD0bVEiTLW
         KmwoYi7TdCJNPQadrIkQbRg3Q+DLny7l6vVJwDLBlV0n/7VMolk3bRvhDGkX217yAgPs
         fvHM5Ev6yK/9ytYRGEzoLEehzZc/eDXSUUZo7GcvP4DCPmTXpvC7S3Vv7btG04W5ep+r
         sLMJ+LokcJTjreT4kdDdSD86KIq5vmTQJvv1u9+/fN4Iw1eLkZ7HaS6z91FOOyqa+pg9
         a1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iw/AN/Q4GUbUCrWKPx9vacyXbhM+mVMikRdbUfeY4mo=;
        b=yDYIvis4JaJM5n/A+/RflUBpDTLHdGlexiraw/oxN+tmtd9ouaI+82Q8TvpvPXZrYG
         nm8Jc7lsyDu351OBeFZ9pitRBALbziVK+qWvlzyjDO0Z6aFBAog+0zT4yHUIVmWDsX4i
         saAyBBSxipn8Z/nGZELXLpjpcKMhOmPvNs8VCAjnyFrqkbB7CqR7lCX8UNh33AwD3ml7
         kqdOe3qVatiS68/sQ7ovUlsJtU+J/ZTNpClWzZYcq9l5LIcrh5trfvG1PFlukUJbVKHu
         zQb5PKzI1qe+kJpNDEpvkFr2YMoroLeIVoypNgw8AYBWpg1YZ+a7+N9mlXwgt7Xz2x9I
         t86g==
X-Gm-Message-State: AOAM531PgS7EfxfVg2T2smCeT2bvl0jJYp44aR6en1emzDfKbFBjCvyc
        CMPzZLPzu/enQWRXm7b+BRIW528sts2ZFw==
X-Google-Smtp-Source: ABdhPJz3EqGzcL3pma4c7SXDNSOSppifi7GtU/rs3gLFUuKAvK7Q2DnY2FgnUOGMWE6AcB1S/K3Yxg==
X-Received: by 2002:a05:6602:13d5:: with SMTP id o21mr3328351iov.191.1635784586954;
        Mon, 01 Nov 2021 09:36:26 -0700 (PDT)
Received: from [192.168.1.170] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b3sm8276643ilc.36.2021.11.01.09.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 09:36:26 -0700 (PDT)
Subject: Re: [GIT PULL] Block driver updates for 5.16-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <36d0a261-bd28-123d-5eb8-4003eac7fad7@kernel.dk>
 <CAHk-=wj2JmPuCie_paZAD4Kdk6d0bBs+U8CHxWHQy5e5Ex1=AA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7899d8b8-d61f-fce1-95f5-1dbc8135a8ba@kernel.dk>
Date:   Mon, 1 Nov 2021 10:36:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj2JmPuCie_paZAD4Kdk6d0bBs+U8CHxWHQy5e5Ex1=AA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/1/21 10:31 AM, Linus Torvalds wrote:
> On Sun, Oct 31, 2021 at 12:41 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> - paride driver cleanups (Christoph)
> 
> The mind boggles.
> 
> I've pulled it, but I did have a double-take at this. Anybody still
> actually _use_ that thing?

I was asking the same questions, pending answers on that. Because I'd
rather kill it if we can, but... We'll see.

-- 
Jens Axboe

