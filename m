Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A729C433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 12:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18965611AE
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 12:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241097AbhDPMbI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 08:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240778AbhDPMbC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 08:31:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B177C061761
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 05:30:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so16279284pjb.4
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 05:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5iDQ+n5O+yKXMjT+TRIf4eZ4wu1n263xyTGUJyOMGZk=;
        b=poaug3sfihBK/PNZlpnWudeGAAaaZGqBflAJqkGlUdZOkob3Rlj+kRbCgHuXqrGxfU
         9bH/OsiNwI4rE8Vyh8E0eI+fBJiZW6S5L6MDSTSHLTQIrKPvGA5XJFdJKL0BRDFFO9uZ
         +bEA+KMj6VmchABU9cEWhLJqky38zZHnzlHJl1mATVroUHQ906GtpZpAGLc91o1uGxDk
         NIRVH/vM0cBnPZ9qW8xCdtXBHlhhOeXjhJyGEFCNRjrpCn5c/qlXpGUYB+LCqw6Q5lvy
         hNsOt34tkvimsHY5eCftYUJNtyh1JkbMpLRUOMcBYgOQRV0R0gtEUfppI/YbR3Qtp+9E
         QizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5iDQ+n5O+yKXMjT+TRIf4eZ4wu1n263xyTGUJyOMGZk=;
        b=kM1ilGf66XzQx045u9Mnp42Xmk6YSRr/2JobuOZgiXA/0xVapJCPzrgdhmtD2CsNLz
         hPVzZeXzq9ExibyBu4neTV1UIWqlDhR2PwGC1zm7vR6LQuRZgzmP5OQZEtHGCIzMADli
         GlEXkAZ5vLoVRnGwUjyn2UJsDbIYW7JW3CbQ7yHFh7AZq2+hbRtxxkYHTDY9C7yqLfMe
         5HW68eFxa9YXdiPSbFIbKkueFn5WH9UVVTwdWI1bZP0M/4/0T0CXOmAc7AkXMKobEHvJ
         WI4loDpN4f69l7gP4PL6qqwFkzoTibI1BvPMmCTnhbmvbYWH7ZxaaS5tG8BZQXQP88ZQ
         /nbg==
X-Gm-Message-State: AOAM533XFY7uBRa1GVyANBI6TCywssKhvp7vYZ/ZsWFqudfpehve/GTb
        jYwuIbwEu+JK+Wv+1h5ymRAD05we3HQgpA==
X-Google-Smtp-Source: ABdhPJw9rE4NqIus0mK7zt2Ef16XnLgBz/gbAgkWlhy2LAvQdKD98QnKkKd465mwQJSXov69gYu8Zg==
X-Received: by 2002:a17:90a:7f95:: with SMTP id m21mr9850212pjl.174.1618576233554;
        Fri, 16 Apr 2021 05:30:33 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i10sm1668126pfo.37.2021.04.16.05.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 05:30:33 -0700 (PDT)
Subject: Re: [PATCH] floppy: remove redundant assignment to variable st
To:     Denis Efremov <efremov@linux.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin King <colin.king@canonical.com>,
        Willy Tarreau <w@1wt.eu>,
        linux-block <linux-block@vger.kernel.org>
References: <20210415130020.1959951-1-colin.king@canonical.com>
 <d6c29628-be82-c812-e021-fd0f0ab02172@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a61c6976-0035-d562-6059-d8ae0c6d2425@kernel.dk>
Date:   Fri, 16 Apr 2021 06:30:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d6c29628-be82-c812-e021-fd0f0ab02172@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/21 6:29 AM, Denis Efremov wrote:
> Jens, could you please take this one? I thought to send it to you with other
> cleanup patches in a merge request, but you already applied rest of the
> patches. If you prefer to take it as merge request, it's ok I'll send it
> based on your branch for-5.13/drivers.

I have applied it, thanks.

-- 
Jens Axboe

