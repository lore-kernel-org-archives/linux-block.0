Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B868C0650F
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 18:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EEC20C01
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 18:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfG3SSF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:18:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40147 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbfG3SSF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 14:18:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so30257900pfp.7
        for <linux-block@vger.kernel.org>; Tue, 30 Jul 2019 11:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=brM2vy8GAAw7hQGH8n7IiDhTyVm/OGsWJf8LH5FSdzI=;
        b=H0uXvwP49dFtV9sS1aNAvxnVgBSUC33PhTgAYTTaZERIIEuROsdezX+7tS5Da/9D5t
         gPxau5359iyw0Fmjh83dPMWNr4jRFbxAvWOktTqZW4oV1Nr6PYP/zkTSmxUs3JZFxUFg
         hN6y22xeRNVm7E+wx1YozZ0lOs4DnJ+l/ziudkouw23F/xn2PITlB4DIIX6BBu9MBWHd
         d+wkhZgtHmhUExoA2lV1VhFOOYrb7DPDIErIgJD67JYGbwVUDexMgTt/1qb3dLUCZXSZ
         +GF7EKI1dSTV6tbD9i8bgrO+1eu7EpIE3+06CRWxuPLkpK6K41GrZrQcQb92kg3v3b4v
         kYOQ==
X-Gm-Message-State: APjAAAUo4/wbXENE43d3X71OcBIWZwaafPSVIzQP9UWojjvxtrd87iTP
        /TL3jQzYC9x6j+n7jWNwu10=
X-Google-Smtp-Source: APXvYqz5Pf/eXdnsNtX7WLnCgUnjg+Xtut3kh2r8ukmLhtIwpVUdIssx+HdXQeD3+Q5Oe6FqvCy7cA==
X-Received: by 2002:aa7:9ad2:: with SMTP id x18mr45016770pfp.192.1564510684663;
        Tue, 30 Jul 2019 11:18:04 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 32sm12165895pgt.43.2019.07.30.11.18.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:18:03 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] Fix a race condition triggered by submit_bio()
Date:   Tue, 30 Jul 2019 11:17:55 -0700
Message-Id: <20190730181757.248832-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

One of the consequences of the switch to blk-mq is that generic_make_request()
calls, a function called by submit_bio(), must be protected by a
blk_queue_enter() / blk_queue_exit() pair to avoid that the block-cgroup
functions called by generic_make_request() trigger a race condition. This patch
series makes the kernel report a warning if that race condition is hit and also
adds the necessary protection in submit_bio(). Please consider these patches
for kernel v5.4.

Thanks,

Bart.

Bart Van Assche (2):
  block: Verify whether blk_queue_enter() is used when necessary
  block: Fix a race condition in submit_bio()

 block/blk-cgroup.c         |  2 ++
 block/blk-core.c           | 34 +++++++++++++++++++++++++++++++++-
 include/linux/blk-cgroup.h |  2 ++
 include/linux/blkdev.h     |  8 ++++++++
 4 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.22.0.709.g102302147b-goog

