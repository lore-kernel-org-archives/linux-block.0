Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7878CC43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 11:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473B820848
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 11:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="GM84PBXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgCaLlY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:41:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36266 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730343AbgCaLlY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 07:41:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so25467968wrs.3
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 04:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AJzDszuR40zqrjz/vQbGdN2e/QJNMHJ4HIPx+b9Bdz4=;
        b=GM84PBXXMTxr7GcpDEIv4+IdJi42PUZEBtEdUTLSsUydzCDpxOpPSqFgiw8FmbQjFO
         dldtPRMemiaJOn7CY1XkqMZ5vMYCkRIPAsNErhEf4+Kzvn4c9eIw8FBxjtCocBcGYZq7
         Q+PTCm9xJbYwklvbU4qm5ENU3lOHpQPcPkyJgRwN43DkQtJOK8v/MKEkfAOfsULLluWF
         rzK7RGwmwd/aQ1wWoYYN6mOiC3H/OetzTgWU2kX/q+YF4KVozuvjkH41NuShyYAYPMDN
         W4QI8KYp3A4Pw46oBxtBgEgIznW8M7kj8i3xhYgKDgbcrfn0gFbpeXfSQ6E/jRpDhWNK
         Co6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AJzDszuR40zqrjz/vQbGdN2e/QJNMHJ4HIPx+b9Bdz4=;
        b=gVMsMMv2mO4FnRt+oidUY9oqJrkf5mQvG+2zpTYdKlpiajK77kqtmch5OxII56G+nD
         rVqSwbEih2YVohhAE24WH82x0liIBpiYxkJIEIrVxAexX8xAMZJd/dqamGYE7R/Efcqm
         +BYpAVOyVaOYK5ksxNh9r4Hu1ku2vU71oEFvLG6HZAskABn2NkgLMiIgsK9e936pYgeJ
         v+1ZaHXgdt98Nn7iFG9RIJJxz2GfV/mq3Jvr1sBtgTLu0RM54dGO5LFkzH4y4d2hqvo4
         g0+JwqACMiDtHlTwT//KszLB74H6N2CnSwplY+Uv39yFNYQkz3SBEEIbDj6ZLRDjkHYU
         2seQ==
X-Gm-Message-State: ANhLgQ14o0swOyU23zzDgnxy/jGba3TMsS3Kg54iSSG7gvFs0D6iLZvS
        1VLjhEh3k50XoK3lIowDtETPes3S0R4=
X-Google-Smtp-Source: ADFU+vs/EUUe5zzpwfKtwA2x3bVdQDpdQNPDqIiPAD/OnlTKMY6GXjjluZnpc29SxKR3m2resIL1oA==
X-Received: by 2002:a5d:65c4:: with SMTP id e4mr18853098wrw.147.1585654882699;
        Tue, 31 Mar 2020 04:41:22 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id h10sm27404944wrq.33.2020.03.31.04.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 04:41:22 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de
Cc:     ming.lei@redhat.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Martijn Coenen <maco@android.com>
Subject: [PATCH] loop: Call loop_config_discard() only after new config is applied.
Date:   Tue, 31 Mar 2020 13:41:16 +0200
Message-Id: <20200331114116.21642-1-maco@android.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

loop_set_status() calls loop_config_discard() to configure discard for
the loop device; however, the discard configuration depends on whether
the loop device uses encryption, and when we call it the encryption
configuration has not been updated yet. Move the call down so we apply
the correct discard configuration based on the new configuration.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 739b372a5112..7c9dcb6007a6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1312,8 +1312,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		}
 	}
 
-	loop_config_discard(lo);
-
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
 	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
@@ -1337,6 +1335,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		lo->lo_key_owner = uid;
 	}
 
+	loop_config_discard(lo);
+
 	/* update dio if lo_offset or transfer is changed */
 	__loop_update_dio(lo, lo->use_dio);
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

