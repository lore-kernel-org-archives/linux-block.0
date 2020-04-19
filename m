Return-Path: <SRS0=58UM=6D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74900C54FCB
	for <linux-block@archiver.kernel.org>; Sun, 19 Apr 2020 19:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5355421973
	for <linux-block@archiver.kernel.org>; Sun, 19 Apr 2020 19:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587325572;
	bh=4OhlOdyFnJ2tiRBSqEwNm/uy5s4uSzRF5PzKx9/Np+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rpQsPRCEoG7hEcpio20FjTA5lpvKc4JILoadNrCATCXnF5cpz30SxEusX9+N9DIHJ
	 uZpJg/MMQwW3ThO99LpKc9JPLUg0dj9Q9Sc35ii/65/JXdf12J8KHd3E0tp4xXMynk
	 mbNmQ6pjAiG7kXiBAev2t5mwZQmOM2IuhyWEMzYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgDSTqH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Apr 2020 15:46:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39336 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgDSTpt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Apr 2020 15:45:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id k18so3128489pll.6;
        Sun, 19 Apr 2020 12:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ocPGiMVOY8YbX62vNwIAKusoCpTyvn+IDMEr8V2SPWM=;
        b=TZUwPDrv4qc/Gi+28U/DbZt6Xq/21p9IQxW8UZRcvMH0ePAhpn/BI7PMGA0jJ5eYt5
         LdnHDq+GbuhDSdFCqAZ30501Qjxxwf9aZlsoU+4HX6aqzioC73s/8gU2JKH2rTzr06iM
         sNFhGRjVa/K/owaUqxogmu2FsTkeSH+4ZHeAQtMKKQBv3mkkRfckMLAHoOcymH207tiW
         yVAQ1v7GSNnmKcFUKGbUUiD6wwDbsuYXW6yYX51w/RLI3Hywivdo2JP7n9XO1Mu9IoRt
         JIr1lsZK/GgEAY7xBapx+9TXP5HBCRfX48zc4iwSk2LnUm98acgTqXzV0zUpfwn8Qcf0
         RNBg==
X-Gm-Message-State: AGi0PuYomujpgMnSwfVstXuBfYVSsIzidsfktMEEjW/smTIYxLxp7ueg
        M/pThJVKTacQp6dZNq3pTJ4=
X-Google-Smtp-Source: APiQypKviuIIU6uo7RWeYDR6Y1M/9tlUiCmGKN/t71TBIfd8bt+jjyzreCRxLywsikXiZrAm1y65nA==
X-Received: by 2002:a17:90a:f98b:: with SMTP id cq11mr757945pjb.193.1587325548759;
        Sun, 19 Apr 2020 12:45:48 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u8sm11614115pjy.16.2020.04.19.12.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:45:43 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 082A04223D; Sun, 19 Apr 2020 19:45:39 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 08/10] blktrace: add checks for created debugfs files on setup
Date:   Sun, 19 Apr 2020 19:45:27 +0000
Message-Id: <20200419194529.4872-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200419194529.4872-1-mcgrof@kernel.org>
References: <20200419194529.4872-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Even though debugfs can be disabled, enabling BLK_DEV_IO_TRACE will
select DEBUG_FS, and blktrace exposes an API which userspace uses
relying on certain files created in debugfs. If files are not created
blktrace will not work correctly, so we do want to ensure that a
blktrace setup creates these files properly, and otherwise inform
userspace.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/trace/blktrace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 9cc0153849c3..fc32a8665ce8 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -552,17 +552,19 @@ static int blk_trace_create_debugfs_files(struct blk_user_trace_setup *buts,
 					  struct dentry *dir,
 					  struct blk_trace *bt)
 {
-	int ret = -EIO;
-
 	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
 					       &blk_dropped_fops);
+	if (!bt->dropped_file)
+		return -ENOMEM;
 
 	bt->msg_file = debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
+	if (!bt->msg_file)
+		return -ENOMEM;
 
 	bt->rchan = relay_open("trace", dir, buts->buf_size,
 				buts->buf_nr, &blk_relay_callbacks, bt);
 	if (!bt->rchan)
-		return ret;
+		return -EIO;
 
 	return 0;
 }
-- 
2.25.1

