Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44934C433EF
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 16:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiCCQIN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbiCCQH6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 11:07:58 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E57198D1D
        for <linux-block@vger.kernel.org>; Thu,  3 Mar 2022 08:07:12 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id w7so6362026ioj.5
        for <linux-block@vger.kernel.org>; Thu, 03 Mar 2022 08:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=x3CSxfWiPMeexpjcxnvsCSa7jVBDlA3IiXoD0HRPXkY=;
        b=IRmPLEnRG/Jb+9kmq2sd1/CGMb6aGeR2Gy3r1cncnqd/6U6E10p8ZOypK9mED9eUQl
         PIliJl5VFst82zMkAswtL7KgYgNXxGHnz2QRHUbOXooD1LD3BegkK5kcCa1yhwcpeVkY
         q/3wVDdYU5ykE8dqpW+P7apm1QASGsMtNOQvKfGZRnzDxeYAE+H596pw9Ynx40OzwVE/
         JRk5sFJEjf0exH2sFBlLGCRmrNsM5tNHYXp9K40Ygzs1LztkhjWNx5lI5kG22ZLvypGn
         D876/q6g2Z4HBTWXbFbtGzePeRPRk+pfMvc5C5dJ64GFMGf35b+jYrLhxGXWnHDFrlKu
         yVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x3CSxfWiPMeexpjcxnvsCSa7jVBDlA3IiXoD0HRPXkY=;
        b=Xfdpw+ygGQRfU+hHUEqEuRNo0byEcG39uvhgcbJQJQpUibj5l+2vkslRBSwizdmZUq
         bgOtRfxH4x/HHuhWqU69u3mkpWEAcGFUMLI8/viFVg2ZrSbcmJ27xKbZ99IWnVM10jzB
         eN1XxRKpqZYC2SgNh3TC4xLS7U7aaYBFZvTPszoxeVhESIu+Y51evq16bh+ptVwSPE0m
         WfXjgpV+YqyuVcxdnX3JYI/EAwofM4O4boUwEBkuqXtjPhmc8GdJMs/+N/4tIXeKlQMH
         QFNV0X88f1L4Sz2FU2/fKaCq5QKu8s8vYzLZEkAYreaP+gA0X6UJyTwe6p9Mv9ebNdOi
         VloA==
X-Gm-Message-State: AOAM530JNGG49frDQgbDjSMGQH06/f5gSf2tYnX6CgYkx55EcEbkGcHs
        KJRYr1Kd20olvJBFqD+8XVn56Q==
X-Google-Smtp-Source: ABdhPJzeXVJeyMRq7uwtmyLgDSmWDDFL2a0XaFuhDsfeiLaZ/X092W+WBXPYspwB8lAs2HOSi13kqg==
X-Received: by 2002:a05:6638:2172:b0:311:9f6f:cc56 with SMTP id p18-20020a056638217200b003119f6fcc56mr29624834jak.148.1646323631692;
        Thu, 03 Mar 2022 08:07:11 -0800 (PST)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t14-20020a056e02160e00b002c60907ec07sm2300382ilu.62.2022.03.03.08.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 08:07:10 -0800 (PST)
Message-ID: <3523636d-dbce-4f31-60a9-503c5e77e492@kernel.dk>
Date:   Thu, 3 Mar 2022 09:07:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [GIT PULL] first round of nvme updates for Linux 5.18
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YiCcsBPAQwEaDCH2@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YiCcsBPAQwEaDCH2@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/3/22 3:47 AM, Christoph Hellwig wrote:
> The following changes since commit df00b1d26c3c3ff9dae4b572a6ad878ab65334e1:
> 
>   null_blk: null_alloc_page() cleanup (2022-02-27 14:49:49 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.18-2022-03-03

Pulled, thanks.

-- 
Jens Axboe

