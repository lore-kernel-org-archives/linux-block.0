Return-Path: <SRS0=58UM=6D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D045AC54FCB
	for <linux-block@archiver.kernel.org>; Sun, 19 Apr 2020 19:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07922145D
	for <linux-block@archiver.kernel.org>; Sun, 19 Apr 2020 19:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587325550;
	bh=Kjz2UV2IjrUUvcAO3SW0csvuEdtPQY4bw4xowWf485E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sl4otURc7LZ8N1V4O3yKm5uj04ITwEqn4+vNTmnBeZbccVjWhWaeExL3NDOIpu5BX
	 EHSsu35aTLp2FSIhI88IZ2bwslI0jUXbWmMx+wJ8Bfzm82ZTgTeSIKqWKaPE+BxPqt
	 k2tZeD7bO4iMqhNWQ0VJFaVdVQZk9IXc4nJykNk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgDSTps (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Apr 2020 15:45:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43538 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgDSTpr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Apr 2020 15:45:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id x26so3958764pgc.10;
        Sun, 19 Apr 2020 12:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LBqvAh1pYV5Fu2bzEcPAYJWpFa0bYvX8DrHKThwj4sE=;
        b=L7YGnf7XJr4I4x9i5OWrNeKaKaVwY38xtKh43Z3hKIipeKiqVXlm+bQZbjU0fBMRzy
         hQs4ucIU0rpYuWin6MxeAl8esKbZCfO7xtVSalmJwlbqiVhK6uK5/8w3BgV5Ob8ndmV9
         paiksCUM/RAXGw0Q0Dnp0+9gvzrIYbqB3XzFYZyKR5EZ6vCxKgyGUCBDQH1/T+72VOVp
         N3UPlEeJ1JIcyisbfVqnfEspAjN8QJiuyrdJbvIXgL9t4rBAlE51hdtg4wPtKZ+O56iJ
         nSQx9yBpYGNOriGVQe0hg9Sjj/WQ80OGFw4FoOHggTMIX2HlgXkFVW8i5W2gKJAeZQFs
         ANZw==
X-Gm-Message-State: AGi0PuYOUg8ZId54A0xrkj9Xg6XB3SQ9YOzS5Cv3wLdvNbXwIR+AWOgK
        sGn3LthxhqoJ8RapYIXNS2w=
X-Google-Smtp-Source: APiQypJR1GexWXMsOuzmodtJsMQOkpRREQvUx/laufKXdAZAUebNf6h/SmgSJQg0ohk2VxpwhRFMdg==
X-Received: by 2002:aa7:96cf:: with SMTP id h15mr9042692pfq.319.1587325546455;
        Sun, 19 Apr 2020 12:45:46 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 13sm10159972pfv.95.2020.04.19.12.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:45:43 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id F313A42079; Sun, 19 Apr 2020 19:45:38 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 07/10] blktrace: move debugfs file creation to its own function
Date:   Sun, 19 Apr 2020 19:45:26 +0000
Message-Id: <20200419194529.4872-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200419194529.4872-1-mcgrof@kernel.org>
References: <20200419194529.4872-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move creating the blktrace debugfs files into its own function.
We'll expand on this later.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/trace/blktrace.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 909db597b551..9cc0153849c3 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -548,6 +548,25 @@ static struct dentry *blk_trace_debugfs_dir(struct blk_user_trace_setup *buts,
 	return bt->dir;
 }
 
+static int blk_trace_create_debugfs_files(struct blk_user_trace_setup *buts,
+					  struct dentry *dir,
+					  struct blk_trace *bt)
+{
+	int ret = -EIO;
+
+	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
+					       &blk_dropped_fops);
+
+	bt->msg_file = debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
+
+	bt->rchan = relay_open("trace", dir, buts->buf_size,
+				buts->buf_nr, &blk_relay_callbacks, bt);
+	if (!bt->rchan)
+		return ret;
+
+	return 0;
+}
+
 /*
  * Setup everything required to start tracing
  */
@@ -597,15 +616,8 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	atomic_set(&bt->dropped, 0);
 	INIT_LIST_HEAD(&bt->running_list);
 
-	ret = -EIO;
-	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
-					       &blk_dropped_fops);
-
-	bt->msg_file = debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
-
-	bt->rchan = relay_open("trace", dir, buts->buf_size,
-				buts->buf_nr, &blk_relay_callbacks, bt);
-	if (!bt->rchan)
+	ret = blk_trace_create_debugfs_files(buts, dir, bt);
+	if (ret)
 		goto err;
 
 	bt->act_mask = buts->act_mask;
-- 
2.25.1

