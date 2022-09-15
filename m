Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DCBC6FA89
	for <linux-block@archiver.kernel.org>; Thu, 15 Sep 2022 16:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiIOQt4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Sep 2022 12:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiIOQt0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2022 12:49:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C29B9E6B8
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2022 09:48:58 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w20so6843221ply.12
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2022 09:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=CC2AT69XGg5wm3bSeW54GIGYiTC1rZqaZVqT6NInl68=;
        b=mu3+zu2fHkK18fyK8GquthMgCh0knmNuo1AuOv6/5p4XsIu5amJTOn6ebMi5f22/na
         PdmtAwktXThz7euWyzkdNELKrfRtOJwgowVocLAbaPOqQuLnlvONAH9Ktcv8xh5VTMrL
         zfixw/KKn7UoVL8Jol7k9Cf7o8+gbedJGP27U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CC2AT69XGg5wm3bSeW54GIGYiTC1rZqaZVqT6NInl68=;
        b=xPrrrlG4JVdlfs0OTYrWiQp0Bwy7oLyVeonpl9Pfj8gk7u9GIIdPno/dYll89BaQii
         emN641RruAE3/h2fcZOCSACmkuuT+lupDaKuxooc+I1i+gMpkKxWwfi3eaJaUWLgO7gN
         wvRqoh+rklxyM9LLNiQngH35N2TGB8Leiq8zMUGeg0PHNdPhUp/nMSN4+LNeljcsTemH
         SVqioUnDVfMm2K16+rgfYwAVLwD5hgM3eOsGulU5P7iq9bXeuOpQOvs3tTsz0Tan3MQ7
         CduhpaEhVwCce/cQQx8m4yt7A+5S2qq5skYoxT9wY5/rdmsfkUwdX9I5C7MRBeCeO1st
         Ra1Q==
X-Gm-Message-State: ACrzQf0RfZc/+xKRT39YS2u8jsvhWEglnURCKV1nv/GxNZ7J2ah2s7A8
        qH7UVuMGiRQ4ms7PxoJGI3ukXw==
X-Google-Smtp-Source: AMsMyM7xQDECJlshM1y7hrMSNYPc8bpR0IMtAX/vgFfB37FWYtZxA5MaaTnkclE6b1SXhntNfjnk0g==
X-Received: by 2002:a17:902:b7c3:b0:176:b7e6:ae6c with SMTP id v3-20020a170902b7c300b00176b7e6ae6cmr292383plz.163.1663260537835;
        Thu, 15 Sep 2022 09:48:57 -0700 (PDT)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:3af2:34b2:a98a:a652])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902bcc400b00177ee563b6dsm13174970pls.33.2022.09.15.09.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 09:48:56 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
X-Google-Original-From: Sarthak Kukreti <sarthakkukreti@google.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH RFC 8/8] ext4: Add a per-file provision override xattr
Date:   Thu, 15 Sep 2022 09:48:26 -0700
Message-Id: <20220915164826.1396245-9-sarthakkukreti@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220915164826.1396245-1-sarthakkukreti@google.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sarthak Kukreti <sarthakkukreti@chromium.org>

Adds a per-file provision override that allows select files to
override the per-mount setting for provisioning blocks on allocation.

This acts as a mechanism to allow mounts using provision to
replicate the current behavior for fallocate() and only preserve
space at the filesystem level.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 fs/ext4/extents.c | 32 ++++++++++++++++++++++++++++++++
 fs/ext4/xattr.h   |  1 +
 2 files changed, 33 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 746213b5ec3d..a9ed908b2ebe 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4424,6 +4424,26 @@ int ext4_ext_truncate(handle_t *handle, struct inode *inode)
 	return err;
 }
 
+int ext4_provision_support(struct inode *inode)
+{
+	char provision;
+	int ret =
+		ext4_xattr_get(inode, EXT4_XATTR_INDEX_TRUSTED,
+			       EXT4_XATTR_NAME_PROVISION_POLICY, &provision, 1);
+
+	if (ret < 0)
+		return ret;
+
+	switch (provision) {
+	case 'y':
+		return 1;
+	case 'n':
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 				  ext4_lblk_t len, loff_t new_size,
 				  int flags)
@@ -4436,12 +4456,24 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 	struct ext4_map_blocks map;
 	unsigned int credits;
 	loff_t epos;
+	bool provision = false;
+	int file_provision_override = -1;
 
 	/*
 	 * Attempt to provision file blocks if the mount is mounted with
 	 * provision.
 	 */
 	if (test_opt2(inode->i_sb, PROVISION))
+		provision = true;
+
+	/*
+	 * Use file-specific override, if available.
+	 */
+	file_provision_override = ext4_provision_support(inode);
+	if (file_provision_override >= 0)
+		provision &= file_provision_override;
+
+	if (provision)
 		flags |= EXT4_GET_BLOCKS_PROVISION;
 
 	BUG_ON(!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS));
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index 824faf0b15a8..69e97f853b0c 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -140,6 +140,7 @@ extern const struct xattr_handler ext4_xattr_security_handler;
 extern const struct xattr_handler ext4_xattr_hurd_handler;
 
 #define EXT4_XATTR_NAME_ENCRYPTION_CONTEXT "c"
+#define EXT4_XATTR_NAME_PROVISION_POLICY "provision"
 
 /*
  * The EXT4_STATE_NO_EXPAND is overloaded and used for two purposes.
-- 
2.31.0

