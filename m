Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ED3C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 02:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5503D206BB
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 02:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbfAICqi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:46:38 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43655 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfAICqi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 21:46:38 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so2612622pgk.10
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 18:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eFvxdBpJbxxAEHSLor6Tt7ib7ckYg/RORv+ZVefTcxQ=;
        b=ZoOmYwDu0M8QQ0ioCyyOPcz/APKbAZY/HRkEX7rDXPp3JkkgVQ0wLPxk3SK4KIR4en
         GF/woVFIlXz+PQy3/EmMg/zSMQUXY6wrNXQW5jwVESjm/veT/f2MHpjM/wF8JIUnnntD
         oE180Pxi3fDg8zPGcR7FkKR/of1X+XaT+0pjtc64ROPKhUnl5AytkqhvlvSzwZ+keSBY
         Bwg2hWoLPw/0pSEpB+MC9R7JLF6+mVG6u3L5pB4AWIprRuF7WjLpKKHDR+ypHIArHt+C
         3UepI+nMmBNrT1hlIFf+mRsouoKUsVyEqr3wPZ05ZXgokE/hzXqwy+DLc1/BP8DhmJPf
         SsDw==
X-Gm-Message-State: AJcUuken3lkJkiWHke8uK3BO4+SwqTc5xd9Wb9Gzf5dY1nu7T2Bjs0cb
        w8fjLr4AQSeMwmqIz9SsRPNNwLaF
X-Google-Smtp-Source: ALg8bN6aQOS62rwMxuc2v/zd9zMOp1a9ilM+KlgCXm2NZr5Ff0AKfFR0r9R4iNumlY3wKDPCtIGldw==
X-Received: by 2002:a62:c683:: with SMTP id x3mr4163668pfk.10.1547001997781;
        Tue, 08 Jan 2019 18:46:37 -0800 (PST)
Received: from asus.site (c-73-222-28-29.hsd1.ca.comcast.net. [73.222.28.29])
        by smtp.gmail.com with ESMTPSA id h19sm91125010pfn.114.2019.01.08.18.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 18:46:36 -0800 (PST)
Subject: Re: [PATCH blktests] src/sg/syzkaller1.c: fix portability problem for
 syscall(__NR_mmap, ...)
To:     Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org
References: <20190107211316.17578-1-tytso@mit.edu>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5423ce34-1d3c-2363-da4e-fe35b02c988b@acm.org>
Date:   Tue, 8 Jan 2019 18:46:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190107211316.17578-1-tytso@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/7/19 1:13 PM, Theodore Ts'o wrote:
> How mmap is mapped to a raw system call varies across different
> archiecture.  On some architectures (such as 32-bit ARM), __NR_mmap
   ^^^^^^^^^^^
   architectures?
> may not exist at all; glibc will use __NR_mmap2 to implement mmap(2).
> Syzkaller is using mmap() as a non-portable version of malloc(3), so
> it should be safe to use the glibc's mmap wrapper instead of trying to
> directly call the system call.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>   src/sg/syzkaller1.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/src/sg/syzkaller1.c b/src/sg/syzkaller1.c
> index 743859a..e254d4a 100644
> --- a/src/sg/syzkaller1.c
> +++ b/src/sg/syzkaller1.c
> @@ -401,8 +401,10 @@ long r[15];
>   void test()
>   {
>     memset(r, -1, sizeof(r));
> -  r[0] = execute_syscall(__NR_mmap, 0x20000000ul, 0x5000ul, 0x3ul,
> -                         0x32ul, (uintptr_t)(-1ul), 0x0ul, 0, 0, 0);
> +//r[0] = execute_syscall(__NR_mmap, 0x20000000ul, 0x5000ul, 0x3ul,
> +//                       0x32ul, (uintptr_t)(-1ul), 0x0ul, 0, 0, 0);
> +  r[0] = (long) mmap((void *) 0x20000000, (size_t) 0x5000,
> +                     PROT_READ | PROT_WRITE, MAP_FIXED | MAP_ANONYMOUS, -1, 0);
>     NONFAILING(memcpy((void*)0x20000000,
>                       dev_sg, strlen(dev_sg)));
>     r[2] = execute_syscall(__NR_syz_open_dev, 0x20000000ul, 0x0ul, 0x2ul,

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
