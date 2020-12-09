Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C01C19425
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 16:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8444723C81
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 16:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgLIQye (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 11:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbgLIQyc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 11:54:32 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F85C06179C
        for <linux-block@vger.kernel.org>; Wed,  9 Dec 2020 08:53:52 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id 2so2185105ilg.9
        for <linux-block@vger.kernel.org>; Wed, 09 Dec 2020 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pFrCVN6Gn+ZyEFuOYf0G1cqZKi+SMHYMwyy/Z9Ayq2A=;
        b=mZRI3YhmR5R/0CaDyOv1WOHWk21Oa2uAoEJRpiBgsKRS0Zq3ZP8tqXNE+iPO/vaIJk
         cdzM5Vqe1Rek8FTcSpl1QA8bG4SF5tsBZaRhkwd5p+HHSSQdQn1hz40UZJjEQAtWWQxh
         D4oVNrgDtlELXrT1dpfLc5G5JLX/LpNpdlnKg+K2jt3p1wHM69QXKoC3qOVhVj0atwe8
         LhOXGAddX6vUSoVOzPE1bcTaxJzAJwoQdvbNgqBWwFIH3TANWny1QJkqpftz4LKhBHOS
         bl5NHaV+I+kXTjwuVwR1b845uYTbfWleV4nVveGywUaRoEqpvaXUOZEf4roZ+SbWYPPF
         9ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pFrCVN6Gn+ZyEFuOYf0G1cqZKi+SMHYMwyy/Z9Ayq2A=;
        b=rl/iZLaJ4aXkhpqGXQFANI+Xa0+ao0PAnUU5XXjikPwOAKN6KENKXz6cghOTS31Zlk
         apzAxsZp6KVgfP5CAT3pnMsIM8Id8DcTlqWUmPvgTcCrhIAxNyEvcqr3zCNSQPUO/QSE
         KB7OU4gsgJZUghUqqjrb4YkeNmXlPbkBjQX9zOL+LLrVyKF4IuMmWsZAh0T9gfBa1/Bv
         FL779zTN/GyA663W7T+WebZ8y/bMYh3qVPUzYKjzYciOyrPS7g/915dNFWDK9tZcKgbe
         H2ZfpKhMTVeLnNn05kt/qBVHlXq0sKnjAvz3sWXGdcFuBJzIvxf0pPXT/pvbXa3jKLg0
         argA==
X-Gm-Message-State: AOAM5329kzPKUrUwfgJcefwIsct/hg/Qwiu2VJ39ZG6l2PDXsSs1CGUI
        dkej4N3P5Inmh4YYtsbgBsgeug==
X-Google-Smtp-Source: ABdhPJzbPYzKTjLVZ7r5OyKSMssKQp99fwx2+5ZR2KRfl0z16NRiaF3hFXMPafTr4IwB2IkW3ePnxQ==
X-Received: by 2002:a92:d44f:: with SMTP id r15mr4160637ilm.237.1607532831277;
        Wed, 09 Dec 2020 08:53:51 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e25sm943626iom.40.2020.12.09.08.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 08:53:50 -0800 (PST)
Subject: Re: [RFC 0/2] nocopy bvec for direct IO
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <cover.1607477897.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b165cd42-be79-69ed-ae06-a3f3ff633c62@kernel.dk>
Date:   Wed, 9 Dec 2020 09:53:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1607477897.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/8/20 7:19 PM, Pavel Begunkov wrote:
> The idea is to avoid copying, merging, etc. bvec from iterator to bio
> in direct I/O and use the one we've already got. Hook it up for io_uring.
> Had an eye on it for a long, and it also was brought up by Matthew
> just recently. Let me know if I forgot or misplaced some tags.
> 
> A benchmark got me 430KIOPS vs 540KIOPS, or +25% on bare metal. And perf
> shows that bio_iov_iter_get_pages() was taking ~20%. The test is pretty
> silly, but still imposing. I'll redo it closer to reality for next
> iteration, anyway need to double check some cases.
> 
> If same applied to iomap, common chunck can be moved from block_dev
> into bio_iov_iter_get_pages(), but if there any benefit for filesystems,
> they should explicitly opt in with ITER_BVEC_FLAG_FIXED.

Ran this on a real device, and I get a 10% bump in performance with it.
That's pretty amazing! So please do pursue this one and pull it to
completion.

-- 
Jens Axboe

