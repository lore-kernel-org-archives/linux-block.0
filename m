Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094FBC001B0
	for <linux-block@archiver.kernel.org>; Mon, 17 Jul 2023 20:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGQUxP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jul 2023 16:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjGQUxO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jul 2023 16:53:14 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE4110C4
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 13:52:30 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-345e55a62d8so21988405ab.3
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 13:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689627149; x=1692219149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0Rh+hgK5RJM2LTqnV8n589VzEO88GagfvtQuoz9vkQ=;
        b=bod9FDO/bX968d17JiiRC3Rkj1Ov86dwMdlXuKHHdGWluLmP95fwzkRFcO9FxEpcHP
         Yya6ZUNDzysYOdSVnGKzr6czaGCi92Tj33X4wgF1dWwguyRM6sITMMibGsfqgxDWdm/7
         Hr2DL8fxjp7/2OT3KoWy15Jic9k2Eda9PnLBGfEelJeFg+kQe9/kDVCtJJc9kVffvGA0
         aO10iPPDadlwZuvIMVzGWkcL76vKtFZvHNcwJgkjSt4rVt0VwaMLlzwH4OtTjchigGMA
         hDfvsayS8peaeOBbZHWUfCAZ3sHFJIQ97EqyYsP/okOHJyvoh/Z/W7E6LcokStTR0wEt
         29kw==
X-Gm-Message-State: ABy/qLZy3w1hpo/8rtE+YmHFCjNqsmUC+5kg1m1siaQJNthlxHx5KyNw
        Ydr6xWfVBotdYY9RtqedCug=
X-Google-Smtp-Source: APBJJlGwXDIBhgTRd5cxE6vLq5rFpSBD0VpkKqfWOKPl89NtLqQCiDSrUkxqPsUQtq9VGdMzX0lOiA==
X-Received: by 2002:a92:c24e:0:b0:348:7ac8:ce6b with SMTP id k14-20020a92c24e000000b003487ac8ce6bmr835468ilo.17.1689627149392;
        Mon, 17 Jul 2023 13:52:29 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ac3:b183:3725:4b8f])
        by smtp.gmail.com with ESMTPSA id v17-20020a17090abb9100b0025645ce761dsm5222403pjr.35.2023.07.17.13.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 13:52:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] Improve performance for BLK_MQ_F_BLOCKING drivers
Date:   Mon, 17 Jul 2023 13:52:12 -0700
Message-ID: <20230717205216.2024545-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Request queues are run asynchronously if BLK_MQ_F_BLOCKING has been set. This
results in suboptimal performance. This patch series improves performance if
BLK_MQ_F_BLOCKING has been set by running request queues synchronously
whenever possible.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Bart Van Assche (3):
  scsi: Inline scsi_kick_queue()
  scsi: Remove a blk_mq_run_hw_queues() call
  block: Improve performance for BLK_MQ_F_BLOCKING drivers

 block/blk-mq.c          | 17 +++++++++++------
 drivers/scsi/scsi_lib.c | 13 +++++--------
 2 files changed, 16 insertions(+), 14 deletions(-)

