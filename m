Return-Path: <SRS0=O1WO=4F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A2FC3402A
	for <linux-block@archiver.kernel.org>; Mon, 17 Feb 2020 21:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C1820801
	for <linux-block@archiver.kernel.org>; Mon, 17 Feb 2020 21:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgBQVIx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Feb 2020 16:08:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35512 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgBQVIx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Feb 2020 16:08:53 -0500
Received: by mail-pg1-f194.google.com with SMTP id v23so6455624pgk.2
        for <linux-block@vger.kernel.org>; Mon, 17 Feb 2020 13:08:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bPzWNOjv3O7tUoM8pshITUVi9l0rQND6jwW8+Nd1kEc=;
        b=US1LP4tL/GkSBJsyyg/Pg5ekeJfrcYEtn1+RgndRgBOhiO4T9MHMQm1jUTBl+JQYDr
         lHFGhTJBAHM3HuRCl80undi8hIG+/Ljd+H9U30HqfyPbJp1rDMjAjmWiourx1ASZt+N/
         KM8Clym0LJuez5Loz9XRmtqE7tG4EITz4X7tU36jto7OUskfBOJwYbePxk8qaa7V42Jt
         I1PfSrCoVf2693mF2Rd29DYJMI1ZXrqK3mKiMZeQwQ9QzwoBCOPgd87dAAaXnMog8RYb
         i894OGP2vZxKR/YT0d/JR9ee1caXtTtZuCS6KR2m1TFQODJQ39pTMEDobMeEBrdFchX1
         knlw==
X-Gm-Message-State: APjAAAXKUnXne74PfVmWAgyT0pY8/e7CPEF+bVr5eySyr+yJITZsVsWi
        GdrgRLRnfMygC960P1pjukARiWgJpzg=
X-Google-Smtp-Source: APXvYqwWtGAZeqHaOzpc2iYCYFwKEQIsVCCf1+hiZevwYMbDE1w/IwowOP5OUGjgbDKNK1bSq0DbAg==
X-Received: by 2002:a63:fb57:: with SMTP id w23mr19102585pgj.231.1581973731785;
        Mon, 17 Feb 2020 13:08:51 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:2474:e036:5bee:ca5b])
        by smtp.gmail.com with ESMTPSA id h13sm362952pjc.9.2020.02.17.13.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 13:08:51 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 4/5] null_blk: Suppress an UBSAN complaint triggered when setting 'memory_backed'
Date:   Mon, 17 Feb 2020 13:08:38 -0800
Message-Id: <20200217210839.28535-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217210839.28535-1-bvanassche@acm.org>
References: <20200217210839.28535-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Although it is not clear to me why UBSAN complains when 'memory_backed'
is set, this patch suppresses the UBSAN complaint that is triggered when
setting that configfs attribute.

UBSAN: Undefined behaviour in drivers/block/null_blk_main.c:327:1
load of value 16 is not a valid value for type '_Bool'
CPU: 2 PID: 8396 Comm: check Not tainted 5.6.0-rc1-dbg+ #14
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 dump_stack+0xa5/0xe6
 ubsan_epilogue+0x9/0x26
 __ubsan_handle_load_invalid_value+0x6d/0x76
 nullb_device_memory_backed_store.cold+0x2c/0x38 [null_blk]
 configfs_write_file+0x1c4/0x250 [configfs]
 __vfs_write+0x4c/0x90
 vfs_write+0x145/0x2c0
 ksys_write+0xd7/0x180
 __x64_sys_write+0x47/0x50
 do_syscall_64+0x6f/0x2f0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jth@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 16510795e377..7cd31d4ef709 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -276,7 +276,7 @@ nullb_device_##NAME##_store(struct config_item *item, const char *page,	\
 {									\
 	int (*apply_fn)(struct nullb_device *dev, TYPE new_value) = APPLY;\
 	struct nullb_device *dev = to_nullb_device(item);		\
-	TYPE uninitialized_var(new_value);				\
+	TYPE new_value = 0;						\
 	int ret;							\
 									\
 	ret = nullb_device_##TYPE##_attr_store(&new_value, page, count);\
