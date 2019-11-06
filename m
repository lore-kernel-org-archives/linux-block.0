Return-Path: <SRS0=NI9l=Y6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6078C5DF63
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 14:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6CD20663
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 14:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="drMejIE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbfKFOKF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:10:05 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46756 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfKFOKE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Nov 2019 09:10:04 -0500
Received: by mail-io1-f66.google.com with SMTP id c6so27067957ioo.13
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2019 06:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3wrtEF/Rzlh75tZwEt9oiPqiKdXJjmpMQ9Y7AZzRq0Q=;
        b=drMejIE+n44EQB/7Y8f0aFSCwCUnxKnblRpdGjLXV9d/F0RagTG1Q/2EfJL91/9e71
         3buO3nJeh37HEJZDuQNuu2tOgGj9y/jAEcWJ63i7mK5myctJnWHq9Cuelez2yOBtXvkl
         RsdXm1PxJ6PanTxZR+kZQ5x49lx4jkMAd0AXg+t/tRc3dN6r7xrQQhq2nj7HcEhGzFKN
         eUm5FHQ8FE7ewHnRkjt8LpD35sb48jCaSlqKu3Ed9BD2SFT312otwLgVf5wzbyOLMGWh
         dGyJRDsWKYs0LxDrYydIoUbfQFyrrqti2CysKVWTuESSapkMBTyqdDJ4Zoy6ITJDE5P3
         Y1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3wrtEF/Rzlh75tZwEt9oiPqiKdXJjmpMQ9Y7AZzRq0Q=;
        b=E34L7dIgPj16EKDE/mXNAo9J1PG/mfTlsZtp2qEnWN8RQR0GlxZn/Zdw56gys+Z9w/
         KygM1riMijFYGfpUAAqMi1AO4VxQdUdxSqGiRdQzGhR1WP8h6XSz27ACez5TWpY/J4vK
         8Mucx/YytxkrapABQsMtK/M9dZ9XAgriM34zPomMGes4mKe9xYZtD1Vuv2lyy7kleG99
         jN2BagxISGhmyPIMBysd+VFaAy6SP4Wpv6/O9AuO7r7yuJowOmRwK2RzS8h6BR4NJZXP
         lM+kP+OgAknyntat/gn5imVJ7mYEH9pBH6433pgCd2HXHzYnxy8GZOAVcWQKe9Siqnu2
         0f+g==
X-Gm-Message-State: APjAAAVECq0YDLcJ6xzpXa1w3pZPVPQ/IW0ckg878YZa04LVzXim4GNg
        /lPKs7LMz5X+9qLFQ/dPWwI3PA==
X-Google-Smtp-Source: APXvYqzu6A1QOsFkaiXnwKhhauiHvp45yIxCn7YcXr9lkZvvYsm7nX83dqhE4BkhYs4Ixy7Te3y/oQ==
X-Received: by 2002:a6b:f306:: with SMTP id m6mr2378847ioh.172.1573049403353;
        Wed, 06 Nov 2019 06:10:03 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r17sm3544372ill.19.2019.11.06.06.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 06:10:02 -0800 (PST)
Subject: Re: [PATCH v2 0/2] cleanup of submission path
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1572988512.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9456fb9c-956d-62da-807c-498d2885f968@kernel.dk>
Date:   Wed, 6 Nov 2019 07:10:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1572988512.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/5/19 2:22 PM, Pavel Begunkov wrote:
> A minor cleanup of io_submit_sqes() and io_ring_submit().
> 
> v2: rebased
>      move io_queue_link_head()
> 
> Pavel Begunkov (2):
>    io_uring: Merge io_submit_sqes and io_ring_submit
>    io_uring: io_queue_link*() right after submit
> 
>   fs/io_uring.c | 110 +++++++++++++-------------------------------------
>   1 file changed, 28 insertions(+), 82 deletions(-)

Applied this series, thanks Pavel.

-- 
Jens Axboe

