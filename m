Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F091C00140
	for <linux-block@archiver.kernel.org>; Mon, 15 Aug 2022 17:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiHORBH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Aug 2022 13:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiHORBE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Aug 2022 13:01:04 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14CF6270
        for <linux-block@vger.kernel.org>; Mon, 15 Aug 2022 10:01:03 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so7301741pjl.0
        for <linux-block@vger.kernel.org>; Mon, 15 Aug 2022 10:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=eQt4mmPSgpx1Fu0DTdvtmEOLxkE0baEUvlPjVGoDlxY=;
        b=oAg4aWCwrpXjzt5eu2nKAbQHuGbU3VfPXmtAkkQ1QS1fcKJApD2UC2/unJuNypyKwe
         LFlzm1hrms9YUhGOGM8eiGveldEw7zrH5rT372IPVKnzHLM3n8exxSGyBF9UqYGvLmGc
         owZdJ8nJKi72OrVgwPD2ToUgBR2ZpcChA2pEnyFXZXiVsvCk+JOkLzu74ikNkv3hiGql
         o5XQF67hgjlE6kJn8shRsBrw1stENF2ux3kQaq5XWH90KxPfVVrfPMekokXznME5XAO2
         Q8PW1lA4+E6dWY1QK1yZkkWhZYTH5htrhKqlVSgxP622SY4drrFoPayu5zKh+mTrNVLh
         PRvw==
X-Gm-Message-State: ACgBeo0xQuB56wnjqKtAqK83qiFV8b4GW3l7HoHq7ZW2vRdtNlaEg6aC
        4eatbUDjR38kRLChVsvKIqg=
X-Google-Smtp-Source: AA6agR45F1diHxPWyRL1naZyR7MrjWTeadsDsG4ESksSmH9CTDqYCm/mr0VtWjbdoQgUwAJ+booWfQ==
X-Received: by 2002:a17:90b:4a50:b0:1f4:f1b9:d21f with SMTP id lb16-20020a17090b4a5000b001f4f1b9d21fmr28311220pjb.185.1660582863113;
        Mon, 15 Aug 2022 10:01:03 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:c1a1:6549:b273:880b])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b0016eea511f2dsm7255690plx.242.2022.08.15.10.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 10:01:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 1/2] null_blk: Modify the behavior of null_map_queues()
Date:   Mon, 15 Aug 2022 10:00:42 -0700
Message-Id: <20220815170043.19489-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220815170043.19489-1-bvanassche@acm.org>
References: <20220815170043.19489-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of returning -EINVAL if an internal inconsistency is detected,
fall back to a single submission queue. This patch prepares for changing
the return value of the .map_queues() callbacks into void.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
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
 
