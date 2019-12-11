Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096C8C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD260206A5
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="icYVu+ip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfLKUFD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:05:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41641 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfLKUFD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 15:05:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id bd4so6426plb.8
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 12:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tsOWIFudRN3reWK5MlLc7h9kutRZZYV6QEDcmlofBfg=;
        b=icYVu+ipVyioTkIzX05lyZ/nDofSI9BiOFxVI5kxybYBYBXw7LjODIWhaKTkcea/nk
         Qk51hgCt/OC6xTOeiKXKK4U9IQ/v0DtnEQnmDYbZz+2e405zkiY6t2RuPdfMCtRZjVJ4
         nQN5W6GuAL8hOr1VyNiCoXkA4kzZ/61mMKXzHyzaLlnRtBA/mqR7NBGgZ59znrF9T7up
         PiQhaUBRqpyGGhCoPJY8HhGBR/cWCpUpKPOfyCGF6DqfefG+wfAbvEP4gR5I8o3lyEm1
         S4V9+2H+vQQ+wyNnqQQZInrv/XHJrEC6N930U5VAF7m846uC0vjDl/+JEuaDExPnMzuf
         +7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tsOWIFudRN3reWK5MlLc7h9kutRZZYV6QEDcmlofBfg=;
        b=ciFN9M0LPEl11nSlMgwFic+ThmsEscC/dCy40TafE3zO5w38D8vYaaiP+9Zh2H61Al
         r0iMCyvgCAMbJljnIlyHZr6629wzfVONS6oTw2rFt8nimKQR6jUNN9UAcgD8qaU5w/WD
         S6c2LtzAaxCqkMS48H0EYlEwms/ND33en/6RzqoFG4OMU+/rqYnsa0fpU9MEscDtXPPa
         5BGOIahXeObFwwKis4BuuW2r47fXvWqzktlXSB0OMS/HRLYxOor5l1F/c3uZZXFRVYoq
         x+bxjJJiw11107vgPGOAbYx2dp/G9wnS65bImMJ3By0iRgej2mJE0iTlRbwBmIYvJREf
         IHxw==
X-Gm-Message-State: APjAAAXLpGRvjJ/8LDIhQFlaSmYuseS5R9A1OAaQklPujmbnIeFV26dp
        VYlirRsENpukIeO29wLSBid3vyLrYHc=
X-Google-Smtp-Source: APXvYqxXBwB0bh9VK6p2nHwY5RWgvHbUK/AdjrWcmYmgtNlHRRs0vYZ+qQZa4Rq9Y8kOzoY88Z9TRg==
X-Received: by 2002:a17:90a:cc10:: with SMTP id b16mr5238863pju.55.1576094702218;
        Wed, 11 Dec 2019 12:05:02 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::1014? ([2620:10d:c090:180::50da])
        by smtp.gmail.com with ESMTPSA id i127sm3971751pfc.55.2019.12.11.12.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 12:05:01 -0800 (PST)
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
 <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
Message-ID: <d3ac2d74-f943-9b4c-570c-c7f6e86a475a@kernel.dk>
Date:   Wed, 11 Dec 2019 13:04:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/19 12:34 PM, Jens Axboe wrote:
> On 12/11/19 10:56 AM, Jens Axboe wrote:
>>> But I think most of the regular IO call chains come through
>>> "mark_page_accessed()". So _that_ is the part you want to avoid (and
>>> maybe the workingset code). And that should be fairly straightforward,
>>> I think.
>>
>> Sure, I can give that a go and see how that behaves.
> 
> Before doing that, I ran a streamed read test instead of just random
> reads, and the behavior is roughly the same. kswapd consumes a bit less
> CPU, but it's still very active once the page cache has been filled. For
> specifics on the setup, I deliberately boot the box with 32G of RAM, and
> the dataset is 320G. My initial tests were with 1 320G file, but
> Johannes complained about that so I went to 32 10G files instead. That's
> what I'm currently using.
> 
> For the random test case, top of profile for kswapd is:
> 
> +   33.49%  kswapd0  [kernel.vmlinux]  [k] xas_create
> +    7.93%  kswapd0  [kernel.vmlinux]  [k] __isolate_lru_page
> +    7.18%  kswapd0  [kernel.vmlinux]  [k] unlock_page
> +    5.90%  kswapd0  [kernel.vmlinux]  [k] free_pcppages_bulk
> +    5.64%  kswapd0  [kernel.vmlinux]  [k] _raw_spin_lock_irqsave
> +    5.57%  kswapd0  [kernel.vmlinux]  [k] shrink_page_list
> +    3.48%  kswapd0  [kernel.vmlinux]  [k] __remove_mapping
> +    3.35%  kswapd0  [kernel.vmlinux]  [k] isolate_lru_pages
> +    3.14%  kswapd0  [kernel.vmlinux]  [k] __delete_from_page_cache

Here's the profile for the !mark_page_accessed() run, looks very much
the same:

+   32.84%  kswapd0  [kernel.vmlinux]  [k] xas_create
+    8.05%  kswapd0  [kernel.vmlinux]  [k] unlock_page
+    7.68%  kswapd0  [kernel.vmlinux]  [k] __isolate_lru_page
+    6.08%  kswapd0  [kernel.vmlinux]  [k] free_pcppages_bulk
+    5.96%  kswapd0  [kernel.vmlinux]  [k] _raw_spin_lock_irqsave
+    5.56%  kswapd0  [kernel.vmlinux]  [k] shrink_page_list
+    4.02%  kswapd0  [kernel.vmlinux]  [k] __remove_mapping
+    3.70%  kswapd0  [kernel.vmlinux]  [k] __delete_from_page_cache
+    3.55%  kswapd0  [kernel.vmlinux]  [k] isolate_lru_pages

-- 
Jens Axboe

