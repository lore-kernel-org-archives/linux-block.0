Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF7FC4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 14:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D1BE611CB
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 14:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbhHXOGK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbhHXOGG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 10:06:06 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AAEC0613C1
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 07:05:22 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b7so26492809iob.4
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 07:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nw4sTpUNgZ91n+tpkyucZrTxjzDAr9k+GWnIeUz1zEM=;
        b=RpmcbbU9SAFt4TRzy0Rf7Y7cjgsvmxmv4X/mXEpqVHuvNojuds0BcCzUJ35yu4t28g
         WRuigI6a4XMITPP4T87ATpzZc6qYbHNDn3ZE6D33WsvIUbLhsXCq16SWTVig55AhAFfx
         LqeME3pEDWQSaW8Hm77wL4zrCI+YKmGe1ZEKXNUV2x6tUBEFWZs03UDN1A5Me/afmIQf
         UovEA7lZ1qPFH9Jy3QmUb8qELpz5wQIio2j+hAUZt8LGt1c3SD3NRM1Fb7KzzGULauUN
         sh89VdhyAlVIX/it51ZPVDfHPG+R3QLL7QRd/Gfgo2GUVZCaKlmMHkLBaGUg9K1gyPlJ
         15Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nw4sTpUNgZ91n+tpkyucZrTxjzDAr9k+GWnIeUz1zEM=;
        b=hQr2NnzvDN0u5U1lpKUtnpbHrEDKzm6XsnQesK7QSQOtKlTnXuXaSJkgiQ3169auiL
         bUF4OceFDQx4miXqasec0c7u1iDk0k1eqhgaja0fpJMg5vPIDXFQuVmQvqxNHOOfiArK
         TWYVryPOsHz0CeJ4/aRI+TgvZ7YF9ftVVpF7WsCNR3ZQ7ZYH0T5ou4TCwtKSvoawLcr/
         j8mkIa8k9w2toWCrVVHQFhgf51UZCfijRAXDJlmYT7+is2J52DijUGUSFauCIGtWwc1T
         60ld3iaPbaFtu9LFnW8IE1RiveWky0GG1kTuNYgHEhy0qmK0LLk6NaE5qehsWP5PwMYA
         NoYg==
X-Gm-Message-State: AOAM532DxWCdWHjtVIS//Q6db0vfW6MxTHfe04YlcK1nwOMu1ve579kR
        zqiADN+SNA3dw5Fxfldj8vmkvw==
X-Google-Smtp-Source: ABdhPJyQjd1lgxFqhQEeITg5uHPGBOyqC6jap0Wkfu45PtQAH/+j6XoyBxZTwGHgKIdQMeaip6KMjw==
X-Received: by 2002:a05:6638:338a:: with SMTP id h10mr11452181jav.8.1629813921630;
        Tue, 24 Aug 2021 07:05:21 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g14sm9920161ioe.55.2021.08.24.07.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 07:05:20 -0700 (PDT)
Subject: Re: [RFC] bio: fix page leak bio_add_hw_page failure
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>
References: <1edfa6a2ffd66d55e6345a477df5387d2c1415d0.1626653825.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e009dc29-6b05-184d-513c-ffcb175ab34c@kernel.dk>
Date:   Tue, 24 Aug 2021 08:05:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1edfa6a2ffd66d55e6345a477df5387d2c1415d0.1626653825.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/19/21 4:53 AM, Pavel Begunkov wrote:
> __bio_iov_append_get_pages() doesn't put not appended pages on
> bio_add_hw_page() failure, so potentially leaking them, fix it. Also, do
> the same for __bio_iov_iter_get_pages(), even though it looks like it
> can't be triggered by userspace in this case.

Applied for 5.15, thanks.

-- 
Jens Axboe

