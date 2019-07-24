Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CF0C76186
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 03:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64392070D
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 03:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a96Fshk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfGXDtY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 23:49:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45008 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfGXDtY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 23:49:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so20467180pgl.11;
        Tue, 23 Jul 2019 20:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IQLyRnhX1U98uZ5/RlUPme0HMor/hCDsDY8BvZ+8wGg=;
        b=a96Fshk/MwVVdB7NTmT4qZmZCuO8Xnost8WdcmjbpP9gHxAdpF98Ipx0xQu5jIjJfv
         f+gLkd1Kc8DPyCaq9E6PV4aqzK+EiVhwpaUyLUq5/c6NsaXP89+pdCL7u+viIM52Lfih
         uIa1UpOUc3PSnxqg1PKEvJRxokGT1YpgoCYCHtqPfB+NAdgtXMK5tud/u/rZ3bAeUq1S
         VEAB2W3bpmCPHYFFGRwynJdB9a0s40Eh+MX+Eb0YCdUNBDQSvJn3wUMTOI3mV2A09JyH
         PBtUpi0TooicuDLdNR5wbOUapVFpYVgcqRcZaujgUVysqrFv+ZJgQT6UFxjIXoLm+w4P
         RB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IQLyRnhX1U98uZ5/RlUPme0HMor/hCDsDY8BvZ+8wGg=;
        b=ckSu1drg3QwVaHDZD14U7i6I268TI/aGXG4fs8DuquruzpSjQ/n8zuEcS15shIGGAA
         pMGi+mhVKE7Mdgw5PZPFly3DWolzjOIUe/tSflATm5g9n0cbyzRG91j0DQp4de2tiYKz
         SLUmdK+sB6Xa73Vnsi4mnW2JAg1gQfVAdLQnhN0ppxhjQ+XTzv1Y2pwQMh2OSJThPrhk
         +84UiHqu1v3AWy1A8tMCHpRsZ9BmOPYdS8vWsx+MpRJqd8f/XS+i9lWiEdFG/rWYgAl7
         mIYoQ9691C7BqAI5+NTMoA1OO/SkvpCK48Nu1B1Fccj4OTBhTQCZtWixj371inUGWZfx
         KBOw==
X-Gm-Message-State: APjAAAWv49yukZOnebyrFdM2WJEhB6481+hAfacDFE6/B0Wa1L2IPVtT
        T/7WAzrnx0f7tdnBEwi6tXc=
X-Google-Smtp-Source: APXvYqzOgcmy45hVT5pcQwcT4irKnM5W7z/3OPHvaOp68PJhdvXsJts8LJmb3h3u7VYjS/Db6ick4w==
X-Received: by 2002:a62:38c6:: with SMTP id f189mr9125668pfa.157.1563940163555;
        Tue, 23 Jul 2019 20:49:23 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id v10sm45113413pfe.163.2019.07.23.20.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 20:49:23 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2] block: drbd: Fix a possible null-pointer dereference in receive_protocol()
Date:   Wed, 24 Jul 2019 11:49:16 +0800
Message-Id: <20190724034916.28703-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In receive_protocol(), when crypto_alloc_shash() on line 3754 fails,
peer_integrity_tfm is NULL, and error handling code is executed.
In this code, crypto_free_shash() is called with NULL, which can cause a
null-pointer dereference, because:
crypto_free_shash(NULL)
    crypto_ahash_tfm(NULL)
        "return &NULL->base"

To fix this bug, peer_integrity_tfm is checked before calling
crypto_free_shash().

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/block/drbd/drbd_receiver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 90ebfcae0ce6..a4df2b8291f6 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3807,7 +3807,8 @@ static int receive_protocol(struct drbd_connection *connection, struct packet_in
 disconnect_rcu_unlock:
 	rcu_read_unlock();
 disconnect:
-	crypto_free_shash(peer_integrity_tfm);
+	if (peer_integrity_tfm)
+		crypto_free_shash(peer_integrity_tfm);
 	kfree(int_dig_in);
 	kfree(int_dig_vv);
 	conn_request_state(connection, NS(conn, C_DISCONNECTING), CS_HARD);
-- 
2.17.0

