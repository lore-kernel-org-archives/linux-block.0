Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568FCC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343E96109F
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJTMbq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTMbo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 08:31:44 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECB1C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:29:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m42so18571591wms.2
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wG+4cB5TLBcuW/1hqXEVSbgGMh0cSXz4iCGV2+Gz3uc=;
        b=JAtBRVK9fyG8FaxUwDSAkzTdb5WtIKSuyHUg479EM5hqHQkGATP+h7jzvNnkn46VJ0
         FWYHm029cG02pYEadx96WB8vgXAimUIgNwiSoLFLLEqeG49JHLtnXvkIf7NBwya0Etnc
         iwzyX6+Por81PKAbARGlsgKPZobNR8DtOaysx8prTCln1eXgFRVlUq7xiynOR+nuKdi/
         F0/+rWsCBY0V/ldLArE9vbU8N7/l7okkwATpHY3g0pt6TkqYLruXmR0AvbFmtDzb797W
         +4XZXWVVySsWm1j5uXU/Bc6aTrC2mE40z5+mDu9g8r8Jgx74UTMMLLDWkGxjkrqDIKh+
         LcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wG+4cB5TLBcuW/1hqXEVSbgGMh0cSXz4iCGV2+Gz3uc=;
        b=1q20XaCa4CxEMPsGXXAiZ3EIkbN8F9tVilo52a/+AqSvPV0iIort+sBh3Hu3O2F74F
         bcnrtkrXHiHFYtc+G6vVcokCesVnl8AWHP23n5otv/6wq9s0NyvFoLLdr4kNN7nT7bJZ
         IKD+pX24li/eANja6WitJyocDcJZnONT7+BWC2USrTj6EPJa7lqRMsQ6afqoM3xE241g
         fkcpGZh0TxCFsEhjbc2aBWzN4fLp/lvIuwsvS67lctahl+l7H3kyezlq5/xIrLCi2oa5
         OMphIcvt0Yg2BFWWlluDe+RVXFOnsw/U3hryHr7i2cG/qi0IacTwO7v7c6EvrGMl9AvH
         r1cQ==
X-Gm-Message-State: AOAM533rmAY5Wp4P5QXf8GgSPxYT5GQXEkxZAyBCLQn4BxTX/a49Orqv
        AFsXVjJpZsWtPR67CVMZQGY=
X-Google-Smtp-Source: ABdhPJy+xF/dxshYP0R3iH3Vk9fiqn0solMPa3M/Z0eyRAAJcrIa6A2tfBAaTWg3D0lc52G/ZbwlKg==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr35937190wrm.312.1634732969094;
        Wed, 20 Oct 2021 05:29:29 -0700 (PDT)
Received: from [192.168.43.77] (82-132-229-137.dab.02.net. [82.132.229.137])
        by smtp.gmail.com with ESMTPSA id p18sm2014175wrt.54.2021.10.20.05.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 05:29:28 -0700 (PDT)
Message-ID: <08da3e0e-e2d0-9fd1-85d7-9719f78f6bba@gmail.com>
Date:   Wed, 20 Oct 2021 13:29:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 10/16] block: optimise blkdev_bio_end_io()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <8e6003932f65ecd9ada5d6296c6eb9d1b946a1eb.1634676157.git.asml.silence@gmail.com>
 <YW+3onhtNw8BzZFN@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YW+3onhtNw8BzZFN@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/21 07:30, Christoph Hellwig wrote:
> On Tue, Oct 19, 2021 at 10:24:19PM +0100, Pavel Begunkov wrote:
>> Save dio->flags in a variable, so it doesn't reload it a bunch of times.
>> Also use cached in a var iocb for the same reason.
> 
> Same question again, does this really make a difference?  We really

No, will remove the patch

> shouldn't have to try to work around the compiler like this (even if
> this relatively harmless in the end).


-- 
Pavel Begunkov
