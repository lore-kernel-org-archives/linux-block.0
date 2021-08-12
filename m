Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01328C4338F
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 18:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF556103A
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 18:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhHLSRF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 14:17:05 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:38439 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbhHLSRF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 14:17:05 -0400
Received: by mail-pj1-f46.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so16593945pjb.3
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 11:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9G5w+btFQ35lZBGj5X71xXpHdysImQdKTJyE7v1iv9w=;
        b=WCFrUSF1bospVseAhJiXI1xPcTD/qYRJ64kd0F/vAwxfynSUcptaw98Ii7KOpLduLA
         ov1VkgF6/NvJEhvRztca4VF/NBj8s5u3ZcWu6VQOq1pE5CkhLqb6QCaUsR0hUlqD6v3o
         lY4CuXETzh2ukNuABZrFgJjR7T7Gj40EMP13dphRfSMYPuVEur/ydTHhYnoEYEtpmgp5
         Lyup+sWMjIN+VKlQMqItQ3o7SBVoGML66FhdSj6Pfv4ZricgqY5LFxoDCpsZxbC+9HGn
         cU+xQWBRtOUjz/k22zWHCTLLihLYd/jOZeWY0VAgTvQcD+rbyaQ60aBTLH3EqRrB2mf/
         3snA==
X-Gm-Message-State: AOAM532NPqUt5zNsYENkgNOL06p6EyrAvPRDLjAY/HnLCc0miesqvHXX
        ajQWA4U23h5wMmqwqnlNIaxAR/nL4OVUUEOR
X-Google-Smtp-Source: ABdhPJw837/icnq5wCIMn1jZwCiNj7ViswmTt1QeBriZl5llHkQKnZCgAddHNX+FJ8KFaWQrX+IzYA==
X-Received: by 2002:a65:4104:: with SMTP id w4mr4994849pgp.296.1628792199104;
        Thu, 12 Aug 2021 11:16:39 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:f9eb:d821:2884:27fd])
        by smtp.gmail.com with ESMTPSA id z15sm4514660pfn.90.2021.08.12.11.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 11:16:38 -0700 (PDT)
Subject: Re: [PATCH block-5.14] Revert "block/mq-deadline: Add cgroup support"
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <YRQL2dlLsQ6mGNtz@slm.duckdns.org>
 <035f8334-3b69-667d-be91-92dcab9dc887@acm.org>
 <YRQhlPBqAlkJdowG@mtj.duckdns.org>
 <00e13a7b-6009-a9d7-41ba-aae82f5813de@acm.org>
 <YRVfmWnOyPYl/okx@mtj.duckdns.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <631e7e18-52ca-9bec-0150-bac755e0ff24@acm.org>
Date:   Thu, 12 Aug 2021 11:16:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRVfmWnOyPYl/okx@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/21 10:51 AM, Tejun Heo wrote:
> There's an almost fundamental conflict between ioprio and cgroup IO
> control. bfq layers it so that ioprio classes define the global
> priority above weights and then ioprio modifies the weights within
> each class. mq-deadline isn't cgroup aware and who knows what kind of
> priority inversions it's creating when its ioprio enforcement is
> interacting with other cgroup controllers.

Are you perhaps referring to the iocost and iolatency cgroup 
controllers? Is it ever useful to combine these controllers with the 
ioprio controller? The ioprio controller was introduced with the goal to 
provide the information to the storage controller about which I/O 
request to handle first. My understanding of the iocost and iolatency 
controllers is that these cgroup controllers decide in which order to 
process I/O requests. Neither controller has the last word over I/O 
order if the queue depth is larger than one, something that is essential 
to achieve reasonable performance.

Bart.
