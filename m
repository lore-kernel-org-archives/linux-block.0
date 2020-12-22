Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA46C433DB
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 16:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5798D224DF
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 16:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgLVQRw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Dec 2020 11:17:52 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44]:38267 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgLVQRw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Dec 2020 11:17:52 -0500
Received: by mail-pj1-f44.google.com with SMTP id j13so1616101pjz.3;
        Tue, 22 Dec 2020 08:17:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sxn77OCGzJYARUGQUKWfpI80sEOeENkuPBT5B5kUpDE=;
        b=X9okfL/gcQIchLw/xycjbwrZvIhPnZST6Y1tFJWdkbhX10VOy6i8UF/09j1sAHqnEc
         NzT6f4y7gOl/m+TSwiwX2NI9ThakAdC0mZxX//dHaXzmGYINqOKEheIFygzlUbxWxMMT
         ejBDP5nRpcz6DNLv7Mr2RAMAj8pXqMTIpUoYFJW9qvS3wmPt+tUu2qp4kHMws9u4RnJc
         lLriTmEgUDK9AXD7+byUwrNaEGPECUDDlyivIIApCHnNY7MxSSOhYmhGZuAjFQ9A612H
         dXdR7yNMXoybbjk6t01xU7KbYl654IaaXFcJMFU1RMoVkb3xLu7QDFKBZNrfIfvzmNiJ
         g+IQ==
X-Gm-Message-State: AOAM532ZB9TBy8v74z94KIDuPNxDAE5u7L40wFzAGes65p3eZNWph9Fu
        3a7aMtjmTpuC1JfqupWscnk=
X-Google-Smtp-Source: ABdhPJyXFh/1YdREN8IB86Dx1s4w2PX5wkZaS82gFgN2rluTbChv6WbOpjsMDsHD223TmvbczHoYrA==
X-Received: by 2002:a17:90a:de95:: with SMTP id n21mr22310181pjv.62.1608653830909;
        Tue, 22 Dec 2020 08:17:10 -0800 (PST)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s1sm20645213pfb.103.2020.12.22.08.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Dec 2020 08:17:09 -0800 (PST)
Subject: Re: [RFC PATCH v2 2/2] blk-mq: Lockout tagset iter when freeing rqs
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, hare@suse.de, ppvk@codeaurora.org,
        kashyap.desai@broadcom.com, linuxarm@huawei.com
References: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
 <1608203273-170555-3-git-send-email-john.garry@huawei.com>
 <df44b73d-6c42-87ee-3c25-b95a44712e05@acm.org>
 <4d2004bb-4444-7a63-7c72-1759e3037cfd@huawei.com>
 <31de2806-bbc1-dcc3-b9eb-ce9257420432@acm.org>
 <b2edab2b-8af7-816d-9da2-4720d19b96f8@huawei.com>
 <e97a0603-f9e3-1b00-4a09-c569d4f73d7b@acm.org>
 <f98fd31e-89d4-523f-df70-4bd5f39ccbd5@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <33e41110-b3b2-ac16-f131-de1679ce8238@acm.org>
Date:   Tue, 22 Dec 2020 08:16:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <f98fd31e-89d4-523f-df70-4bd5f39ccbd5@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/22/20 3:15 AM, John Garry wrote:
> So then we could have something like this:
> 
> ---8<---
> 
>   -435,9 +444,13 @@ void blk_mq_queue_tag_busy_iter(struct request_queue 
> *q, busy_iter_fn *fn,
>      if (!blk_mq_hw_queue_mapped(hctx))
>              continue;
> 
> +    while (!atomic_inc_not_zero(&tags->iter_usage_counter));
> +
>      if (tags->nr_reserved_tags)
>          bt_for_each(hctx, tags->breserved_tags, fn, priv, true);
>      bt_for_each(hctx, tags->bitmap_tags, fn, priv, false);
> 
> +    atomic_dec(&tags->iter_usage_counter);
> }
> 
> blk_queue_exit(q);
> 
> --->8---
> 
> And similar for blk_mq_tagset_busy_iter(). How about it?

Are there any blk_mq_tagset_busy_iter() calls that happen from a context 
where the tag set can disappear while that function is in progress?

Some blk_mq_tagset_busy_iter() calls happen from a context where it is 
not allowed to sleep but also where it is guaranteed that the tag set 
won't disappear, e.g. the call from inside sdk_mq_queue_rq().

How about using a mutex inside blk_mq_queue_tag_busy_iter() instead? As 
far as I can see all blk_mq_queue_tag_busy_iter() happen from a context 
where it is allowed to sleep.

Thanks,

Bart.
