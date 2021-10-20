Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65DDC433FE
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F65F613AB
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhJTOnY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhJTOnY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 10:43:24 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77BBC061749
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:41:09 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id o83so9916930oif.4
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W66dloScVSxQueC923u7QZu2sdDgpaevatl3Hcp3+UY=;
        b=T4k9LG1D9Qdj0MzZxBH8qAvxkg3NMQde+Go0NWXIcJ7SJ7H79QhwXoH20u5JsADwR0
         bcEUnd/YqlNaiDzQ5QBsPi2YCENqVrHvuJufQBOalWZzP1jOd6vZFtuCAIJ8es/tzJzk
         /OvUOexahEFJqYTFNJLw0fZXj+CUeVmTLilG636ec5ykXE9lCU1dqvBwD5gM/mXf+oIA
         Smg8+CCFw4Fy28A23kWc+3UPcb6rnUNmYzZtrpzjZSSgZ63U2nZxCoZvacew7orhs0iN
         OSYc9d1+J0XjAT0X7+pUHsdM0jEvT6b473jlNuG1Bdc6jQfZ1tJ+VDct8yVmzPhN4cjh
         URRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W66dloScVSxQueC923u7QZu2sdDgpaevatl3Hcp3+UY=;
        b=NSAc8P3V+1dUxim/tAoYjYw8i6qLJg2afIlc1t0w8tCTL6UwZziEUfZ8fJWe8SAm4P
         TASMnxLULCYqccWE4mhKL0tvBV8FUrLjkctN0ATpA2qqT4rXirtkUJo0mWxDLQj2MD8x
         +Cs3rC6E5ylNSE4BwZityJP4xflTTb7KEu4pTlhjbLBlnRHV0xdHtK9zOWaVRVQQPpjE
         KNCC4qkp8IWl04zv7WIOa/n1yB3VaNyuNPn8/N5IBkHLxWpuw0tSl9LVvz0uocfR8Skl
         U97ZD6TxybUQ76RXXu6gtp/cHA4IACHNbmdSzcwiMOAdBurSYgnFGCtMezwH0nIK7iYB
         +Adw==
X-Gm-Message-State: AOAM5320keTvnBSy30XvB09dxj3RB/lc+5vccrZ0DP71BRKbM+XBPfwx
        l0FalTE+cblCMrC6L065BBZk74/r8PTL8A==
X-Google-Smtp-Source: ABdhPJwZilGkFpAa6dwX3cTULFJQMa2ef8pICooKP/xl/SxyVXzyIqutFfmR9xMJ3VoXCcRv/JjnvA==
X-Received: by 2002:a54:4618:: with SMTP id p24mr42435oip.134.1634740869183;
        Wed, 20 Oct 2021 07:41:09 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f1sm426917oos.46.2021.10.20.07.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 07:41:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Coly Li <colyli@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 0/8] bcache patches for Linux v5.16 (first wave)
Date:   Wed, 20 Oct 2021 08:41:06 -0600
Message-Id: <163474086423.769448.5701368953740728354.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211020143812.6403-1-colyli@suse.de>
References: <20211020143812.6403-1-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 20 Oct 2021 22:38:04 +0800, Coly Li wrote:
> This is the first wave bcache series for Linux v5.16. In this merge
> window, there is no large change set submitted, most of the patches
> are code clean up from Chao, Christoph and me. This time we have a
> new contributor Feng who provides a useful bug fix for dirty data size
> calculation during cache detaching.
> 
> Please take them and thanks in advance.
> 
> [...]

Applied, thanks!

[1/8] md: bcache: Fix spelling of 'acquire'
      commit: a307e2abfc22880a3026bc2f2a997402b7c2d833
[2/8] bcache: reserve never used bits from bkey.high
      commit: 0a2b3e363566c4cc8792d37c5e73b9d9295e075c
[3/8] bcache: fix error info in register_bcache()
      commit: d55f7cb2e5c053010d2b527494da9bbb722a78ba
[4/8] bcache: move calc_cached_dev_sectors to proper place on backing device detach
      commit: 0259d4498ba48454749ecfb9c81e892cdb8d1a32
[5/8] bcache: remove the cache_dev_name field from struct cache
      commit: 7e84c2150731faec088ebfe33459f61d118b2497
[6/8] bcache: remove the backing_dev_name field from struct cached_dev
      commit: 0f5cd7815f7f4bb1dd340a9aeb9b9d6a7c7eec22
[7/8] bcache: use bvec_kmap_local in bch_data_verify
      commit: 00387bd21dac98f9e793294c895768d9e5441f82
[8/8] bcache: remove bch_crc64_update
      commit: 39fa7a95552cc851029267b97c1317f1dea61cad

Best regards,
-- 
Jens Axboe


