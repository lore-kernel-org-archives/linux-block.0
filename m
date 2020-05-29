Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2477CC433DF
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 17:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B442065F
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 17:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QuGmybJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgE2Rm0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 13:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgE2RmY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 13:42:24 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D91C03E969
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 10:42:23 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 131so93445pfv.13
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OO4kSbvrih2YIhfL8nJkaYn8RNpYzknVtrmNyYtOCug=;
        b=QuGmybJnGVpY4Kj7hE/VsimuXCnT5QbVW8KLxWmcSJuQD0AQcozHdMVMvV2atmf69V
         agalVmqCBCsKNW8HMA6b/CBsWWqoaViA9/UNQxXgRyNPfC8Ylzh1aVtyoThRdSxwBp3F
         1ZA81AiltXokoLVWuB9KeKhrlLYRelr2zY9gVoKCud7munlIk0vzAm5F2w5YDLj/COBG
         giqED11EhK9J/WYq21U3ScP1R1YmBanoo4dTZRquvro5iHBrW/kAh8qCqimM/iLA9Nbh
         c5LQcOa6frHbwB7GU+mkQbLApAO/E3qr33cWdnNap/wTlwb07w5yhSab8OdJ9lXMy123
         NoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OO4kSbvrih2YIhfL8nJkaYn8RNpYzknVtrmNyYtOCug=;
        b=Hq3c/+zOMooCLbKeHbHqU4P8y51EmGgirQecZP3r8i1Y2H4gGQIgvB6WQuSIGIbn6/
         IsiGaB1RUFtfvIEvNZh2hUp443d7plOfiRxHCmcOuxEDGaAOU0mXzB9v6p5SbdXALHQR
         oM0muyjqxBtuYEx6xNSeaR42XIkvqfOYyx6EwFx/vwbBbRjY+wEFehpLI8mhFggUvB6h
         6JBKy0dK3jtF6599LOi8OEBMUJxsv07JDfH+KSYrDUqOFJkoY/XtZOEhsN3QIZ9e8PQn
         AlWmUQpy5gjwgvm60W4b8rpBa0wH+wqBfaCW1gXiDUj9FdBGZXm04GEOsKOiBhmphUrH
         I6Jw==
X-Gm-Message-State: AOAM533wl8t1EfI1CmK6aEDt2qNiI86gWz74Y9BlQTiqw26DUMbvelH1
        RqJmqw9hWhcGJd2YGyk5RlFi5w==
X-Google-Smtp-Source: ABdhPJzNjilukrhtn1y0iMn0ndPQJ6YvLYHdK5fV+M2Phv5I0horjqIGCh3VKdPWeYSvsI2YklinlQ==
X-Received: by 2002:a63:4555:: with SMTP id u21mr9065152pgk.127.1590774143387;
        Fri, 29 May 2020 10:42:23 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d67sm7901480pfc.63.2020.05.29.10.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 10:42:22 -0700 (PDT)
Subject: Re: [PATCH for-next 1/1] null_blk: force complete for timeout request
To:     Dongli Zhang <dongli.zhang@oracle.com>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200529173108.25198-1-dongli.zhang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <351116db-56b6-4865-efe8-fab4fec2f010@kernel.dk>
Date:   Fri, 29 May 2020 11:42:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529173108.25198-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/29/20 11:31 AM, Dongli Zhang wrote:
> The commit 7b11eab041da ("blk-mq: blk-mq: provide forced completion
> method") exports new API to force a request to complete without error
> injection.
> 
> There should be no error injection when completing a request by timeout
> handler.
> 
> Otherwise, the below would hang because timeout handler is failed.
> 
> echo 100 > /sys/kernel/debug/fail_io_timeout/probability
> echo 1000 > /sys/kernel/debug/fail_io_timeout/times
> echo 1 > /sys/block/nullb0/io-timeout-fail
> dd if=/dev/zero of=/dev/nullb0 bs=512 count=1 oflag=direct
> 
> With this patch, the timeout handler is able to complete the IO.

Applied, thanks.

-- 
Jens Axboe

