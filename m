Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0A6C10F0B
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 21:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C712206DD
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 21:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfDAVUa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:20:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32776 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDAVUa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Apr 2019 17:20:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so5203242pfd.0;
        Mon, 01 Apr 2019 14:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eHDjoWZvxansatEzDR84uL7iy57E5jPUMhqN+zE2r4c=;
        b=OKDZRaw8+vtcijCKZ3BAtlMaFag6pKk1m2YBhnRrk+h6BRg5FCxr5zBB7zrVh8FF62
         zlK0F2zvwcQv71Ctp+r2LvSYKtNCWcNOJPKpniLPOGY6QUMbo/z3VKjyx//CfQkd1bij
         GMupyL60D6W0BITq1ORlmei4YsBtOLGA1dx8xQY12Bp1zkLgtUNohyt6bMgRoaUg8KfC
         y4wCw5HpNP42Fr//To8j1jDU4aG9GiJfpr5RIUD2I3vXgqMefOjEY11FFIkNWuL785hI
         DKNjqKxcxsZZ70jl6pTBUksWDYW/nYfVdvVs8DFJtR3Me1DQomf/sxuexwJVd/f/zNW7
         bQug==
X-Gm-Message-State: APjAAAU/O4VEj1aPypCrTBILNTlg6F4lpVRag+1oKCZpHwpE787giwRl
        XxVPOh4WM6KptLY/AwTKxlo=
X-Google-Smtp-Source: APXvYqzpn4+nna6jiQ3oQGuynVtRfGM3quowNyUe4OEgkPc8eunj0MygGru4IdzxE859Dg0kayxSyg==
X-Received: by 2002:a63:d1f:: with SMTP id c31mr38885887pgl.353.1554153629453;
        Mon, 01 Apr 2019 14:20:29 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z129sm20178813pfz.103.2019.04.01.14.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:20:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, stable@vger.kernel.org
Subject: [PATCH 3/4] block: Fix a comment in blk_cleanup_queue()
Date:   Mon,  1 Apr 2019 14:20:13 -0700
Message-Id: <20190401212014.192753-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190401212014.192753-1-bvanassche@acm.org>
References: <20190401212014.192753-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change a reference to the legacy block layer into a reference to blk-mq.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fdcf6de2243f..bfdbdbb8ec65 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -339,7 +339,8 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	/*
 	 * Drain all requests queued before DYING marking. Set DEAD flag to
-	 * prevent that q->request_fn() gets invoked after draining finished.
+	 * prevent that blk_mq_run_hw_queues() accesses the hardware queues
+	 * after draining finished.
 	 */
 	blk_freeze_queue(q);
 
-- 
2.21.0.196.g041f5ea1cf98

