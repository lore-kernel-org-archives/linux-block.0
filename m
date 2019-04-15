Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709D5C10F0E
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 05:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4028E2075B
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 05:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L6mTNGqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbfDOF5P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 01:57:15 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:49640 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfDOF5P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 01:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555307835; x=1586843835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rvwMfsgUiX0pwQOFDexTA/LWfaE/7S6aOz5IeajEt4w=;
  b=L6mTNGqbCnWlOogHLOYAHMLFXUEPA/ixiI7g8q3uhMItNXxDqJRKjBnK
   YLLMOFYIalfkwsUmGkhltJz8mS5ORF2YYbNKK2vog+grIdha9fRT+u6wM
   6R8ZcbR/eqCm/tyP6E2z3ys3XgxvmHGBEsUU6raPlrJ8tmdH/yC6GxZ2k
   u69QdWE4WHwAGyc9jbhz0qhA2VUI3nmUorltiSjWKvDQsNSXENYF6YTnt
   Vw8exQEc7XmthpRVCHfWokjoYxXXqBdHHa9NZ0L7OCVTMsXTf6dq9stEM
   cz12kz4z6uRZKVZERmBoAlII+fXkWGS2Mrfx9qGX1sjSzIbDNPvK6mQvJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,352,1549900800"; 
   d="scan'208";a="107192422"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2019 13:57:15 +0800
IronPort-SDR: yvERQJVOXdW2Y+TYui6UOlWNIgO0ZCLDCfE8JFL8CmdSYio3pTXFMYu7N0bcGlOJdoQa+FCjw4
 IVEC2pf3fHxtREvGiByhBJNMm+gmGUmcgTXtlD/e54iMQjycz2yznLUHRGZoKyiYuQUAi6Xu1+
 lY//Vl5PxRwzP8dJyJf2fjhryVTv/iXqN4FY+nexBQCq3chRAzTpy83RIoCjJ/uKCXhz6rYczK
 WJyoKz0qjp1j06VvhgR6TR3Hx5RYeHkq6cqWkMeLn4rSBO2QCnxCrXW5v1mmjg77RYpwALYONU
 LGq3x2bQXv6bl2vBIhJ+bTVs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 14 Apr 2019 22:34:02 -0700
IronPort-SDR: IhXF5+woc7bbxo9YrD1E44wYQ0rC1Tld83AOpAbSs68WDEfa3+VHMbUdWlH4mX6ngIxM0wfktQ
 ZpVxSWmQ2tGQ4RkqDZRcKse1J/DqRwSVzdB0+OfmdSxvWijq/g6bciM49PiaF1KQtZTSF0Oen2
 4NFX7BeHiEbxFs/tgW/DYL4yp5K+k40i07OhG3glv75vWQVcs9pWWT6lqjRqDIprvJiPBUx8xt
 2fMEm2EF4L9mnTIv4Pfc/fYz5Brld1Ge2nPrJ7Sj/+a6cmRWvAd381pDNq4eDARCF5g1IM5gAy
 vDI=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Apr 2019 22:57:15 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/2] block: adjust code for get_task_ioprio()
Date:   Sun, 14 Apr 2019 22:57:02 -0700
Message-Id: <20190415055703.5512-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190415055703.5512-1-chaitanya.kulkarni@wdc.com>
References: <20190415055703.5512-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a preparation patch which adjusts the code and exports
get_task_ioprio().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/ioprio.c         | 20 ++++++++++++++++----
 include/linux/ioprio.h |  2 ++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index f9821080c92c..9853e9077022 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -156,7 +156,7 @@ SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
 	return ret;
 }
 
-static int get_task_ioprio(struct task_struct *p)
+static int __get_task_ioprio(struct task_struct *p)
 {
 	int ret;
 
@@ -172,6 +172,18 @@ static int get_task_ioprio(struct task_struct *p)
 	return ret;
 }
 
+int get_task_ioprio(struct task_struct *p)
+{
+	int ret;
+
+	rcu_read_lock();
+	ret = __get_task_ioprio(p);
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(get_task_ioprio);
+
 int ioprio_best(unsigned short aprio, unsigned short bprio)
 {
 	if (!ioprio_valid(aprio))
@@ -199,7 +211,7 @@ SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
 			else
 				p = find_task_by_vpid(who);
 			if (p)
-				ret = get_task_ioprio(p);
+				ret = __get_task_ioprio(p);
 			break;
 		case IOPRIO_WHO_PGRP:
 			if (!who)
@@ -207,7 +219,7 @@ SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
 			else
 				pgrp = find_vpid(who);
 			do_each_pid_thread(pgrp, PIDTYPE_PGID, p) {
-				tmpio = get_task_ioprio(p);
+				tmpio = __get_task_ioprio(p);
 				if (tmpio < 0)
 					continue;
 				if (ret == -ESRCH)
@@ -230,7 +242,7 @@ SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
 				if (!uid_eq(task_uid(p), user->uid) ||
 				    !task_pid_vnr(p))
 					continue;
-				tmpio = get_task_ioprio(p);
+				tmpio = __get_task_ioprio(p);
 				if (tmpio < 0)
 					continue;
 				if (ret == -ESRCH)
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index e9bfe6972aed..1384446c614d 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -90,6 +90,8 @@ extern int ioprio_best(unsigned short aprio, unsigned short bprio);
 
 extern int set_task_ioprio(struct task_struct *task, int ioprio);
 
+extern int get_task_ioprio(struct task_struct *p);
+
 #ifdef CONFIG_BLOCK
 extern int ioprio_check_cap(int ioprio);
 #else
-- 
2.19.1

