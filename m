Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65E3C0650E
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 20:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C196221882
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 20:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfGCUts (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:49:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35665 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfGCUts (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jul 2019 16:49:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id u14so656281pfn.2
        for <linux-block@vger.kernel.org>; Wed, 03 Jul 2019 13:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i0Qt59q0lr75zT5BR3Wr9KLQYkuxO6+SoYwgj4mE+eQ=;
        b=BVEkegxTkosg4YUALBM05Bdwy4IV7Pa8QVpd2OnNuuZbgcVT0XEJB3+nWKSvl8dsEm
         HXIGer4/SRP7y9mspwlQxWvbeBit0w0ByodIb364x6Ixd/XjiA718U9zkl2ExU0MSihV
         0nK4ZjzJvZqxC8asVodfMLM7RwPdTRe3QXUMPWHwahed9sy1/xytxUYNgCRwhxzHPCOo
         fVcV0VqPWz2DqY1w8EYlKDGUymFE/nVhmBIugsJPox0Qc8epTV68y178iRuVwkqWTnni
         aaOl5EzN++bPcX6OTX45rAWr0MvmOZEO2M8hGrlpA4nO2Q/mmY1wd+UcQZderU/Pk0as
         RXvg==
X-Gm-Message-State: APjAAAV0B8XreY88XXCqXeFAYK1fOWReWaa/wusxfG8ZdewP6Ezcqqt2
        R62C3ZhXzFm53t0w47Wf3vg=
X-Google-Smtp-Source: APXvYqyQ5gXZuogNg6VTNbSpb+/YBuj21jqRndRNQPFsS27B9ofd5Mbd3phnfepK5dsthihb856GAw==
X-Received: by 2002:a17:90a:24ac:: with SMTP id i41mr14904753pje.124.1562186987155;
        Wed, 03 Jul 2019 13:49:47 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id o12sm2585314pjr.22.2019.07.03.13.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 13:49:46 -0700 (PDT)
Subject: Re: [PATCH liburing 2/2] Fix the use of memory barriers
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>
References: <20190701214232.29338-1-bvanassche@acm.org>
 <20190701214232.29338-3-bvanassche@acm.org>
 <5d5931e08e338a8a8edb1e58a33a120e@suse.de>
 <876fa5e3-f050-b95c-a30c-755d1e0430d1@acm.org>
 <723180510314b2928ba97752e5383202@suse.de>
 <0bffbfd9-a57e-857f-4699-856295a11f3a@acm.org>
 <2cd14f5d8cfcc36dec90574ff8a9e8b5@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <77df5484-9737-715a-2cb8-968f02ae6473@acm.org>
Date:   Wed, 3 Jul 2019 13:49:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <2cd14f5d8cfcc36dec90574ff8a9e8b5@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/3/19 2:49 AM, Roman Penyaev wrote:
> It seems you took the chunk of the code with macros from
> tools/arch/x86/include/asm/barrier.h, where indeed smp_store_release
> and smp_load_acquire are defined only for x86-64.  If I am not mistaken
> kernel defines both __smp_store_release / __smp_load_acquire equally
> for x86 memory model in arch/x86/include/asm/barrier.h.

Agreed.

>> Since there are 32-bit x86 CPUs that can reorder loads and stores
> 
> Only "loads may be reordered with earlier stores"
> (Intel® 64 and IA-32 Architectures, section 8.2.3.4), but "stores are not
> reordered with earlier loads" (section 8.2.3.3), so smp_store_release and
> and smp_load_acquire can be relaxed.

Certain IA-32 CPUs do not follow that model. From Linux kernel v4.15:

config X86_PPRO_FENCE
    bool "PentiumPro memory ordering errata workaround"
    depends on M686 || M586MMX || M586TSC || M586 || M486 || MGEODEGX1
    ---help---
    Old PentiumPro multiprocessor systems had errata that could cause
    memory operations to violate the x86 ordering standard in rare cases.
    Enabling this option will attempt to work around some (but not all)
    occurrences of this problem, at the cost of much heavier spinlock and
    memory barrier operations.

    If unsure, say n here. Even distro kernels should think twice before
    enabling this: there are few systems, and an unlikely bug.

Since support for these CPUs has been removed from the Linux kernel it's 
probably fine not to worry about these CPUs in liburing either. See also 
commit 5927145efd5d ("x86/cpu: Remove the CONFIG_X86_PPRO_FENCE=y 
quirk") # v4.16.

Bart.
