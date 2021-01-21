Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BB3C4332B
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 23:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22EA323A5E
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 23:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbhAUXZH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 18:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbhAUXGb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 18:06:31 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C3C0611BD
        for <linux-block@vger.kernel.org>; Thu, 21 Jan 2021 15:03:53 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id f7so2549872qvr.4
        for <linux-block@vger.kernel.org>; Thu, 21 Jan 2021 15:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=rQjj2/WzWm3qCtm3ibhFIzAxq8pwrDZXF1QHOMz3o4g=;
        b=OQwGeNkLyENvgqmLiHvbP7CSYH33j6r4RtJwGizSN8nWtM8Bd2dSMW/aHoyzXkcIXQ
         SFQAzk5HLMFt5kaGzlRUPtwP9Cbhd/ympkQ6qOFzAlI2PxYcVQ0gf5Y41UoQBpok/ssF
         pdjthPoUH3UPaE0tH2FUI6ZXptBS76fptbASUd5oFKbwFtVjL+37a5dGq3QxI8snd6w2
         /ZXit2IQfvc79GmSw0sHRQPGpRCCqCtWa32wqwXTBD9Q5oUnteXCjDPx8vA++4qRAB8/
         5eOStHbSSsuYUP+zC61cZOHerpgOL2Kh/UfZQ+22Z1w+MhDwLjcekAl9wXkg40ZZM1zP
         yyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rQjj2/WzWm3qCtm3ibhFIzAxq8pwrDZXF1QHOMz3o4g=;
        b=Mk+6UUcJAV+8cvdsYH1/tnHucV4h0o1NHdUVT3bOFHg6hglO0DQkTn+SGxXd8d0NI6
         CQPg0wALa8qjnie2YVBE7mVexrg+vPXGpalvAcigc758NRqCR2j/QwPFiGB0MYM1nSAG
         /wCpmxpFeOAt47qo5cLu9NTpIrk61DN6FTW+0tsReo3G2knz3Bvv73g+zn2Ilb5fB0GZ
         eXPsJ4u83KQEKUKzLi5XoYnaUPgyB+WA2ZcR81NstSecpqC122x0ByYZwP4ehlN6YFx9
         NFH6foqegbI9AbTHYCWWvQO41MAlWgdwvxAtuO17SsHuRFiYmS7kT+5zOQiibdLg1o+7
         +BUQ==
X-Gm-Message-State: AOAM532IguZO46+ezBfTUynfvnQtb+3Vwl9hNU9+7ty0mFNuL6ZU3bL9
        rs9LQvWg7I4z+RsE7r/EtAaxHKfvCig=
X-Google-Smtp-Source: ABdhPJzBS4n+vW6iQYRenoIZnviw813XxH38zeCsNFuDUBoahsAaZ41A78g1uNGV7RY2FFPhiAQAyieotuA=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a0c:a692:: with SMTP id t18mr2037203qva.18.1611270232543;
 Thu, 21 Jan 2021 15:03:52 -0800 (PST)
Date:   Thu, 21 Jan 2021 23:03:35 +0000
In-Reply-To: <20210121230336.1373726-1-satyat@google.com>
Message-Id: <20210121230336.1373726-8-satyat@google.com>
Mime-Version: 1.0
References: <20210121230336.1373726-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v8 7/8] f2fs: support direct I/O with fscrypt using blk-crypto
From:   Satya Tangirala <satyat@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Wire up f2fs with fscrypt direct I/O support. direct I/O with fscrypt is
only supported through blk-crypto (i.e. CONFIG_BLK_INLINE_ENCRYPTION must
have been enabled, the 'inlinecrypt' mount option must have been specified,
and either hardware inline encryption support must be present or
CONFIG_BLK_INLINE_ENCYRPTION_FALLBACK must have been enabled). Further,
direct I/O on encrypted files is only supported when the *length* of the
I/O is aligned to the filesystem block size (which is *not* necessarily the
same as the block device's block size).

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bb11759191dc..5130423a13e7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4091,7 +4091,11 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int rw = iov_iter_rw(iter);
 
-	if (f2fs_post_read_required(inode))
+	if (!fscrypt_dio_supported(iocb, iter))
+		return true;
+	if (fsverity_active(inode))
+		return true;
+	if (f2fs_compressed_file(inode))
 		return true;
 	if (f2fs_is_multi_device(sbi))
 		return true;
-- 
2.30.0.280.ga3ce27912f-goog

