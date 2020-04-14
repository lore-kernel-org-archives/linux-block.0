Return-Path: <SRS0=NWvS=56=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41E8C2BA19
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 10:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B593720644
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 10:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438330AbgDNK3s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:29:48 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43691 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbgDNK3l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Apr 2020 06:29:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id h25so11854994lja.10;
        Tue, 14 Apr 2020 03:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mIqPfx4e4L3IGXAgqiGpZ+KDaVK6Sf0ZxBEGjobhNgg=;
        b=YkJDJtbAgra7v3UYjYVtYPOnf0CNMnHXI8XUkhZ+YIL+AmUhnpN2ikIv8tP1jiSNOB
         ilryebmTsJ5RBN8H40CZZ9bSFLmznuge0UieQwGllUvPIsZ6Ap9L8mSrEjoxs368v5+N
         Xv823xwnnQo0/4uQvY4yJFWQ5eVkYK3oD2kO4FN+VHQOeULktKDKA4OWJc/IcpJahcua
         ZqbINp7WeOuSc5yZya2QyBdAicTgBQBGw8gBE9+vpd9YkCt4WrfVci7TkyKBhIWU3nVI
         uNe/lkO3/dRTQzCKsOtPrrv/ZZeOXxJys91F65yYc/qnBDa6OxjvungkfQIYtGrKfyPo
         5vXg==
X-Gm-Message-State: AGi0PuZybjaADxwiYwnXq+xhDKCCxzPpfpExl8GlA6qD4rnNcGWBLBo3
        WMXp6dCt9Wp+Bw4baH356tw=
X-Google-Smtp-Source: APiQypJXm0vqnFUdHEU+gU9EChhbVBRXDN1IQWGmNCNeRRGTnxki0Q4ff7wcuBIxWxY3kTOc2iR98w==
X-Received: by 2002:a2e:9886:: with SMTP id b6mr13417739ljj.237.1586860143935;
        Tue, 14 Apr 2020 03:29:03 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-231-41.ip.moscow.rt.ru. [188.32.231.41])
        by smtp.gmail.com with ESMTPSA id w3sm11127835ljm.0.2020.04.14.03.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 03:29:03 -0700 (PDT)
To:     Willy Tarreau <w@1wt.eu>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>, Ian Molton <spyro@f2s.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>, x86@kernel.org
References: <20200331094054.24441-1-w@1wt.eu>
 <ae23d88d-fc21-6f46-7c27-ea0adf6211e5@kernel.dk>
 <20200414053119.GB20927@1wt.eu>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Subject: Re: [PATCH 00/23] Floppy driver cleanups
Message-ID: <da6afb7c-d543-b0a3-c165-89ad0b2a2783@linux.com>
Date:   Tue, 14 Apr 2020 13:29:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414053119.GB20927@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 4/14/20 8:31 AM, Willy Tarreau wrote:
> Hi Jens,
> 
> On Mon, Apr 13, 2020 at 04:46:41PM -0600, Jens Axboe wrote:
>> I'll be happy to queue these up for 5.8 when ready. Would be handy
>> if you could resend a v2 patchset with the extra patches, makes my
>> life so much easier...
> 
> Sure, will do once Denis confirms he's done with the review and is
> OK with the series.
> 
> Thanks!
> Willy
>
I can see no new issues, respecting that the initial version
was sent privately and additional [24-27] fixups.

[+] eye checked the changes
[+] compile tested the patches on x86, arm, powerpc, sparc64,
    m68k (forced ARCH_MAY_HAVE_PC_FDC by removing BROKEN)
    sparc64 showed a couple of warnings in printks
I was expecting that some of the arch maintainers will at least
ack the patches.
[+] tested on real hardware for x86
[+] local syzkaller fuzzing reveals no new issues

Willy, could you please resend the patchset with printks fix for sparc64?
Or if Jens don't mind and you don't want to send 30 patches again you can
resend only sparc64 patch and I will reapply it and send everything to Jens
with merge request. I applied your patches a couple of days ago here
https://github.com/evdenis/linux-floppy/ to cleanups branch.

I also faced minor ubsan warning in setup_rw_floppy that is not related
to these patches. It's false alarm of cross-boundary access of cmd,
reply_count, reply in floppy_raw_cmd. This access is intentional.
I will send a patch on top of your patchset.

Thanks,
Denis 
