Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDFBECAAD8
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 13:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiITNvL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 09:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiITNvI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 09:51:08 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2659A40E06
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 06:51:01 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id g8so2330663iob.0
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 06:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=CK9TebHno8mIksOGMP5iM3H7Bl6eF54lPzCEEcDUT8A=;
        b=1pix+LOtxXtsEWvUmhnBjK3Gi+Nnb5nIznsQKF7piSBaXYJeoA+t+BzRXQud265iJj
         IoaThAE80xzywXLO4AXggmrZzoENkNb+RhP2jf7qx7b4hpSNhSWrj6Avdb0urPmwJTBr
         Hm8FSrU8cQRUgiZzngJhBpezxDAxEUqDdYpE5T1ZPuppXTiXk5uEBsgedRxlN2Z85lG7
         rlYwEgPLBJrJLrua5ZL2USGLNcOTnY8FRV8fEpPFS7ABnKRktyzzIxraJ2styn+HWl3X
         ijUCyEC1A/x8QOvGtZYd0wo/Ar7rx/A7UZaxiOarJBC0GHjtnBLMf+Nzn8HN1ej7vhnN
         3OGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CK9TebHno8mIksOGMP5iM3H7Bl6eF54lPzCEEcDUT8A=;
        b=o6DgUxk76XJNK8wmTIwkldvA10Tw2mV3i0KNJZovz/gCQGPMYalCfDqga8M/lJcP7o
         v1inVRYnePpgZRfUKJYxqGRf0kZ/VGcThLccl6APlj6glV48K8yVm7Etpeq9PhAJNb61
         QV5tY3VfhhF8tlHRw7Uco3n5A3aF9q7Oi+/NXnmk1q5EI+MKl3w16kjc5L1Gx2v/tPRQ
         h6cJdIITW0ZCyQfCtisAKswrItEYa+SDxLtvWcvmrYlm5MO+7CUpuwoJmb8Ul/TnAHAs
         glpXXuiba/lS6PhoPFewK5w/3sy97OE0vcKfM8iOKauQvZb0JeBVhiyOQ7QSt4I6GNxU
         fVUw==
X-Gm-Message-State: ACrzQf0dpcAtY+hdwHTcocAYgjvQn3gfH0kyJsz0abZ0DLqTiZjqYM09
        8gDndgEYeHioIIT8ZEfLxpSZi8qUrnLJVQ==
X-Google-Smtp-Source: AMsMyM5/3U4XqLk26/Dwj3BYAtCy7LF4qawYFbJqiCdHYjNuc+YqIYw+7kE3g0JkUej/1M3hc9dQIQ==
X-Received: by 2002:a02:c4d4:0:b0:35a:a076:bb5e with SMTP id h20-20020a02c4d4000000b0035aa076bb5emr7927171jaj.300.1663681860310;
        Tue, 20 Sep 2022 06:51:00 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v8-20020a056e0213c800b002f1a7929d67sm65818ilj.72.2022.09.20.06.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:50:59 -0700 (PDT)
Message-ID: <c296189b-0a43-e682-d5c1-85cec7ce1f98@kernel.dk>
Date:   Tue, 20 Sep 2022 07:50:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [GIT PULL] first round of nvme updates for Linux 6.1
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <Yylz9ST3BJeXmQCU@infradead.org>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yylz9ST3BJeXmQCU@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/20/22 2:04 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> here is currently queue up nvme patches for 6.1, which are not a lot.
> There are a few more patches under discussion that will follow later.
> 
> The following changes since commit 91418cc4fd8f8e2e21b409eb8983d074359c8be6:
> 
>   block/drbd: remove unused w_start_resync declaration (2022-09-12 01:47:57 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.1-2022-09-20

Pulled, thanks.

-- 
Jens Axboe


