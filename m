Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94897C433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 20:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiDFUxN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbiDFUvn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 16:51:43 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791823CDB42
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 12:07:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id d10so3854824edj.0
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 12:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x6Z98lJKXuS91zE/lsKZc5fIxCcxTcDsBFNfuGVittc=;
        b=eo1ARq8XmDt4WJEG0fNRv1dh9ZyUYCvrTijwHC867kmZU3IKD5dL6KdP6iczPp7pQy
         tnHgSGg3MfdBTqOVO2b3wHz1Z1mFb8Wy98zw0SLKqmDjHRE/4/DbCsgTBy7NOY5paS8p
         nijBU4Ij7aZfaQxXvIOGZwEYAEJTEbOiT2lyhnYGBEja+bnssGEBiy65Dw46FE2/H9UV
         imNJlRPrr05hmPE64cmvbNhcIp4UPW+Qk3Y1ciKA1Tx83BjewM3t9IBYibMz3dVMHHKn
         uH8gkqbRDc2yw+GEAn0188l22b0ZHzaEI+RGp7WxxHsGJ5OBspo1dMpXv1v3j5kAjIoG
         nv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x6Z98lJKXuS91zE/lsKZc5fIxCcxTcDsBFNfuGVittc=;
        b=WVNdeY7/eBghwekUPz5tj7zL1WL4r3jVMlYNXgJAkvyNCcEukE4GwnXpPKTjNsr32K
         v7zlyES989EohnkuEhJSo8Xy8sDNC0YKKLiNjJYV8Tt7y1DBQFjbjW+0h9l96wrwV19M
         ghr3kmTBTewJcQ1Idcdr3dRkNj0D8X5OKT09M+i+NfGBDcAeYpZSlDIOq77C4JNLe5D/
         qEuTjUxjJOivojFVzs/FF6aVjx7qJ3psrse5VNMh5tKrCD2+D1UT5nVRTJEq4BKXqr7n
         UsPmLfSGEoegtuUrZmHAJ+1XTR3kqU946+mh42tXizaYc0Cl1Sk5/Mn7P751V6qgpSSX
         nPBg==
X-Gm-Message-State: AOAM533AI7gFsgHox951sZIzOyxG9r30M59OgqzOMBcIh5svcVaC2ava
        lfj+3J8Azl7GFIgLYYkr+2ivNg==
X-Google-Smtp-Source: ABdhPJziYZNh8lETm/Afxn5OVMjYG1YbWRgvE9PR7ajZDuxwzBFio8OijpeIWLus8bx4HMB+EFR/ag==
X-Received: by 2002:a05:6402:430d:b0:419:45cd:7ab1 with SMTP id m13-20020a056402430d00b0041945cd7ab1mr10233378edc.367.1649272059049;
        Wed, 06 Apr 2022 12:07:39 -0700 (PDT)
Received: from localhost (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id gg7-20020a170906e28700b006e73ac96f99sm4886409ejb.224.2022.04.06.12.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:07:38 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org, Haowen Bai <baihaowen@meizu.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 7/7] drbd: Return true/false (not 1/0) from bool functions
Date:   Wed,  6 Apr 2022 21:07:15 +0200
Message-Id: <20220406190715.1938174-8-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
References: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Haowen Bai <baihaowen@meizu.com>

Return boolean values ("true" or "false") instead of 1 or 0 from bool
functions.  This fixes the following warnings from coccicheck:

./drivers/block/drbd/drbd_req.c:912:9-10: WARNING: return of 0/1 in
function 'remote_due_to_read_balancing' with return type bool

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_req.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 75be0e16770a..e64bcfba30ef 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -922,7 +922,7 @@ static bool remote_due_to_read_balancing(struct drbd_device *device, sector_t se
 
 	switch (rbm) {
 	case RB_CONGESTED_REMOTE:
-		return 0;
+		return false;
 	case RB_LEAST_PENDING:
 		return atomic_read(&device->local_cnt) >
 			atomic_read(&device->ap_pending_cnt) + atomic_read(&device->rs_pending_cnt);
-- 
2.35.1

