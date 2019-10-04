Return-Path: <SRS0=jhC6=X5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A44BC47404
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 16:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCBA20873
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 16:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uBdKamW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390173AbfJDQLo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:11:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34056 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389835AbfJDQLo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Oct 2019 12:11:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id k7so3355747pll.1
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2019 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DwKt3G7QXVq3aQfAzuC1kpV5tmL9eFpQI9C/ij8Q1qg=;
        b=uBdKamW0AVrjJRNTlZlG0RZnLUqElgqB1SpYGy6HUOvWz0Q61voHrgwceiW4GRjvFM
         Rk4BmW2NfGM+se0KLobrBS6tLkATtcPTrZqWIq7AQK/SzZjKVsA8xdCipMXYRcANEWk9
         6pm7HJEaFGnsCLh0xBLOA/abrArR173I+S+60lSNHZfKtL5D02FSfxnEQiXMoXSqGkEC
         wHlI7kAdG6E0z20cwwb/n+QpfVU37FpqMl+N8w/OIlh19b3sN54UvtHMFpAfHz06IN5b
         fnA115y5VNDJIoh0vSuyofLx4j3ynuCfiBioiFd+UYvoxnu8hKZO/8D2SYYJQUUralZa
         72lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DwKt3G7QXVq3aQfAzuC1kpV5tmL9eFpQI9C/ij8Q1qg=;
        b=KaID9E85PW4bl+ftKd2El3UTLwbJKjUMNXRmbSK0GTqtPiGyLn6mTVRGB0p7dfmG2u
         mhMEmVfgmVGurk4TBmgTzS9J/V/XE5f1kR7RO68CBpmr0cgAvJLgMDGcxoMhQ45cmhyc
         UB5n1TRkT4/Q0IngTNBywSh/1acaaCr1M5oa5q1wHpUTl5yAlAEFCFzCD1vDIO8TSKNw
         3kp8b5wuDLkYitTdGmZx8eRMGB7R83JgJtcMTtf4JoQBQpZvJRIQHLIy5v0gmC8JhxkL
         RjK9CnZz+/smxE5DVR/Dqe1baXdOyqcZrdi49EcS/CraHAv5DhlO5bLOW8DiJcnO+NmE
         CHew==
X-Gm-Message-State: APjAAAXvydTdVGXIUyBDmNQ2+2GnRaKpqSYA5MBg6bsHmARkLxgeIbAJ
        BaYMQWHWfQ+VxB8u+5AkDUHRF4TE9z4=
X-Google-Smtp-Source: APXvYqzTSrOmvCIIdDyU9rueuEEgqridGmx5xwtKL5wRf7zmBKf9sixhZZMJcE8iWMCVgp/V8Vg/Tg==
X-Received: by 2002:a17:902:5983:: with SMTP id p3mr16283379pli.156.1570205501478;
        Fri, 04 Oct 2019 09:11:41 -0700 (PDT)
Received: from ?IPv6:2600:380:7548:69cb:e476:ab55:1c76:9921? ([2600:380:7548:69cb:e476:ab55:1c76:9921])
        by smtp.gmail.com with ESMTPSA id z4sm5756188pjt.17.2019.10.04.09.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 09:11:40 -0700 (PDT)
Subject: Re: [PATCH] io_uring: add support for IORING_REGISTER_FILES_UPDATE
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <a7bc8d7f-2379-7492-93af-6ca0353c5eab@kernel.dk>
 <x49d0fcmsn8.fsf@segfault.boston.devel.redhat.com>
 <bbf022a4-9091-1e65-8516-aab39942e958@kernel.dk>
 <x498sq0mram.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fa43a684-77e7-7f4f-6fce-8fe1b0df6455@kernel.dk>
Date:   Fri, 4 Oct 2019 10:11:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <x498sq0mram.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/4/19 10:03 AM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 10/4/19 9:34 AM, Jeff Moyer wrote:
>>> If I'm reading this (and the code) right, that means you can't add files
>>> to a set.  Wouldn't that be a useful thing to do, instead of just
>>> replacing existing ones?
>>
>> You can add files to a set, you just can't grow a set beyond the size
>> you originally registered. I actually forgot to post the pre-patch for
>> this, which is:
>>
>> http://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring&id=fb3e60f87aa43f4f047f01243d6be54dadd9d67a
>>
>> This allows registering -1 as the fd, so you could register 10 files,
>> but an array of size 500 (for example), and the last 490 fds are just
>> -1. Then you can use the IORING_REGISTER_FILES_UPDATE to replace those
>> empty fds with real files later on.
> 
> That makes more sense, but still requires a priori knowledge of how many
> files you'll need to work with, otherwise you're back to
> unregister/register dance.  Is it really that hard to grow on demand?

It's not, it's just more efficient to add a file through replace, than it
is to alloc a new array, copy things over, free it. That also impacts the
application side of things, since that has to maintain an array of
descriptors so that it knows what fd maps to what index.

If you expose growing, you also have some kind of obligation to make it
efficient, and I just don't think that's possible. But there's nothing
preventing this API from supporting it, you'd just do an update with
offset == current_array_size, and then nr_args as what to grow with.
Currently that would -EINVAL, but it could be added as a feature.

-- 
Jens Axboe

