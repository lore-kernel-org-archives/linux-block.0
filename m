Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB17C433DB
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 20:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1458264F30
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 20:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhCQUxA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbhCQUwz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Mar 2021 16:52:55 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C13EC06174A;
        Wed, 17 Mar 2021 13:52:55 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id v2so19916pgk.11;
        Wed, 17 Mar 2021 13:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AKYuNNautpL9GsX/k1t8k+V+WDGi+hWf1VRFyREZzWA=;
        b=fUA+sXj1+G1P5qNMQ3kV1By1YcbAhSpxmiKaAIT23Y1EzpBNXfRcRBmgdK17ce3hub
         0keIoX//U2oSDv731hzNmxXSUCF82cav2yP2CKAdC2kNZUIRnStPyLaZU84yARuYvxNb
         bJn+0Cn3o4OMuHE7fMdvQL3q1o5I+AT0651yDaEsO+g/Y0mm/NZrRD5PoRYVYf6CBmCy
         YQ0A7+Jb2NACN97GCRD8jy744trAaVTwv5VuelkHknxUzvpRTBo4PYjJ8iLATc1u1t90
         CrMD4Mcjg5nS/JL9eO0AMwOSMyNllGprQPsULRWUYN1RTPc6uP+LKFam7LhJOGap1LJ4
         RO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AKYuNNautpL9GsX/k1t8k+V+WDGi+hWf1VRFyREZzWA=;
        b=SeiXMAJK7rPmuLkXmsAFKPvJiwTLNBCwpwZcs5HPpp3g/KyGj+7Sbd2LfPEz3MSgG4
         B0fVu+mM25KxmpQESiFBkRUe7U08ZMw8j/7Fd2sH/JoHf7NeKEBAA0WJmT8AGBlqIXgg
         X9Qa0OAk+4P7XdQY1hJ57Tpm8Hr/5kmzdnFeUtAawUua35LeyF6T1fx6OOG8UH1FxzaX
         Vq1zYdEpUtfWhgEqEGkq4tSjzGAkKGuDWK2FA3XnFBxhZir8ZxM0CMQYB/KJZN8JmDfK
         widbJaS2UVJxoIUuSJmPdJX1NjSprNt9GN4llzUUioEqg5M/v+kk/4PpsWySfEOaj4S0
         N5tg==
X-Gm-Message-State: AOAM530VQ9wRLfi+C0LOYhgnE06J2drInaed8a5FvW7XYja3IH9gzFx5
        FhjU4y6QSUuT1moPsTBHN3xDR8mz/+o+Pg==
X-Google-Smtp-Source: ABdhPJy8/iAz5N4nZP350sq8I/6aYbGirU4K/scVbtxPllJU5LobeunkJS+SKR9TRE0ZhRvTrrMjIA==
X-Received: by 2002:aa7:9841:0:b029:1f8:f326:a3b3 with SMTP id n1-20020aa798410000b02901f8f326a3b3mr785222pfq.7.1616014374477;
        Wed, 17 Mar 2021 13:52:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a089:85d1:b0af:d6ff:42d8])
        by smtp.googlemail.com with ESMTPSA id d24sm30137pjw.37.2021.03.17.13.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:52:54 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, ldm@flatcap.org,
        axboe@kernel.dk, linux-ntfs-dev@lists.sourceforge.net,
        linux-block@vger.kernel.org
Subject: [PATCH] block: fix comment syntax in file headers
Date:   Thu, 18 Mar 2021 02:22:45 +0530
Message-Id: <20210317205245.24857-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
There are files in block/partitions/ which follow this syntax in their file
headers, i.e. start with '/**' like comments, which causes unexpected
warnings from kernel-doc.

E.g., running scripts/kernel-doc -none on block/partitions/ldm.h
causes this warning:
"warning: expecting prototype for ldm(). Prototype was for _FS_PT_LDM_H_() instead"

Provide a simple fix by replacing such occurrences with general comment
format, i.e., "/*", to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
* Applies perfectly on next-20210312

 block/partitions/ldm.c | 2 +-
 block/partitions/ldm.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index d333786b5c7e..14b124cdacfc 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * ldm - Support for Windows Logical Disk Manager (Dynamic Disks)
  *
  * Copyright (C) 2001,2002 Richard Russon <ldm@flatcap.org>
diff --git a/block/partitions/ldm.h b/block/partitions/ldm.h
index d8d6beaa72c4..ffdecf1c6bb3 100644
--- a/block/partitions/ldm.h
+++ b/block/partitions/ldm.h
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * ldm - Part of the Linux-NTFS project.
  *
  * Copyright (C) 2001,2002 Richard Russon <ldm@flatcap.org>
-- 
2.17.1

