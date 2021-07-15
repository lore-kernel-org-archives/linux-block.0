Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F4DC07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 04:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A2EB6128B
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 04:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbhGOE6n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 00:58:43 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:44733 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238811AbhGOE6m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 00:58:42 -0400
Received: by mail-pf1-f176.google.com with SMTP id p36so3961762pfw.11;
        Wed, 14 Jul 2021 21:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pOI+K4se5F+tjOo+nofYA29zCaWihWWoanvceJ6H/xU=;
        b=lf7/jppG/vhzD2IQbiX4XOm/jOk5Ns2OqzfsOYzEtYYhLW4D9bwIL6KXkL57+CHgE+
         bLWaljI4SgGZNDzE+P7d9bzrCUqhdUVcQZYP1PchhYTpybY3skZym8xdj1v9pi6JrVxx
         gHEXCFhnSKCmR87ru6oiXPsoKcRJbZxBzAlp3yW9PruktNKnh2JN+qfpo+lnBXtfniYN
         slux/mtXnD0blkUP4rCs1Eizcq+ai4NKjuelry4uNvZyy7U1V7w2bAqyksWFF8m5dJqA
         zsoXpcFE/nSpv1itIwbI2hdYdTUNAyVwcUdFW2oS7CQ+cqSuLVz8cXzvB3mtXFRN0RKu
         0yrg==
X-Gm-Message-State: AOAM530Wf6Wry+JgeVTUEdgQwf4OwW7ynbO3VYKSFzkCj4zgq8lsiZNK
        8hGlHFsUou3xxpnjwPKpse8=
X-Google-Smtp-Source: ABdhPJzg/unAdwX1mLJAowB5+WGRjSo9XkLzoOJAxLVtb3bUrtqCUVr0/U3td/GkmhClBUcuWjNfJw==
X-Received: by 2002:a63:c62:: with SMTP id 34mr2414998pgm.32.1626324949607;
        Wed, 14 Jul 2021 21:55:49 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id g141sm4630465pfb.210.2021.07.14.21.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 21:55:48 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 6/6] block: skip queue if NULL on blk_cleanup_queue()
Date:   Wed, 14 Jul 2021 21:55:31 -0700
Message-Id: <20210715045531.420201-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715045531.420201-1-mcgrof@kernel.org>
References: <20210715045531.420201-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that error handling for add_disk*() calls is added, we must
accept a common form for when errors are detected on the the
add_disk*() calls, and that is to call blk_cleanup_disk() on
error always. One of the corner cases possible is a driver bug
where the queue is already gone and we cannot blk_get_queue(),
and so may be NULL. When blk_cleanup_disk() is called in this
case blk_cleanup_queue() will crash with a null dereference.

Make this an accepted condition and just skip it. This allows us
to also test for it safely with error injection.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 04477697ee4b..156f7d3b4bd9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -372,6 +372,9 @@ void blk_cleanup_queue(struct request_queue *q)
 	/* cannot be called from atomic context */
 	might_sleep();
 
+	if (!q)
+		return;
+
 	WARN_ON_ONCE(blk_queue_registered(q));
 
 	/* mark @q DYING, no new request or merges will be allowed afterwards */
-- 
2.27.0

