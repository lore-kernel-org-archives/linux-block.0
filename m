Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A665C433EF
	for <linux-block@archiver.kernel.org>; Thu,  6 Jan 2022 07:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbiAFHrF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jan 2022 02:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbiAFHrF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jan 2022 02:47:05 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2B0C061245
        for <linux-block@vger.kernel.org>; Wed,  5 Jan 2022 23:47:04 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 8so1889911pgc.10
        for <linux-block@vger.kernel.org>; Wed, 05 Jan 2022 23:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vZOdo9J2Z4fTykFol49hVR75+vHlN4IYPuL8oNVXvww=;
        b=Bd63+XKwDB6Go6Yb2ZfOQruoUMYloPL7/KVijWzJYkJj9pFY/8aOk+jK+9g8V+V3TY
         q1Njy8CG5E5ZzlKXJerx337/iFN1CqOqsZweFahIpztexWxSlqpe8VZxcm1sfWpnZwGp
         8Jl9tVA6F2crv/f9Rj/NP9XEeOmAsKljdaEnN7WGj89HMA7fUmBm667PhGaTQKmapI6O
         5ozGrSJIt9XMi3Ff7TCDRuxJtz+wxWDRZvydRTfKzvrVZVWc9KJ20HYSuD4LDODkOlvg
         h03T8vqbC+A94RR4ys4tqq9+h+Dcofir06vtXQjPFspUmuwC4FBCv5baUNwmSum0ZrDK
         axDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vZOdo9J2Z4fTykFol49hVR75+vHlN4IYPuL8oNVXvww=;
        b=BjPkRUflNUWGCde+Ipmw0oZ5Uu/ewaGjGR1wPylPp1oEr1styVMkiUxh/HOI6I/z/6
         1Ftb8yg639xkSzoBVvzQ/vE0MDNyjMhsLbupzOTlbMTq4fSJOvvL3iNBDSJz1xOAOjc9
         YOYJzgx6e3k5e5BkgNzzpSzGsp7N+5VlKG2re439sG4gUVsxL+BU5c8nAAJw4/dMU94k
         FyREBxYW5QYMEAZ1boIkeUkKFxnfIJeIzz5s+zx1QV6cW6x5lgkbIFvt3CjLvKDgn/DH
         BG9zd/9cFhw1ihkyjFLnsuNG8hfTKto+tLDR8dpkLse8CcP0OWXgK6eJYYig9zTxs5B5
         Sy6g==
X-Gm-Message-State: AOAM5304JLe2kPvYnSg8477U1ZjJQboYNjyq68tgEGAWlz4+yehhN1lq
        2aAZX5jY88BVN2+EuNEuNSBFBqx9ad5Dtg==
X-Google-Smtp-Source: ABdhPJzaHYoBrcuubqcTeDY9f58o7cO3uu+hVGq0JE3JnpFIx/ZMDL4LZKXAG0wiHffICeuNfG+64Q==
X-Received: by 2002:a63:2b4a:: with SMTP id r71mr52096317pgr.57.1641455224589;
        Wed, 05 Jan 2022 23:47:04 -0800 (PST)
Received: from [192.168.255.10] ([203.205.141.113])
        by smtp.gmail.com with ESMTPSA id h5sm1090601pgv.40.2022.01.05.23.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 23:47:04 -0800 (PST)
Message-ID: <6eac325f-3d37-92b9-ca4a-f419a17345a1@gmail.com>
Date:   Thu, 6 Jan 2022 15:46:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] block: throttle: charge io re-submission for iops limit
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, lining2020x@163.com,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>
References: <20211230034513.131619-1-ming.lei@redhat.com>
From:   brookxu <brookxu.cn@gmail.com>
In-Reply-To: <20211230034513.131619-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming:

I think it may be due to other reasons, I test this patch seems work fine,
Can you verify it in your environment?


From 2c7305042e71d0f53ca50a8a3f2eebe6a2dcdb86 Mon Sep 17 00:00:00 2001
From: Chunguang Xu <brookxu@tencent.com>
Date: Thu, 6 Jan 2022 15:18:50 +0800
Subject: [PATCH] blk-throtl: avoid double charge of bio IOPS due to split

After commit 900e08075202("block: move queue enter logic into
blk_mq_submit_bio()"), submit_bio_checks() is moved from the
entrance of the IO stack to the specific submit_bio() entrance.
Therefore, the IO may be splited before entering blk-throtl, so
we need to check whether the BIO is throttled, and only need
to update the io_split_cnt for the throttled bio to avoid
double charge.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/blk-throttle.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 39bb6e6..2b12fc7 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2049,6 +2049,9 @@ void blk_throtl_charge_bio_split(struct bio *bio)
 	struct throtl_service_queue *parent_sq;
 	bool rw = bio_data_dir(bio);
 
+	if (!bio_flagged(bio, BIO_THROTTLED))
+		return;
+
 	do {
 		if (!parent->has_rules[rw])
 			break;
-- 
1.8.3.1

