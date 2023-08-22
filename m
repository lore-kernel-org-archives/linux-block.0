Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC48EE49A8
	for <linux-block@archiver.kernel.org>; Tue, 22 Aug 2023 09:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjHVJkc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Aug 2023 05:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjHVJkb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2023 05:40:31 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D177CD2
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2023 02:40:05 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a8586813cfso357215b6e.0
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2023 02:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692697204; x=1693302004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sr6MBkGwc3RIQcHR+4SRgKjOQiJDuxcox5KC3SInR9E=;
        b=cK5PAZq0s2x+sHUii11IsAKidedA6yK65dQTWCTQCycC68+HDSanecAKsnNBROPPMZ
         gDyrZwSlJcjtPtgebHx5AREw4Qbheh639asrVf0O4uJH1ojfn0LEplc907HFGcfQjTr9
         FgY/4w0sS4YB5ryqq4u6wNne9kwICNpfMVb0uOiE3lp5nwvVWvCTZF4FUti7sAqQMlIq
         JOqWLj1vYEbcl01JQf9DrFqA8UiGc19NzHNSKOKb0oGNcaLlPy4QK3xnlRQ67BdmjNXE
         FzBUYOcDoXCQqnPhutB7VCBork72a6FMW41XHWmvu+HcxDp3sl1kwyx8NsISb/nVMDPw
         1iWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692697204; x=1693302004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sr6MBkGwc3RIQcHR+4SRgKjOQiJDuxcox5KC3SInR9E=;
        b=auDZIw1zhV/fG+QVMtjU7Ow0HxWiIARnrODNF651ogmLqzaCgA5D8F3y7TxIQziTbm
         VS7Emqsm6CuW3Xtaqi6x0lk7sgJUy1BlzRUB3v5RapvYeHbld5q2PVmOFEv5NJSekOwW
         NCUKqGPYmZqwfcFdsdAj2LNNWeOqEvers7OBD0wl943jVPuiLq9fHGWqIjgwfYHhaZwz
         gXI7XfikNwAfmc8rF0P5bD7+iyU4k0b+lMRhWCJextaoQuSZFiFSdK6XXqcJSKlSU/CX
         qeXBpeyfgPH2ucz/HoAKUi4oNKaCr0VBjjdc6TIAbYg7PBvXNmp7vrmhX/8k7Mo1nn2U
         bcTA==
X-Gm-Message-State: AOJu0Yyr+PgKzJpsy3jHshk3LYx1j2u00Ql/egRIecNkGl39n+AraUi6
        dX7PeBMMVE0jQk9bLZybDVj+DN30OahvKDUQcYY=
X-Google-Smtp-Source: AGHT+IH8YPSI2kgbhEQ0ubM6vfWX0Of6Lw8gDBAoEhA4qPjI1v2a+PMnupR0f1pIaqiMrIlO9ehSNg==
X-Received: by 2002:a05:6830:6782:b0:6bd:990:1a2 with SMTP id cs2-20020a056830678200b006bd099001a2mr9866047otb.0.1692697204366;
        Tue, 22 Aug 2023 02:40:04 -0700 (PDT)
Received: from HTW5T2C6VL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id i8-20020a63a848000000b005634343cd9esm7666108pgp.44.2023.08.22.02.40.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Aug 2023 02:40:04 -0700 (PDT)
From:   Fengnan Chang <changfengnan@bytedance.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH] block: warn when write a bdev which already mounted
Date:   Tue, 22 Aug 2023 17:39:54 +0800
Message-Id: <20230822093954.6991-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

we may write a bdev which already mounted by
accidentally, and cause filesystem corrupt, add
a warn log to notice user.

Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 block/fops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index a286bf3325c5..5b679ad48df4 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -563,6 +563,11 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if ((iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT)) == IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
+	if (bdev->bd_super)
+		pr_warn_once("warn:try write bdev %s, which already mount with %s!!\n",
+				bdev->bd_disk->disk_name,
+				bdev->bd_super->s_type->name);
+
 	size -= iocb->ki_pos;
 	if (iov_iter_count(from) > size) {
 		shorted = iov_iter_count(from) - size;
-- 
2.20.1

