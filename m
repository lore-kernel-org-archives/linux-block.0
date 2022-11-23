Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71302C43219
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 17:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238961AbiKWRjY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 12:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239111AbiKWRjU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 12:39:20 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77156976F3
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 09:39:13 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so4162233pjt.0
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 09:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVheXuX8LGH5JYP/sNnMLkgS4V4oAwG+GeizIcMSxe4=;
        b=voPkRtcK5zM5t0+MCDyFqyjwkx5NSDyvO45EyLu6XanHIeHkZqsA51JaP4qIocDEPI
         o3N6ixoUtaINWFLA/nJTFA+HS8vGAR+RIeTYNSNFtA3j5Xp0Mzg0L0B6U7sn1SuevGmq
         S+BSCuFlrMwVWZULLZV6zfLw1VE8ZycN96ZNi2BCxww/5C6Nf5Q4GCxZM0mLVpTa6NgG
         JTlxlvi14TXrl91IxpPPjYzmw+qoVq+6CwaNwIK3j/sv2NVjqMyNy+zf2pxX0CZ+oN96
         l3artVER3K0129JMEOWBvIRQPY4Nt5DY/fyJZPuj2810aNvxoiJLpRue375TVdnrfkmo
         BPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVheXuX8LGH5JYP/sNnMLkgS4V4oAwG+GeizIcMSxe4=;
        b=ftG/BF+dgdkxZpZWx56hYqYwbDn9mr+tF7hT9e9P+GuFODZsvWOW4tx2CNaeA0ebWJ
         PSfzKXLonXF5GuMfkWH9/yVfNO3bxc6+skSKW7Fp4uTsQtoYQSXbtqx4TGqnrI7X6LIz
         JiKYPLyZHbeTZSeDYe2Jg/N7CMs/geKDTAvLIiHwFnG0lXy/8nGH6Mlyo++fWn6zCzLm
         PF9KJfCAMWlsuPvFb++hrUx3B4X5UER6zUA1Dz5vv3rQ1KYTKTjXn5zYbDQyw2iQ8lXh
         F0Jx98JtVz4yUPyZsExbHfr0ComiPtwdqMscBEgJWzh/OvqrwUDHhc9x/CaUhCZ4hRwi
         m92g==
X-Gm-Message-State: ANoB5plTDfObLzTejVje+LfUPfvAKCFTHhKhSoNeMbtMFVNX/vYDVMT1
        GKFmakJCWSNMMPR9Uw/TSQm32tZ8floHBw==
X-Google-Smtp-Source: AA0mqf4HT0ag6jsmUP/jIl+QneeuuS08tScB3h9atP6vSGnDzwQbTG0o2pYh1bUh3D/xQAW7fSsnwg==
X-Received: by 2002:a17:902:ec01:b0:186:878e:3b0d with SMTP id l1-20020a170902ec0100b00186878e3b0dmr9707489pld.149.1669225152681;
        Wed, 23 Nov 2022 09:39:12 -0800 (PST)
Received: from [127.0.0.1] ([2600:380:4a4b:9d2c:aa9c:d2b:66c9:e23f])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b001743ba85d39sm14468360plr.110.2022.11.23.09.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:39:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Christoph Hellwig <hch@lst.de>
In-Reply-To: <20221123172923.434339-1-bvanassche@acm.org>
References: <20221123172923.434339-1-bvanassche@acm.org>
Subject: Re: [PATCH] blk-crypto: Add a missing include directive
Message-Id: <166922515142.2606.472578798999047121.b4-ty@kernel.dk>
Date:   Wed, 23 Nov 2022 10:39:11 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-28747
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 23 Nov 2022 09:29:23 -0800, Bart Van Assche wrote:
> Allow the compiler to verify consistency of function declarations and
> function definitions. This patch fixes the following sparse errors:
> 
> block/blk-crypto-profile.c:241:14: error: no previous prototype for ‘blk_crypto_get_keyslot’ [-Werror=missing-prototypes]
>   241 | blk_status_t blk_crypto_get_keyslot(struct blk_crypto_profile *profile,
>       |              ^~~~~~~~~~~~~~~~~~~~~~
> block/blk-crypto-profile.c:318:6: error: no previous prototype for ‘blk_crypto_put_keyslot’ [-Werror=missing-prototypes]
>   318 | void blk_crypto_put_keyslot(struct blk_crypto_keyslot *slot)
>       |      ^~~~~~~~~~~~~~~~~~~~~~
> block/blk-crypto-profile.c:344:6: error: no previous prototype for ‘__blk_crypto_cfg_supported’ [-Werror=missing-prototypes]
>   344 | bool __blk_crypto_cfg_supported(struct blk_crypto_profile *profile,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
> block/blk-crypto-profile.c:373:5: error: no previous prototype for ‘__blk_crypto_evict_key’ [-Werror=missing-prototypes]
>   373 | int __blk_crypto_evict_key(struct blk_crypto_profile *profile,
>       |     ^~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] blk-crypto: Add a missing include directive
      commit: 85168d416e5d3184b77dbec8fee75c9439894afa

Best regards,
-- 
Jens Axboe


