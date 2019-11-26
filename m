Return-Path: <SRS0=BQu2=ZS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A49CC432C0
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 17:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABCB20684
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 17:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfKZR5G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:57:06 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:43898 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfKZR5G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 12:57:06 -0500
Received: by mail-pj1-f67.google.com with SMTP id a10so8621896pju.10
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2019 09:57:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d7OHw7kkh5rNDuZysQokElNgMwZGjWRroNp01X4L20Q=;
        b=OclgXkEU0MCSoqi0itRM4z2onnTtI5qGFYoMZCM8nVv6gHlcfNdRaTOV/D63EYWBYS
         XYQ3g+WouWZEJ8QB9/AVaoF9/v9hwuMyiq1fiMMMxjOPqqGTxKFNRDn+i/tBrtdNvljb
         9y4HkWPV6lU8g4KYzki/zlp1pYygSSaJq2nVwYaOTaYdx3MfhjkcuHoy+eTF0shCkkRO
         BCozfzShrrAdznLy9CCCZgz84QReaEz8Smrho4pK3dWfeimwG/EV2JUfRA/XyNJ/7rl1
         tqyT7BlOqjy7wB1DmMBdqgkkzoYIOzaaVjtmisH6yVbl0+zGW18xMvJsHmNq4YQoGDPW
         r2Ig==
X-Gm-Message-State: APjAAAVT7Z0ZRljBwmv1HjextyUbfwKN/xBHV44+j1UJ4+3M7xiXz5CX
        wL/+S3qJMjLdwzbfSZlqtUo=
X-Google-Smtp-Source: APXvYqzdNNGzsxYLR2xIlIKrwlMEwO8Ov41tvHZ4v6EdUZ9xn6ZlLBMo4y9OMLH7J0UPOo1987euow==
X-Received: by 2002:a17:90a:989:: with SMTP id 9mr383028pjo.35.1574791025864;
        Tue, 26 Nov 2019 09:57:05 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 82sm13178715pfa.115.2019.11.26.09.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 09:57:04 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] blk-mq: Support sharing tags across hardware queues
Date:   Tue, 26 Nov 2019 09:56:53 -0800
Message-Id: <20191126175656.67638-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Although the block layer already supports sharing hardware queues across
request queues, it does not yet support sharing tags across hardware queues.
Some SCSI hardware needs this functionality because this is a good match for
how some SCSI HBA's work. This patch does not incur a performance overhead
for block drivers that do not share tags across hardware queues.

Note: my original plan was to post this patch series after the merge window
has closed. I'm posting this now to allow comparison with alternative
approaches.

Thanks,

Bart.

Bart Van Assche (2):
  blk-mq: Move the TAG_ACTIVE and SCHED_RESTART flags from hctx into
    blk_mq_tags
  block: Add support for sharing tags across hardware queues

John Garry (1):
  blk-mq: Remove some unused function arguments

 block/blk-mq-debugfs.c | 42 ++++++++++++++++++++++++++++++++++++++----
 block/blk-mq-sched.c   |  8 ++++----
 block/blk-mq-sched.h   |  2 +-
 block/blk-mq-tag.c     | 19 +++++++++++--------
 block/blk-mq-tag.h     | 13 +++++++++++--
 block/blk-mq.c         | 38 +++++++++++++++++++++++++-------------
 block/blk-mq.h         |  2 +-
 include/linux/blk-mq.h | 10 ++++++----
 8 files changed, 97 insertions(+), 37 deletions(-)

