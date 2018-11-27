Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F0BC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 10:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36A420873
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 10:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36A420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbeK0U7h convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:59:37 -0500
Received: from smtpbg202.qq.com ([184.105.206.29]:49817 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeK0U7h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 15:59:37 -0500
X-QQ-mid: bizesmtp22t1543312912t8b6qqls
Received: from [127.0.0.1] (unknown [210.22.22.130])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 27 Nov 2018 18:01:41 +0800 (CST)
X-QQ-SSF: 00400000002000F0FK51000C0000000
X-QQ-FEAT: 9MsTBLS6yXGyE53cehL7fPLn4YLQ5KsiV8cevJQICX/xH0AIbgDPjW4LeX6x+
        mFkhGMhWmjbyqCU25aIhdcnSZcfJIJIYq0fZ2EFjNjaVxC9bZN7GKbRJJ2sGd5Rx3oOrfvj
        OA5zQmSiJkQ5mnkTidQrQ56XbteH6EZwee2QGfqwY035AtljNd8H7m2BygNRj4Gblbk3Fo3
        JWXc937IAWBEQEf3Uedlmi/wtujaesUUMmhMvrLBLllJ5dEiLBHa7i2/m7IyML/Aha+gqL5
        l7nyFc9cpVwE/pbE5SwMGQFyifYYSrjr7kgfatatu6N9RsKWyecDSwgmw=
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH v2 1/2] arm64: add workaround for ambiguous C99 stdint.h
 types
From:   JackieLiu <liuyun01@kylinos.cn>
In-Reply-To: <CAKv+Gu9TEZ9j3xB9dM_tP9tenzoH+p6Y7-1KCKGEL7AkiVdRdw@mail.gmail.com>
Date:   Tue, 27 Nov 2018 18:01:40 +0800
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-block@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <36D96063-1722-4231-9810-CFAE6368616A@kylinos.cn>
References: <20181127052701.4144-1-liuyun01@kylinos.cn>
 <CAKv+Gu9TEZ9j3xB9dM_tP9tenzoH+p6Y7-1KCKGEL7AkiVdRdw@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: Apple Mail (2.3445.101.1)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yep, you are right. I will change code later.

But now, I found an new problem, when build the kernel, 
I got follow message:

WARNING: EXPORT symbol "xor_block_inner_neon" [arch/arm64/lib/xor-neon.ko] 
version generation failed, symbol will not be versioned.

I don’t know why, do you have any idea?

> 在 2018年11月27日，16:17，Ard Biesheuvel <ard.biesheuvel@linaro.org> 写道：
> 
> On Tue, 27 Nov 2018 at 06:28, Jackie Liu <liuyun01@kylinos.cn> wrote:
>> 
>> In a way similar to ARM commit 09096f6a0ee2 ("ARM: 7822/1: add workaround
>> for ambiguous C99 stdint.h types"), this patch redefines the macros that
>> are used in stdint.h so its definitions of uint64_t and int64_t are
>> compatible with those of the kernel.
>> 
>> This patch comes from: https://patchwork.kernel.org/patch/3540001/
>> Wrote by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> 
> 
> OK, I remember now :-)
> 
> So this is the reason you had two separate source files in the
> previous revision.
> 
> Could we maybe deal with this differently? Could we add a header
> 
> arch/arm64/include/asm/neon-intrinsics.h
> 
> that includes <arm_neon.h> after setting the preprocessor overrides
> below? And reference that header from your code?
> 
> That way, we don't have to override asm/types.h for everyone.
> 
> 
> 
>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>> ---
>> arch/arm64/include/uapi/asm/types.h | 26 ++++++++++++++++++++++++++
>> 1 file changed, 26 insertions(+)
>> create mode 100644 arch/arm64/include/uapi/asm/types.h
>> 
>> diff --git a/arch/arm64/include/uapi/asm/types.h b/arch/arm64/include/uapi/asm/types.h
>> new file mode 100644
>> index 0000000..0016780
>> --- /dev/null
>> +++ b/arch/arm64/include/uapi/asm/types.h
>> @@ -0,0 +1,26 @@
>> +#ifndef _UAPI_ASM_TYPES_H
>> +#define _UAPI_ASM_TYPES_H
>> +
>> +#include <asm-generic/int-ll64.h>
>> +
>> +/*
>> + * For Aarch64, there is some ambiguity in the definition of the types below
>> + * between the kernel and GCC itself. This is usually not a big deal, but it
>> + * causes trouble when including GCC's version of 'stdint.h' (this is the file
>> + * that gets included when you #include <stdint.h> on a -ffreestanding build).
>> + * As this file also gets included implicitly when including 'arm_neon.h' (the
>> + * NEON intrinsics support header), we need the following to work around the
>> + * issue if we want to use NEON intrinsics in the kernel.
>> + */
>> +
>> +#ifdef __INT64_TYPE__
>> +#undef __INT64_TYPE__
>> +#define __INT64_TYPE__         __signed__ long long
>> +#endif
>> +
>> +#ifdef __UINT64_TYPE__
>> +#undef __UINT64_TYPE__
>> +#define __UINT64_TYPE__                unsigned long long
>> +#endif
>> +
>> +#endif /* _UAPI_ASM_TYPES_H */
>> --
>> 2.7.4
>> 
>> 
>> 
>> 
> 



