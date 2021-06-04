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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52705C4743C
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 21:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C5A1613EA
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 21:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhFDVM1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jun 2021 17:12:27 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:48997 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhFDVMZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jun 2021 17:12:25 -0400
Received: by mail-pj1-f74.google.com with SMTP id v2-20020a17090a9602b029015b0bb8b2b9so6638054pjo.3
        for <linux-block@vger.kernel.org>; Fri, 04 Jun 2021 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P+DRV+1kr28zVJ/U3wDOfdSPd3HkANrRfuFzxqlC4Pc=;
        b=BD3ZmfBd88tZgrK5VWyAdL43R8ifUsR8x6sFdE82nRuDKynYAWDrzE4ViAPmykHBE4
         iyytiZIYdAESIcvzY6xdWybqTUGCNisGZiXWYfKieKbymZmV/yt7zvjY9NFl3juibb/s
         ikEDpwDO3GTB7QBr/5PZz/yTynDJQ+EVyDbqXYxqVspW4jHjr6GfHmb6aePCiI+9M6Vd
         nAWhQ+RRLTv2OXSWhOZSnRNx4+nvq3NfPSSnycc4sLlhRuBgnNb++2d32IlTONdzLlpM
         5aRbbSRXEHIXxwZ6wYXd6/i1swYlGsa4c2M1WAwUuXtMLF2EffxUpGOmrT0pPALk2QKG
         mb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P+DRV+1kr28zVJ/U3wDOfdSPd3HkANrRfuFzxqlC4Pc=;
        b=sEBjQT5qjiZ+Lp2MfUzCyola0QgyVB2w5SO3wNNpF1Ss87VhWF+9BsSojyPBAmO+3p
         MwtV5w4jmuk+Hz8BABz0sX4IruQDMFYllwc/l6j0TxTSQ8tndfgBkiqlY0Qz5ANIvm/8
         MbtA+G1muUSnNlPuOUt6RT0Qm4Q6VVcHRlP+rYWzt5VNUwJeYwsUfcRcrRSBx7EeF4F2
         JAx0TW93XI2ft7lucSABaVk555wxqPU/JEcW0F3GY05Nn3EOEkyDugMWaDwGe+915xI9
         zld1edIE3DUBjYu+pv0eByBiN6fX/tPPQ584ifHY7sUqINDzCnOjIBpamnVgrWz6u0yx
         vrAQ==
X-Gm-Message-State: AOAM5315f3vwBqwvve73OysdB/iQzOa2VUpnJf/j2siOIqPNBn/BCd2I
        Rxk5jrv//I5kCpTj7E1pBx8QtIE1tVs=
X-Google-Smtp-Source: ABdhPJxmL8KM/5Kv0n8tQo795U2DFcdkGRAYUhSqHM6sj42QWQ+C3ACMCn3W2CeCnI48cqnYWj3LpGGCTK0=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a63:1e55:: with SMTP id p21mr6828807pgm.412.1622840965137;
 Fri, 04 Jun 2021 14:09:25 -0700 (PDT)
Date:   Fri,  4 Jun 2021 21:09:07 +0000
In-Reply-To: <20210604210908.2105870-1-satyat@google.com>
Message-Id: <20210604210908.2105870-9-satyat@google.com>
Mime-Version: 1.0
References: <20210604210908.2105870-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v9 8/9] f2fs: support direct I/O with fscrypt using blk-crypto
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
index c83d90125ebd..a416ea3a1a04 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4181,7 +4181,11 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
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
2.32.0.rc1.229.g3e70b5a671-goog

