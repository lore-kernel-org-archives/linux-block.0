Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DE3C433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 00:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F002207C4
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 00:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgEPATX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 20:19:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46975 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgEPATX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 20:19:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id 145so1765182pfw.13
        for <linux-block@vger.kernel.org>; Fri, 15 May 2020 17:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sb4fG38GHBGsnRUu6/BUNBKLtAONj/+5m1P6lENvIY0=;
        b=VzkE2yWkMJ27ytGwO4D1+CitwLPKGZyvTu33BzWHkZ9UraleDYE9hSfqmh+1n84nci
         mhy69FmDp6m/nsgld1+VYl8N/5b5Kb1YV2lCTRHiM30OsDIaBffG6yX2z2Gwm1sWTQ41
         /GABKQjGCLZc3xeYjtzaP4oqCUdLAVVW2YlMdsyGhe8IUVgKifVSyBnsJ/Re5OasAFw/
         744V+AAwjFeQ6EZ57Wy0gZjc5eb4n41OonYdkHaK5XpC0K4PAsPym78cB6gYyo/21aIY
         PLK1W915p/zvkyqNvgxqKyMeH4xs3iz2LKxe5tjeN+7SbV3ncHGTU0odqNitGDU+DI+h
         5/zQ==
X-Gm-Message-State: AOAM532std4ogDgWsL3lIh5KaaCKw9sCaj9A4UBhq8K22Fkf0bYjhqIN
        iHTU1AuuOzgAAMTZPBnSalQ=
X-Google-Smtp-Source: ABdhPJwozG+k1GSU1ysovUbpYOEnVNHrTsydUTNktcr55nOSBZsKxzHVP9pulyUnzUsVaRclBaNjOA==
X-Received: by 2002:a62:1684:: with SMTP id 126mr6532106pfw.169.1589588361464;
        Fri, 15 May 2020 17:19:21 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:f99a:ee92:9332:42a])
        by smtp.gmail.com with ESMTPSA id 30sm2542383pgp.38.2020.05.15.17.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 17:19:20 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/5] Block layer patches for kernel v5.8
Date:   Fri, 15 May 2020 17:19:09 -0700
Message-Id: <20200516001914.17138-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The patches in this series are what I came up with as the result of
analyzing Alexander Potapenko's report about reading from null_blk.
Please consider these patches for kernel v5.8.

Thanks,

Bart.

Bart Van Assche (5):
  block: Fix type of first compat_put_{,u}long() argument
  bio.h: Declare the arguments of bio iteration functions const
  block: Document the bio_vec properties
  block: Fix zero_fill_bio()
  null_blk: Zero-initialize read buffers in non-memory-backed mode

 block/bio.c                   | 27 ++++++++++++++++++++++-----
 block/ioctl.c                 |  4 ++--
 drivers/block/null_blk_main.c | 30 ++++++++++++++++++++++++++++++
 include/linux/bio.h           |  7 ++++---
 include/linux/bvec.h          | 18 ++++++++++++++++--
 5 files changed, 74 insertions(+), 12 deletions(-)

