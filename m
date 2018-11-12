Return-Path: <SRS0=fNpn=NX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3420BC43441
	for <linux-block@archiver.kernel.org>; Mon, 12 Nov 2018 16:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC1322419
	for <linux-block@archiver.kernel.org>; Mon, 12 Nov 2018 16:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="p0l3Kd3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC1322419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeKMB7r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:59:47 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44740 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeKMB7q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Nov 2018 20:59:46 -0500
Received: by mail-pf1-f194.google.com with SMTP id b81-v6so4035399pfe.11
        for <linux-block@vger.kernel.org>; Mon, 12 Nov 2018 08:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V+pp3RB3QPmZ7ONFN2yXCuP86/d7gL2nH4AJvH2SvNM=;
        b=p0l3Kd3gSKAcsdTo87PcDRvp95lkI8ngrS0tLM2My3J67debcJPz08Z+9XV/PuS9P9
         gAJrKc9ruPJ07XNgVexhdLUK0fvDDmrq1+184619JcmUmWwOH5SKXqmYHrIKhPMSIfTj
         E0ilRS15tCTtgVbSSJXnRizLtJMXYQ4qoilHIc5kGCqnUSBP4EZLaHD2Uh76ysmtTVGE
         ++PqA9ob6HtU5N6aq7GuLDY7eezF8YAldy4+gyN2xRAkJlSz6t3Bg8jS2VwlOsxb3kbg
         yXPyYcZSjaK4O+52wdVUIwIgnVS97T9UIYUFmNOB4iSFvH4Jo3jG1Z6mgpfoXmjXc8gL
         9E0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V+pp3RB3QPmZ7ONFN2yXCuP86/d7gL2nH4AJvH2SvNM=;
        b=M3XiEL8WMiVgEwHZMKtt3UE6txT9ui5aTHsX2tWP01JKJ7YIuctFKe1aG+bvTqvlyt
         8tqiVYc6uKAx9wxOb3HYNjtq29C8QRsHJQtjCkMSq/KUncNwPp3vMzfJzo3GPT6XX7wo
         RHIL4Ylgqv3MDe26ifJ32QOW3M63XOCP1B9xcJjeYBzB8K6lZ73K+gAk5HX+v7UFCEtk
         MNwbivb9TAfTqcmzJCl28lLEyulptP7dNG3FbdinIUO2VL1pJcLP/i6+DghNqjcHO3dC
         albQN5bB30l8lswRCxx660iCuYdGls1l0RWIttFHyGf7u3qZf6qkCLZ3L7+D9tPOlzx6
         ChSA==
X-Gm-Message-State: AGRZ1gIFiCj5wwQ59vSLSOr291c1umv4uJHvq2OpKCZ82oRJutmvgC9o
        seO4KSVs6CZgIHqb1z6cQt8KAA==
X-Google-Smtp-Source: AJdET5cn+3fzr6Ksu/pfggApdL39b6arv6Zzr6lGdNDMZYjCY3KYPkttmRzylkqMvkq/vTZBrphuxg==
X-Received: by 2002:a62:d58a:: with SMTP id d132mr1420822pfg.132.1542038754173;
        Mon, 12 Nov 2018 08:05:54 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a73-v6sm20342170pfj.38.2018.11.12.08.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 08:05:53 -0800 (PST)
Subject: Re: [PATCH 00/12] unify the interface of the proportional-share
 policy in blkio/io
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        lennart@poettering.net
References: <20181112095632.69114-1-paolo.valente@linaro.org>
 <9e8adb3271680165d85994a225713391@natalenko.name>
 <E8A20452-A73C-4A31-B5EC-48EFB9937832@linaro.org>
 <e85cfae0-7743-8c51-c2c9-0855c26f868e@kernel.dk>
 <F0F86365-D4EC-43F0-AE13-CC8FA6CC3D97@linaro.org>
 <c665a05b-66fc-6b8a-fa73-1c76885053db@kernel.dk>
 <20181112155406.rtx7ze2l3gadmiyx@MacBook-Pro-91.local>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6b6ac3db-1f19-a290-4662-3c10b2b81ed8@kernel.dk>
Date:   Mon, 12 Nov 2018 09:05:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181112155406.rtx7ze2l3gadmiyx@MacBook-Pro-91.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/12/18 8:54 AM, Josef Bacik wrote:
> On Mon, Nov 12, 2018 at 08:48:35AM -0700, Jens Axboe wrote:
>> On 11/12/18 8:45 AM, Paolo Valente wrote:
>>> BTW, since this patch series is probably even more useful for older
>>> than for future kernels, might it make sense to also propose it for
>>> stable/longterm kernels (provided that such a possibility exists)?
>>
>> That just not how things work, we don't put different things in
>> older/stable kernels, it's strictly backports of what we have in
>> current/newer kernels. Hence it appears to be a dead end right now.
>>
> 
> It may not be useful currently, but my plans are to do a scheduler agnostic
> proportional io controller next, so having these interfaces unified would be
> nice so I don't have to do a rqos.io.weight or something similar.  Thanks,

I'm not saying the work isn't useful, I'm saying that we can't go adding
different interfaces to stable kernels than what we currently have in
tip. I'm all for unified interfaces for this kind of thing, it's much
better than having something that's specific to any given
implementation.

-- 
Jens Axboe

