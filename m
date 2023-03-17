Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C08C6FD1D
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 20:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCQUAH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCQT7t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 15:59:49 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8D6B328B
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 12:59:48 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id ja10so6466236plb.5
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 12:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679083188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSCHFLaVXTN5mWYwGr2KqX7OOoJsy4ZOnFZbH+d5fV4=;
        b=uPEJiC9JCgNuNWfEzz1mdNsX3fSNGJ20Gp54e8NNyDGPXgf11dwa2WUuXKifdsMLoC
         XAZfUB0AN0n6cIgfhM4pZzOkmbJLhDkdO/tkuN7Orcmypyby8ghjxK+aJsaY4/Z2VK3a
         wjjxET69pL4XjhXwKownre19Nhe/kVwGiC7Gn6luAyv/CkPJO2HvIP36S5j6B8FX5Ifa
         Xcdwwx1IN19MJRpfQGIp5N59+7c4NCJ4aOp0N9xx0AJba8CXD8aKrA8lIQPzdQyifxHv
         4rhycPrAmd1uKcxM93I2gZl9p8N6QZFvKM390KfyPRFgsWNeTMpK8cn6UAaiF+nd0t3x
         pGYA==
X-Gm-Message-State: AO0yUKVFD5l2R5UU/khQkYfgu8dkR/4suwtdreOuT1NdE2FeYIfuKzri
        hZncpj/ZoZx0e7l55KIrvoU=
X-Google-Smtp-Source: AK7set9wflKAF2yuUtqY4icRvv96MyPBx8YhXvwyVgEDY4Gwo+kaCMEwyi/EIVRsOu4j8cV49IojEQ==
X-Received: by 2002:a17:903:2310:b0:19e:6760:305b with SMTP id d16-20020a170903231000b0019e6760305bmr9248732plh.47.1679083188281;
        Fri, 17 Mar 2023 12:59:48 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad26:bef0:6406:d659])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902eec600b0019cb131b89csm1051917plb.254.2023.03.17.12.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 12:59:47 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] Submit split bios in LBA order
Date:   Fri, 17 Mar 2023 12:59:36 -0700
Message-Id: <20230317195938.1745318-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

For zoned storage it is essential that split bios are submitted in LBA order.
This patch series realizes this by modifying __bio_split_to_limits() such that
it submits the first bio fragment and returns the remainder instead of
submitting the remainder and returning the first bio fragment. Please consider
this patch series for the next merge window.

Thanks,

Bart.

Bart Van Assche (2):
  block: Split blk_recalc_rq_segments()
  block: Split and submit bios in LBA order

 block/blk-merge.c      | 33 +++++++++++++++++++--------------
 block/blk-mq.c         |  7 +++++--
 block/blk.h            |  1 +
 include/linux/blk-mq.h |  6 ++++++
 4 files changed, 31 insertions(+), 16 deletions(-)

