Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17742C76188
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 12:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D409A2173B
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 12:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSTX/MOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfGPM7v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 08:59:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34256 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGPM7v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 08:59:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so9093169pfo.1
        for <linux-block@vger.kernel.org>; Tue, 16 Jul 2019 05:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HKBne90hDm9vNrkTEEdEpDrjib0o59wHPm5tU1kvnX4=;
        b=ZSTX/MOlkHU/Im361h0M+y3VurKvcwVVEXQbBgtefBCraTf9JqeLqwwGmj2LNLg5+C
         ESGSwrT3dK9Y0OvGbBaRlaiE0YO78eTN16IaVSIHnCfgdY6kXJxj/On7sV1C895OtV0y
         qUIYJBlKphtv1nlng7xfHfRG/9Y5kgwBby8tNjqX6hO5U0YmXv6YD6ytboLf2sEZoWZ/
         CKs+S1m9F+2Si87C6hA9OmZtEv+P3qtily+Q4JAgU3dthHp9DG0buOsrU3MjR6l/ClvX
         3PAtbRMzRDLDtQkHJk+6L8vfL0Ztnko7MLqcWxivWUPQZn5H6LJX7IqWvnlTuLxj34TT
         CKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HKBne90hDm9vNrkTEEdEpDrjib0o59wHPm5tU1kvnX4=;
        b=VZcfS+y0PIXieKhIVWYGYz0dlzaPIEwZ6f4f5pohx6ZGWs/lWHw6aKOgfSxW8FqPy9
         5/dOIufAqmsoCSHJ4KSo2ehDEjakOsHIlbwHQD3uwhBa8jkJp2Hzn0lPzGzfbJvMq7BM
         lncDRsZdrhoZL5d5+SG4lQTkiDshMHE/RWxsV1RSZ3s4fFsqhtgLoMhJHP8TSlhZ8b/p
         GBLt9g5CpRLi0obMl24pWL/rp/ZmENbYPdRtCOaRCkl4vzKuvBX9ewuFLMpaARuWuEOp
         1TZslqz7S/b5JffUhlSZCCdIHt6B/1IuT2p4T8xeDU/PZYcApCHhQbpScBnTB7MNcARr
         TrMQ==
X-Gm-Message-State: APjAAAXvpIvOIBWoaPHF+UxGzv5F2g70an9Mc5LIwBUBMjCvXNE4HOYN
        f8hf+DckERbRVsqNoKzaG9enyuqL
X-Google-Smtp-Source: APXvYqzbvOqe6vipw5sDDC0eENT3xybM7hUV7qg48ffSmSB+aKlh5nfeFykON2wfxR4W4xlk4awwqg==
X-Received: by 2002:a17:90a:338b:: with SMTP id n11mr35691625pjb.21.1563281990393;
        Tue, 16 Jul 2019 05:59:50 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id m16sm21513841pfd.127.2019.07.16.05.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jul 2019 05:59:49 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: fix sysfs module parameters directory path in comment
Date:   Tue, 16 Jul 2019 21:59:35 +0900
Message-Id: <1563281975-6353-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The runtime configurable module parameter files are located under
/sys/module/MODULENAME/parameters, not /sys/module/MODULENAME.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index d8c71a4..73a4999 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1971,7 +1971,7 @@ static const struct attribute *disk_events_attrs[] = {
  * The default polling interval can be specified by the kernel
  * parameter block.events_dfl_poll_msecs which defaults to 0
  * (disable).  This can also be modified runtime by writing to
- * /sys/module/block/events_dfl_poll_msecs.
+ * /sys/module/block/parameters/events_dfl_poll_msecs.
  */
 static int disk_events_set_dfl_poll_msecs(const char *val,
 					  const struct kernel_param *kp)
-- 
2.7.4

