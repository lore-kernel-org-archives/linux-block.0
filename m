Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC161C433EF
	for <linux-block@archiver.kernel.org>; Thu, 12 May 2022 23:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359485AbiELX37 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 May 2022 19:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359484AbiELX36 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 May 2022 19:29:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1396285AFD
        for <linux-block@vger.kernel.org>; Thu, 12 May 2022 16:29:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2fb7cb07885so57377477b3.23
        for <linux-block@vger.kernel.org>; Thu, 12 May 2022 16:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ll/7XSf/H3qu4hV/tAquY/NfSRFNg8NkKW4o64RepQ0=;
        b=Q++eRMtfjcI9Weo+kStkfr2hsfPcC9L4GFNLEm94yFV/g1ZBzPR6G83a/UtRlDixkw
         1Mot0a2ot9E4Ej2LdOq1Ytks78WCqTbHZx0yVJnvsos7xdhlaK+WsGzunh0TSnLeNOXK
         Rmhft858TNrWZxHb1vIXyDzJqV51Ui4zlKeutD2qw2Wh05j4bkzG3cBakYQkipB/1d+c
         2VLSAB4vN3c+D0lTWLcznHNfsa97Zo6a/KCZMcr6AA59RHowXzghwDrpb9IVJ4bWK5I5
         Ip/NJBKvapOsic3bceuoopIlLuIsz3ifSY+XZAaN8ZSrIkbXWxoNb6mVy2d0WqiuUZPN
         0pZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ll/7XSf/H3qu4hV/tAquY/NfSRFNg8NkKW4o64RepQ0=;
        b=5I3rX894XlVWyaQavoT5NvqUculbBfGABkCa04D5CXWkxbahKUu9ns7O238QZH8o/+
         5PkLUjuoaQt7KFkdasDjdHatPGkaxhGeeOKUz62SIwC8Oi+/x+4Cb7rLUgxz1z7ky4Sv
         79BjlrBqjLL/WdxinCrAd4XOdvkzA425DwwbdSmhoWfaFvBAELUhytI/dkpRqiIKNqrn
         HrxMZpH9B9FVJGlaq5ZK2uLi0Yjt+FsbRpgPRx+fxX6tYmglHBpn9a+wB8Q9iued2yOg
         y3+U3fIObYTo/d/blnx4tSGTw00e+K9xQMPHRKNxg9Dm3ce3WSXG1tWz+aNzLEhpdbx2
         aZBg==
X-Gm-Message-State: AOAM532dNfv83yby6ZKtD86y1wI2j3mOSLo/FNDi/edySOGp4Y5TsnV0
        JHUoc8tK2H+XPtenKzXMsSlf+0xJHhg=
X-Google-Smtp-Source: ABdhPJzwLo+8YO8Slpp9TJgLo1ENvJJUmE+JpdNMGnIkuOH30USGHB2TLD4cdG1YNKXX7zXUg53tmsP4rkQ=
X-Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2cd:202:a792:e3ab:48df:f42e])
 (user=khazhy job=sendgmr) by 2002:a81:a016:0:b0:2f7:cfa3:4dc3 with SMTP id
 x22-20020a81a016000000b002f7cfa34dc3mr2638289ywg.467.1652398194037; Thu, 12
 May 2022 16:29:54 -0700 (PDT)
Date:   Thu, 12 May 2022 16:29:07 -0700
In-Reply-To: <CACGdZYLMW2KHVebfyJZVn9G=15N+Jt4+8oF5gq3wdDTOcXbk9A@mail.gmail.com>
Message-Id: <20220512232907.312855-1-khazhy@google.com>
Mime-Version: 1.0
References: <CACGdZYLMW2KHVebfyJZVn9G=15N+Jt4+8oF5gq3wdDTOcXbk9A@mail.gmail.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH] blkcg: rewind seq_file if no stats
From:   Khazhismel Kumykov <khazhy@google.com>
To:     tj@kernel.org, axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In lieu of get_seq_buf + seq_commit, provide a way to "undo" writes if
we use seq_printf

Fixes: 252c651a4c85 ("blk-cgroup: stop using seq_get_buf")

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/blk-cgroup.c       |  5 +++++
 fs/seq_file.c            | 14 ++++++++++++++
 include/linux/seq_file.h |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8dfe62786cd5..50043a742c48 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -909,6 +909,7 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 	const char *dname;
 	unsigned seq;
 	int i;
+	int scookie;
 
 	if (!blkg->online)
 		return;
@@ -917,6 +918,8 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 	if (!dname)
 		return;
 
+	scookie = seq_checkpoint(s);
+
 	seq_printf(s, "%s ", dname);
 
 	do {
@@ -956,6 +959,8 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 
 	if (has_stats)
 		seq_printf(s, "\n");
+	else
+		seq_restore(s, scookie);
 }
 
 static int blkcg_print_stat(struct seq_file *sf, void *v)
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 7ab8a58c29b6..c3ec6b57334e 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -408,6 +408,20 @@ void seq_printf(struct seq_file *m, const char *f, ...)
 }
 EXPORT_SYMBOL(seq_printf);
 
+int seq_checkpoint(struct seq_file *m)
+{
+	return m->count;
+}
+EXPORT_SYMBOL(seq_checkpoint);
+
+void seq_restore(struct seq_file *m, int count)
+{
+	if (WARN_ON_ONCE(count > m->count || count > m->size))
+		return;
+	m->count = count;
+}
+EXPORT_SYMBOL(seq_restore);
+
 #ifdef CONFIG_BINARY_PRINTF
 void seq_bprintf(struct seq_file *m, const char *f, const u32 *binary)
 {
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 60820ab511d2..d3a05f7c2750 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -117,6 +117,8 @@ __printf(2, 0)
 void seq_vprintf(struct seq_file *m, const char *fmt, va_list args);
 __printf(2, 3)
 void seq_printf(struct seq_file *m, const char *fmt, ...);
+int seq_checkpoint(struct seq_file *m);
+void seq_restore(struct seq_file *m, int count);
 void seq_putc(struct seq_file *m, char c);
 void seq_puts(struct seq_file *m, const char *s);
 void seq_put_decimal_ull_width(struct seq_file *m, const char *delimiter,
-- 
2.36.0.550.gb090851708-goog

