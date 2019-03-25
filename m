Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076C8C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1042087C
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="vqXpLsAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbfCYQ7i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:59:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46633 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYQ7d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 12:59:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so230920pll.13
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 09:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NWGLIQGu38/jJb6e8uWtmgESprJGVMgumpIJ57GgwLQ=;
        b=vqXpLsAUGm0QT70kX4qwhbmciXz3cS7QYuXaQZf1e26ddA9ixDkoyH1skKslX3iVK9
         U+yWZOWSgHV8bhdUFn28dzhI/SwxuP/uPdlwilQ8Zwe4VEmI0WKVyP9IAhi8pyL04eTI
         bTJXctHM6c0Kf0OAEgUhwGhw9urE1YlnLPivsY8jyT0xz0LWVR1FrqmKWJdNuavaFM/7
         u/IQl743Qcbo6PgvrV7mgBYltaw80uUEbBty85iiwU0UL5oyh2cl6M7+Lx8F3nAPbBRP
         fO3QZ1DMn+N9myfUKaXFcCqzdlt0Xx7FTgpWGy7xyJ+eLzsmAESdOMRH2cttOuq0QPXZ
         wSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NWGLIQGu38/jJb6e8uWtmgESprJGVMgumpIJ57GgwLQ=;
        b=RAuY+khZBpB/aiJ4IfwU9mzPNhAtXiGuztzFwlxWUz+t+x9ZSZYiSbi2sUA7pvzzkw
         apA8PYHJ2xZEk3EmFqrshqihfzw4/R/c6hkBxd442IuITpePRoIqH/64Npxgp9qQrloB
         7ImXGK4D1L38ByFTY/p3RmR31p6VCW6ezENVGz4ZvV9Wkl7t5VT7pKBGe/4Y1xjAO9W/
         0MOevzmVkhAJDKil/oZF5OYdidOEtsEzKgVLqoQB/zs5y/C3pDfoLY/+aNNzdRmqhPow
         iGk0qdtCkVqZl/x+a2tlW7vFV/DwyCC3aeWb2/fl57csLWfN0WoMeTYJiC1fvhT9xtBT
         u9cg==
X-Gm-Message-State: APjAAAWraWY0vPqwjjCc3FAb6wfYfIshzlhSv0x8u6RuvAZVustsKVJr
        Msh1//XJNZ5jUz39qX/45rhMU7edMQA=
X-Google-Smtp-Source: APXvYqwXslOnXOKe7wC30klcY2KN8K5xcX4jq5xguuZL/3Igbc5bGQNlXFr+P0grfxvTw8OCG3cGEA==
X-Received: by 2002:a17:902:e684:: with SMTP id cn4mr3383014plb.71.1553533172882;
        Mon, 25 Mar 2019 09:59:32 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.googlemail.com with ESMTPSA id z77sm30426023pfi.155.2019.03.25.09.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:59:32 -0700 (PDT)
Subject: Re: [RFC PATCH] mm: readahead: add readahead_shift into backing
 device
To:     Fengguang Wu <fengguang.wu@intel.com>,
        Martin Liu <liumartin@google.com>
Cc:     akpm@linux-foundation.org, axboe@kernel.dk, dchinner@redhat.com,
        jenhaochen@google.com, salyzyn@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20190322154610.164564-1-liumartin@google.com>
 <20190325121628.zxlogz52go6k36on@wfg-t540p.sh.intel.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <9b194e61-f2d0-82cb-30ac-95afb493b894@android.com>
Date:   Mon, 25 Mar 2019 09:59:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190325121628.zxlogz52go6k36on@wfg-t540p.sh.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/25/2019 05:16 AM, Fengguang Wu wrote:
> Martin,
>
> On Fri, Mar 22, 2019 at 11:46:11PM +0800, Martin Liu wrote:
>> As the discussion https://lore.kernel.org/patchwork/patch/334982/
>> We know an open file's ra_pages might run out of sync from
>> bdi.ra_pages since sequential, random or error read. Current design
>> is we have to ask users to reopen the file or use fdavise system
>> call to get it sync. However, we might have some cases to change
>> system wide file ra_pages to enhance system performance such as
>> enhance the boot time by increasing the ra_pages or decrease it to
>
> Do you have examples that some distro making use of larger ra_pages
> for boot time optimization?

Android (if you are willing to squint and look at android-common AOSP 
kernels as a Distro).

>
> Suppose N read streams with equal read speed. The thrash-free memory
> requirement would be (N * 2 * ra_pages).
>
> If N=1000 and ra_pages=1MB, it'd require 2GB memory. Which looks
> affordable in mainstream servers.
That is 50% of the memory on a high end Android device ...
>
> Sorry but it sounds like introducing an unnecessarily twisted new
> interface. I'm afraid it fixes the pain for 0.001% users while
> bringing more puzzle to the majority others.
 >2B Android devices on the planet is 0.001%?

I am not defending the proposed interface though, if there is something 
better that can be used, then looking into:
>
> Then let fadvise() and shrink_readahead_size_eio() adjust that
> per-file ra_pages_shift.
Sounds like this would require a lot from init to globally audit and 
reduce the read-ahead for all open files?

Sincerely -- Mark Salyzyn
