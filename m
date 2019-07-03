Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B8EC0650E
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 09:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF5621882
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 09:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfGCJta (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:49:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:48768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbfGCJt3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Jul 2019 05:49:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF7D6AFAE;
        Wed,  3 Jul 2019 09:49:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 03 Jul 2019 11:49:27 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH liburing 2/2] Fix the use of memory barriers
In-Reply-To: <0bffbfd9-a57e-857f-4699-856295a11f3a@acm.org>
References: <20190701214232.29338-1-bvanassche@acm.org>
 <20190701214232.29338-3-bvanassche@acm.org>
 <5d5931e08e338a8a8edb1e58a33a120e@suse.de>
 <876fa5e3-f050-b95c-a30c-755d1e0430d1@acm.org>
 <723180510314b2928ba97752e5383202@suse.de>
 <0bffbfd9-a57e-857f-4699-856295a11f3a@acm.org>
Message-ID: <2cd14f5d8cfcc36dec90574ff8a9e8b5@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-07-02 22:31, Bart Van Assche wrote:
> On 7/2/19 11:40 AM, Roman Penyaev wrote:
>> On 2019-07-02 18:17, Bart Van Assche wrote:
>>> On 7/2/19 2:07 AM, Roman Penyaev wrote:
>>>> Hi Bart,
>>>> 
>>>> On 2019-07-01 23:42, Bart Van Assche wrote:
>>>> 
>>>> ...
>>>> 
>>>>> +#if defined(__x86_64__)
>>>>> +#define smp_store_release(p, v)            \
>>>>> +do {                        \
>>>>> +    barrier();                \
>>>>> +    WRITE_ONCE(*(p), (v));            \
>>>>> +} while (0)
>>>>> +
>>>>> +#define smp_load_acquire(p)            \
>>>>> +({                        \
>>>>> +    typeof(*p) ___p1 = READ_ONCE(*(p));    \
>>>>> +    barrier();                \
>>>>> +    ___p1;                    \
>>>>> +})
>>>> 
>>>> Can we have these two macros for x86_32 as well?
>>>> For i386 it will take another branch with full mb,
>>>> which is not needed.
>>>> 
>>>> Besides that both patches looks good to me.
>>> 
>>> Hi Roman,
>>> 
>>> Thanks for having taken a look. From Linux kernel source file
>>> arch/x86/include/asm/barrier.h:
>>> 
>>> #ifdef CONFIG_X86_32
>>> #define mb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)",\
>>>         "mfence", X86_FEATURE_XMM2) ::: "memory", "cc")
>>> #define rmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)",\
>>>         "lfence", X86_FEATURE_XMM2) ::: "memory", "cc")
>>> #define wmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)",\
>>>         "sfence", X86_FEATURE_XMM2) ::: "memory", "cc")
>>> #else
>>> #define mb()     asm volatile("mfence":::"memory")
>>> #define rmb()    asm volatile("lfence":::"memory")
>>> #define wmb()    asm volatile("sfence" ::: "memory")
>>> #endif
>>> 
>>> In other words, I think that 32-bit and 64-bit systems really have to
>>> be treated in a different way.
>> 
>> I meant smp_load_acquire / smp_store_release
> 
> Hi Roman,
> 

Hi Bart,

It seems you took the chunk of the code with macros from
tools/arch/x86/include/asm/barrier.h, where indeed smp_store_release
and smp_load_acquire are defined only for x86-64.  If I am not mistaken
kernel defines both __smp_store_release / __smp_load_acquire equally
for x86 memory model in arch/x86/include/asm/barrier.h.

> Since there are 32-bit x86 CPUs that can reorder loads and stores

Only "loads may be reordered with earlier stores"
(Intel® 64 and IA-32 Architectures, section 8.2.3.4), but "stores are 
not
reordered with earlier loads" (section 8.2.3.3), so smp_store_release 
and
and smp_load_acquire can be relaxed.

--
Roman

