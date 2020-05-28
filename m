Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB88C433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 13:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33DA206F1
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 13:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390346AbgE1Nhy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 09:37:54 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52754 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390335AbgE1Nhx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 09:37:53 -0400
Received: by mail-pj1-f65.google.com with SMTP id k2so2158671pjs.2;
        Thu, 28 May 2020 06:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aQV6CwzBmrGEG9swVeTMKCGFEpgz2wMm2rS1osfawFM=;
        b=cGBx+XTqBjKIxvGgXRlu4pU6MxZhNgIj6DEqrEeCsmj/BSUKxYVbYFgQYbbXVQnfvU
         kV57NK8u2Q9lJruYXY+uCuKjcuavhrBidVuWdYB3AkGvK+Nkuu/smqT+JG3GiGR4VRl5
         Iz06gFbZmoYLaccKtKMW/cTfjkYj8lHzKnRSa1GDUU2GPCnbalHyDi3W+AVpIruwvhiv
         ub9tN7k66qFBMAcvg4Rp5WHXJo4/SOwyVxmJd8Pm6JrVd0HU2ERC2EA3HU0ekh4DdOr+
         QCzmFLn6LkAYT1WQf+gp+xH84pywAXiCMwQKhbf19Li3antdrWGLeBVKiRNZ4wHhM5wG
         g4oQ==
X-Gm-Message-State: AOAM533EmcLJbrgjLsOU3vyg2sRuDhAIfreQWV8WqMZCXDdnQ7IsYZG2
        y9uKDpDj7XpPzIT9B6Er6fgx2vM1
X-Google-Smtp-Source: ABdhPJyMiGo8X9zkrNeqAFY9ccqWKXXAfJwLN1ebTGmlMDcp/57AU842L36nZGoT78lP0k6aDjFkIw==
X-Received: by 2002:a17:90a:4811:: with SMTP id a17mr3822782pjh.130.1590673070454;
        Thu, 28 May 2020 06:37:50 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:40e6:aa88:9c03:e0b4? ([2601:647:4000:d7:40e6:aa88:9c03:e0b4])
        by smtp.gmail.com with ESMTPSA id j13sm4829574pfe.48.2020.05.28.06.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 06:37:49 -0700 (PDT)
Subject: Re: [PATCH 8/8] blk-mq: drain I/O when all CPUs in a hctx are offline
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-9-hch@lst.de>
 <7acc7ab5-02f9-e6ee-e95f-175bc0df9cbc@acm.org> <20200528014601.GC933147@T590>
 <1ec7922c-f2b0-08ec-5849-f4eb7f71e9e7@acm.org>
 <20200528051932.GA1008129@T590>
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
Message-ID: <4fb6f0cf-a356-833e-25ab-47f9131c729b@acm.org>
Date:   Thu, 28 May 2020 06:37:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528051932.GA1008129@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-27 22:19, Ming Lei wrote:
> On Wed, May 27, 2020 at 08:33:48PM -0700, Bart Van Assche wrote:
>> My understanding is that operations that have acquire semantics pair
>> with operations that have release semantics. I haven't been able to find
>> any documentation that shows that smp_mb__after_atomic() has release
>> semantics. So I looked up its definition. This is what I found:
>>
>> $ git grep -nH 'define __smp_mb__after_atomic'
>> arch/ia64/include/asm/barrier.h:49:#define __smp_mb__after_atomic()
>> barrier()
>> arch/mips/include/asm/barrier.h:133:#define __smp_mb__after_atomic()
>> smp_llsc_mb()
>> arch/s390/include/asm/barrier.h:50:#define __smp_mb__after_atomic()
>> barrier()
>> arch/sparc/include/asm/barrier_64.h:57:#define __smp_mb__after_atomic()
>> barrier()
>> arch/x86/include/asm/barrier.h:83:#define __smp_mb__after_atomic()	do {
>> } while (0)
>> arch/xtensa/include/asm/barrier.h:20:#define __smp_mb__after_atomic()	
>> barrier()
>> include/asm-generic/barrier.h:116:#define __smp_mb__after_atomic()
>> __smp_mb()
>>
>> My interpretation of the above is that not all smp_mb__after_atomic()
>> implementations have release semantics. Do you agree with this conclusion?
> 
> I understand smp_mb__after_atomic() orders set_bit(BLK_MQ_S_INACTIVE)
> and reading the tag bit which is done in blk_mq_all_tag_iter().
> 
> So the two pair of OPs are ordered:
> 
> 1) if one request(tag bit) is allocated before setting BLK_MQ_S_INACTIVE,
> the tag bit will be observed in blk_mq_all_tag_iter() from blk_mq_hctx_has_requests(),
> so the request will be drained.
> 
> OR
> 
> 2) if one request(tag bit) is allocated after setting BLK_MQ_S_INACTIVE,
> the request(tag bit) will be released and retried on another CPU
> finally, see __blk_mq_alloc_request().
> 
> Cc Paul and linux-kernel list.

I do not agree with the above conclusion. My understanding of
acquire/release labels is that if the following holds:
(1) A store operation that stores the value V into memory location M has
a release label.
(2) A load operation that reads memory location M has an acquire label.
(3) The load operation (2) retrieves the value V that was stored by (1).

that the following ordering property holds: all load and store
instructions that happened before the store instruction (1) in program
order are guaranteed to happen before the load and store instructions
that follow (2) in program order.

In the ARM manual these semantics have been described as follows: "A
Store-Release instruction is multicopy atomic when observed with a
Load-Acquire instruction".

In this case the load-acquire operation is the
"test_and_set_bit_lock(nr, word)" statement from the sbitmap code. That
code is executed indirectly by blk_mq_get_tag(). Since there is no
matching store-release instruction in __blk_mq_alloc_request() for
'word', ordering of the &data->hctx->state and 'tag' memory locations is
not guaranteed by the acquire property of the "test_and_set_bit_lock(nr,
word)" statement from the sbitmap code.

Thanks,

Bart.
