Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EB3C0015E
	for <linux-block@archiver.kernel.org>; Sun,  6 Aug 2023 12:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjHFMYC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Aug 2023 08:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjHFMYB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Aug 2023 08:24:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB88EF4
        for <linux-block@vger.kernel.org>; Sun,  6 Aug 2023 05:24:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6873a30d02eso2378614b3a.3
        for <linux-block@vger.kernel.org>; Sun, 06 Aug 2023 05:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691324640; x=1691929440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0OP3sZeafU4m0UvmTlOzrFMO40KUOq+JpcUSvznD7bw=;
        b=rlM0y2UFWX5yMGImUCu9Uzd/HOr6asy+NiIwL5GVuh7acTg7rjT8i3fEt7Dx0N9LcK
         ZLTDcXd6ew4TMQTZrJIUk2NlrHrkVpgv1LNjmzcVSyqmtKdDLcx4mCy5IAJKOHYmwVBs
         OUwqNmiw3kiDk9cA+0xhjBERUpIwv+lI3FGGaxUbxvIhdb2P70Zz44Zv02KQ6HTkZ3Pt
         YGqTmdNnfvijvXL9Xyy/n62BQA0rBJ5NeXd1zfvMMNYb+ZeQuuv1SfXFzZxVpNI9APtW
         cjA/QxqvcoEaFWJYFTOUXh+sHe39sKJZS9Bu5QoDxg0jp2XZ6gmey5B/ocJMi0T0itA+
         SDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691324640; x=1691929440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OP3sZeafU4m0UvmTlOzrFMO40KUOq+JpcUSvznD7bw=;
        b=CnFNVMJFo9vBk+i7eV0pw45YlXgvjyXrLt8YWoa/no3k6QEz4QO0+5Hb6oGPCpCOx+
         9jdedesE7um/C5F4Ta1IO4hOio5jzsxy11ejGGjcKCDCkapeQyWad3J/70IeaFXdblIf
         7xEyElQiOvF40ek4ood0XNz0sXJZq6niM7l50/0FHW7bCK27dLuEM0Reu08Lpu1Tkq4l
         iG8II6fCDR0z12UaYCryvUWfD+v0XLf1/thKmgqVenboxtfmHCDzsBqEnEBJaZ1F+v9N
         jkulJVpkfcQ6romCCKBJb2Vqd6AqwiXnTJ/LenipT4gOMTOUL+IiGKd0KhdvjDiPEcKN
         wfiw==
X-Gm-Message-State: AOJu0YxJtpQDkOg5qXrz+M1b81/UlcM9zRmCQVXCiJQgSliu2u3PBac4
        JCAnLnqSDsvMHh8VrZyFZ7A=
X-Google-Smtp-Source: AGHT+IFr1bZnirGJUFRnxXC9TXA6S12TQZZnJCcuPAvKxdcjo7aby1bQ6E/0zdEL/4qy7x9DgHi4ug==
X-Received: by 2002:a05:6a00:2495:b0:66c:9e97:aece with SMTP id c21-20020a056a00249500b0066c9e97aecemr5796227pfv.10.1691324640150;
        Sun, 06 Aug 2023 05:24:00 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:58e9:3a2a:ee75:10eb:7534])
        by smtp.gmail.com with ESMTPSA id p26-20020a63741a000000b0054f9936accesm3540570pgc.55.2023.08.06.05.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 05:23:59 -0700 (PDT)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        shuah@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v1] drivers: block: Updates return value check
Date:   Sun,  6 Aug 2023 17:53:51 +0530
Message-Id: <20230806122351.157168-1-atulpant.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Updating the check of return value from debugfs_create_dir
to use IS_ERR.

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 drivers/block/nbd.c     | 4 ++--
 drivers/block/pktcdvd.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 9c35c958f2c8..65ecde3e2a5b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1666,7 +1666,7 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
 		return -EIO;
 
 	dir = debugfs_create_dir(nbd_name(nbd), nbd_dbg_dir);
-	if (!dir) {
+	if (IS_ERR(dir)) {
 		dev_err(nbd_to_dev(nbd), "Failed to create debugfs dir for '%s'\n",
 			nbd_name(nbd));
 		return -EIO;
@@ -1692,7 +1692,7 @@ static int nbd_dbg_init(void)
 	struct dentry *dbg_dir;
 
 	dbg_dir = debugfs_create_dir("nbd", NULL);
-	if (!dbg_dir)
+	if (IS_ERR(dbg_dir))
 		return -EIO;
 
 	nbd_dbg_dir = dbg_dir;
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index d5d7884cedd4..69e5a100b3cf 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -451,7 +451,7 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 	if (!pkt_debugfs_root)
 		return;
 	pd->dfs_d_root = debugfs_create_dir(pd->name, pkt_debugfs_root);
-	if (!pd->dfs_d_root)
+	if (IS_ERR(pd->dfs_d_root))
 		return;
 
 	pd->dfs_f_info = debugfs_create_file("info", 0444,
-- 
2.25.1

