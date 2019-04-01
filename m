Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3204C43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 21:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13C8206DD
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 21:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfDAVU0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:20:26 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:40028 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDAVU0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Apr 2019 17:20:26 -0400
Received: by mail-pg1-f175.google.com with SMTP id u9so5388766pgo.7
        for <linux-block@vger.kernel.org>; Mon, 01 Apr 2019 14:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L63reSCWRJdu9lRbWDZB5SfgKwwSMngqSu47iw8A3yA=;
        b=AtdB15ECpNc9TTlmMVY2XPeNOAHvuKNcAn/dVby+jWbIRdh3xl+FVIdi4IGgjJICJ9
         r1+nnFakAljycF167V8FgM2TAEAWIUT/RLPSzU5Ij9QXl+OFlijtKLgG+hMgieE4mXPd
         OuGrXhbb1IJ5RDFi3fkv3TjULz4RY/fCDB0Y51UJFG4OKzDv2v1ZbdL+qwIDU5KW45Ba
         ufs34WJmokMiwN/7qvWnQyl4mEPdKmF/QWYc5psKUsfSAdYlISXsrY8LvD/bvRAcQZ7u
         Jl4MPW/DntydihX6T3FEThelvvtywfWOmqsH8Y4OXmbbnAWGxoZiechQdImec6wQBYwm
         F2vA==
X-Gm-Message-State: APjAAAXTWVFVkkNjztiN3fn2LMnufk0hBRZAObrq4CsWanI6xZGhfyfw
        yeW5IJU0ZUXo3SdCfV94u0T13NUI
X-Google-Smtp-Source: APXvYqwVnpIb0uL8WVs5s02ePqHGdCQtkL2B98u4RP8KG/t7AuBmmJN6vvXChvMsFnoD5Hvl8iUTpQ==
X-Received: by 2002:a62:b602:: with SMTP id j2mr51683004pff.68.1554153625671;
        Mon, 01 Apr 2019 14:20:25 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z129sm20178813pfz.103.2019.04.01.14.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:20:24 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/4] Fir a race between request queue cleanup and running queues
Date:   Mon,  1 Apr 2019 14:20:10 -0700
Message-Id: <20190401212014.192753-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series fixes a recently reported race between request queue cleanup
and running request queues. The approach followed is not to run the queue
anymore after a request queue has been marked "dead". Please consider this
patch series for kernel v5.1.

Thanks,

Bart.

Bart Van Assche (4):
  block: Move the percpu_ref_exit(&q->q_usage_counter) call into
    __blk_release_queue()
  block: Fix a race between request queue freezing and running queues
  block: Fix a comment in blk_cleanup_queue()
  block: Make blk_cleanup_queue() faster

 block/blk-core.c  | 17 ++---------------
 block/blk-mq.c    |  8 ++++++++
 block/blk-sysfs.c |  1 +
 3 files changed, 11 insertions(+), 15 deletions(-)

-- 
2.21.0.196.g041f5ea1cf98

