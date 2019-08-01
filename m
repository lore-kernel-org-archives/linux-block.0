Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505CDC433FF
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 22:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A022080C
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 22:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbfHAWu5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:50:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36428 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbfHAWux (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 18:50:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so34897158pfl.3
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 15:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xvL9Haq30NQeSrZpsoUzp42SRMMMsWiR+7O3kyGepU=;
        b=iq/WVTkiQPYUoIW6iMEXLWqVfUGVIWLRt4XsI14u6iK6mSymoZo0hQD/fif/K3/M47
         spwhG5IW59zsEMypt/VBsJ1TvZN+wl4SkN0wBGGRkYa87mRHuZz+KULgNG3tVm2Qri8v
         3imZ/LUVZxYg0QiXubgj5WqZkn9iBW+XOzxH3kHmO35WrwWsIL+OsabL2WYpG7DbdlPB
         yZJZBvMYocLnHMgnoAxgX0aucBlfxI/IWsayMWnkCfzd3MwQ+PD2gsrUMQ9N/3OGvYDA
         Q1sLXjInjzCG+u7dowcVzstKfaEdbvTCqFXDFOogmzlXwUeGc8dkbKtag/WRr2Fb1lmO
         aPEw==
X-Gm-Message-State: APjAAAUFHfa/LRRWH4GT9qZP6ZkcK0FCZ0d6eiH+D/aKKwJlUzzIuXTl
        8xIa7cuIh/jYXjqtoloZzgk=
X-Google-Smtp-Source: APXvYqzGesGNoSYqTCNIk3/ctWg4MJ+qB+9Fna+xA2vScCyx+zAmNbt1xm0iwb4CyWw2Dj+FgaNzdg==
X-Received: by 2002:a65:4786:: with SMTP id e6mr118580161pgs.448.1564699852855;
        Thu, 01 Aug 2019 15:50:52 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id d12sm35472010pfn.11.2019.08.01.15.50.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:50:51 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/5] Optimize bio splitting
Date:   Thu,  1 Aug 2019 15:50:39 -0700
Message-Id: <20190801225044.143478-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series improves bio splitting in several ways:
- Reduce the number of CPU cycles spent in bio splitting code.
- Make the bio splittig code easier to read.
- Optimize alignment of split bios.

Please consider this patch series for kernel v5.4.

Thanks,

Bart.

Changes compared to v1: addressed Johannes' review feedback.

Bart Van Assche (5):
  block: Declare several function pointer arguments 'const'
  block: Document the bio splitting functions
  block: Simplify bvec_split_segs()
  block: Simplify blk_bio_segment_split()
  block: Improve physical block alignment of split bios

 block/bio.c            |   4 +-
 block/blk-merge.c      | 151 ++++++++++++++++++++++++++++-------------
 include/linux/blkdev.h |  32 ++++-----
 3 files changed, 120 insertions(+), 67 deletions(-)

-- 
2.22.0.770.g0f2c4a37fd-goog

