Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC35C83003
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 03:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D292073E
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 03:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgD3DIG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:08:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44490 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgD3DIG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 23:08:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id p25so2183050pfn.11
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 20:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4jqxbsQu+SNrxeRmej5Y5nbV3BRRtE8+iFOP7TubHOQ=;
        b=thgQIgKpUbX4XuK4lJTyr/sdU9h4xTNEfUlM9rbf4JP3dAosuuDYkCcxlQ8zMcXcws
         XPd155vDZasOs/yxjVV1LKlvJhxCuRcp43OPfcnVK3RF8L/3+asS3czNk4A7cO5m8rXf
         vFxohEjtyrI8NPnNl9JYUaX6nog+locafSTjeehSj7ccjJhBj2OTB6X/zLR1Qmi021pB
         mpbtS+rE6yh+ncCbUw4oOI4g45rB2641j2m3ZOI8SAlee30RC0ez+lhJjmRhhvHNUDJK
         6gaaqEYiQU8+s4XsIGGVIhGt2RVYQ1d0SFNMfdd7o3fX3ZM5GZu5CTL/1WQUfC4RY03r
         eEiQ==
X-Gm-Message-State: AGi0PubU7CjNOsdkPYGtRQTeW6KAxdf5sagb4KPDlWvtLzx8VQUXio2T
        253Vnb60JsU5wnxqJpzbibs=
X-Google-Smtp-Source: APiQypKnqyIC6/qwBef7xpv00d4IlKQipv2sS52IlcMjnYcNpok0Hyd1jhzo1jekpkSBkAAC26rYqA==
X-Received: by 2002:a62:e213:: with SMTP id a19mr1365969pfi.180.1588216085708;
        Wed, 29 Apr 2020 20:08:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:59b8:8c44:587f:7518? ([2601:647:4000:d7:59b8:8c44:587f:7518])
        by smtp.gmail.com with ESMTPSA id r17sm1997379pgn.35.2020.04.29.20.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 20:08:04 -0700 (PDT)
Subject: Re: [PATCH 1/2] block: add blk_default_io_timeout() for avoiding task
 hung in sync IO
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200428074657.645441-1-ming.lei@redhat.com>
 <20200428074657.645441-2-ming.lei@redhat.com>
 <7e339c3d-8600-4a9b-99bf-24afb023c4dd@acm.org> <20200429011728.GA671522@T590>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <61520b08-326d-036b-e69d-08e2cad4d3c8@acm.org>
Date:   Wed, 29 Apr 2020 20:08:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429011728.GA671522@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-04-28 18:17, Ming Lei wrote:
> On Tue, Apr 28, 2020 at 07:19:33AM -0700, Bart Van Assche wrote:
>> On 2020-04-28 00:46, Ming Lei wrote:
>>> +/*
>>> + * Used in sync IO for avoiding to triger task hung warning, which may
>>> + * cause system panic or reboot.
>>> + */
>>> +static inline unsigned long blk_default_io_timeout(void)
>>> +{
>>> +	return sysctl_hung_task_timeout_secs * (HZ / 2);
>>> +}
>>> +
>>>  #endif
>>
>> This function is only used inside the block layer. Has it been
>> considered to move this function from the public block layer API into a
>> private header file, e.g. block/blk.h?
> 
> Please look at the commit log or the 2nd patch, and the helper will be
> used in 2nd patch in dio code.

Has it been considered to use the expression
"sysctl_hung_task_timeout_secs * (HZ / 2)" directly instead of wrapping
that expression in a function? I think using the expression directly may
be more clear. Additionally, it is slightly confusing that the function
name starts with "blk_" but that nothing in the implementation of that
function is specific to the block layer.

Thanks,

Bart.
