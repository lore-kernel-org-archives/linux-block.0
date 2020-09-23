Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C74C4363D
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 15:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6074421D43
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 15:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UwYPfCHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgIWPSa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgIWPSa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 11:18:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DE4C0613D1
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 08:18:30 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 34so14573412pgo.13
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 08:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nsm/SLpnI1gdm4X4OKozNS3TNzCBnlqB2Om83wtrvTM=;
        b=UwYPfCHCkuZSpIeCGStKHAWyo1CDDFErhXwN/nKs+DtOMuKzWm3Ru4fAVyK2uJC8qt
         c1kchVce3LxG5k62yYPWGhxExhYubU1CmUlYTQs+vNFL99vt1MJw8R6n85S3UwyCvQxm
         GohP7WvEJNxqNh7ABOo7NUNhVLiVdZIWF6rVjgqQRQSZAlj9IrtU5El4ZrugnG+jnJNS
         VSKqmHHY2rgXz4kgHYPDhS9Es4HiK1Icm9gmTPraFvc18zLU6JNSPy5h7SSON2ToEhBj
         rXI/A07vNJ4Fe0k24pgT3/8KclQsNFK1HEPN24YeSopnBbytHL3kp3YFTw7dulvBdWSN
         SBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nsm/SLpnI1gdm4X4OKozNS3TNzCBnlqB2Om83wtrvTM=;
        b=WPxj9BZ6m5baJirrC31qZqUcDFdaY+cuY7Xb/AtS1EDC/g1/mWoCDYLhnqCKvW1zL1
         4yFnkDXI7/I22Pbp8szk7+JnE7ogRb42dvSuZFdngo/6N7KGXhhMqJE9HsILmc8U4F5c
         yr3DebJvZbHqEaY3qTl8MJvon33LexK5oxvCpkejtcMcq/PRV4j4Yo15N0F+cPsfXoio
         u7qNqHrK+17VUX9XgcQuvOTq/H55+oJ4duT6MXbFfUfgvTwi78gPQ0hIKyd1Hfqpcumj
         tQu4TrS3McK9NFFiAldNPT9aXHEKEJ0BkNBr5/FHN//IrspChWvShT3/Sy82BGOQAicS
         RXtQ==
X-Gm-Message-State: AOAM5305LCpicIlNTA27VbdRFWfnCBEcVmrIBnKdPEcBw5c4BdwF0VRY
        8gFko7fSDiwj5/2+OcNIJ8HzpQ==
X-Google-Smtp-Source: ABdhPJzJ/ejg9GYFqB77f/Yk8KzNOg6TdYV6IGyGBQKLmXK/daOda5tYkOU0zVvC/ZDIxC6p+dcLzA==
X-Received: by 2002:a63:580c:: with SMTP id m12mr188720pgb.99.1600874309643;
        Wed, 23 Sep 2020 08:18:29 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 22sm288302pgh.18.2020.09.23.08.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 08:18:29 -0700 (PDT)
Subject: Re: [PATCH 06/14] block: drop double zeroing
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr>
 <1600601186-7420-7-git-send-email-Julia.Lawall@inria.fr>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b71efcfb-4ffd-d125-0ef7-ed5ab6b03892@kernel.dk>
Date:   Wed, 23 Sep 2020 09:18:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1600601186-7420-7-git-send-email-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/20/20 5:26 AM, Julia Lawall wrote:
> sg_init_table zeroes its first argument, so the allocation of that argument
> doesn't have to.
> 
> the semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression x;
> @@
> 
> x =
> - kzalloc
> + kmalloc
>  (...)
> ...
> sg_init_table(x,...)
> // </smpl>

Applied for 5.10, thanks.

-- 
Jens Axboe

