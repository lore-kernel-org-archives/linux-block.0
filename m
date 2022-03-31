Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE58C433FE
	for <linux-block@archiver.kernel.org>; Thu, 31 Mar 2022 18:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbiCaS5E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 14:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbiCaS5A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 14:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3339F192357
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 11:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648752911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=k0Z1jeCIKmFnHUAVH1qnoY3Db0lyY6IzDGCak9lVPA4=;
        b=I6UfAKID5dXbjC+sUAyB5JoKR2tGzk0f+uFsZM+qflorfhQiq3m4bQzpc1cq2dgZgyfyeT
        Iw4h7FRpbJNYPThb81WrhYmLccyequalx4M1I9VGUA+f7BRhQGzBZXfnuyZ9jMhznT62ny
        ZlGFHMrixWBMhBLQvm34U/l1EcWoSFw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-efqZm7nAOVaeOKlcNfxMHw-1; Thu, 31 Mar 2022 14:55:08 -0400
X-MC-Unique: efqZm7nAOVaeOKlcNfxMHw-1
Received: by mail-qt1-f199.google.com with SMTP id k1-20020ac85fc1000000b002e1c5930386so267898qta.3
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 11:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k0Z1jeCIKmFnHUAVH1qnoY3Db0lyY6IzDGCak9lVPA4=;
        b=k1WuOAwKcrHjgnoQYgwMlQlZGGMovDtalvnJWUXuVvGX4ctdscZAGZHe28ajEsMkoj
         lkPnjNFHxL0jaCFbEf0cipyCDVkbknFOcw8P/1M7CLYYiBrBVJO/eYiMsCs7c7FuWyHL
         IqOsXL2ZUXfaK/ZtOYAlJJD2+lcmx1uqZhq5mT0zub59rxm/X3qJaLkKd9dtqM9bPRMq
         qzCCba4HTDEm3y7h6+qQ46i8HICTZJbGVgHfstnQpgpWj17OnvFlGqNAwMu4H0Ft3ZWK
         VSVVAP+LHacyJJ6qr7o3o9j5hIYj3SyKKTsY34mcPA5yycNgFwjjPPbBA1GrAwx8YZsO
         98eg==
X-Gm-Message-State: AOAM532UtW8AuchKRhxrwBUKq/ywvBX/9L3oEFgkEr22EdFx5ozjJj6J
        zh/KeYUyuYC2rOCST+zccyDJyzRj+RO/pFfJO3Kqnj4kfl2McFgMleb1iTNI+q5qFTkimp+6n2/
        534KU4LPn6/PdztGyry8MZZM=
X-Received: by 2002:a05:622a:30c:b0:2eb:871f:be08 with SMTP id q12-20020a05622a030c00b002eb871fbe08mr5653193qtw.128.1648752908001;
        Thu, 31 Mar 2022 11:55:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOfSfgjRpynVUGU6NUsEVov2wHm6Z2q5VA2LwjDD2FsuUZ0dBiyT2QVfsvS200T/64ZPCA0g==
X-Received: by 2002:a05:622a:30c:b0:2eb:871f:be08 with SMTP id q12-20020a05622a030c00b002eb871fbe08mr5653182qtw.128.1648752907803;
        Thu, 31 Mar 2022 11:55:07 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id bk15-20020a05620a1a0f00b0067e5bd7a9ccsm68289qkb.50.2022.03.31.11.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 11:55:07 -0700 (PDT)
From:   trix@redhat.com
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] blk-wbt: remove wbt_track stub
Date:   Thu, 31 Mar 2022 11:54:58 -0700
Message-Id: <20220331185458.3427454-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tom Rix <trix@redhat.com>

cppcheck returns this warning
[block/blk-wbt.h:104] -> [block/blk-wbt.c:592]:
  (warning) Function 'wbt_track' argument order different:
  declaration 'rq, flags, ' definition 'rqos, rq, bio'

In commit c1c80384c8f4 ("block: remove external dependency on wbt_flags")
wbt_track was removed for the real declaration, its stub should
have been as well.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 block/blk-wbt.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 2eb01becde8c..7e44eccc676d 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -101,9 +101,6 @@ u64 wbt_default_latency_nsec(struct request_queue *);
 
 #else
 
-static inline void wbt_track(struct request *rq, enum wbt_flags flags)
-{
-}
 static inline int wbt_init(struct request_queue *q)
 {
 	return -EINVAL;
-- 
2.26.3

