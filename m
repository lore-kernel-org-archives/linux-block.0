Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A223C77B75
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 17:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbjEWROJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 13:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238039AbjEWROD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 13:14:03 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70192130
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 10:14:00 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7747f082d98so4739f.1
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 10:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684862039; x=1687454039;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5k88qCVwcZa1f8fNaWmQwZNtP2UmSyRYMW1h4mnpwcI=;
        b=rhdAfeRDbJmV0coNwwtLAWZdVXOofT1UdxJjGXcSRViQbRVuZ8FnUMRC76WPG/9T5Q
         nVoomGNwKzzqo8FayjjsRBuNoPcfRmAuhz9DpozcRaL4sqLVc5TcNW7E6FJCho7w17rM
         I50v4Q7AMpW+5sf5n0sTtGsA8qhmkUk230SGRSovk7kxhOhSws9/XO15Uy80VvpGNBz8
         66FB1k+fZaAUTDB0E/ICHc05RIIbAmUh9ASqfD52HFxrtIbK8fROTXdNDEw3O8osrpJm
         LlI6vzwTjqx6ZIozjW/QP+od+Wd7ybXAhUq+vJy69TttrXxTW2lr9DsK+rwsV5uGvMQl
         ZO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862039; x=1687454039;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5k88qCVwcZa1f8fNaWmQwZNtP2UmSyRYMW1h4mnpwcI=;
        b=Zcfvwx0s+QrKi/WJP9AQwuCiaVoMgQNLk2/AfvSP1fB8xzbgDCU3Dh12Ou3+Ixxl56
         olpasEIadxgVAEZ+RmtmOBnOO87vTQ1eyXOs9vARrooPHFDURx/5rGUtFbG/b/bExsZQ
         kgPLYokpdYStkkmxc0m7UuVqVTDuytUb0EgdG63EfYagqMoK/RcEOJyWkSmaj+JD2a3e
         N8PcjAcVdndQ8Th1f2AePEh4dHjeR2MzMUxP5JUaxhhc6UJbLZnRQZSqa3zJIF3NIsbT
         orGBPBQwwEpx3PkYo9VLltKxuD3q9nFTmmhi8GKMrRGPDb9m6boMKr38jccuoMo+5kbu
         LYUQ==
X-Gm-Message-State: AC+VfDx+Aslgu4ZtBEcBu5qRwLhjNaOpKlpGYIDhxSot2ygy4AtWn6tr
        VBH397u4IQODi2jyPimnZRUvp+S5L5KpS1+FoP4=
X-Google-Smtp-Source: ACHHUZ5lI6ZJzmHP2RmyEmRkLyYJRDQQXAZ4tqrkSxq5mRlghLrc9YkfThO9dMuwV0hk2urNFdCKog==
X-Received: by 2002:a6b:b20f:0:b0:774:8351:89ac with SMTP id b15-20020a6bb20f000000b00774835189acmr1406141iof.1.1684862039717;
        Tue, 23 May 2023 10:13:59 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u7-20020a02aa87000000b00411a1373aa5sm2524580jai.155.2023.05.23.10.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:13:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, Anuj Gupta <anuj20.g@samsung.com>
Cc:     linux-block@vger.kernel.org, gost.dev@samsung.com,
        anuj1072538@gmail.com, joshiiitr@gmail.com, stable@vger.kernel.org,
        Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20230523111709.145676-1-anuj20.g@samsung.com>
References: <CGME20230523112014epcas5p267f30562f3f2e3c6d58fbb76c0084e5b@epcas5p2.samsung.com>
 <20230523111709.145676-1-anuj20.g@samsung.com>
Subject: Re: [PATCH] block: fix bio-cache for passthru IO
Message-Id: <168486203851.398377.17993706922201051962.b4-ty@kernel.dk>
Date:   Tue, 23 May 2023 11:13:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 23 May 2023 16:47:09 +0530, Anuj Gupta wrote:
> commit <8af870aa5b847> ("block: enable bio caching use for passthru IO")
> introduced bio-cache for passthru IO. In case when nr_vecs are greater
> than BIO_INLINE_VECS, bio and bvecs are allocated from mempool (instead
> of percpu cache) and REQ_ALLOC_CACHE is cleared. This causes the side
> effect of not freeing bio/bvecs into mempool on completion.
> 
> This patch lets the passthru IO fallback to allocation using bio_kmalloc
> when nr_vecs are greater than BIO_INLINE_VECS. The corresponding bio
> is freed during call to blk_mq_map_bio_put during completion.
> 
> [...]

Applied, thanks!

[1/1] block: fix bio-cache for passthru IO
      (no commit info)

Best regards,
-- 
Jens Axboe



