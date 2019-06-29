Return-Path: <SRS0=xgQW=U4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D45CC4321A
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 15:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5704208E3
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 15:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JsRzVHcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfF2PiR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jun 2019 11:38:17 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36307 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfF2PiR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 11:38:17 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so19083212ioh.3
        for <linux-block@vger.kernel.org>; Sat, 29 Jun 2019 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=umCJsC+Xi/AFXT71IkKzcjjIl1YRRQ69dceOHAE2Rpw=;
        b=JsRzVHcpRO5C6DQGxzUnXA/bBlClgjfo3FOq6JDjYMD0TIWq3wyQUlUO+zoMAAJJiN
         plhuRyPpu+OvvKtVZ3m/MpKDH5kggibfodAC5yC1M5gZ4I8pRcy2RZlbIc1hO4tVv5B6
         fEJtHIbdmq7FfwCJiWTyYmUCneGLLDHaSvOhLEePbh9JVd42WisZaU4KasVmEcqUoh9v
         ztkDQGt9JfQn17Q7poVjX5v7yjBzJfIdQsZNtgYe3U4pUHA7n0CywUg5DfO3hj5BoOW+
         COBQy2Cd8Gn8nfkOzCdTe54b6wxA0DpTjwih8OA8TYmS7OVZgPvQHgYxXgQ04cH7ZdyJ
         LNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=umCJsC+Xi/AFXT71IkKzcjjIl1YRRQ69dceOHAE2Rpw=;
        b=Ui8uhoaHatboyId2FRdxBjYz9Za8hPpeUkwHU4t4/And1vTaCKlmfs/qeEI6fmPme7
         LogFv/AINOHDNHp16gnYReCo0HbBMgDlTMXeEY8Fb+T8RAx2H5iUwTG5TE5+7Pxy0qTI
         JkKKQV/9Nl+P9/dQD71kDRHksTtrFz8UUXNlFkJMw60ChFe7S0NgNwSnBMxXwqe+errX
         cbvCGi2WrGRdbMbRrZPnCC3oH0KTzVJnC4YtYd8bb5SSLmped6cN/xd5TlLsT7X36/3H
         97ji9HIH5BjAPrFGuJ+x62ECMDtZ+WUpmWZeeMNxWob/bJLceWXxtKD9WWSFksdqUzE7
         WatA==
X-Gm-Message-State: APjAAAUaySIJAGevLRoWczxD/aP0sXRjzjlCWBbmk979nIwbhpQiWMwv
        7hP7kAKDEW3CAAQ3/N54ju6/4vUi3MZ66A==
X-Google-Smtp-Source: APXvYqyhKXf591aWyNUdyUeTN6Iy7or+i+HBbzgNvea/tB3fB+8HDAamz5UGnJNC9Dk80j8Gsj0PLw==
X-Received: by 2002:a05:6638:201:: with SMTP id e1mr17878784jaq.45.1561822696136;
        Sat, 29 Jun 2019 08:38:16 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u187sm11169149iod.37.2019.06.29.08.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 08:38:15 -0700 (PDT)
Subject: Re: [PATCH 0/4] Improve block layer request queue sysfs parameter
 documentation
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20190628200745.206110-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eec45082-47e8-a736-df82-1f03bcfa939f@kernel.dk>
Date:   Sat, 29 Jun 2019 09:38:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190628200745.206110-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/28/19 2:07 PM, Bart Van Assche wrote:
> Hi Jens,
> 
> While reviewing Documentation/block/queue-sysfs.txt I noticed one spelling
> issue, that the parameters are not listed alphabetically, that the word
> 'segments' needs clarification and also that documentation for some
> parameters is missing. These patches address all four these issues. Please
> consider these patches for kernel v5.3.

Thanks Bart, applied.

-- 
Jens Axboe

