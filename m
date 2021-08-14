Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F16C4320E
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 19:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF7060F46
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 19:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhHNTbD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Aug 2021 15:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhHNTbC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Aug 2021 15:31:02 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383A7C061764
        for <linux-block@vger.kernel.org>; Sat, 14 Aug 2021 12:30:34 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id b7so8693147iob.4
        for <linux-block@vger.kernel.org>; Sat, 14 Aug 2021 12:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JbeDQ4x16e5G5gIVypE4YgHTi2ZFRimYJ1CyJiMvUlQ=;
        b=xkiRijzMCah70wTodyE2LfL4ZqJrQirVS/aCf0QmkKuU/Ysq5hMtrYzgFV2R723eD7
         v2kX8S3ohjaWaCTYfXNKCN3QFy413zcCuc6Q8Lag9JVcDac3r0S54TUgBZhF/sWxdIMV
         3ApfJZGIMKn1XpcmNL2XrPV2K1JGBfS16yjIedT7IYoJa7op6ryVKOu9DdCyOM+6dqz/
         xg+6bwdG1PHtXkPt4r5qve1KQr514suuLbdhSTXoJOvTK1CUC7Jh0iyQPtIJQZ7a2Ptd
         pvHMwyUYwtPsUpeTBqDQ5zw7i9yx+DTjbq0bOCVLeS6k2G7sc3xPIX2l7lzOcecfE4jf
         Pbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JbeDQ4x16e5G5gIVypE4YgHTi2ZFRimYJ1CyJiMvUlQ=;
        b=aC3j/D8uYA1t7hA9Iu21gx1c7J3lgQUAnmGjeop5zwzn2XIMZ0ls3M/KdzjghFAakY
         4aE6Miphfkv1Y+NDm6KtEcUo8vYEElfqWOKdoBfl4YOgaSSNsOzIV/R1+UDrn6ZlvDqw
         PpjLOPvAUGh+B4gYl5BWJRQTRb7pAJocNPcyOJjM+XyI8G7HkX+Yk/6NsrpORjLGqr0W
         jc0nG5dzYQrmSqzZEbNIAUJuGpBO8yNqEPnQJ4cX0XAVzD50ggbAots72nFHJ/WCCq6/
         qfNHQC6m5UJgLAipPnQyVR2tQDCUHfhemiKCdkTXxUxWtigx+z162I6VV+og/eIlpXjT
         FkWw==
X-Gm-Message-State: AOAM532nHKL15CBSAjnP08+q48+hmqV2FD/MzyGZEINQIoT2xtyXEE9d
        nzOWyuyrb+aM963kTgRzkCl4ucC21uuyeevo
X-Google-Smtp-Source: ABdhPJyX1hdL4HzyioRyFH/5AU+jMOR8WI6MANxllEGuSGxPkVkqvH28RsHCdHYoG5zVX2sSaYRsTA==
X-Received: by 2002:a02:4e04:: with SMTP id r4mr7905240jaa.99.1628969433368;
        Sat, 14 Aug 2021 12:30:33 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g14sm475564ila.28.2021.08.14.12.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 12:30:33 -0700 (PDT)
Subject: Re: [PATCH] remove the lightnvm subsystem
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Christoph Hellwig <hch@lst.de>, javier@javigon.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20210812132308.38486-1-hch@lst.de>
 <094e8eec-affe-81ba-908e-fbbe2fb7fa84@lightnvm.io>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <512bf4a4-fc60-36d0-adae-93caaf0441d2@kernel.dk>
Date:   Sat, 14 Aug 2021 13:30:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <094e8eec-affe-81ba-908e-fbbe2fb7fa84@lightnvm.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/14/21 1:01 PM, Matias Bjørling wrote:
> Thanks, Christoph.
> 
> Reviewed-by: Matias Bjørling <mb@lightnvm.io>
> 
> Javier, if you agree to the removal of the subsystem, would you like to 
> provide your reviewed-by as well? Thanks!

Side bar - please don't quote 400k of text, this reply really didn't
need any of it.

Pet peeve of mine, and it happens way too often on reviews as well.
Don't quote the whole email just to add Reviewed/Acked-by, it's just
wasteful.

-- 
Jens Axboe

