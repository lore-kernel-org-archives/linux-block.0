Return-Path: <SRS0=WP4r=WL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27C2C3A59C
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 17:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880D720578
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 17:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HZpXjn+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732221AbfHORWN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:22:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40279 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732171AbfHORWM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 13:22:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id e8so3109366qtp.7
        for <linux-block@vger.kernel.org>; Thu, 15 Aug 2019 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OQP1eUr9wWUBvltOQ9Z8Ub62tAaopiVDYE144Am9PUo=;
        b=HZpXjn+wNo0sYnP8fO/9yi9VvMIl2O1vBqS8Gie0c3FRn6sQcTfP9It56G6JplB5nu
         6VownGa1B8OF7b8irbXNCSR+PzKi7JmcuM4CQfuPlRxhfFejaHkab6ZOdE3AoI32m0ym
         9kJ/FcPddnqe494h+5mJIqpN8bMFl29a2XjmzcKwArH2JCGXbQ9IqvTODG3SBiXDo6OK
         yCF3is3A5wQj8iInyzHqtNlF6mJXcwZY3WY1cZAnr4RFS8A7douZtCnwhELnMFfM1jlj
         QwAOY9+OGQNin1iSiarC/jXnwc6Mrf+qPsKiJHOkejdQmAIyz9D1rE115khKlpbX0f0O
         kg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OQP1eUr9wWUBvltOQ9Z8Ub62tAaopiVDYE144Am9PUo=;
        b=MT7BTlMZL29Kke6oCz1I+rPvXDHVA61hbD87E5EL/So6Lx/YCEvrS9mz8bE5Jsu4kw
         nUnJholxvEYXQjRCmrKaqhx9cdDq1EZkZIDEpSHxkN1kYzuEwzdtRKyBC/fyNNxj1IvA
         tnLj8zxnxt1/0mbWLjyxj4OoPvK7OwwPY/YkOJIkfhdxXLpww5ARZblHZ+ul+RPLfHUK
         h0Ilx37fPcidOZ5PDsfYmGGd0GnVHJxLMD+svppOuA0/jq0sJyF0yYiArR8fsdvO1Zqi
         nxUF0zDN+ti8KTNJfaemt5xXuOlKqo4HueZv6l2Ddf/qXI0CNkJtRBX9TBffzm6gqm+Z
         dlkA==
X-Gm-Message-State: APjAAAWME7dG82upZS7EYYXPauEbDWRAK5EBqBoNaYv1HJdGdByJiHnX
        stDu+rq8ZNa4l7aKmrrmlxNyggxh8moAjA==
X-Google-Smtp-Source: APXvYqytVj4F93Lz8NG25cUqyDAsrQnJhJ3dX1TYfOQ21CEln44s8gEqzzxOvwnd/uQdneR7JttTRQ==
X-Received: by 2002:a02:5105:: with SMTP id s5mr6163824jaa.42.1565889730912;
        Thu, 15 Aug 2019 10:22:10 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f9sm4511731ioc.47.2019.08.15.10.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 10:22:10 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix manual setup of iov_iter for fixed buffers
To:     Aleix Roca Nonell <aleix.rocanonell@bsc.es>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190815120322.GA19630@rocks>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ab327769-f18d-61d4-1c71-fb7ad60bb53d@kernel.dk>
Date:   Thu, 15 Aug 2019 11:22:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815120322.GA19630@rocks>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/15/19 6:03 AM, Aleix Roca Nonell wrote:
> Commit bd11b3a391e3 ("io_uring: don't use iov_iter_advance() for fixed
> buffers") introduced an optimization to avoid using the slow
> iov_iter_advance by manually populating the iov_iter iterator in some
> cases.
> 
> However, the computation of the iterator count field was erroneous: The
> first bvec was always accounted for an extent of page size even if the
> bvec length was smaller.
> 
> In consequence, some I/O operations on fixed buffers were unable to
> operate on the full extent of the buffer, consistently skipping some
> bytes at the end of it.

Applied, thanks.

-- 
Jens Axboe

