Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0ACC48BE5
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 774DF600EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFVXWi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 19:22:38 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5566 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhFVXWh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 19:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624404020; x=1655940020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bivCQGXwuOn77OzvqHMukBeOj693hXYMPyQOqoyfTxU=;
  b=NUUgpxQcw0vdTpk8CXa1VgUZ4TL69DbGkrXPxpewlHcjB1RyOHBulGET
   FS/0TiZQMVQzSzEqZql9b3IsRjxGacw9b1mwd75vsoEXeKP0iSlfec46Y
   dzPzPK84HcCkBTfm4ukqQuA1KySfQQ+wb6EDGhlWBcB+pSWnTUT8+xqMY
   xCo5xw4Ac6EPqdmKc/HQkA/lYkpLQBA5RbaoQswuUFYAji2+A/TKnqlq1
   al920mBEzPvN7XbKO7IDP30Qq5W14R67osFR7yBHy6R4xj5PbJoTk7U9+
   zN8Y69a3sHo53DINC0hHR/OCWiSTEap0ACQBbnR6fThluIqjzpEnT6Ags
   g==;
IronPort-SDR: b8gQVEH3xn5w6d1PzfjLbLMiFcqJC4vWEk32dLt1j+cl5shboXGki/HN9smjEgza7Z1xIjPNob
 G1qQp2IvfocdTg+vFlOeHWujsogR/4UlH9m+XitdZI//kLMBGeCM7hgFZCkF+akSP/6FJYvNi/
 Jkgf0a89DC6ZG6EtpEgOHn7VqbnE4VlluB2FNKUBS2NmtXK3jitjf1eOib+AzNrDAuWDi4XkAV
 SJT4XU6KjORGXWokhYiFqYowVLudYNbQkHcxKpEJ/tbhFWfSUyUfXZSCMxVcclzPApg1jtGW8d
 ipE=
X-IronPort-AV: E=Sophos;i="5.83,292,1616428800"; 
   d="scan'208";a="177421333"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2021 07:20:19 +0800
IronPort-SDR: pUIlU+r2B2tCfA4oDszfIfgOBEk0112T2R/U5ULMPLSfRzW3CqPRMx7FCf4YJoz6ue6d7JN2vl
 UNt/ihU3gqdUbtPMIgpz4iWgNILicP/Mzs72vZvsLxyqFasw18Ll89+PeTGgGjTXx/yFNuEUvZ
 93yiEHIhkQnuWbp0WwoPBdLV9qrKGaSisdNYGLjrXyu7rPUrjO3OSYuMx/iDz66AEDU3TQUYem
 uzHmj7tfD0F5kquMl9POGg/82QiENki+vwRwbu6bU8h1PB8W4V+JpxvlC8W9dgNpfo5FGV/mQU
 04EULdlvXC+C/Z8HaNLoyMrc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:57:36 -0700
IronPort-SDR: cvCtA8lrXJ8VKgYbW71j1EboSPRupSu6QJDcfdnvO0C5l0bjf3ThC7EWDYekzN7CxsDzUuYrOa
 /dY1tmoGqJyxfOqfWrePSnxvtvcEMsZlDteCHU75Y3vw146K8TRCX8T3eC99GjPVpoDQaNEzen
 B0k4Q4tLto0BnlasUMyatQJu7wWXFSLlYbQIsEb5VotD49yuEu4NKFP0EC2etryJWpYfNfYmgd
 ndWUIjC65mStuGFG4EhUIFghFKgjvMlKChVBkTNU2CbHs1xStNdU92hXbKoAZpT+GggEBSKdQt
 DjU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Jun 2021 16:20:20 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/9] loop: use sysfs_emit() in the sysfs sizelimit show
Date:   Tue, 22 Jun 2021 16:19:44 -0700
Message-Id: <20210622231952.5625-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
References: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Output defects can exist in sysfs content using sprintf and snprintf.

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Use a generic sysfs_emit function that knows that the size of the
temporary buffer and ensures that no overrun is done for sizelimit
attribute.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 847faa6c48fc..084fa914a399 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -812,7 +812,7 @@ static ssize_t loop_attr_offset_show(struct loop_device *lo, char *buf)
 
 static ssize_t loop_attr_sizelimit_show(struct loop_device *lo, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)lo->lo_sizelimit);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)lo->lo_sizelimit);
 }
 
 static ssize_t loop_attr_autoclear_show(struct loop_device *lo, char *buf)
-- 
2.22.1

