Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42020C0650F
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 13:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBDD21479
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 13:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EylqCyMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733063AbfHHNbT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:31:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44173 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732865AbfHHNbT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 09:31:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so43524787plr.11
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2019 06:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BOGXkv2eq5LzpgbiQpijW+BYV+myujjXowu9Y8jZ1JU=;
        b=EylqCyMdUfJCaP+DGBkKQp3ZouA8/qzfrRCwdhcc3Pxzzq5HqbsJ1FBBtJzq6K7brl
         9yTwUCPKvhAuyZ8s1JswtB3P6V9oUx7vqE72lXBXTRSIFrWxBymddeGHyaO8b5xIocEU
         9hCqXmk7ENjL5aDEdxvpXVcn5owpRK6hThCzPXMJyfwzGoRuQaEVP35daFufVVvpasUr
         CFLB55yTwoa3Gq9RWoVw8VOjXiQ9yE3DEipTfS7V4de6xEq7BN5DTdQ/sfGkP3hRnJfr
         +EhqtvJbJqNabCSxp5meecDdQfRAZ/GMuWcCQcuC8VLB8wUG7gAzumLzeQ028WTrrxhe
         +x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BOGXkv2eq5LzpgbiQpijW+BYV+myujjXowu9Y8jZ1JU=;
        b=e9Q1HAKI/wgkUkxhYOTQ2lOe45VAyK1l+kKQr1dOYx9lK+aRvwE7BduI/OxRMkh6Hq
         0WquFSz5KwJb/St+paCH7v50pj/x/zUrJlj5Ol6VZDVfmHz6H/Fyi+gDZowBafPmCFAL
         GBsgVu+NhbaD11gKbtj9wT1MiGN9KnycnhQrXW8ICjskGfXPk+XySown2FbHpsiXmZ7A
         Qa0xwLtgvKuXDdGYvhZ4aS3XKaZc10qk8qcC99TGTi9Isjzsq8mIAqSxIollxD9rA2Ss
         NeqFQXH6XkpGNQ7S48sVv7vv8AoatTMSAxM2cN6uMsWstalTHDoO8G3U/1rFPB4hnN9u
         MUnw==
X-Gm-Message-State: APjAAAXAHfmfDXx4y9onB0z5CKspHSHPrvuDS9f93SH+GUsAM7PQD0XA
        Ztk1+mI2KgShutx7js2RSv+SEY6UxA3Thw==
X-Google-Smtp-Source: APXvYqwzC8UH+BwTDNYOd9a8XdLsnp2ltbmnDTl1XWwJvQnwqtaNO8EdxMmTOpgrx05xp3m7rwRhmw==
X-Received: by 2002:a17:902:7202:: with SMTP id ba2mr14065245plb.266.1565271078780;
        Thu, 08 Aug 2019 06:31:18 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:186c:3a47:dc97:3ed1? ([2605:e000:100e:83a1:186c:3a47:dc97:3ed1])
        by smtp.gmail.com with ESMTPSA id x1sm2445502pjo.4.2019.08.08.06.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 06:31:17 -0700 (PDT)
Subject: Re: [PATCH BUGFIX 0/2] block, bfq: fix user after free
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        pavel@denx.de
References: <20190807141754.3567-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d081622d-0e0a-14d0-449b-27900ac94904@kernel.dk>
Date:   Thu, 8 Aug 2019 06:31:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807141754.3567-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/7/19 7:17 AM, Paolo Valente wrote:
> Hi Jens,
> this series contains a pair of fixes for the UAF reported in
> [1]. These patches are the result of the testing described in this
> Chrome OS issue [2] since Comment 57.

Applied, thanks.

-- 
Jens Axboe

