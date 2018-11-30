Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EF4C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 01:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5C72082F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 01:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5C72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeK3MXY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:23:24 -0500
Received: from smtpbgsg2.qq.com ([54.254.200.128]:39015 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeK3MXX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 07:23:23 -0500
X-QQ-mid: bizesmtp14t1543540546t8qrugfp
Received: from [127.0.0.1] (unknown [210.22.22.130])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 30 Nov 2018 09:15:44 +0800 (CST)
X-QQ-SSF: 00400000002000F0FL51B00A0000000
X-QQ-FEAT: 5t7Y1p3pIzE5PSgnrySUiCT17YKQtZJHdGZrevJqNZ4G+n8QithuqADNJiZ6V
        bbBa4lTt21gERcUhgCsYMi7TX1Q7DRgPeYcX8eDi+U1E3SQmwoKBRDiY9J8E7DtnVUp1798
        xyKHSNfPoZBNO1f99Z/43PSumyJBfuvldSCUHa9E1Ucmu51K5CUdC/owrpsUbfVEmpHlTsd
        SuyHJfUgH0tUnhJPS5XEHmwslU1jIdijpwQDmGevqsbWtNYVgLmMPNpptlbhiiELD1UaKEB
        yZ+A/1vpNXTZaKViV5VosaIG3tqMwQvjF+Lpg2xhGRnnT5
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH v3 2/2] arm64: crypto: add NEON accelerated XOR
 implementation
From:   JackieLiu <liuyun01@kylinos.cn>
In-Reply-To: <20181129182040.GR3505@e103592.cambridge.arm.com>
Date:   Fri, 30 Nov 2018 09:15:44 +0800
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-block@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D0DE560B-476F-4E86-A60D-76F6D5CC2207@kylinos.cn>
References: <20181127100858.6995-1-liuyun01@kylinos.cn>
 <20181127100858.6995-2-liuyun01@kylinos.cn>
 <20181129170048.GQ3505@e103592.cambridge.arm.com>
 <CAKv+Gu-rm6uygi7+_=ssJ7UK-RgYgGNVyiTQ4O9zkN3JoYEB7g@mail.gmail.com>
 <20181129182040.GR3505@e103592.cambridge.arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
X-Mailer: Apple Mail (2.3445.101.1)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> 在 2018年11月30日，02:20，Dave Martin <Dave.Martin@arm.com> 写道：
> 
> On Thu, Nov 29, 2018 at 07:09:10PM +0100, Ard Biesheuvel wrote:
>> On Thu, 29 Nov 2018 at 18:00, Dave Martin <Dave.Martin@arm.com> wrote:
>>> 
>>> On Tue, Nov 27, 2018 at 06:08:58PM +0800, Jackie Liu wrote:
> 
> [...]
> 
>>>> +static struct xor_block_template xor_block_arm64 = {
>>>> +     .name   = "arm64_neon",
>>>> +     .do_2   = xor_neon_2,
>>>> +     .do_3   = xor_neon_3,
>>>> +     .do_4   = xor_neon_4,
>>>> +     .do_5   = xor_neon_5
>>>> +};
>>>> +#undef XOR_TRY_TEMPLATES
>>>> +#define XOR_TRY_TEMPLATES           \
>>>> +     do {        \
>>>> +             xor_speed(&xor_block_8regs);    \
>>>> +             xor_speed(&xor_block_32regs);    \
>>>> +             if (cpu_has_neon()) { \
>>>> +                     xor_speed(&xor_block_arm64);\
>>>> +             } \
>>>> +     } while (0)
>>> 
>>> Should there be a may_use_simd() check somewhere?
>>> 
>>> If we invoke this in a softirq I don't see what prevents us from
>>> corrupting the task's NEON state.
>>> 
>>> (The check might be in some surrounding glue code that I missed...)
>>> 
>> 
>> There is no check. This code should simply not be called from
>> non-process context, same as the RAID56 code.
>> 
>> This is not terribly robust, obviously, but appears to be common
>> practice in this realm of the kernel.
> 
> Fair enough -- I was just curious.
> 
> If this goes wrong, we should get a clear splat in kernel_neon_begin()
> anyway.  I'd be more concerned if we could just end up scribbling over
> the NEON state silently.
> 
> Cheers
> —Dave

I checked the code of xor.h for other architectures. except the arm32 
platform has interrupt judgment, and the others are kept simple.

In fact, the xor algorithm is currently only available to RAID456 (maybe?),
I hope it can be simple enough.




