Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7936C10F0B
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 15:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD02120674
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 15:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfDBPoN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:44:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36831 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDBPoN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 11:44:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id ck15so5275949plb.3;
        Tue, 02 Apr 2019 08:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2J3JNlHEnfYSgUSsh4Gi92+U0Z8xFY101mPnbVB1XAk=;
        b=EkgYOSc3ZC+oNEgu6MkBIhiHqpt8VLjdIDCPWJkHjwicCjnJ1Tg7cS0nAofVa2Im9C
         R/UzCnTiFQHbLeKmfySwfWczjJz+438qga6MNDKag0hyFwURSBlktcig0kNVSCcn+zdw
         bQr89suhBGmmTXkvGIVVEsJQaiX2ZaDHIHM5kkwJukbP9aO0Ja1QenqAZAbgTaGZYkVt
         TmtS7ZqUgJhBihG8R1KZ/2hOiw4kqgOeYtcpqR7ZKLVY7DVnckUe7i1eCMMlT27hnwIQ
         bIwk7g7D9qnghX8OfjIH2QG3LIhwHtt0hKXjJrkjfRFov3QopY5DNsQJOEjKLMTHpDvu
         szoA==
X-Gm-Message-State: APjAAAWaDqr6b6XKmyp6pLLBNGm4N2WY37zfP07+d7GLbOhmyJkynkuc
        JYtyNol+uT5/12lgXU0dtnQ=
X-Google-Smtp-Source: APXvYqybGfV8ExXBOe9ipe+tbKKQUecA0O/A7dAMNIatBAkqQ627vPLFfWuhJx9VOY1vLRCKZ/cT1w==
X-Received: by 2002:a17:902:31c3:: with SMTP id x61mr69975476plb.143.1554219852863;
        Tue, 02 Apr 2019 08:44:12 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id o68sm38666591pfi.140.2019.04.02.08.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 08:44:12 -0700 (PDT)
Message-ID: <1554219850.118779.137.camel@acm.org>
Subject: Re: [PATCH 2/4] block: Fix a race between request queue freezing
 and running queues
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, stable@vger.kernel.org
Date:   Tue, 02 Apr 2019 08:44:10 -0700
In-Reply-To: <20190402005318.GC21944@ming.t460p>
References: <20190401212014.192753-1-bvanassche@acm.org>
         <20190401212014.192753-3-bvanassche@acm.org>
         <20190402005318.GC21944@ming.t460p>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-02 at 08:53 +-0800, Ming Lei wrote:
+AD4 On Mon, Apr 01, 2019 at 02:20:12PM -0700, Bart Van Assche wrote:
+AD4 +AD4 diff --git a/block/blk-mq.c b/block/blk-mq.c
+AD4 +AD4 index 3ff3d7b49969..652d0c6d5945 100644
+AD4 +AD4 --- a/block/blk-mq.c
+AD4 +AD4 +-+-+- b/block/blk-mq.c
+AD4 +AD4 +AEAAQA -1499,12 +-1499,20 +AEAAQA void blk+AF8-mq+AF8-run+AF8-hw+AF8-queues(struct request+AF8-queue +ACo-q, bool async)
+AD4 +AD4  	struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx+ADs
+AD4 +AD4  	int i+ADs
+AD4 +AD4  
+AD4 +AD4 +-	/+ACo
+AD4 +AD4 +-	 +ACo Do not run any hardware queues if the queue is frozen or if a
+AD4 +AD4 +-	 +ACo concurrent blk+AF8-cleanup+AF8-queue() call is removing any data
+AD4 +AD4 +-	 +ACo structures used by this function.
+AD4 +AD4 +-	 +ACo-/
+AD4 +AD4 +-	if (+ACE-percpu+AF8-ref+AF8-tryget(+ACY-q-+AD4-q+AF8-usage+AF8-counter))
+AD4 +AD4 +-		return+ADs
+AD4 +AD4  	queue+AF8-for+AF8-each+AF8-hw+AF8-ctx(q, hctx, i) +AHs
+AD4 +AD4  		if (blk+AF8-mq+AF8-hctx+AF8-stopped(hctx))
+AD4 +AD4  			continue+ADs
+AD4 +AD4  
+AD4 +AD4  		blk+AF8-mq+AF8-run+AF8-hw+AF8-queue(hctx, async)+ADs
+AD4 +AD4  	+AH0
+AD4 +AD4 +-	percpu+AF8-ref+AF8-put(+ACY-q-+AD4-q+AF8-usage+AF8-counter)+ADs
+AD4 +AD4  +AH0
+AD4 +AD4  EXPORT+AF8-SYMBOL(blk+AF8-mq+AF8-run+AF8-hw+AF8-queues)+ADs
+AD4 
+AD4 I don't see it is necessary to add percpu+AF8-ref+AF8-tryget()/percpu+AF8-ref+AF8-put()
+AD4 in the fast path if we simply release all hctx resource in hctx's
+AD4 release handler by the following patch:
+AD4 
+AD4 https://lore.kernel.org/linux-block/20190401044247.29881-2-ming.lei+AEA-redhat.com/T/+ACM-u
+AD4 
+AD4 Even we can kill the percpu+AF8-ref+AF8-tryget+AF8-live()/percpu+AF8-ref+AF8-put() in
+AD4 scsi+AF8-end+AF8-request().

The above approach has the advantages of being easy to review and to maintain.

Patch +ACIAWw-PATCH V2 1/3+AF0 blk-mq: free hw queue's resource in hctx's release handler+ACI
makes the block layer more complicated because it introduces a new state for
hardware queues: block driver cleanup has happened (set-+AD4-ops-+AD4-exit+AF8-hctx(...)) but
the hardware queues are still in use by the block layer core.

Let's see what other reviewers think.

Bart.
