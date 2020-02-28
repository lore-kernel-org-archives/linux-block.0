Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC184C3F2CD
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 14:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F262469F
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 14:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="M1HRRYsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgB1O0B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:26:01 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44044 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgB1O0A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 09:26:00 -0500
Received: by mail-io1-f67.google.com with SMTP id z16so3540644iod.11
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2020 06:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l2WSH1oXYkiW7xPeB9rbvaZ7jIhKj/eFuTA0GXjb3nI=;
        b=M1HRRYsjitsovSHd+P8PpfeR+tB7pQ8p28KRekHwDSsesQsLWia+lN/ff0TlL2HhNJ
         guKkSAJ8Fbgw0+0xAyUmk7FpYymv+AUPYRY/EEnXHDe4/8NVLdBqxaliddYUipK7/2jb
         R8HRcBz/tjDekvYbhDcI93M8EhUE1tMl3PBECsYsuuQHR3V5M5/zHxlz9Ug7nMqE2y1i
         5OOOsA83JIex7/VKCzkv8iHmChHxlHgy6K+h4+nF049kCDaUvgkVLJD0JXKS4NZJ3g0H
         P8cSjAS4NEMRtvhnJE/os3l7Y26faBB2IsvSt+w3ajCydUYCI6dKD8148Bfd+0fGYYOL
         VZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l2WSH1oXYkiW7xPeB9rbvaZ7jIhKj/eFuTA0GXjb3nI=;
        b=AlgaMsSUHg97oZQlD+kWdOlPfv3dXWbolT5SHiKGZx0lwJuy35nrvJ8xL/9sZAMIER
         lAo8TvXl8/Yzi7qMqUqA1zWZOxEHjet+wI2QJyT5ggGFSqJ+xcMq8lCJBN9kcq0Vs0lD
         1Xr3A6bxjyAS19t6gic9z28uEmsDnyWGQHa6whq4wbyaJlY1XiNMvdhTvfvx4w0NTfef
         tJG/DFC4FxbZlopxkXqmdX/F/BPt+2fRAVzi056MFqAsiIISnYoFOv5QP/0cbCVBlX59
         c8xHIGGsLFZ6urw9jnN2apGQp9oHHIz/p0jFEN23OQx5bwuzEMSltjObk/CeIJnrB76V
         zKHA==
X-Gm-Message-State: APjAAAVO35FTb+/yLCgXxM3mc/yEa0HZrp7RBNR060Fnh2J/Q0ONwi9M
        gVXmJbI38SV5YEE69AHmVUKZcBDdT7E=
X-Google-Smtp-Source: APXvYqxpxYDUhqIs9YgHwUj4LkegpankEQOinBeCy7wnRJkpbKzyp+VOO0iRN2sv9gT0k08Wnjg2DQ==
X-Received: by 2002:a02:cd82:: with SMTP id l2mr3460112jap.103.1582899959967;
        Fri, 28 Feb 2020 06:25:59 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u15sm1249914iog.15.2020.02.28.06.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 06:25:59 -0800 (PST)
Subject: Re: [PATCH] loop: Fix IS_ERR() vs NULL bugs in loop_prepare_queue()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200228141350.iaviwnry3z4ipjqe@kili.mountain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c106c6ec-7171-3586-d5c5-5c14e386b3d5@kernel.dk>
Date:   Fri, 28 Feb 2020 07:25:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228141350.iaviwnry3z4ipjqe@kili.mountain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/28/20 7:13 AM, Dan Carpenter wrote:
> The alloc_workqueue() function returns NULL on error, it never returns
> error pointers.
> 
> Fixes: 29dab2122492 ("loop: use worker per cgroup instead of kworker")

I can't seem to find this commit?

-- 
Jens Axboe

