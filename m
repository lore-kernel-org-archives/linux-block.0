Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2372C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9897120867
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SpjWkyYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9897120867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeLAEH2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:07:28 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43654 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbeLAEH1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:07:27 -0500
Received: by mail-io1-f66.google.com with SMTP id g8so5053605iop.10
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t5Ipy9cJT+UymoTkcHrGWgGflPH0UWisZzkkCO9C0qI=;
        b=SpjWkyYZItYDW+aLLrAYQSIkYTHzXKUa07G+A7smAY9qZ9aOqX7lnGMpjXxMIDPBEC
         15XbsteKPaOdvTjSIye1ZmaN8/neTzAGWPGfXaRB8GT56nJlxI9OteOD6VRQBAGqPdQ8
         b3x7qaNblQo1RGJ+WIvs27W3d7TJ/VgelhJYlxXqFm3tfIaOf0Bs7CObWMC7jGvlbcHa
         2IKOgg80aX6SArLrN6G+EwDigtnNzWdM2iRLv3xjDV0PGzb+O6ScXvam0MZLwzaaPJyQ
         bC3+rBHHwnIMohGq3BFHifk/TpXv1In7ckR8oqgUwbPvG/BKhij14/fw+KxtpOLtjISj
         AKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t5Ipy9cJT+UymoTkcHrGWgGflPH0UWisZzkkCO9C0qI=;
        b=UUdSxiJUFTvZANS5zTeeQ/toRyITNvitrL40lWGSKlC9X70usNK/QW1+4tvqq0LDQr
         11Eu2iV8FeDYkAp5hHAwNbPxyr7XMR2bJAFtLKBev6sHFWuMoqJNTP0X68JIZ7Pm+AoD
         /WRk0mOFCI2GdWf5u07/nSwpauH2zY55h95aHnxp3hMoomJ81b0RTrGG4IvUfR7zAINY
         fw6brNWG7I3nO7qKLMVDLUx2OmSP4dodWX41SOicP5pmGt5E5yXDxjJGZ0soONg3Zclb
         LfMtxyfMDC0aDPCDJiQapzyLEk0rACwB/8G07roYbohYmaVjr2dbzTOVbTX2N7BBmzxS
         cSOA==
X-Gm-Message-State: AA+aEWbRzPiq4dFQf0i3EWKOVz+N7ieSR48AHLiv/9m8M795bC8WgRjO
        C7oPVOwE6W8+BmxBvr0TzfYUf5q22+g=
X-Google-Smtp-Source: AFSGD/XWHdoKjMOdVnyilerhhmLIemiGEc8b5V5SqbnHw2OlGhkbNKO664axLyd6pyc32pWmUPBFYw==
X-Received: by 2002:a6b:7946:: with SMTP id j6mr5106927iop.29.1543597051153;
        Fri, 30 Nov 2018 08:57:31 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:30 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 26/27] iov_iter: add import_kvec()
Date:   Fri, 30 Nov 2018 09:56:45 -0700
Message-Id: <20181130165646.27341-27-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This explicitly sets up an ITER_KVEC from an iovec with kernel ranges
mapped.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/uio.h |  3 +++
 lib/iov_iter.c      | 35 ++++++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 55ce99ddb912..bbefdb421f6d 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -284,6 +284,9 @@ int compat_import_iovec(int type, const struct compat_iovec __user * uvector,
 int import_single_range(int type, void __user *buf, size_t len,
 		 struct iovec *iov, struct iov_iter *i);
 
+int import_kvec(int type, const struct kvec *kvecs, unsigned nr_segs,
+		size_t bytes, struct iov_iter *iter);
+
 int iov_iter_for_each_range(struct iov_iter *i, size_t bytes,
 			    int (*f)(struct kvec *vec, void *context),
 			    void *context);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 7ebccb5c1637..a5b6dd691f37 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -431,25 +431,33 @@ int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes)
 }
 EXPORT_SYMBOL(iov_iter_fault_in_readable);
 
-void iov_iter_init(struct iov_iter *i, unsigned int direction,
-			const struct iovec *iov, unsigned long nr_segs,
-			size_t count)
+static void iov_iter_init_type(struct iov_iter *i, int type,
+			unsigned int direction, const struct iovec *iov,
+			unsigned long nr_segs, size_t count)
 {
 	WARN_ON(direction & ~(READ | WRITE));
 	direction &= READ | WRITE;
 
-	/* It will get better.  Eventually... */
-	if (uaccess_kernel()) {
-		i->type = ITER_KVEC | direction;
+	i->type = type | direction;
+	if (i->type == ITER_KVEC)
 		i->kvec = (struct kvec *)iov;
-	} else {
-		i->type = ITER_IOVEC | direction;
+	else
 		i->iov = iov;
-	}
+
 	i->nr_segs = nr_segs;
 	i->iov_offset = 0;
 	i->count = count;
 }
+
+void iov_iter_init(struct iov_iter *i, unsigned int direction,
+			const struct iovec *iov, unsigned long nr_segs,
+			size_t count)
+{
+	/* It will get better.  Eventually... */
+	int type = uaccess_kernel() ? ITER_KVEC : ITER_IOVEC;
+
+	iov_iter_init_type(i, type, direction, iov, nr_segs, count);
+}
 EXPORT_SYMBOL(iov_iter_init);
 
 static void memcpy_from_page(char *to, struct page *page, size_t offset, size_t len)
@@ -1582,6 +1590,15 @@ int import_iovec(int type, const struct iovec __user * uvector,
 }
 EXPORT_SYMBOL(import_iovec);
 
+int import_kvec(int type, const struct kvec *kvecs, unsigned nr_segs,
+		size_t bytes, struct iov_iter *iter)
+{
+	const struct iovec *p = (const struct iovec *) kvecs;
+
+	iov_iter_init_type(iter, ITER_KVEC, type, p, nr_segs, bytes);
+	return 0;
+}
+
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
 
-- 
2.17.1

