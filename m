Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BCBC433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 08:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F16610CE
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 08:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbhDPIfm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 04:35:42 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:40863 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbhDPIfm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 04:35:42 -0400
Received: by mail-qk1-f176.google.com with SMTP id q136so7136748qka.7;
        Fri, 16 Apr 2021 01:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CC2FvscLdIp0sWXOA6KEj+ZwFZbmF/RC4jgWkWMcj88=;
        b=bN4jx0rUOvms7TWJ9AjLvEWaa0qYdM5WPAWZHrCDN4siY71IJgPdEmv6V0lZMZ8Hv+
         wTYPmed82shNGYDXwkl7Lbjh/X9qyINK32r849MuTZi2sV+VIwZpfgTk1M+sd++WQfJx
         UCafq9EzwbjsAqhzv1iPtJZogwEG8yp/kWr5C79iG60CdKS/lYxjnRFezQCQRRC9/cOY
         N5KxADOu5QrZGsfKY8ACfTA+LPzapfJnREooOQ4VxNJBsml2XF8jZggOT73ObJ+XYo0h
         hTSbejHvWbBmFaToMNZIG3WbDRTGmmGDnmO0zbaC61v16tg6EuZR2CizolLmz4yhdqUx
         m2Qw==
X-Gm-Message-State: AOAM530S4H9fJGVIZMqCI5/F/znmpA+I34GhLHzmszK3C8WzhNn5DglJ
        aHfDR5Bju+Dl8GbuJiswv9vWP5d66ZDX0g==
X-Google-Smtp-Source: ABdhPJx/iGpyIW6lZoLd7y+WIzdFvl/DJzzzbe4BB7Ls3PwAWLU9BOE7e4pxi/Eapk/qqLxnl/FTow==
X-Received: by 2002:a37:a89:: with SMTP id 131mr7296918qkk.92.1618562117331;
        Fri, 16 Apr 2021 01:35:17 -0700 (PDT)
Received: from black.ru.oracle.com (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id k17sm3363778qtp.26.2021.04.16.01.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 01:35:17 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Another small set of cleanups for floppy driver
Date:   Fri, 16 Apr 2021 11:34:44 +0300
Message-Id: <20210416083449.72700-1-efremov@linux.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just a couple of patches to make checkpatch.pl a bit more happy.
All these patches preserve original semantics of the code and only
memset(), memcpy() patches change binary code.

Denis Efremov (5):
  floppy: cleanups: remove trailing whitespaces
  floppy: cleanups: use ST0 as reply_buffer index 0
  floppy: cleanups: use memset() to zero reply_buffer
  floppy: cleanups: use memcpy() to copy reply_buffer
  floppy: cleanups: remove FLOPPY_SILENT_DCL_CLEAR undef

 drivers/block/floppy.c  | 23 +++++++--------------
 include/uapi/linux/fd.h | 46 ++++++++++++++++++++---------------------
 2 files changed, 31 insertions(+), 38 deletions(-)

-- 
2.30.2

