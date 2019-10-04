Return-Path: <SRS0=jhC6=X5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3052C4360C
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 16:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9618920873
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 16:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="i22h0MnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389835AbfJDQTb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:19:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36254 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389131AbfJDQTa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Oct 2019 12:19:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so4206381pfr.3
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2019 09:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2fNRwbVqv8PVG/TSgBbLCjgvm5lj/3A9OIIf0evoFRM=;
        b=i22h0MnBIwDiDNt9fnQ1Jmb3H19c1noNb+Pe4tLo5D7cLd7Up9PrPbeLska7xnlRO0
         qATNsbrnQ4NR0uSnU0MTpPWxvfFWhD+R52FhQsmhJgcRGpGknEsrrjoAxtroloJ5rh9y
         vyPJ2XS/hfKL2+S8UiEBhrQXoJijCTNodpo/CVrxfpl62X6HwIO+YrOF+G09fQeVKLIk
         DpvOF462hx659w3DBF7viKsGa3jugGjak5G3GvCBGdKGJNUyg5BZqX/QBDV3uD/yWy/L
         4RkD5seX9tmRnMSb6AUBRPZinP/+uOx4pnK+zkhWiCaK0LVrvEdrKm5vuWs77qTczDVr
         SEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2fNRwbVqv8PVG/TSgBbLCjgvm5lj/3A9OIIf0evoFRM=;
        b=sAlJK3Sea8U7IF2nkji+irEXlgJi0fs/aTlI3FcrNp6QJX+qQlOdSRlpPK/ecGo62X
         1nfE9FxKea8Tikk0m+Mthed2KbnHaSUc+LfAyN6sDlXfMTHSfc8OVU/MOA5mAQUOEz1S
         YOU1htvF3k6XdaorUPuH1Bg8R5Byb8V82FCq1bMEobSMb8QoptkeDKowHBK/ELAjrYOu
         YkauneAp5zxIoAV5QvFisNF2qzmPoxt5mUSWMF8OlL1ALtaOUthv5F8YYRKdEjftfld0
         ugC4WossVzYzdicxw1CwFJ9f5lKaqp/YScZJioTrauYDAdXXiv6q3NK8G0/7PPgdnNwn
         r6Xg==
X-Gm-Message-State: APjAAAU81ets2Bc+qaONPg05Ryz9pgJOTPXMGDD68m9u/G8KvdYYMmg8
        S2Eodpskwfa8HWiQCBsyVC7TlZC/DV1wJA==
X-Google-Smtp-Source: APXvYqxUDMhDeZdSgbxOURSHH5R6OFo9dUB2C6F7JhKSguN6q/e7QfOJ8/b4lqyMGe5aCVYjvZo5sQ==
X-Received: by 2002:a17:90a:ad81:: with SMTP id s1mr18177081pjq.27.1570205967889;
        Fri, 04 Oct 2019 09:19:27 -0700 (PDT)
Received: from ?IPv6:2600:380:7548:69cb:e476:ab55:1c76:9921? ([2600:380:7548:69cb:e476:ab55:1c76:9921])
        by smtp.gmail.com with ESMTPSA id l1sm6099835pja.30.2019.10.04.09.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 09:19:27 -0700 (PDT)
Subject: Re: [PATCH] io_uring: add support for IORING_REGISTER_FILES_UPDATE
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <a7bc8d7f-2379-7492-93af-6ca0353c5eab@kernel.dk>
 <x49d0fcmsn8.fsf@segfault.boston.devel.redhat.com>
 <bbf022a4-9091-1e65-8516-aab39942e958@kernel.dk>
 <x498sq0mram.fsf@segfault.boston.devel.redhat.com>
 <fa43a684-77e7-7f4f-6fce-8fe1b0df6455@kernel.dk>
 <x494l0omqnz.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6c64acf6-5c24-abd6-42b9-f56c1f928118@kernel.dk>
Date:   Fri, 4 Oct 2019 10:19:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <x494l0omqnz.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/4/19 10:17 AM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 10/4/19 10:03 AM, Jeff Moyer wrote:
>>> Jens Axboe <axboe@kernel.dk> writes:
>>>
>>>> On 10/4/19 9:34 AM, Jeff Moyer wrote:
>>>>> If I'm reading this (and the code) right, that means you can't add files
>>>>> to a set.  Wouldn't that be a useful thing to do, instead of just
>>>>> replacing existing ones?
>>>>
>>>> You can add files to a set, you just can't grow a set beyond the size
>>>> you originally registered. I actually forgot to post the pre-patch for
>>>> this, which is:
>>>>
>>>> http://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring&id=fb3e60f87aa43f4f047f01243d6be54dadd9d67a
>>>>
>>>> This allows registering -1 as the fd, so you could register 10 files,
>>>> but an array of size 500 (for example), and the last 490 fds are just
>>>> -1. Then you can use the IORING_REGISTER_FILES_UPDATE to replace those
>>>> empty fds with real files later on.
>>>
>>> That makes more sense, but still requires a priori knowledge of how many
>>> files you'll need to work with, otherwise you're back to
>>> unregister/register dance.  Is it really that hard to grow on demand?
>>
>> It's not, it's just more efficient to add a file through replace, than it
>> is to alloc a new array, copy things over, free it. That also impacts the
>> application side of things, since that has to maintain an array of
>> descriptors so that it knows what fd maps to what index.
> 
> Yeah, that's a good point about the application side.
> 
>> If you expose growing, you also have some kind of obligation to make it
>> efficient, and I just don't think that's possible. But there's nothing
>> preventing this API from supporting it, you'd just do an update with
>> offset == current_array_size, and then nr_args as what to grow with.
>> Currently that would -EINVAL, but it could be added as a feature.
> 
> OK, I'm fine with the API as-is.  If someone asks, growing can be added
> later.

Sounds good, thanks. I'll send out a v2 with the prep patch included.

-- 
Jens Axboe

