Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B220AC433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 07:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiFBHtO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 03:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiFBHtN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 03:49:13 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976381FE4F8
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 00:49:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h5so5378175wrb.0
        for <linux-block@vger.kernel.org>; Thu, 02 Jun 2022 00:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oJf+zqoVPm9HbCA5FeT4yjE/v4jzRZhL63iSHZ6XqAw=;
        b=nyMsuMnEP12ieVqTx8r0EwS5gypEy5jHizmBT0oUWmYxlMN+Uatwq8KWpsQ8ckde4W
         j0P2asodKFOmqyh8tADanYLrwwDE0QL43MyCZCNkhQZpd/lPNg/yCx5d5aS9Rpodz+SC
         GTZZFYKt0Z/wBYLN/ifp6p2LrD48oRYPrh5Eh1E+G/KlGVkpLLw8mkR9Jlkzn0IlDoN4
         7drz7iiVhwLddXwwCWSedNfpBtA+3opUwODBSo+kMcjiCCgtA7KbaaRUshghVMUC4iKW
         NyPlObj4hGYdNK9F+4IoJ8E99PAXmNq0scRusfrRoplu89bFVY29KuXkSl5ppbR3yQxm
         tBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oJf+zqoVPm9HbCA5FeT4yjE/v4jzRZhL63iSHZ6XqAw=;
        b=AELJQHZSGBs11Ywq3Cen6XeTvVWyUN1LkQP/1pHheEzeAZFrvDGetracj9gf6Z54yW
         CHcgGPEfCwhfvwWm3xs6EuYMNe04lwQLsXMTCtHNb9IgtajruBdXY+YnBzTv2yjxcgco
         4tfdsxylFvrXrC+PacF84eFjlzl9DMEtLb94XViWHP6kP13/8YP0CdqWLhZqRqEQQ41l
         5MQHE2d04wkT12L9FoNrXYd/2/wPaH2Z+8aHddYrkpyIk/4KFTHKytkS2VQilWG0R7v1
         vyD2EuIg6hG6bR3guHR33T2BxoN0P7MSDKAlpF22APbvXB1Y/9xkYujjahJm1wqoDpf9
         H4dw==
X-Gm-Message-State: AOAM533L9mFqw4jp2Pw/fJU2Y5LVs14ROoCPBjB0oNdLswuAfQ50L0sA
        c2HZdbGn/89doreSi4jxqqOxcRikREnN4VOo
X-Google-Smtp-Source: ABdhPJxREbHpGZIVLRhL5vYhnl4+E+L67zd2HvjFj/K/eyddhiy3qAFeyU+kKR0OLkpRbJhRlaaqdQ==
X-Received: by 2002:a05:6000:1a87:b0:20f:ecc0:3686 with SMTP id f7-20020a0560001a8700b0020fecc03686mr2491156wry.708.1654156150160;
        Thu, 02 Jun 2022 00:49:10 -0700 (PDT)
Received: from [10.40.36.78] ([193.52.24.5])
        by smtp.gmail.com with ESMTPSA id q16-20020a5d61d0000000b0020d110bc39esm3523356wrv.64.2022.06.02.00.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 00:49:09 -0700 (PDT)
Message-ID: <2ae24afc-6474-60f3-ece0-fb5a1d19f8c5@kernel.dk>
Date:   Thu, 2 Jun 2022 01:49:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [GIT PULL] nvmes fixes for Linux 5.19
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YphKZBtmtKFRNIPL@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YphKZBtmtKFRNIPL@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/1/22 11:28 PM, Christoph Hellwig wrote:
> The following changes since commit a1a2d8f0162b27e85e7ce0ae6a35c96a490e0559:
> 
>   bcache: avoid unnecessary soft lockup in kworker update_writeback_rate() (2022-05-28 06:48:26 -0600)
> 
> are available in the Git repository at:
> 
>   ssh://git.infradead.org/var/lib/git/nvme.git tags/nvme-5.19-2022-06-02

Eh, I can't pull from that... I used the usual git url with this tag.

-- 
Jens Axboe

