Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F690C433FE
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 13:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbiKWNzb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 08:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbiKWNzH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 08:55:07 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4D76CA1B
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 05:49:21 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b29so17336244pfp.13
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 05:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zrVe2HG7K4KYDuuN/nWl35U8fSffq8o7IIpF1fFkJnw=;
        b=f5JyZx5tZM8pw4jNUo0ArgCIRmBp3uAVAITbN6XSZGW7+Xu8vQbZOjD9wjgloJPHBW
         7wVM8g1nog9VscQPI+BWBTk03tTqIY3Umm2NWZ9n8YIA+3fmehkpU3RRYiCejKJwHRJW
         9U+DcMKtYmMNovvRUk7odGb2Jzr0dlzyBFTos8MiWorygAF6IHyi62PAu8qdkLjF4lyy
         Ap/sczrMwySEfqIDIYiVQKTr9lyvUGh6tk7eJjVnPKBdCP06CSw4H2E5SHNIza40xvyq
         silov/8iQ+KM4sdOMGb/1rDqZ7nWiqUJhP78RNNjNBrf3LQRnzoKr0GbZP+W1NEK1VEV
         IkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrVe2HG7K4KYDuuN/nWl35U8fSffq8o7IIpF1fFkJnw=;
        b=QUw2RimzMZ576EY8P4R/7vEjQzB5audkkk3+PellJwgf6G1ZP3QpKltHQ+HvYX1rvW
         mgwMnA4uWfQGXYFSNlD+gdx6d+34o2baVDBTlh3IxuFJqDJkrsDfX6BcNVXWHXOdAnVe
         QJ9le64rDuqtVHKzwLIiTvfZxpxXcKG/lPqAVZOfDcwe2EGR9CKwIPmH+XXOjTquZiIR
         whUZZdiTVGg7hWEPqlr0PSa91JvN3caZNs0ZCOp3E2jCWPFztr2NMKm+BXVAdq7DnhPq
         TW9089w8ekQLvcibsNadge4WsCE+E95PZNmF7xeh+7JHXSGMoZPF9Bc9GAd92A7hDfrs
         pQZg==
X-Gm-Message-State: ANoB5pnOKiKawB9eheKhdW7LmuxCSqT+++YsORO4IBSs1oa4DMXcnnw2
        Znq5dWFMg326tEAzOlgyB0WaoQ==
X-Google-Smtp-Source: AA0mqf7e1xKNCeTa0rWTsmWUe76k1WT/wUtiPZ8XSANCaGFuONk3yiRkZ9VZVwAK6adqjtvdG/x1Nw==
X-Received: by 2002:a63:ec10:0:b0:477:b359:f03c with SMTP id j16-20020a63ec10000000b00477b359f03cmr4879022pgh.32.1669211361255;
        Wed, 23 Nov 2022 05:49:21 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b0016c9e5f291bsm14481768plh.111.2022.11.23.05.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 05:49:20 -0800 (PST)
Message-ID: <5760ca74-002a-ee41-fa46-3d8bdd5b2afe@kernel.dk>
Date:   Wed, 23 Nov 2022 06:49:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 0/2] drbd bugfix and cleanup.
Content-Language: en-US
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     liwei391@huawei.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com
References: <20221123020355.2470160-1-bobo.shaobowang@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221123020355.2470160-1-bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/22/22 7:03 PM, Wang ShaoBo wrote:
> drbd bugfix and cleanup.
> 
> v3:
>   - add out_* label for destroy_workqueue().
> 
> v2:
>   - add new patch for removing useless memset().
> 
> 
> Wang ShaoBo (2):
>   drbd: remove call to memset before free device/resource/connection
>   drbd: destroy workqueue when drbd device was freed
> 
>  drivers/block/drbd/drbd_main.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Patch 2/2 doesn't apply to the for-6.2/block branch. Can you respin
it?

-- 
Jens Axboe


