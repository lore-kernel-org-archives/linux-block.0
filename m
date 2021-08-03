Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0328DC4338F
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 18:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE3BA60EE8
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 18:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbhHCSXY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 14:23:24 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:37684 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbhHCSXX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Aug 2021 14:23:23 -0400
Received: by mail-pj1-f45.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so5114611pjb.2
        for <linux-block@vger.kernel.org>; Tue, 03 Aug 2021 11:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C5+k4RTsg4OJPfxTC3g493H7YxEOE3l6/fpNODib68k=;
        b=OvHxaBHT2Dldq1/GZgSkDBFMeeabM9nxASA06bSYNr6ufBFd8yQPTg9CIIUiqcvebG
         F5XaP4MMHhOTDX7T6KRebftA6yy3uIDIUSfxZAc9K1RQTAUASXatNKXErPAUCMpVaaO5
         mNNUE0lo8gf7R3lSll1m3d/Pa9Rhu2XQRcfQnq/9LFufYtxrfNdcDfBK+LWhXLdnU9A6
         XbKE1H4ATjjIdjALv5ogj2eVCw31/aZS81P3M0++ZTHFTqKYYYrVu4PbyMnd3z7EIXg8
         pJRIdPCKa1LLIXDdsEs6xMG8HAG80vOty9sth1FE41otUC4BmplIQHNLsG504VB3QIu8
         HZpw==
X-Gm-Message-State: AOAM531p0LgCK0wX5LjgSgSkIJuoU+l+Rpd/uQM3xOjQA6KA0TulX1tn
        j8yG5fgFNi9WqBnK8161Lv8=
X-Google-Smtp-Source: ABdhPJwkfWdo5mfQxLU/TyS80zKDf2iPRsBGHJbv2bkSbFyB3bdIlnYMYAI/Z9R2PKP6eBiCqCaBEA==
X-Received: by 2002:a65:6110:: with SMTP id z16mr4175280pgu.152.1628014992132;
        Tue, 03 Aug 2021 11:23:12 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:f630:1578:90bf:ff92])
        by smtp.gmail.com with ESMTPSA id ms8sm3476279pjb.36.2021.08.03.11.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 11:23:11 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/3] Improve loop driver I/O scheduler and QD selection
Date:   Tue,  3 Aug 2021 11:23:01 -0700
Message-Id: <20210803182304.365053-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The two patches in this patch series are what I came up with while testing
Android software. Please consider these patches for inclusion in the upstream
kernel.

Thanks,

Bart.

Changes compared to v1:
- Introduced BLK_MQ_F_NO_SCHED_BY_DEFAULT and use it in the loop driver.
- Removed BLK_MQ_F_NO_SCHED again from the loop driver.

Bart Van Assche (3):
  blk-mq: Introduce the BLK_MQ_F_NO_SCHED_BY_DEFAULT flag
  loop: Select I/O scheduler 'none' from inside add_disk()
  loop: Add the default_queue_depth kernel module parameter

 block/elevator.c       | 3 +++
 drivers/block/loop.c   | 8 ++++++--
 include/linux/blk-mq.h | 6 ++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

