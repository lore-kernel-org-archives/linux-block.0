Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5666FC433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 18:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiGOSrq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 14:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiGOSrp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 14:47:45 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B93402FC
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 11:47:44 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id bh13so5164940pgb.4
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 11:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xP7KsdzDRMTl5TooPnos98MJEZYTAJYE+yac1x8kR9E=;
        b=i3WNM5IsIlRo8QmKAE7fDxK5UqyrbeMZBPkFRQzChrgF5XnOauEeRDPpQwOgFM4Cub
         O04UtXkPDxYUwr01WyUQOHD+BRO60D8S5xNhNC5xDX1U94unAQOQkECLGSym0p90+88y
         4fw3hP0+mol3E9AhBk9YCdWKOpfZSUGCY3NbM3rqu2JHgfU6PKikzV4ntIsEBdQWTuWW
         izXGXuvrKkBZfP4Zxwj0vX7b5OlaHWWnlItA1bUwlEkN741kI0fyRuXQVM0rlUWwDUBN
         HvNsPnF1GQQ2Twk1c8oARpKC7lLy6xShffZNbK8I6NDL4esBMFyVS4N7eGDCJ6DfsZML
         7HFg==
X-Gm-Message-State: AJIora+abY93C2r7aFAkrLCb9Dcg5h0XBCUQHM5Ws70vSzsR5FNCuRBo
        L7A2JOj3M/g0Gx4lCtkEIpk=
X-Google-Smtp-Source: AGRyM1uM6aLsk1iCRZV6ZGRffyT13P0yezAxUxbrKAPy2AZmSigvIBuIIGvMA5fViSlnAfD1ht2tXg==
X-Received: by 2002:a65:41ca:0:b0:408:aa25:5026 with SMTP id b10-20020a6541ca000000b00408aa255026mr14071142pgq.96.1657910863788;
        Fri, 15 Jul 2022 11:47:43 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2e39:7b26:bf0e:fb58])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b0016c2cdea409sm3880490plc.280.2022.07.15.11.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 11:47:43 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] fs/buffer: Fix the ll_rw_block() kernel-doc header
Date:   Fri, 15 Jul 2022 11:47:34 -0700
Message-Id: <20220715184735.2326034-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220715184735.2326034-1-bvanassche@acm.org>
References: <20220715184735.2326034-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bring the ll_rw_block() kernel-doc header again in sync with the
function prototype.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 1420c4a549bf ("fs/buffer: Combine two submit_bh() and ll_rw_block() arguments")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/buffer.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index af53569930bb..82de136b83bb 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3049,14 +3049,13 @@ EXPORT_SYMBOL(submit_bh);
 
 /**
  * ll_rw_block: low-level access to block devices (DEPRECATED)
- * @op: whether to %READ or %WRITE
- * @op_flags: req_flag_bits
+ * @opf: block layer request operation and flags.
  * @nr: number of &struct buffer_heads in the array
  * @bhs: array of pointers to &struct buffer_head
  *
  * ll_rw_block() takes an array of pointers to &struct buffer_heads, and
  * requests an I/O operation on them, either a %REQ_OP_READ or a %REQ_OP_WRITE.
- * @op_flags contains flags modifying the detailed I/O behavior, most notably
+ * @opf contains flags modifying the detailed I/O behavior, most notably
  * %REQ_RAHEAD.
  *
  * This function drops any buffer that it cannot get a lock on (with the
