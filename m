Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91007C433F5
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 12:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbiERMcr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 08:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbiERMbU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 08:31:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3633A199B03
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 05:28:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ds11so1899079pjb.0
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 05:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RKKiWskFYEO4JtJYg3y4PPO7hdCJClkCLDpQ1ZxY9IE=;
        b=Y/A1vUTBeIKsExnYauXIr/evTkQLOMipBRqSBbSDBFhSuULTERLwRALe4s19NvAXQQ
         4117TIqbvQmBNEoVFpuhKgKfk1woFKI2/54Mogo0XItNIGkVtT9SERSPu0TVBcAFcD8G
         IPI69QGYOSMIRcumPwOywOqIKTzkLh9IYn/jGOIugMsCXQ8TUrqiJOEi+OmzAKwyPwzX
         qwBQcaXampsct/0IAQXijOOdbtAf1Hb5y7yTLQNNePWr+737eFkOLfXmzc1626mlubLr
         CP7JmzDlq8bo1hrIpCit30BtmPpf1+P+IyPU6kTCGSV9AuqhjxhAVSELFIN/4TAsKTHh
         NpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RKKiWskFYEO4JtJYg3y4PPO7hdCJClkCLDpQ1ZxY9IE=;
        b=6AbvHQqeJD5SBVTxCZJ0PMeEMtrZJUDIa3eGIvzcFEN/4P7Dt8UHSJ+uD0X4gmABHW
         jRV+J/AKR8UoeWi1BSiN35Obip3wrgBC/HXk1vzWnnOIriTLq7MBuxI021SN9lx7yHhd
         Puyc0UXQCf/gUypDQPWTmhB5Z11BHWu2ha/YBSKCnC2wSZi0wHUxH0RXUtcCSbv0YrCG
         Gk48cEbS5S62aJZC59yLnB3Dl78P8aZisbNVLNkYHSNCeLCzJT2d2Bb77aC6pqFsCpfP
         kAyjk9hwsGpnbQrxnVYmBY4q06iPCa1g5M5kFKV8zcImx0e5xJ69qf7bnoqTlRXk/+Ce
         u1kg==
X-Gm-Message-State: AOAM531JQFLiwc1lPxmojn8ZJCAY987Ai6RUnota7EkZoTbm1Rlb3VCA
        MybVdeseHzXcSeTLWkMRWBx5g4M0eJlCiQ==
X-Google-Smtp-Source: ABdhPJz61MW7jCYQilLUG+EiwA8dYn/bkzlKKTpAKcSo1M3wVYLLqNTLCMVrnqHQg8LOwFHk1Xw5jw==
X-Received: by 2002:a17:902:b18e:b0:15f:b2c:6ca with SMTP id s14-20020a170902b18e00b0015f0b2c06camr27066398plr.84.1652876928929;
        Wed, 18 May 2022 05:28:48 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 64-20020a620543000000b0050dc76281e0sm1755807pff.186.2022.05.18.05.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 05:28:48 -0700 (PDT)
Message-ID: <33fcd4f2-3318-2d64-0aa1-f55fceb32bfb@kernel.dk>
Date:   Wed, 18 May 2022 06:28:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [GIT PULL] nvme updates for Linux 5.19
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YoSWZoB1/38DdP4S@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YoSWZoB1/38DdP4S@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/22 12:47 AM, Christoph Hellwig wrote:
> The following changes since commit c23d47abee3a54e4991ed3993340596d04aabd6a:
> 
>   loop: remove most the top-of-file boilerplate comment from the UAPI header (2022-05-10 06:30:05 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.19-2022-05-18

Pulled, thanks.

-- 
Jens Axboe

