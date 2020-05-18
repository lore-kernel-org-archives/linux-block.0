Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BEDC433DF
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 01:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50EF820758
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 01:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgERBsR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 May 2020 21:48:17 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50417 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgERBsR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 May 2020 21:48:17 -0400
Received: by mail-pj1-f66.google.com with SMTP id nu7so1826585pjb.0
        for <linux-block@vger.kernel.org>; Sun, 17 May 2020 18:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x+zg3IZlDk49LKTIYto5My49MTn9w4kMWDWNdNzyDno=;
        b=rDjOaNv/k4ZUtkLQZqeC4JtsrQWSpss9pFV3EjnLnSm6DEw4th6eo+V96uAyRTqstG
         Ko/krF+6nu0IAmEKUS7wOBOPYVR89ABdJ5OA7V8TKNcaaZc/9zgmISUSHkyv8+zYuiLA
         yN77fgzd1/1p3kavBc15gUItLSlffbNzswgTC2/2EXTfjxVWXmUTaA9VtlsE8uhR5rnv
         huIFQTPsyfN1hLZWKO3hLfR8U+Keyg8BgkNoXCrnglysL3eDj4z1Py1irX+xkYQR80GY
         fb5VudiFvHgxux9MkOBh8ndvW8e1v0U/JtVQsRfH/ROI24S8MiSYoeqrrE6IxFjHrlnL
         Obaw==
X-Gm-Message-State: AOAM5322koM3p7z2CoRR+WG2dXOC22xNcJfFkdVM5sP9I0VYc9/t9tCQ
        iUgXWsgWAJ0nXcogholNkiU=
X-Google-Smtp-Source: ABdhPJz4RHbCsHv2r8sCfZn24VJFfKczHr/jZW7CTvDsOhrG+qM5cZS3gLcRPiLvAxpbSAlySDJpLg==
X-Received: by 2002:a17:90a:2610:: with SMTP id l16mr16169324pje.219.1589766496331;
        Sun, 17 May 2020 18:48:16 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:1c3f:56a2:fad2:fca1])
        by smtp.gmail.com with ESMTPSA id m2sm3778353pjl.45.2020.05.17.18.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 18:48:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/4] Block layer patches for kernel v5.8
Date:   Sun, 17 May 2020 18:48:03 -0700
Message-Id: <20200518014807.7749-1-bvanassche@acm.org>
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

Changes compared to v1:
- Adjusted the comments added by patch "Document the bio_vec properties" as
  requested by Christoph.
- Left out the patch "Fix zero_fill_bio()" since it is not necessary.
- Moved zero_fill_bvec() from patch "Fix zero_fill_bio()" into patch
  "null_blk: Zero-initialize read buffers in non-memory-backed mode".

Bart Van Assche (4):
  block: Fix type of first compat_put_{,u}long() argument
  bio.h: Declare the arguments of the bio iteration functions const
  block: Document the bio_vec properties
  null_blk: Zero-initialize read buffers in non-memory-backed mode

 block/ioctl.c                 |  4 +--
 drivers/block/null_blk_main.c | 50 +++++++++++++++++++++++++++++++++++
 include/linux/bio.h           |  6 ++---
 include/linux/bvec.h          | 13 +++++++--
 4 files changed, 66 insertions(+), 7 deletions(-)

