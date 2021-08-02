Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C866C4320A
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 09:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A7FF61050
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 09:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhHBJWM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 05:22:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7966 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbhHBJWL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 05:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1627896122; x=1659432122;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+Bv5i6pnPJv25BpMkzWfJ12S73tfSuHprq5TDSMC/cY=;
  b=kKQiJATB3pr/gEcYoyCpVX+1Xfh/X4CUlG84GBkBcaRMHt5G6cx5KjCJ
   y1+ODacD8uvvad6pMQGyOkBGba8hn5JV0frPrDobuSzeqLuj3Juex8pXU
   o/XlfVwhZoOd6HhMlGubGeNP8u5KOvNzUgO8PNltFKsEaV5yqCUSFv82U
   EFvq6lmkdKDlkmMKbOKq7KD/CxuP29HgpUvMieEpBCAWkwDYwuFuigV4a
   jD8gXxtjCYSLQRZhzNtQvjvhH126yQYRLDkqcWQd5jftBST/eRONAKNhv
   carDlxcoF3f3785WuvpiArvG5Yrpki9SRjjywdGjN06j+nH/Bb87/ICl0
   g==;
X-IronPort-AV: E=Sophos;i="5.84,288,1620662400"; 
   d="scan'208";a="180888881"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2021 17:22:01 +0800
IronPort-SDR: A4mlE7mbGg6qTzPwv7da4TDHxYtolZWBlVGG9n6oXus+wPOguHkIUqwrWFYRnRbcp+o6gNXUeR
 EPIJ3OI0xUCyGP1CnBj1yrZfu8CQz+q506b/20DKKJil0gTnusgQzDZK3V56MCM5z78uqr9mhd
 VdeAkew3GxjP1KK+1fZgLl5OtgvGRRyN2rvcKc8Ype/F376stMv4mUPGevU4KvYk8bvhTmp/EI
 2/GjbLxNgCTjGr8TcGHWOYgIcK+/pscmLPD+gVbrSjg/PsTEa4ZCrBhYuxP37Jtkx15IuVbUWj
 E4IvOq/Y6YoKqohpskfzCkH4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 01:57:41 -0700
IronPort-SDR: LvbojvhY1YLYsAAJDZVdRjLWO8QaprUzs3CPDIzSOv7WxV4qS5a/7Uyy+aNdLcQ3q/Rw91GI3B
 8kMqfMY9fWL5mp6VIIQgb1jM+6Y3IBpGrWeUbzYuZqiXhErepJ365TuuQI1OYnb40Hk9ufhAJu
 duyQbQpmMRtlyD1V5gLNB/xk9bDADHZZlTF6/LRgiauz4783Ho7VuhD84wjzEJ0dBZG84Gubun
 FLZfr2QdZDVyMgOVOiARUl6IeY1CtzxUTuzlcNHZVoXri3XYdtMf2sxp8y1ylWsvkNRy21Toa2
 JXA=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Aug 2021 02:21:59 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 2/3] block: fix ioprio interface
Date:   Mon,  2 Aug 2021 18:21:56 +0900
Message-Id: <20210802092157.1260445-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210802092157.1260445-1-damien.lemoal@wdc.com>
References: <20210802092157.1260445-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

An iocb aio_reqprio field is 16 bits only, but often handled as an int
in the block layer. E.g. ioprio_check_cap() takes an int as argument.
However, with such int casting function calls, the upper 16 bits of the
argument may be left uninitialized by the compiler, resulting in
invalid values for the IOPRIO_PRIO_CLASS() macro (garbage upper bits)
and in an error return for functions such as ioprio_check_cap().

Fix this by masking the result of the shift by IOPRIO_CLASS_SHIFT bits
in the IOPRIO_PRIO_CLASS() macro. The new macro IOPRIO_CLASS_MASK
defines the 3-bits mask for the priority class.

While at it, cleanup the following:
* Update the mention of CFQ in the comment describing priority classes
  and mention BFQ and mq-deadline.
* Change the argument name of the IOPRIO_PRIO_CLASS() and
  IOPRIO_PRIO_DATA() macros from "mask" to "val" to reflect the fact
  that an IO priority value should be passed rather than a mask.
* Change the ioprio_valid() macro into an inline function, adding a
  check on the maximum value of the class of a priority as defined by
  the IOPRIO_CLASS_MAX enum value.
* Remove the unnecessary "else" after the return statements in
  task_nice_ioclass().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 include/linux/ioprio.h      |  5 ++---
 include/uapi/linux/ioprio.h | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index ef9ad4fb245f..997641211cca 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -25,10 +25,9 @@ static inline int task_nice_ioclass(struct task_struct *task)
 {
 	if (task->policy == SCHED_IDLE)
 		return IOPRIO_CLASS_IDLE;
-	else if (task_is_realtime(task))
+	if (task_is_realtime(task))
 		return IOPRIO_CLASS_RT;
-	else
-		return IOPRIO_CLASS_BE;
+	return IOPRIO_CLASS_BE;
 }
 
 /*
diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index 77b17e08b0da..27dc7fb0ba12 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -6,10 +6,12 @@
  * Gives us 8 prio classes with 13-bits of data for each class
  */
 #define IOPRIO_CLASS_SHIFT	(13)
+#define IOPRIO_CLASS_MASK	(0x07)
 #define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
 
-#define IOPRIO_PRIO_CLASS(mask)	((mask) >> IOPRIO_CLASS_SHIFT)
-#define IOPRIO_PRIO_DATA(mask)	((mask) & IOPRIO_PRIO_MASK)
+#define IOPRIO_PRIO_CLASS(val)	\
+	(((val) >> IOPRIO_CLASS_SHIFT) & IOPRIO_CLASS_MASK)
+#define IOPRIO_PRIO_DATA(val)	((val) & IOPRIO_PRIO_MASK)
 #define IOPRIO_PRIO_VALUE(class, data)	(((class) << IOPRIO_CLASS_SHIFT) | data)
 
 /*
@@ -23,9 +25,16 @@ enum {
 	IOPRIO_CLASS_RT,
 	IOPRIO_CLASS_BE,
 	IOPRIO_CLASS_IDLE,
+
+	IOPRIO_CLASS_MAX,
 };
 
-#define ioprio_valid(mask)	(IOPRIO_PRIO_CLASS((mask)) != IOPRIO_CLASS_NONE)
+static inline bool ioprio_valid(unsigned short ioprio)
+{
+	unsigned short class = IOPRIO_PRIO_CLASS(ioprio);
+
+	return class > IOPRIO_CLASS_NONE && class < IOPRIO_CLASS_MAX;
+}
 
 /*
  * 8 best effort priority levels are supported
-- 
2.31.1

