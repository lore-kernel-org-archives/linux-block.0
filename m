Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D580FC004C9
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A278121783
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ChNM/qyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfEAE3C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:29:02 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:63878 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfEAE3B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685008; x=1588221008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZexC5LrS/sHvEisanY9rw27K81jpxhafKMvfYnkeiEk=;
  b=ChNM/qyl2eNM9vGK1kNwhOs+atR15mXvUWbs6xpeuYzlKb2SWVPf5+wd
   ptdut+bV/9aij+Vwui//xPwPq4Jo7dvS56VwftngKx3br/7qcRQLjyL+m
   uqovkrfqa4528O8y/icGgZQ2vgvy8U4DAYlZX+e5BZHS7HrWrTYHs8rca
   CdIj6OSK7oBSK3txazWN/SSfTKDjINiZYuxwY+lz+Q/XdCBiaDAzXLccI
   +a9W4Wg9cQ9F0tku0+uVrkmRTcl439NcIn/CuZcHwYM6zJp2O/je7rm3/
   tz+JYeHMPPLtq7F/tMvylPnDQMlUZG+z7jwnmbcdc4D6v4f7cp62jhmkB
   A==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="206432278"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:30:08 +0800
IronPort-SDR: ouQ98F5AZlsgCZYofNakWovgFgJn8vPxReDt9IW2seEp47Qob/m4s+x322mwu3BLLqVpypGazk
 ukD7TdkcJ4luepRlsaXRnltwbJxu55ZRQSrcJmi9tjFgqgoRn90Uo0kU1ZZCaKdmVjNqhuE+iJ
 8oNzvX8+rsuaK5AQ7xCfl5ml04OExsATqnKANPC4NL4XViykWxt5OyTJ4+6q0HJYYs8SNRVoWE
 W3dIdk8zHG9XIq2LzIxAWBT2lCPBE5CDTeW7buDmfsWb42e4FvxpNVQQv5Ubu2xBJ4JE4crd+o
 wpA7luQgY4j1xDyyYf2J+rzb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:07:30 -0700
IronPort-SDR: vFxXkdmGe6BEA90T4j/0RZZmtKWVnspwE/I9zI+jcZAmTHsBzd84gQtMHxE15Eh6uZy3Blks5h
 MedxxCeceXYgUhX1Gh9BIHKJRd4cV2J92q5cGkwRWqLe7lQpkeRE1CdRvOk5fJwuaRWOOsk64X
 P+FUx7bPuyqFYFjyZMLha9YM51IUrS3+fHVIhQym4RpKwkniF03/csUsnx0z+qdnmx0hx2Bi20
 fKYLjNIaky5kU5NUkfBwwOGaeCJgOp9KsYVqFHqQHg76qsDVMGj2iNkKCMl9vDubMirdEqSarg
 +Ok=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:29:02 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 06/18] blktrace: add iopriority mask
Date:   Tue, 30 Apr 2019 21:28:19 -0700
Message-Id: <20190501042831.5313-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Update the actual trace structure to actually store the priority and
IOCTL structure to hold the priority mask just like the action mask
from the userspace.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/uapi/linux/blktrace_api.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index c34cf752a9a1..143bf81c088d 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -123,6 +123,7 @@ struct blk_io_trace {
 
 #ifdef CONFIG_BLKTRACE_EXT
 	__u64 action;		/* what happened */
+	__u32 ioprio;		/* ioprio */
 #else
 	__u32 action;		/* what happened */
 #endif /* CONFIG_BLKTRACE_EXT */
@@ -158,6 +159,7 @@ struct blk_user_trace_setup {
 	char name[BLKTRACE_BDEV_SIZE];	/* output */
 #ifdef CONFIG_BLKTRACE_EXT
 	__u64 act_mask;			/* input */
+	__u32 prio_mask;		/* input */
 #else
 	__u16 act_mask;			/* input */
 #endif /* CONFIG_BLKTRACE_EXT */
-- 
2.19.1

