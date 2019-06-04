Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC35C282CE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 18:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3CF20693
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 18:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFDSRo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 14:17:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45736 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFDSRo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jun 2019 14:17:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id x7so7671726plr.12
        for <linux-block@vger.kernel.org>; Tue, 04 Jun 2019 11:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s3Y0jbUJs68B4nxWJFSeO55vagLP40PvCFGFCWldvWU=;
        b=KlYgdR1c/Nrlm28o/MGzGMrUeFyLV3sXCrNHt+wAnw7Um2I95O771aYjZf1k2R/yCm
         QR5LT0JKTgAGoZluXl040BMUgozl74He2M/ETOOdwGvrMLWelRtpkp9RD1e5I3+/wabS
         Pp7eJ+6nOD/c5BzsEPG9NinLX3L8VvF8kBie7gWnoOSQ27HQpngFCHq+QM8396VpoLGY
         m3SNC7CE6HThrhtDbWewzUJMxu7017GNRi85s/BPxPI645he0JNEQWik5i48g7FLvoeW
         gPoYoyg0OPsrGEbvg7MgTGRHEYdP9yTVMPWPmsFD4eTZaQjBaVmFz8jfkLQtnbn3liNS
         eS+Q==
X-Gm-Message-State: APjAAAVWazMamiVTDJleeWMLFhVMpVweUbR47pptKn5sf+y8ZmLxp3/p
        Eus9RdhaUtajfHBf9JNMbEGTwvX8
X-Google-Smtp-Source: APXvYqzvxmLa538Hqy4mSc9HKc7prijLTyfK80GnlCKCE0TGJKdoQ2l3cp5jMW1Jbg1Y8c0oUTbg1g==
X-Received: by 2002:a17:902:76c6:: with SMTP id j6mr13439463plt.263.1559672263412;
        Tue, 04 Jun 2019 11:17:43 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id q19sm18318709pff.96.2019.06.04.11.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 11:17:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] Simplify blk-mq implementation
Date:   Tue,  4 Jun 2019 11:17:34 -0700
Message-Id: <20190604181736.903-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

While reviewing the blk_mq_make_request() code I noticed that it is possible
to simplify the implementation of that function. Please consider these patches
for kernel v5.3.

Thanks,

Bart.

Bart Van Assche (2):
  blk-mq: Remove blk_mq_put_ctx()
  blk-mq: Simplify blk_mq_make_request()

 block/blk-mq-sched.c  |  5 +----
 block/blk-mq-tag.c    |  8 --------
 block/blk-mq.c        | 26 +++++---------------------
 block/blk-mq.h        |  7 +------
 block/kyber-iosched.c |  1 -
 5 files changed, 7 insertions(+), 40 deletions(-)

-- 
2.22.0.rc3

