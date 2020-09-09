Return-Path: <SRS0=/Scz=CT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B69C433E2
	for <linux-block@archiver.kernel.org>; Thu, 10 Sep 2020 02:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5E8C20C09
	for <linux-block@archiver.kernel.org>; Thu, 10 Sep 2020 02:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="azshADfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgIJCdz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730596AbgIJCcb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Sep 2020 22:32:31 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07BEC061387
        for <linux-block@vger.kernel.org>; Wed,  9 Sep 2020 16:44:37 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id h9so2379413qvr.3
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2020 16:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1OQRbnpVQqbSHeNIDm4Hm9mK1gT2gj5RYSqpBEjn4gM=;
        b=azshADfVoWxyDpQuXUO3to8kiY9uHNIzQ57x8KjQIX+EK/Em5xQVxYtJPoEDS0aePD
         Y61/giUZ05cffykw283xaA3l6iWVCJg9wpB71S5nzH9EVlsB7DrwYd/1GbZ/6hqyy+aP
         V3CsVsXVhEhkNrcI6fwNQ8MdTXYqYu3mK8JIgFfSqFMjLHbltgP4QvmvdGhsb6hEmTat
         HpU4YccntOhHTahvRdzBbRxShPfV83u92ZPa5sdOLsdziXdRXd2FLqZ8tbj6J+BnKJxh
         1ZzYAG/BSCC00j0EQm3RdQEmkV8TCxNK7oGMetTxZt4LkGA2j5eaVT5Dc+FDNGRbc5iD
         dDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1OQRbnpVQqbSHeNIDm4Hm9mK1gT2gj5RYSqpBEjn4gM=;
        b=YEnqzi70G9TcVJNF65N6SCiw3IMhQ32wp9sUH5+cFfpUqRan0xA2JTl7Dorgd603e9
         rNSW/k5JB3dTuvUcM9FbVaCjrONqgfZvTE6cXHXNo6bf9PL+U4R5y2AeoFun9bvZB3vq
         frPoJvkxXMoZHYuaYKJtQYind4w45jKbbVknFA8B1znNocZ6m3DeAt78tz+GpkSxJkYv
         bcX0J+jh0fMDaY/7lMckiTG/0ugHVTdY0Jk9CRmRjmclIx9CJl6eNTPgn93eVMdKgZMA
         9qeSqM94F31REBskT3ALrqYBWRXahTm2uMZV0lUtDnto4qelljEH9nsg0hloXXYLTl3P
         T4sA==
X-Gm-Message-State: AOAM531hlEjkFZTgBWcYQQaDGnsvlcceC807oy24fKU6clNtg8aC9tOQ
        HAqzM0L1zKSc9juY15ThClumt6r8ipdjRJmF5eAbbUD7ZhZZnf+OfuMr6zBkuP0LyVccLjLWPcT
        ucbcA1iztNoYTx0cQ6TzYFS7UIkHFl+A/0T/5JS+yWmv/xX35YVeJYVSaRo0QRbvyh2lI
X-Google-Smtp-Source: ABdhPJzRLKGMJkhtGLLHYN+CRFtSzCzysN6IpaLbffgbJgz/w24BGG12zL9AWcZQDiOos9PZsag2+r5yVUI=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:2d8e])
 (user=satyat job=sendgmr) by 2002:ad4:5565:: with SMTP id w5mr6354094qvy.24.1599695074759;
 Wed, 09 Sep 2020 16:44:34 -0700 (PDT)
Date:   Wed,  9 Sep 2020 23:44:22 +0000
In-Reply-To: <20200909234422.76194-1-satyat@google.com>
Message-Id: <20200909234422.76194-4-satyat@google.com>
Mime-Version: 1.0
References: <20200909234422.76194-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH 3/3] dm: enable may_passthrough_inline_crypto on some targets
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

dm-linear and dm-flakey obviously can pass through inline crypto support.

dm-zero should declare that it passes through inline crypto support, since
any reads from dm-zero should return zeroes, and blk-crypto should not
attempt to decrypt data returned from dm-zero.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/md/dm-flakey.c | 1 +
 drivers/md/dm-linear.c | 1 +
 drivers/md/dm-zero.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index a2cc9e45cbba..655286dacc35 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -253,6 +253,7 @@ static int flakey_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_discard_bios = 1;
 	ti->per_io_data_size = sizeof(struct per_bio_data);
 	ti->private = fc;
+	ti->may_passthrough_inline_crypto = true;
 	return 0;
 
 bad:
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index e1db43446327..6d81878e2ca8 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -62,6 +62,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_secure_erase_bios = 1;
 	ti->num_write_same_bios = 1;
 	ti->num_write_zeroes_bios = 1;
+	ti->may_passthrough_inline_crypto = true;
 	ti->private = lc;
 	return 0;
 
diff --git a/drivers/md/dm-zero.c b/drivers/md/dm-zero.c
index b65ca8dcfbdc..07e02f3a9cd1 100644
--- a/drivers/md/dm-zero.c
+++ b/drivers/md/dm-zero.c
@@ -26,6 +26,7 @@ static int zero_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	 * Silently drop discards, avoiding -EOPNOTSUPP.
 	 */
 	ti->num_discard_bios = 1;
+	ti->may_passthrough_inline_crypto = true;
 
 	return 0;
 }
-- 
2.28.0.618.gf4bc123cb7-goog

