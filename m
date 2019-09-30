Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C818C35280
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 23:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A882053B
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 23:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfI3XA5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 19:00:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32835 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfI3XA5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 19:00:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so6475487pfl.0
        for <linux-block@vger.kernel.org>; Mon, 30 Sep 2019 16:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mSTVW81MOB0fdiWZYyq6yTKbKqq2M0RuHi0rUPr9vpE=;
        b=QvVFknOFWPl5llzDqy71hDunKY1UHiUzXvrFSlC2t8xo4lhGoIbFe8wUf2A/m6dJkf
         nCXzt6L0x8wYFmcuzsgnUG/SrnocEf9IgmYeZq/6qyZurSG5e/yCb3qYo1Zkzix17GgC
         5dUUVe9wvCEchsU0HY/jc415m9E2Kiw10oxvUMPmsvYge/B+R0Nfkhk/13R16onGPtzr
         9eZLevsIfW7nHmmvisqrc6OOc3DqmUaw5l6oaNtzO1iFpr1u6xE+blEtW46aNngXlF/I
         MygwdOhKIQ/WeOV5R6x8cwO5fxjGuORRgw9DXD3iYN3ExtTme7GcdjW9uFS3x4Zygj2Q
         J48w==
X-Gm-Message-State: APjAAAWrfEEOIHRut52POHWolUbe452GagqM/Phpz3el0PNXkNdai0yD
        mED8AqaYiAUubcBfN9vKFAA=
X-Google-Smtp-Source: APXvYqyPOtkRj+lCOvscYqjp8Ss55MYqBggR/geriNUbUz8W6uU5syuiCRU8uTd4fvlKXwm3rleURQ==
X-Received: by 2002:a62:1a4d:: with SMTP id a74mr268625pfa.179.1569884456706;
        Mon, 30 Sep 2019 16:00:56 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 74sm15071747pfy.78.2019.09.30.16.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:00:55 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 1/8] block: Fix three kernel-doc warnings
Date:   Mon, 30 Sep 2019 16:00:40 -0700
Message-Id: <20190930230047.44113-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930230047.44113-1-bvanassche@acm.org>
References: <20190930230047.44113-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the following kernel-doc warnings:

block/t10-pi.c:242: warning: Function parameter or member 'rq' not described in 't10_pi_type3_prepare'
block/t10-pi.c:249: warning: Function parameter or member 'rq' not described in 't10_pi_type3_complete'
block/t10-pi.c:249: warning: Function parameter or member 'nr_bytes' not described in 't10_pi_type3_complete'

Cc: Max Gurtovoy <maxg@mellanox.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Fixes: 54d4e6ab91eb ("block: centralize PI remapping logic to the block layer")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/t10-pi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index 9803c7e0376e..f4907d941f03 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -235,16 +235,12 @@ static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
 	return t10_pi_verify(iter, t10_pi_ip_fn, T10_PI_TYPE3_PROTECTION);
 }
 
-/**
- * Type 3 does not have a reference tag so no remapping is required.
- */
+/* Type 3 does not have a reference tag so no remapping is required. */
 static void t10_pi_type3_prepare(struct request *rq)
 {
 }
 
-/**
- * Type 3 does not have a reference tag so no remapping is required.
- */
+/* Type 3 does not have a reference tag so no remapping is required. */
 static void t10_pi_type3_complete(struct request *rq, unsigned int nr_bytes)
 {
 }
-- 
2.23.0.444.g18eeb5a265-goog

