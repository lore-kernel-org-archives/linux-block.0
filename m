Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7E9C433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 02:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C89A64EBA
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 02:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhBXCYW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 21:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhBXCYW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 21:24:22 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4FFC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 18:23:42 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cx11so280475pjb.4
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 18:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jDmLmtY/xDK/ShoMjUAHkWmKZ7Wl26XudbxxxcklzU0=;
        b=NdwaD9hJLalqYZGCWAqqvt4ob6pstYDGTg0e8/+CNuK+Pm13pFaUtIWMafNQFfGHDQ
         WThUhI1Cp45emlpEWnLV2yPHixP1jp6MT6VAwWqMt48WvzJZO62khyGS7oRmp5k58bKl
         crZagQI9BvxwZuVF3GWcMre7CuR/zyVQevXl/7Ix0Jy6SpdsWHkKtVDnU8+EHEkYw/mM
         cm/6ew56OUdHQ+Hny10HIZ5SsRk8fxhiPjs5PJyxMcpgZY6fQkH/RyElR3nPdCfejjGB
         9veJ7XXw6k9z0U1PPeWEZnPcDKtFg1k5+J2B4z0uV2av8/HdvvN8dIWiVOKdtHDCbvu3
         2wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jDmLmtY/xDK/ShoMjUAHkWmKZ7Wl26XudbxxxcklzU0=;
        b=UzRF3YDVABmMvLAUb7rmnt98o1hxsTw3oo4AJYWm/GM4DQU5gMxXfK+LLuXtClrhTs
         PFHR17BFITT9x+QtAsiaeDOGInniS6KmOOAnYJrEWmX/qhJ5Srow5GjaRc5TwwQxMcSC
         41Vq5dgmcMfuTV+U5fvW89G3bdDTLUwNtzAaSIfSWpVZw8ihxqyGROStQo39KfKSgx2n
         1bqhi7dhoW9K1cCSABTipCuCQj82G7KoBtaPpyTi0Sks58hJ9IHFoCLHIy1hTyxvao1N
         LOmU/zb62x0/KPnzx87hBYZejwE5VNpfeWENlrNTTGgg30HjL0/+6BhWM3m1Y3e3ccha
         SP0g==
X-Gm-Message-State: AOAM530/a297lFyOdnU51uHVN/vr4mxaB8glnzbwOq5aUthaTqon6dDo
        Zqv+3Hd9DEzCFfaBFmZZl7B9Ow==
X-Google-Smtp-Source: ABdhPJwxBRRMxXpc3L/XwGdOxAf04PIEc/qx/4iJ66daKp6douamwUp9H76E6k0z4M170r/3IZO4lQ==
X-Received: by 2002:a17:90a:d507:: with SMTP id t7mr1829226pju.95.1614133421753;
        Tue, 23 Feb 2021 18:23:41 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id p1sm450460pjf.2.2021.02.23.18.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 18:23:41 -0800 (PST)
Subject: Re: [PATCH] block: reopen the device in blkdev_reread_part
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Tom Seewald <tseewald@gmail.com>
References: <20210223151822.399791-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9a74aa84-0ae7-a778-75b0-c09335a8b5af@kernel.dk>
Date:   Tue, 23 Feb 2021 19:23:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210223151822.399791-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/23/21 8:18 AM, Christoph Hellwig wrote:
> Historically the BLKRRPART ioctls called into the now defunct ->revalidate
> method, which caused the sd driver to check if any media is present.
> When the ->revalidate method was removed this revalidation was lost,
> leading to lots of I/O errors when using the eject command.  Fix this by
> reopening the device to rescan the partitions, and thus calling the
> revalidation logic in the sd driver.

Applied, thanks.

-- 
Jens Axboe

