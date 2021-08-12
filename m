Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDC5C432BE
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 16:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B8BD6109F
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 16:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhHLQax (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 12:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbhHLQax (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 12:30:53 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2104C0617A8
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 09:30:27 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id h11so11320801oie.0
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x4cHlQi/obhutO8LyeLFAXruEbBUWhCtJGxWE1s0N8U=;
        b=1rQ0mvustmtHXZ9U4L7gESxZbbqf2omo6y+0DkbXfIM5f7jDR1C54mTtLi+VBRe8Ri
         eKlcSaEDchw6I1SlloYW3zJh04HuTIYO+Q882Jty+7he4kk9+5qPwRsQsLOZVeMjMIsc
         oi3ti9jbeFQ7J/hgVkb0EM50yCmk+wxySBnupMJHBjAM0Bx5zUYk34ix6PG4vi9yZ7oa
         d48PgHNqKN03IFkifLYQ62bUSU7YhdJZ0I9vvA5ZLVJIw2JCm7DusCjxWeO87jlAh9zg
         oSC9fDh0NRkzMVe+Tlv05IDtO33QLAZpSejO9BUjaeTjO8bYFsIpetOwwMJGZLXPeFsA
         N4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x4cHlQi/obhutO8LyeLFAXruEbBUWhCtJGxWE1s0N8U=;
        b=lPq1nMFC69kAMNc2C2nAQRabCGf9xngHm3O1IYAdO7QWL7KL3ygHCMq3bjXekXYizm
         v3wNOKLvwRgh1nqz6IXb7d3PwM/QVRx2DgO2LYgo6iTCvwOq9vgTqBHCc+30jz5uWNnw
         bNcBqmb3jeqOCSWcR0AJyKKyjHiQZAhL2tuhWBgEFdOJWaFjDMcHcqdA3EIigh3Ik2hv
         zMkm+OG9NUgfyTeW+/Xk2kcdWrHoCCO5nwEd4OUx2DQQcTbv1+/1xvDqPtPnk1BH4VYS
         4r6Zmeyw6yp8gi8rgk1EcbyGbVkdXetuq6/CJYXTKK/doNtcIJ54xwUJ+c45su6Lb81A
         HCbQ==
X-Gm-Message-State: AOAM530LXLkZZcJ2hjVAReChJGGkSI2ihExkz2WvGNSl4qU2VbwATVCy
        zA2HR0Tu2Mo35m/3aHPewt5FRg==
X-Google-Smtp-Source: ABdhPJy2dkFA+KnUiS1sS6pKuw2wcOYGZn612cKtDfh2S9ahMGuS9i7oBMQNyXf3JaG+igFZLuxRCw==
X-Received: by 2002:aca:1c0a:: with SMTP id c10mr4010067oic.87.1628785827272;
        Thu, 12 Aug 2021 09:30:27 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m9sm637634ooe.32.2021.08.12.09.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 09:30:26 -0700 (PDT)
Subject: Re: remove GENHD_FL_UP
To:     Christoph Hellwig <hch@lst.de>
Cc:     Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20210809064028.1198327-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <477bcf09-1711-b643-85b2-e8f0809b6dda@kernel.dk>
Date:   Thu, 12 Aug 2021 10:30:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210809064028.1198327-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/9/21 12:40 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series first cleans up various drivers to not rely on the
> internal GENHD_FL_UP to decided if they need to call del_gendisk
> and then removes the flag entirely.

Applied, thanks.

-- 
Jens Axboe

