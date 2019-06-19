Return-Path: <SRS0=VMX8=US=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A4AC4646B
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 22:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDB72085A
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 22:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cErvzcsO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfFSWB6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jun 2019 18:01:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3312 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfFSWB5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jun 2019 18:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560981717; x=1592517717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D9U2HPu6ZOTNILV65ybHX1iqiYPNs4JUq1wtjqsbBCM=;
  b=cErvzcsOZFhiIkH7HyVZBqvz63bLfyjDeN6rlw6ivp4M0xfsE5dlqLHl
   mw1AzIQ9/WESbb/lt2ytwyCQPDtat2NV+cWhpAA50XvnpSMgCiX2WZP2F
   V1eWtFrfNxkG4cDljCLMhE+o35pvto9vJmFsLDCjodk3YvgikoJWYNdDY
   DvOWjFxPCkRtiETm8N2RUPov5jidnQO1yohCxQ8awJt+JherHVWYT7bEj
   Dxx4ZAidgZXclFot2vQen5sXfbuJix1QMXZLo4VUenNpLds84Zjj0ft19
   lHY5IBAuEohMj9mSXQn5rAYIcudWB9VaJDvwAWK3+FXxpiZZJk3vDgGYe
   g==;
X-IronPort-AV: E=Sophos;i="5.63,394,1557158400"; 
   d="scan'208";a="112236312"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2019 06:01:57 +0800
IronPort-SDR: XdUTPXU7q0kB08y9B4fh14WyOQOMhl1IEmHdnm+DNC61z7CWBY6udtKNtB89ljupVdhaKXfjOu
 AeApBHQvQDmNXb3AvSZDpBNEaMH3ok55Goce4URErMsR2pRumYeTfkCvsm5lV8cgzKUeN3V7qj
 IfUEqBilmzyYZfCsew1hNiuSYQpqn5U+b+7gF1u+YTjqMLuI0ZDhCdkiCV4cFUbeVCYZvmDBlQ
 5jzvAlnWpRvBsC1mgDJphAglZeXLVpAE6LL0H7laW8+98jrQzr81UzNOtLlZsie5GpGW4sMtVM
 KSJ0OxTPLRC5ZCS3cy8n1D61
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Jun 2019 15:01:24 -0700
IronPort-SDR: dg/SAC+dFuS87lYfjxH5qi+mXUBJ08wfWJAM/AMMHgIZQF+2iiu4q2QYpUGgCn8geILGAhw62x
 IfKMSOcGz8dWYam0lIAzmlIaOXyc/7AxWkiiOScWL+lzDQoCYeFmtAz4NVCm79T2OsctqWF8KW
 3hYS7VFZvVEfTqYM5RyMeztqZsJPlSFNyLZ4HLj16KMPzLMkMq6iXMuOKKx/Y7XvjD86LcnmoU
 WZX0KDMZFAzyyW+7Gj1QuE+kksF6umNFLCDZsb24vKwICtkbc2KpGED5C730gQj3hEczPthS/d
 z48=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jun 2019 15:01:57 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/3] block: get rid of redundant else
Date:   Wed, 19 Jun 2019 15:01:48 -0700
Message-Id: <20190619220150.6271-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190619220150.6271-1-chaitanya.kulkarni@wdc.com>
References: <20190619220150.6271-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a pure code cleanup patch and doesn't change any functionality.
This removes the redundant else in the code which is not needed since
we are returning from function anyway.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-mq-debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 5d940ff124a5..84394835e2b0 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -779,8 +779,8 @@ static int blk_mq_debugfs_release(struct inode *inode, struct file *file)
 
 	if (attr->show)
 		return single_release(inode, file);
-	else
-		return seq_release(inode, file);
+
+	return seq_release(inode, file);
 }
 
 static const struct file_operations blk_mq_debugfs_fops = {
-- 
2.19.1

