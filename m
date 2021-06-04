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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF1BC4743F
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 21:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5825561403
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 21:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFDVM1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jun 2021 17:12:27 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:35629 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhFDVMZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jun 2021 17:12:25 -0400
Received: by mail-qt1-f202.google.com with SMTP id l6-20020ac84cc60000b0290243ab0e481cso5812130qtv.2
        for <linux-block@vger.kernel.org>; Fri, 04 Jun 2021 14:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8v+WJhPg9I/xdgL6B4MiQX3CWBXyQYuM5MOB3Jc9dDY=;
        b=QRP2TwQixPWYnCinwP+Ayc/NX9oESif3zXsMESiFr/fPmLerJLAJJI31ktNvQoUUi/
         270xuMczduXDEX0vo2WK/GiF+vYlLeW1mKOFuNGgyPlQ58ZhE1qMy99pqSLvPW1zdSpI
         7WHShNVJE/9VUm/dGSwEosOgNVoiQe1PPfDMFzezYnam9YjQYccnGi34ygSa7XEX7oyb
         0LCE4C40aaOhyoeVm54LpIKdrTmC5JktSYenjEnkgNCDh1qyuQ5tx8nGQ9HAf956iCrx
         BD3SroZd7ttHA4w1l8C5fBKwL3tag/vAJxI3kmg5oNF7aOlMV5WLKwZoVqv3hv8mcYMc
         gRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8v+WJhPg9I/xdgL6B4MiQX3CWBXyQYuM5MOB3Jc9dDY=;
        b=PxoWUZKEVd7f0oEVqaejkaI3NvQ1+YND+q2AMdPNt6EkYOS5+rSMqLqg+0lJKpo901
         b+G167E0Yd5M0Xr79fnFSclbhFWVCVolJZ8Nf3LXCWCoZeP5CirPGqUHdKm16XzNyu9p
         GXTll2L5Tn/UwkNdWs+GvhLq5VjkKO6D8wt2wf4bs0qzjqXtkvqOSoEq5vNKlrhXxA6X
         OSF9dYa172SAorf6GuCppwMw86vpKR+OLd8GDqIwZlMuGN/ryIhOPYDqAr/a1jpJ4cMv
         xFDSbadS292Ja9H772KaUcen+zsH5Y9bQOen+3IcbIPjaAMbYoybNBI5Aj/2FwYRRt1p
         436g==
X-Gm-Message-State: AOAM533CyQG4YwFu4yXbVNvN4dqP0h0bat0RZ59UbCIXGrl6c8S0uGIw
        o9YAfd70Q/nVeYxvUDbkEzEjqqJGKtY=
X-Google-Smtp-Source: ABdhPJyjv+YInqbg6KaJ0jOYrxG2sn5YDWcEehU2DlFwYYyA8k2F0TGVXbcKcmz67/7RnRJ6djeyEnwJoGQ=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:ad4:4e68:: with SMTP id ec8mr6758723qvb.62.1622840966813;
 Fri, 04 Jun 2021 14:09:26 -0700 (PDT)
Date:   Fri,  4 Jun 2021 21:09:08 +0000
In-Reply-To: <20210604210908.2105870-1-satyat@google.com>
Message-Id: <20210604210908.2105870-10-satyat@google.com>
Mime-Version: 1.0
References: <20210604210908.2105870-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v9 9/9] fscrypt: update documentation for direct I/O support
From:   Satya Tangirala <satyat@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        Satya Tangirala <satyat@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Update fscrypt documentation to reflect the addition of direct I/O support
and document the necessary conditions for direct I/O on encrypted files.

Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/filesystems/fscrypt.rst | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 44b67ebd6e40..c0c1747fa2fb 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1047,8 +1047,10 @@ astute users may notice some differences in behavior:
   may be used to overwrite the source files but isn't guaranteed to be
   effective on all filesystems and storage devices.
 
-- Direct I/O is not supported on encrypted files.  Attempts to use
-  direct I/O on such files will fall back to buffered I/O.
+- Direct I/O is supported on encrypted files only under some
+  circumstances (see `Direct I/O support`_ for details). When these
+  circumstances are not met, attempts to use direct I/O on encrypted
+  files will fall back to buffered I/O.
 
 - The fallocate operations FALLOC_FL_COLLAPSE_RANGE and
   FALLOC_FL_INSERT_RANGE are not supported on encrypted files and will
@@ -1121,6 +1123,21 @@ It is not currently possible to backup and restore encrypted files
 without the encryption key.  This would require special APIs which
 have not yet been implemented.
 
+Direct I/O support
+==================
+
+Direct I/O on encrypted files is supported through blk-crypto. In
+particular, this means the kernel must have CONFIG_BLK_INLINE_ENCRYPTION
+enabled, the filesystem must have had the 'inlinecrypt' mount option
+specified, and either hardware inline encryption must be present, or
+CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK must have been enabled. Further,
+the starting position in the file and the length of any I/O must be aligned
+to the filesystem block size (*not* necessarily the same as the block
+device's block size). If any of these conditions isn't met, attempts to do
+direct I/O on an encrypted file will fall back to buffered I/O. However,
+there aren't any additional requirements on user buffer alignment (apart
+from those already present when using direct I/O on unencrypted files).
+
 Encryption policy enforcement
 =============================
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

