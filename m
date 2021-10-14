Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF90C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD16C61056
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhJNPvg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 11:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbhJNPvf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 11:51:35 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9DAC061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:49:30 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id k3so4022976ilu.2
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3odmASdhDQbSYTcbEQAbsuCHdYE4o+abSN83vnJ4iKU=;
        b=aqJ1vmiK82pHHpE26fMhp54xm7oCR+0iVWHgEl6Kbsv96As+u7664fZdzjCzReVcM3
         lfNwCnFmvIivAD6ap8xvISG80LcKrzcmjwBl0f3cmwNF9JhCqY4xgFxDARsrG34QnWqt
         ei4Zr0QJNOjmGGRtBsCpmHPiT+TLv0Fh87QEr2XsoOGDUsViWGU2h4+uucK250uUgeo7
         ii/iWr8EdnsquicQHdKDj9miRCaI3T83et6Gp+gJb1PP75CcD4a1mr6xT6p2tLvk/MB/
         Ha4VMvTI9g4fMlxKPclO4zSWi0hueCNmSyPet+4Rhlbuh1MnPhhjM/1+3wT5G+l45bEY
         HYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3odmASdhDQbSYTcbEQAbsuCHdYE4o+abSN83vnJ4iKU=;
        b=ePFCG2hFk29hoz3zug2pVUm36rUOyZNRsjutDUzKsh4XX73p8nRRZf+ta7pghrN1ap
         E6QoQvJJl7x6F94W2tCZK3aviIPrqHjNGKyixLy2rxjMmD7+Eza24hIOnaaX2QlmF+lr
         i593+RJQ8EZEuTvP8fBy7vbRZWiCs9t4grbXVfkYoZlVu7BektfCwtmuT/Vk8a2qfvNH
         I8QDQHyLOBqyOrM2VZzwT0ahKcQgDdbEii77gEtGTnKZjXZXPCQmGSx4mRwQRD0wOIQQ
         9owST/pGS5NZfvpqQ3tgHKG7JrmdBuPHAyxvf7vmGZxW5LFthAAU2sT5gSGH1eLSqYaQ
         dy3g==
X-Gm-Message-State: AOAM530zzpBmAPN8bFjshBrMaURlMdqeMm2ruqZ8FBehRSTOgkNy0GAt
        /BzsKZgtyMMd6p8E5r1KpLPXc4RxvXej1Q==
X-Google-Smtp-Source: ABdhPJwtWWoa5J6glsc3duKf+bMtLIXSYNNhk52STQi0FdmvYnJr+ofJgYew2bEN5iBxFAK+94fy8w==
X-Received: by 2002:a92:d851:: with SMTP id h17mr3053912ilq.312.1634226569695;
        Thu, 14 Oct 2021 08:49:29 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r18sm1432783ilo.35.2021.10.14.08.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 08:49:28 -0700 (PDT)
Subject: Re: [PATCH 9/9] nvme: wire up completion batching for the IRQ path
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-10-axboe@kernel.dk> <YWfiA96OpkT4Oomp@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9ce8ea1a-9e20-e9a1-e1c6-a7badbab410d@kernel.dk>
Date:   Thu, 14 Oct 2021 09:49:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWfiA96OpkT4Oomp@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/14/21 1:53 AM, Christoph Hellwig wrote:
> Couldn't we do something like the incremental patch below to avoid
> duplicating the CQ processing? With that this patch could probably go
> away entirely and we could fold the change into the other nvme patch.

Yeah should probably go into the first patch in some shape or form, I'll
take a look.

-- 
Jens Axboe

