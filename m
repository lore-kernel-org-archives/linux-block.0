Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA19C433C1
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 16:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8415E61A1E
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 16:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCYQub (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 12:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCYQub (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 12:50:31 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14739C06174A
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 09:50:31 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id z9so2686328ilb.4
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eGM+Wb+P5x3c9noHsnTuN/hj/s8DPZX00U0JLAeymJ8=;
        b=iqsccfzlZru7D/SzBxZSQV6V8nNiKAD6l2/EWpgaUa1obvKDk7301p63rga1nxatXt
         ASDt6GWHWiONj/FqhnazOKXO9DuAlid931fdQlD/Vt3/JMmD4Xqnx05a5iWrSF5AlWrw
         ot9g4QBq44RmXw2n0mZ1w+KaHeuE6gKcTtgLcYC6zuQIw+4QmtWdrq3OyhEQfgkVRLC/
         wZCzf8o402FaOBB4ErsZIHClOdXIVR71s2JQmogVasfU9fBO7wjBDcQ7xsgk/FpUJJ9s
         LIiw6YnWtig16v2xxq/7KM5UeLLxguky6T9HmSCH8G4a0hRc4hHaU/Gv7pJq63fkOl8U
         /XAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eGM+Wb+P5x3c9noHsnTuN/hj/s8DPZX00U0JLAeymJ8=;
        b=iDQEDQrv2Gleckl1OHQFPabDTLvwn4/M1Gw9Dh0f7uxcNee0iHBDH+SYgwqi1qjdX6
         dSSyh997xa+5hasWAiwsgmq22LxZCrQ0EqfhJ0BK3uMs7WroiFR3SrGbnhAntiHnuyyo
         QkV+etThyDX8ejSMpdLP1g38JJDxUBFTw/+CMDy1Dj4oObeGZItxtsAFo1EC5EUUZQoH
         qSyxb8YtkxIFnEeAhEQ27OaNQ79swwK4o/HhaV/Gcrp7nt1bOksRex6dYns0Ovp23psm
         9sIFdHjfW4c5xXBN2gutJAo2HKVqQxRWM3lEFMioDiw7JKCyoaxk8ZSDUd7HteEnFwIV
         75Vw==
X-Gm-Message-State: AOAM532Z5GVUNWUedTxK5mM9NX2ax1RPpfJep5kz4+vyjWkzBedcrSq6
        8t2MFFnknBgC4rkYcdsr5zwtpA==
X-Google-Smtp-Source: ABdhPJxK2Y+ZDGrbyjvV8N8vjntGzKY/hZmvzOaSKdaSY7GDlqdJYuPjJVZ2yCIvDVEZRDNchtNZxg==
X-Received: by 2002:a92:d783:: with SMTP id d3mr7712362iln.256.1616691030522;
        Thu, 25 Mar 2021 09:50:30 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q8sm2902491ilv.55.2021.03.25.09.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 09:50:30 -0700 (PDT)
Subject: Re: [PATCH BUGFIX/IMPROVEMENT V2 0/6] revised version of third and
 last batch of patches
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210304174627.161-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <96b5c1f4-2814-2d88-6e05-6bfb10c8e9e2@kernel.dk>
Date:   Thu, 25 Mar 2021 10:50:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210304174627.161-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/4/21 10:46 AM, Paolo Valente wrote:
> Hi,
> this is the V2 for the third and last batches of patches that I
> proposed recently [1].
> 
> I've tried to address all issues raised in [1].
> 
> In more detail, main changes for V1 are:
> 1. I've improved code as requested in "block, bfq: merge bursts of
> newly-created queues"
> 2. I've improved comments as requested in "block, bfq: put reqs of
> waker and woken in dispatch list"

Applied, thanks.

-- 
Jens Axboe

