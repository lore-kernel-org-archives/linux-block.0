Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85CBC2B9F4
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 13:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9583B610A3
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 13:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhFQNmz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 09:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhFQNmy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 09:42:54 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFB5C06175F
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 06:40:46 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id d19so6565562oic.7
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t0TvC9vxbYXD2X7fWelTsYo5dpOMlgANUi5TSU8s7OI=;
        b=oz1T+GWjdJT8uTEvVA0W3Z2PyEx0iETJxxIkiknnlbTfHtHmujaiqU24IZLATQMQbY
         9yAf06IeoLnTkFbxyvpdNuR3n0TdtoYPiLpbxciGi9NETcuMdcNKE0bDJS2/aRepSs1o
         aTxJTvtCGk607N7FmoHP2/pbBsln+w8RmZAFsFYbMrAam6PPWSFBm23zG7vi/QhpbpRA
         uLoR/LWSkvTpeuwlj7pRcwZEGneUUpkA9Is7bK/lY3+vK1n3tmSyEzpDg5fxNaSXIaik
         M3s5pqXGr9n/KMkiRC9Y2Vqlp/vIeh6zAAvTMXtXNVUmVVjcSEF1C+XvrYmW8qwBV1V/
         PZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t0TvC9vxbYXD2X7fWelTsYo5dpOMlgANUi5TSU8s7OI=;
        b=fYxXI2FEyHjaVoyqkcrHGnW2OpSUyg8WmapOXHuvQED0D3KVpkhYyiSIMembD8WK40
         VwebamCcUKK2uVJm3rXxRZASiUuZGPHylhWucjA6Dj09P6G69H4+YSlXanLe4ypnD9Nn
         ozfoMxWIX5D/7mzMukxwTbHVbz/rw1qb7jFNVQoUDlFV/ZPoIK37Y4jIkX6hpwD0ZcH3
         0atRmb22e/JRwIOCCUVg7yR4AoWm6bfIdRt0fAZqXJamCx7pFn7GjJ6uaumJpwjXhfiO
         WfLLLSahmqDnpo2hcll/B71vPQ0n6NPQCxa0Wt4q/n7MXwpLjTBz3fJCalQQd5Y8C3fd
         adpA==
X-Gm-Message-State: AOAM532k9R7w7lYR3Q7lEkPcn4CpTrzEpQaubVpNcec8NiSdg0pG38j+
        LGZ5h973Y5pXwiTxy8qTASSMgpALzSb1eQ==
X-Google-Smtp-Source: ABdhPJz3Sw7hZWVb8Px6STcaJDgfhU9hpvTpBcuB9vu9YFudVVyibHohPmpHFrx8XeUW1BKaykQ5JQ==
X-Received: by 2002:aca:b8c2:: with SMTP id i185mr10589434oif.172.1623937245688;
        Thu, 17 Jun 2021 06:40:45 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id v203sm1084418oie.52.2021.06.17.06.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 06:40:45 -0700 (PDT)
Subject: Re: convert the mmc driver to use blk_mq_alloc_disk
To:     Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
References: <20210616053934.880951-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a669563e-468c-faf2-27a2-062ef41a863c@kernel.dk>
Date:   Thu, 17 Jun 2021 07:40:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210616053934.880951-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/15/21 11:39 PM, Christoph Hellwig wrote:
> Hi Ulf,
> 
> can you take a look at this series which converts the mmc driver to the
> new blk_mq_alloc_disk interface.  It is based upon Jens' for-5.14/block
> or for-next trees.

Applied, thanks.

-- 
Jens Axboe

