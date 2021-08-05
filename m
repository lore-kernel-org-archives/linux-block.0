Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98C4C4338F
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 17:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB9461104
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 17:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhHERmX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 13:42:23 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:45974 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhHERmW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Aug 2021 13:42:22 -0400
Received: by mail-pj1-f43.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso11294968pjf.4
        for <linux-block@vger.kernel.org>; Thu, 05 Aug 2021 10:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dU531f21BXDNharoKE8ruDXQphQ1CSt9jQ0hwIzXdUE=;
        b=dg7ewrlpDMnzwmHJ1lmNItYksqJQ+qyVfQw3Hib33sOEOIEapqFJlhMqMnjEeXqo1g
         OpuiBKkDuabzp85pzMuL0gqorIrKcuH31Jt9pDoXDGMaBSh3IK3f0vVjFAygyxSxp9+6
         ci/UKrPcmpQQeLmVYSH88/mzrhMadT19oE0DZiKA31gjGHBnHW/lUyF06c4XnfrLIKDL
         03+RUHBxpt/2wdnLQLfL5J1QihEgXARCgveKzLChT1dvql/v/ZtD+IdVJUiSfWLv57IM
         LA0dSTr8wVISUDYvd2ONMYlYyTdH38Rn0zyZSOO9R6HbT7gjrZ+GAAUl74fuzLrHfAhI
         1iqw==
X-Gm-Message-State: AOAM532OPpUUQajNylMjqNrJrKLcBGo0oK9yLtC0BYg6XI57kHW1qzfP
        2esWnf3HqdwlTIbAZvwAaps=
X-Google-Smtp-Source: ABdhPJzI2kuHYCgF9y+XvvNd7PsPhN7YqRDvaEkFF9PhDbCHYPpoI3DvxG8SOQxET1CPvWF4UW74YA==
X-Received: by 2002:a63:cd4c:: with SMTP id a12mr259576pgj.449.1628185328151;
        Thu, 05 Aug 2021 10:42:08 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:93c2:eaf5:530d:627d])
        by smtp.gmail.com with ESMTPSA id m11sm10381834pjn.2.2021.08.05.10.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 10:42:07 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 0/2] Change the default loop driver I/O scheduler
Date:   Thu,  5 Aug 2021 10:41:58 -0700
Message-Id: <20210805174200.3250718-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The two patches in this patch series change the default I/O scheduler of
request queues created by the loop driver from 'mq-deadline' into 'none'.
Please consider these two patches for inclusion in the Linux kernel.

Thanks,

Bart.

Changes compared to v2:
- Dropped the patch that makes the loop driver queue depth configurable via a
  kernel module parameter.
- Added a q->tag_set test in patch 1/2. Although I'm not sure this test is
  still needed after Christoph's latest queue creation rework, it doesn't harm.

Changes compared to v1:
- Introduced BLK_MQ_F_NO_SCHED_BY_DEFAULT and use it in the loop driver.
- Removed BLK_MQ_F_NO_SCHED again from the loop driver.

Bart Van Assche (2):
  blk-mq: Introduce the BLK_MQ_F_NO_SCHED_BY_DEFAULT flag
  loop: Select I/O scheduler 'none' from inside add_disk()

 block/elevator.c       | 3 +++
 drivers/block/loop.c   | 3 ++-
 include/linux/blk-mq.h | 6 ++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

