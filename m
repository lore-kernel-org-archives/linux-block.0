Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDF8C49ED7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 20:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7352054F
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 20:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="p4EMx8iq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbfIMUux (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 16:50:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37076 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730990AbfIMUuw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 16:50:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id c17so8100131pgg.4
        for <linux-block@vger.kernel.org>; Fri, 13 Sep 2019 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=amnZFjFLfOACEYssP4ybWlOoLB0GcCjGJaEaTzkQYek=;
        b=p4EMx8iqWDd9hfto/+tPAci++WmUe0xrVYOap2a2kGwTSrR7iPPYczwlKHtipr0O0J
         zrJ/Ir1q8Wmbh7NwMvKDhmACmOPonr+cZDORZCN1uVwt6ewhM6LSOO7HCnKppBZRFzOu
         MetUz5wWsnZXkpSO/0oHqrPTViT3Hd5muM3GGfXxzKeUCq9Mj+GYsd/VQPPM377vs9py
         eV2VVetitWEnTmypoXGFcCK9N3qMdivoF/NGRHIpZY9sHdtsK3AwOhxQpNW+AoZxiutc
         DaRK0NXhi4Z5KvSzyvnVc3k8KfVCn540E9ARnxZ7QIHYyMzmOuaEk62KlcYmJw4+RsZG
         qc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=amnZFjFLfOACEYssP4ybWlOoLB0GcCjGJaEaTzkQYek=;
        b=iItW7BJBoD8RvuFPL1qCl8umxpqwh8j9v7Wwjw/hXKJAUaZ4W23AL82PrtJLIpYjHB
         FHufWautMbUJYVYtzjpK2BYyPLGguWe7prSNMvcrZ+HuQvCh8gAEibelPJlQ3bjY0mQN
         EUfdRjEyUzICZ5bqbYKn59qAX8INgpv1QMv/vvkk2Pqv/wgAVugxFI01s/Yo1CjambYs
         m938yLRVptbMB7dDMqVJ+DXlx3AfQ3HSTI6jledsOL2IBkwQlTpL2yGTqeXkjhxgH2X1
         Cd1GIa/PQ1T6ip5X7MK5F/N6ChGfeb1jGFUKgAJW3dDvsES9lLw0DFerG5KDHDbR+tzk
         ObNA==
X-Gm-Message-State: APjAAAUUzktJU3GOoXBakQhw0IKQ2SXKcT/iP4U5HrexVdKfL3WagtNl
        SUjXBL83vzw/G3o0URS/g/JpTw==
X-Google-Smtp-Source: APXvYqz5qWK1aYI4TwmVbW046ISVYHo53rVsbU36YfEeDcBB0FJk+WmeAd5sG7VYxShR+rIIBTbkEA==
X-Received: by 2002:aa7:9d8e:: with SMTP id f14mr574370pfq.217.1568407852069;
        Fri, 13 Sep 2019 13:50:52 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:4d1e:aad2:f066:c964? ([2605:e000:100e:83a1:4d1e:aad2:f066:c964])
        by smtp.gmail.com with ESMTPSA id s76sm27619768pgc.92.2019.09.13.13.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 13:50:51 -0700 (PDT)
Subject: Re: [PATCH 0/4] null_blk: fixes around nr_devices and log
 improvements
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, kernel@collabora.com,
        krisman@collabora.com
References: <20190913185746.337429-1-andrealmeid@collabora.com>
 <FFDFD18F-C242-46D2-B64B-5515987AD82D@kernel.dk>
 <467709ad-e174-4d4a-6906-aba5bf7a8111@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bfc26640-b10e-e93e-abe5-1dfd79226354@kernel.dk>
Date:   Fri, 13 Sep 2019 14:50:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <467709ad-e174-4d4a-6906-aba5bf7a8111@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/13/19 1:22 PM, André Almeida wrote:
> On 9/13/19 4:03 PM, Jens Axboe wrote:
>> On Sep 13, 2019, at 11:58 AM, André Almeida <andrealmeid@collabora.com> wrote:
>>>
>>> ﻿Hello,
>>>
>>> This patch series address feedback for a previous patch series sent by
>>> me "docs: block: null_blk: enhance document style"[1].
>>>
>>> First patch removes a restriction that prevents null_blk to load with
>>> (nr_devices == 0). This restriction breaks applications, so it's a bug. I
>>> have tested it running the kernel with `null_blk.nr_devices=0`.
>>>
>>> In the previous series I have changed the type of var nr_devices, but I
>>> forgot to change the type at module_param(). The second patch fix that.
>>>
>>> The third patch uses a cleaver approach to make log messages consistent
>>> using pr_fmt and the last one add a note on how to do that at the
>>> coding style documentation.
>>
>> Please add Fixes tags to your patches.
>>
> 
> I've added to [PATCH 1/4], should I add to all 4 patches?

The ones where it's pertinent, yes, always. Both 1-2 fix issues with
the previous patches.

-- 
Jens Axboe

