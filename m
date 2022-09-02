Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4251C001B5
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 16:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiIBQmt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Sep 2022 12:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbiIBQms (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 12:42:48 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B081EF72E7
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2022 09:42:47 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e195so2105869iof.1
        for <linux-block@vger.kernel.org>; Fri, 02 Sep 2022 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=Ld4Dn0+G8FvUen2ebQrbqIWxP0JuKkAiOT6lCzYNvMI=;
        b=IIDsmDypJ5SChnpuIQfkK1APvaTzysgojts3vYVP1tr+2wXqWQRD65dmh3T2cjHMgN
         pFsJRMSt4lWNSQShnA+yQiM+2kvsCjqZLighbO+yxODxS3lyEXlgSq5mn6bR9UGBM5D0
         8C96choNpr2afsG55JMt3156oJzZBGQpUTPHo1q2lHUPqadfVERnvToeFqdeaJsRfZQk
         k3/J81SIJeE4hOaAapcJlnJ3G7ajrYJooXh757CO30aWPkFbDnhitnNl60cIq2DRoYvg
         VMNtF6RfOBTugsgEmcqcN2PaFg/xZRz4k05ytrFbKjaD+r4UIIsNKIrjt/pNgPIkL5ly
         /EMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=Ld4Dn0+G8FvUen2ebQrbqIWxP0JuKkAiOT6lCzYNvMI=;
        b=WEKM+q9kORJ3BQf+roaF8tml2SG1fMynNFgeDS21eA6lxLSqF0dzXZTeigN15SMKtd
         gmgCgSZgvYKGChh16jpY3RBxm2yFmzIirgz+vW9hAErvVwiC7bB4qnYnD0Yljd5LAV2f
         Ss9BeR8wYUlqseDm23JAdMjqi1US5izgWCEPr/VtnpCDgJOSOqL+Z3PdZIB0Z/3ylRUw
         jnrz8VdvojpU956+UG/21yRIsdYf+raBE/LAmAjuy3MMRM9pVKFTqvJQ2CHPW7/FIg5R
         vZXObU3zvwP5H7zTm/rQZ4PFWGXWr22t4/rgfUkt4wQfoc1i0ZBEKUk4kbzYqvhRV0Vb
         rSxg==
X-Gm-Message-State: ACgBeo0sBruiojexk06Kpx3Z8hdJ5YHBSWob7ykdqRoz/N1n0KlVENig
        ARSZ6KMFHDBCGTrPLVWvxEPZSLnZNIyn3g==
X-Google-Smtp-Source: AA6agR7zanMEXNoPzHtBjZYcC4lqc5JxHP8pUA6NOwrQicxgEw3vMMnYMNYawobGeOONM456Peeitg==
X-Received: by 2002:a05:6602:1409:b0:691:4dd7:48e0 with SMTP id t9-20020a056602140900b006914dd748e0mr2403748iov.23.1662136966892;
        Fri, 02 Sep 2022 09:42:46 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u188-20020a0223c5000000b0034ac4b215c3sm1031507jau.102.2022.09.02.09.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 09:42:46 -0700 (PDT)
Message-ID: <f2863702-e54c-cd74-efcf-8cb238be1a7c@kernel.dk>
Date:   Fri, 2 Sep 2022 10:42:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-US
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH for-next] block: enable per-cpu bio caching for the fs bio set
Cc:     Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is useful for polled IO on a file, or for polled IO with the
io_uring passthrough mechanism. If bio allocations are done with
REQ_POLLED for those cases, then initializing the bio set with
BIOSET_PERCPU_CACHE enables the local per-cpu cache which eliminates
allocations (and frees) of bio structs when possible.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/bio.c b/block/bio.c
index 3d3a2678fea2..d3154d8beed7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1754,7 +1754,8 @@ static int __init init_bio(void)
 	cpuhp_setup_state_multi(CPUHP_BIO_DEAD, "block/bio:dead", NULL,
 					bio_cpu_dead);
 
-	if (bioset_init(&fs_bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS))
+	if (bioset_init(&fs_bio_set, BIO_POOL_SIZE, 0,
+			BIOSET_NEED_BVECS | BIOSET_PERCPU_CACHE))
 		panic("bio: can't allocate bios\n");
 
 	if (bioset_integrity_create(&fs_bio_set, BIO_POOL_SIZE))

-- 
Jens Axboe
