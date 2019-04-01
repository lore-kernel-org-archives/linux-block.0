Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D7DC10F05
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 21:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8A52133D
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 21:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfDAVUb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:20:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44597 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDAVUb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Apr 2019 17:20:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so5185917pfm.11;
        Mon, 01 Apr 2019 14:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lbtL5HDiGSmdongH2mvoJvZmPRCHYZ1en9PeFqokieA=;
        b=KEd9LNmZu6DRJvr7hPbSiR2/u2ptUL+WZV/Bo79s2FQFSzM93xbHhwst4C4zv80zJ5
         GtjNpAa4bTjF8up91EnkcjgYFX1VmLWEOSasjWXvO+in6WUHGo3RoIi/pmg42YC98BzY
         Q/jXaibvEvRazw7YVJWlGrnZJwrkrag2dgVZrgQJXJ/6EilysmhRDie0D4CsHOVRuQK1
         60D1LGGQV8Dvl4gGw6nYtjkhhgWYJeOZgklVPVvDaFHPaFVRrZS2/QwxEh9c7j/+x7uC
         PoK+XDMkKx+im9554lROcxmYz7JFtIZrRXCX6ajTuwrKp47aEt15rq52pDuCV+EeVBNE
         mbZA==
X-Gm-Message-State: APjAAAXaljUBru9bu0MZm3/298/+9yzRjBNLskrLdbXWnF6Yn8My5Prj
        W6vOI7O1opTOQAsn+DGD1EI=
X-Google-Smtp-Source: APXvYqzH/E/LcqsQUY6rA3LXFaVZDBZeRC1BGguDHjD5AB6URA4MsRZhmpni8HKKJEBf5ECFbf1BJg==
X-Received: by 2002:a63:170d:: with SMTP id x13mr59836321pgl.169.1554153630633;
        Mon, 01 Apr 2019 14:20:30 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z129sm20178813pfz.103.2019.04.01.14.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:20:29 -0700 (PDT)
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
Subject: [PATCH 4/4] block: Make blk_cleanup_queue() faster
Date:   Mon,  1 Apr 2019 14:20:14 -0700
Message-Id: <20190401212014.192753-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190401212014.192753-1-bvanassche@acm.org>
References: <20190401212014.192753-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since blk_cleanup_queue() waits until q->q_usage_counter drops to zero
before setting the "dead" flag, it is guaranteed that all requests that
were in progress when blk_cleanup_queue() was called have finished before
the "dead" flag is set. This means it is not possible that any .queue_rq()
call is ongoing while the "dead" flag is set. Hence remove the code that
waits for ongoing .queue_rq() calls to finish after the "dead" flag has
been set. See also commit c2856ae2f315 ("blk-mq: quiesce queue before
freeing queue") # v4.16.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bfdbdbb8ec65..2921af6f8d33 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -348,18 +348,6 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
 
-	/*
-	 * make sure all in-progress dispatch are completed because
-	 * blk_freeze_queue() can only complete all requests, and
-	 * dispatch may still be in-progress since we dispatch requests
-	 * from more than one contexts.
-	 *
-	 * We rely on driver to deal with the race in case that queue
-	 * initialization isn't done.
-	 */
-	if (queue_is_mq(q) && blk_queue_init_done(q))
-		blk_mq_quiesce_queue(q);
-
 	/* for synchronous bio-based driver finish in-flight integrity i/o */
 	blk_flush_integrity();
 
-- 
2.21.0.196.g041f5ea1cf98

