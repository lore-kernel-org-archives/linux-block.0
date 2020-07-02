Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2488EC433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 19:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF53207CD
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 19:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AgbLvpJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGBTfI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGBTfI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 15:35:08 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02268C08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 12:35:08 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id z5so13935288pgb.6
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2020 12:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d5A8yh4Dr13sX2ZywwgxnMIhzrvGMxewH8dG4zP57Rw=;
        b=AgbLvpJTvH6D7chnDWGIsHjt1s8a2+YUblJV2wE8YTGYMudavQkxTEmrju+x420qax
         H03eyquU9NXw3phDiax75wSnegPhP2Dux+WxaJoaHU81p3zDZJqU0WsBnsJS2hJXgQqC
         NAr0Sn8DVY1lhRshxsuA09dYxbwfNwrxtrUkQ5W1bO6/YuWApTEgFr3mqfAv+ZAY9NJt
         NC3/ZasXOuJyx0bXpmt4pD2L8KKDnjwbF2wLmPZxuGlw/EhuqZcWSePO5BNEa38qDj0n
         5dEIs/eZZo41aTz1N3X39njGHraEuCQiIhX3r/QVgfB7LCpCbpWfw56XouPdwarNS84i
         dDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d5A8yh4Dr13sX2ZywwgxnMIhzrvGMxewH8dG4zP57Rw=;
        b=unMjwKwRqcS0krWpuOMgVdG9gXsZLQe6VqkJqfhO+kkxW5F1pngsGSSv5L+doKBeVg
         jU6o6TDctVYx5rosiSSfF+I24LsyeLa7kvptTnDf1oseQnIDLasXwCdpj3a5ACIQo2K6
         gKo8zK6u8sFfgktC1+GKxafz26QPua4iX8zbD29ksjbomAwzpvLZUkjOb3YyRdYCPkBp
         h8EgVmomWyCXVfU2VvKER8OGLbndv471Mtu5qgrzbKfnAYZ/+47FvkHibtvgnP1cvzAr
         abV+yttVApzoGXNtRXWVGhENVXsIQtgG7oh5HS4HkM9D6+jwZD6LJw6fqcnNQ5mKyLh/
         +w5A==
X-Gm-Message-State: AOAM531at9oq8QJeR01XTC/QfCA6FI7Lqtwv4XzCchTLErtUdDg84LOM
        Yh++LPBLZxGbsswG2vPdbE06MvrvDnXQNg==
X-Google-Smtp-Source: ABdhPJx5hjUQYoaaV0tPGeXHwqAAunfPcCec17SlRWBuaw7sPBUpJF1mDWADRDHq3DCXbeJe7cSDwA==
X-Received: by 2002:a63:eb55:: with SMTP id b21mr25616230pgk.433.1593718507472;
        Thu, 02 Jul 2020 12:35:07 -0700 (PDT)
Received: from [10.174.189.217] ([204.156.180.104])
        by smtp.gmail.com with ESMTPSA id 144sm9645096pfb.31.2020.07.02.12.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 12:35:06 -0700 (PDT)
Subject: Re: [PATCH] block: initialize current->bio_list[1] in
 __submit_bio_noacct_mq
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20200702192125.3754607-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c34b27f2-98b3-98d3-d1c7-a0665590f58b@kernel.dk>
Date:   Thu, 2 Jul 2020 13:35:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702192125.3754607-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/2/20 1:21 PM, Christoph Hellwig wrote:
> bio_alloc_bioset references current->bio_list[1], so we need to
> initialize it for the blk-mq submission path as well.

Applied, thanks.

-- 
Jens Axboe

