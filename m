Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB3AC25B08
	for <linux-block@archiver.kernel.org>; Fri, 12 Aug 2022 21:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiHLVIb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Aug 2022 17:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiHLVIT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Aug 2022 17:08:19 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0853B56DD
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 14:08:18 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso9396618pjo.1
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 14:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7rYoij0HxrZKxxljtTYd/rOiW2mwhPINEv/BJWGX9ak=;
        b=DqznOj2DWiolpG8NlmRmJ7E21AhaVrnnuhKKBMth7hgdhG2jZo3txm4xCzXrNVZN8A
         GnJaT3e5kJLFB0NLXrS9MPbdz3ISpGc0hsSRg9lEONy7UyQzTRj6RXR+C6ApKOZLNuVf
         ++kSY5ayZEhp3z7Igrg8yYoxZGa775q2LHqBmyr5U6IzJdLFbl6jjBmUG3CWN/VSha+b
         qon+Z5A+gJsRvAsi502XeDZyXcUpM5W0PU1KL0TLfvd1z1S8njvbYNZ3F4yaKxQbPveb
         CQnJDRvvSfDBUZJ/E8jfqbX1I1Y6vurjhpU2YFnID0ZLP10S9i0KCJY+pvuxR9W+CGiK
         NfSA==
X-Gm-Message-State: ACgBeo25JIIboQPCYsEAqXzlVOvHWQ6otQZzUE+N3dvGgPMt0sl+MZJS
        fxcfno5S7PWV7jQiIfjouiY=
X-Google-Smtp-Source: AA6agR5s4bmwM/w++2657Gw5S+W3YfxVDchGzBTL92PjyJA9Dt7UAI/TVO/0UUnkxdfqzu2cz5XriQ==
X-Received: by 2002:a17:90b:4f91:b0:1cd:3a73:3a5d with SMTP id qe17-20020a17090b4f9100b001cd3a733a5dmr5972449pjb.98.1660338498043;
        Fri, 12 Aug 2022 14:08:18 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2414:9f13:41de:d21d])
        by smtp.gmail.com with ESMTPSA id w62-20020a17090a6bc400b001f3095af6a9sm245905pjj.38.2022.08.12.14.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 14:08:17 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 5/6] null_blk: Modify the behavior of null_map_queues()
Date:   Fri, 12 Aug 2022 14:07:59 -0700
Message-Id: <20220812210800.2253972-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220812210800.2253972-1-bvanassche@acm.org>
References: <20220812210800.2253972-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of returning -EINVAL if an internal inconsistency is detected,
fall back to a single submission queue. This patch prepares for changing
the return value of the .map_queues() callbacks into void.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index c451c477978f..535059209693 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1555,7 +1555,9 @@ static int null_map_queues(struct blk_mq_tag_set *set)
 		} else {
 			pr_warn("tag set has unexpected nr_hw_queues: %d\n",
 				set->nr_hw_queues);
-			return -EINVAL;
+			WARN_ON_ONCE(true);
+			submit_queues = 1;
+			poll_queues = 0;
 		}
 	}
 
