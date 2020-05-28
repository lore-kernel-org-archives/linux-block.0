Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D760AC433E1
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 03:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13C920721
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 03:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgE1Ddy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 23:33:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42571 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgE1Ddx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 23:33:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id x11so9970034plv.9
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 20:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=F3hElMYfsazVztMw014WUWigCqq3LqLUl3ZDXLMtgZg=;
        b=HYqZiQkhtczU3Bzu5yZ3/36FNzl94MeA6ts3NgIUYprDSq4y9RpwMX1sWqghaOgTRW
         aKZpowD+JccZQ+T/N0wBWhkJxm4kcIyeCH7RQdhqXkE22J5z5Bc1977wrLKblTh/isql
         DxNSxObfMBI3dJ+uq681yc1qKoLt7hmTfAPAZTp6O4wY/EVptt8NDpgwnHpXcVtR1Ua7
         JUGmiiaiQkWIrLOusjo7cPe1WGnDWW4d+ltKpF5Z4EnyRg/YvNVASrueoETaB2mMAyNc
         XqMVzvUFPNvifU3I/DEXbUka5pA71/w3auT0k1ksUOotDbs218mMP7avcr9S7DR1WkeD
         +q5g==
X-Gm-Message-State: AOAM531BGgYvX3rJUZPyOWQX6cxj0395FQX5fGYzec8byqq9ZOdFM0Yq
        s+E0GfbE4m9jfkShc7wPsOA=
X-Google-Smtp-Source: ABdhPJwUbai5BjhKZfBbKYXfRkv5Uy2NnB1vDYaUwN26BkCC/5A/YbPUdJmy9Ng1yEqUnTomVnSdJA==
X-Received: by 2002:a17:90b:113:: with SMTP id p19mr1637027pjz.129.1590636831672;
        Wed, 27 May 2020 20:33:51 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id gg8sm3822183pjb.39.2020.05.27.20.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 20:33:50 -0700 (PDT)
Subject: Re: [PATCH 8/8] blk-mq: drain I/O when all CPUs in a hctx are offline
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-9-hch@lst.de>
 <7acc7ab5-02f9-e6ee-e95f-175bc0df9cbc@acm.org> <20200528014601.GC933147@T590>
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
Message-ID: <1ec7922c-f2b0-08ec-5849-f4eb7f71e9e7@acm.org>
Date:   Wed, 27 May 2020 20:33:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528014601.GC933147@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-27 18:46, Ming Lei wrote:
> On Wed, May 27, 2020 at 04:09:19PM -0700, Bart Van Assche wrote:
>> On 2020-05-27 11:06, Christoph Hellwig wrote:
>>> --- a/block/blk-mq-tag.c
>>> +++ b/block/blk-mq-tag.c
>>> @@ -180,6 +180,14 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>>>  	sbitmap_finish_wait(bt, ws, &wait);
>>>  
>>>  found_tag:
>>> +	/*
>>> +	 * Give up this allocation if the hctx is inactive.  The caller will
>>> +	 * retry on an active hctx.
>>> +	 */
>>> +	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state))) {
>>> +		blk_mq_put_tag(tags, data->ctx, tag + tag_offset);
>>> +		return -1;
>>> +	}
>>>  	return tag + tag_offset;
>>>  }
>>
>> The code that has been added in blk_mq_hctx_notify_offline() will only
>> work correctly if blk_mq_get_tag() tests BLK_MQ_S_INACTIVE after the
>> store instructions involved in the tag allocation happened. Does this
>> mean that a memory barrier should be added in the above function before
>> the test_bit() call?
> 
> Please see comment in blk_mq_hctx_notify_offline():
> 
> +       /*
> +        * Prevent new request from being allocated on the current hctx.
> +        *
> +        * The smp_mb__after_atomic() Pairs with the implied barrier in
> +        * test_and_set_bit_lock in sbitmap_get().  Ensures the inactive flag is
> +        * seen once we return from the tag allocator.
> +        */
> +       set_bit(BLK_MQ_S_INACTIVE, &hctx->state);

From Documentation/atomic_bitops.txt: "Except for a successful
test_and_set_bit_lock() which has ACQUIRE semantics and
clear_bit_unlock() which has RELEASE semantics."

My understanding is that operations that have acquire semantics pair
with operations that have release semantics. I haven't been able to find
any documentation that shows that smp_mb__after_atomic() has release
semantics. So I looked up its definition. This is what I found:

$ git grep -nH 'define __smp_mb__after_atomic'
arch/ia64/include/asm/barrier.h:49:#define __smp_mb__after_atomic()
barrier()
arch/mips/include/asm/barrier.h:133:#define __smp_mb__after_atomic()
smp_llsc_mb()
arch/s390/include/asm/barrier.h:50:#define __smp_mb__after_atomic()
barrier()
arch/sparc/include/asm/barrier_64.h:57:#define __smp_mb__after_atomic()
barrier()
arch/x86/include/asm/barrier.h:83:#define __smp_mb__after_atomic()	do {
} while (0)
arch/xtensa/include/asm/barrier.h:20:#define __smp_mb__after_atomic()	
barrier()
include/asm-generic/barrier.h:116:#define __smp_mb__after_atomic()
__smp_mb()

My interpretation of the above is that not all smp_mb__after_atomic()
implementations have release semantics. Do you agree with this conclusion?

Thanks,

Bart.
