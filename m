Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37817C433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 19:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F6DE20772
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 19:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dLEeSTbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgGBTGD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgGBTGD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 15:06:03 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70F3C08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 12:06:02 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 72so1088949ple.0
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2020 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uNkDA+ksKrwzfRgaRZJIL/u4W1JOCNY1j9WesonYres=;
        b=dLEeSTbd68m1IjLim5QGg8dn/kneJAmWaDb6Oa9HPC8XDDED3c0j3Z1lxlhWff7LZz
         4KPT7luVYAwqsAmnk8g9l6TqdKjjqON7p9oKmoBJCAQe6CH4/viYgtL20o6VSW5XUFMM
         KjnpemarBUpY3M4a/brupE0lYpn1mEFq9+26H4+QqnAeVJ6xC11bOaEToMxFFpJw2k5s
         AJT+zaFoZQrd+lHPAfFL1bX8LNI7Mvl3tvsMUcjPMcW04G32OQwMcRlqBQxJeZkNzKvu
         Vio6masvQsxdWk99PSYR9BMZl/O9dKsjnpuoffWtbP3HD2b3z5jjjeZjobhqam6dapao
         tmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uNkDA+ksKrwzfRgaRZJIL/u4W1JOCNY1j9WesonYres=;
        b=jPfHoCl25hYCB3yQSGpgztcVpIvY6JHGsg4k5e9IuJG3AedbjV+y2/YP2ueBiZv9Ap
         1acxH8pKL0gEYc3vV+zWLApxPajUSCn2Cz+s7siRoShxywwTub+iL1HsqegP4Br7L8Zv
         AXLLntcAYULQyVAxy/+eyhI8M3O80C+B3y6L2NZ5I+ym3hIKSxkEAeS7ZcWM30wXBw8H
         KaEcMNkPNDtawjg8wGvjPAeAGcVP7XhIdjvjeU6WQPP8RZOz7Dm/4ujeid8teiuDH+c5
         UZwpLC5hssyys0N6+uiLMguzJVOjlcnOjW1n7dsrOoK+0dte0NB9iQOyTNBm7gtIYL8s
         0P2w==
X-Gm-Message-State: AOAM532Er9lTWRNe0MejIzeM0ik62ZkY7LN2360eb/Vb2zhb4ztGL1Qo
        7E5knIILHdFoa4ExrPlC0RCaIQ==
X-Google-Smtp-Source: ABdhPJxZDh1MRR1LLLMetht4Yl4xP49t6qjEJeZIDzEgyKZzW8ls/Kct0psmuVQvswbwcQyj2yO6Lw==
X-Received: by 2002:a17:90a:e007:: with SMTP id u7mr23417660pjy.9.1593716762178;
        Thu, 02 Jul 2020 12:06:02 -0700 (PDT)
Received: from [10.174.189.217] ([204.156.180.104])
        by smtp.gmail.com with ESMTPSA id u20sm9258983pfm.152.2020.07.02.12.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 12:06:01 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: release driver tag before freeing request via
 .end_io
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20200702134838.2822844-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <54bc7fb4-2780-7c55-1fe5-806e0de5e945@kernel.dk>
Date:   Thu, 2 Jul 2020 13:05:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702134838.2822844-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/2/20 7:48 AM, Ming Lei wrote:
> The built-in flush request shares tag with the request inserted to flush
> machinery, turns out its .end_io callback has to touch the built-in
> flush request's internal tag or tag.
> 
> On the other hand, we have to make sure that driver tag is released
> from __blk_mq_end_request(), since this request may not be completed
> via blk_mq_complete_request().
> 
> Given we have moved blk_mq_put_driver_tag() out of header file, fix this
> issue by releasing driver tag before calling .end_io().

As I wrote yesterday, I reverted the three patches:

https://git.kernel.dk/cgit/linux-block/log/?h=for-5.9/block

so you'll need to send a new and updated series. Please fold in the
'unused variable' and related fixes as well.

-- 
Jens Axboe

