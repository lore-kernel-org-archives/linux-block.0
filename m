Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500C6C433E1
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 20:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D35121531
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 20:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592599697;
	bh=zqWGiZrPP2UkxxMFtdWDADZiBysETtZKvJ2GgHDTwPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bPIaYfZsXKKpWUQmQmz9x6sfrfUCUh8vfqqFeeXFxyMwQ9l7IiSl8cDicE0U5Tb7f
	 TIWLbVQMwcvUpGbM0ovzLr/j9fMNpU2syZ0nSQ21SwISyUALU2G2wSiUktn1wDbqeC
	 8azJsZIt4CD/NkC4KhsbOqcY/1jNb7PsfImPvD8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393442AbgFSUsM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:48:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32969 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391138AbgFSUro (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 16:47:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id 35so4395999ple.0;
        Fri, 19 Jun 2020 13:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WAnSKbcOgD9mh5TKczvQeK3USc0HG+X2VK1Fl/2VodI=;
        b=NJztYQ3dF5tG17nEQ57jCHuTNRW67BWYB2fB9cLpIJVsKIxctZYmjrJVU7IpumzS+c
         lkBju4CWzlimvSLy+t8jLS0dv4Ic3axv6zVf9l1BCliiF8FNZDdHd6+k99Bo3hgFESP7
         Cf6dZJG7E9JjoLCs5UIxME5HkEJe6auk8ayycofvtAoo7LVs/eTJvizqwiDSXQ9UbSQI
         sW29GHUd8zBdHJT6nQlB50S9BoGc/WHnmmhBBKJRHCzg5/7OzCubp7R0NcYbaHoRBspo
         ojlVOOSysR/rK9tf8DdtdgdlrBG2Ann/uFQX/zGaMabCjxIwOiR0FA0AY4PXugrAo08m
         H9AA==
X-Gm-Message-State: AOAM533IQcgHTw1RINrplwlTeEhOVmW8roir8FmczreOeFh4oqIzv3hC
        KZ/+/w5NHYbSOyoVuLc0tJM=
X-Google-Smtp-Source: ABdhPJyt+q2/jgY/ucUkJNHL+DMXosz4eR8RKCOdVty3Tudmz1nHdpy8UFn8y3lmFu7CwHtJNrHb/w==
X-Received: by 2002:a17:902:d889:: with SMTP id b9mr9091448plz.206.1592599663520;
        Fri, 19 Jun 2020 13:47:43 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d189sm6688611pfc.51.2020.06.19.13.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 13:47:39 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 99B6242340; Fri, 19 Jun 2020 20:47:32 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v7 7/8] blktrace: ensure our debugfs dir exists
Date:   Fri, 19 Jun 2020 20:47:29 +0000
Message-Id: <20200619204730.26124-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200619204730.26124-1-mcgrof@kernel.org>
References: <20200619204730.26124-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We make an assumption that a debugfs directory exists, but since
this can fail ensure it exists before allowing blktrace setup to
complete. Otherwise we end up stuffing blktrace files on the debugfs
root directory. In the worst case scenario this *in theory* can create
an eventual panic *iff* in the future a similarly named file is created
prior on the debugfs root directory. This theoretical crash can happen
due to a recursive removal followed by a specific dentry removal.

This doesn't fix any known crash, however I have seen the files
go into the main debugfs root directory in cases where the debugfs
directory was not created due to other internal bugs with blktrace
now fixed.

blktrace is also completely useless without this directory, so
this ensures to userspace we only setup blktrace if the kernel
can stuff files where they are supposed to go into.

debugfs directory creations typically aren't checked for, and we have
maintainers doing sweep removals of these checks, but since we need this
check to ensure proper userspace blktrace functionality we make sure
to annotate the justification for the check.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/trace/blktrace.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index e6e2d25fdbd6..098780ec018f 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -538,6 +538,18 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 #endif
 		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
 
+	/*
+	 * As blktrace relies on debugfs for its interface the debugfs directory
+	 * is required, contrary to the usual mantra of not checking for debugfs
+	 * files or directories.
+	 */
+	if (IS_ERR_OR_NULL(dir)) {
+		pr_warn("debugfs_dir not present for %s so skipping\n",
+			buts->name);
+		ret = -ENOENT;
+		goto err;
+	}
+
 	bt->dev = dev;
 	atomic_set(&bt->dropped, 0);
 	INIT_LIST_HEAD(&bt->running_list);
-- 
2.26.2

