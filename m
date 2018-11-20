Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B10C46462
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFBB206BB
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Pzl3bG8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFBB206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbeKUDuN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:50:13 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42993 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730339AbeKUDuM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 22:50:12 -0500
Received: by mail-io1-f68.google.com with SMTP id x6so1939602ioa.9
        for <linux-block@vger.kernel.org>; Tue, 20 Nov 2018 09:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vjQmCjtMfgeSTXM33EwWkwcAAZSfGgg/BnpXf4PVsww=;
        b=Pzl3bG8djEWQw6DmvK7B/f3Ij5P1N52alFFM4EnVN+XXt4KmNE2OZb1/mT4f+xOw9y
         VwRz5UpzCBH7RwdyToYNE5P7uMI/WwukvkISxjfZdgAYYPYuHaPUmNsm3c0d9UcLg82C
         zy1gEfZPWBoPXz5VhFhnugQkalUlGO07AwPeUk/EdR7LtE9LVyN+HJPkHM1cCAVfKVZL
         3P14LVfpmOS0vnd2NCOKszW+HjrmN6UZjTPi7ITsDErufkHeOfAsO4CqEn6+EjMgzhjI
         TmXkpYYO2yyi4/NEk6ockHKFh5Yj7AQgQOsKdajOd/lwdLfgGR08+TB6B85/ZS5TSldo
         Rprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vjQmCjtMfgeSTXM33EwWkwcAAZSfGgg/BnpXf4PVsww=;
        b=mh0e79aLwqPvf6tHF4pItDHMZBLD0fNQRQP2x+i5NjDKaEg0l4ozvHBL5ybmnTeWPq
         Owapxv3YXEb3jlju6tnUT0rY0rtXitGnfNR+KWReUvpZeIdzSJZveSdsoKNOGmlZlYa/
         nCaT0DzeGwO8yD5HP+A+Nh0oW1wro56v2W+oZ22Vmg5NJI7VUFOk/tFHXNHEFhGEqRCJ
         Spa5ONj54oKsjZlbp9z0AgSf2c1V7hSUHUruRV0hO6EGnw4T7DzvfKAx4oHaBoMu8D8E
         kKkeoxtHezjoah+eOM6K6PTMaWkOjNuk1jdKnzWSnkK/EmjSB5jJmc4BAmv4QDZuBrKV
         wy0Q==
X-Gm-Message-State: AA+aEWZQ+hyKu9DUuAnTVpRRPQAk03RQNfusmOfd9j4L7A4CZDulRn9L
        KvcFvUFUuEE3w0Qp0/YnA8eb+EJdSCA=
X-Google-Smtp-Source: AFSGD/UonK3hot73Mg4ZvjLkxxys/F+e0OUUYxFRFWb1owjmJv61iFUiM/4Kh+54npdkww3thoyVHw==
X-Received: by 2002:a6b:ed04:: with SMTP id n4-v6mr2248372iog.106.1542734398384;
        Tue, 20 Nov 2018 09:19:58 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 186-v6sm15751530itf.11.2018.11.20.09.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:19:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/8] fs: add file_operations ->iopoll() handler
Date:   Tue, 20 Nov 2018 10:19:46 -0700
Message-Id: <20181120171953.1258-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120171953.1258-1-axboe@kernel.dk>
References: <20181120171953.1258-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for adding async aio iopolling.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index a1ab233e6469..9109c287437a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1781,6 +1781,7 @@ struct file_operations {
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
+	int (*iopoll)(struct kiocb *kiocb, bool spin);
 	int (*iterate) (struct file *, struct dir_context *);
 	int (*iterate_shared) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
-- 
2.17.1

