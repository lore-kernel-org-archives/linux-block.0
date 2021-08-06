Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EF9C4320A
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 11:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8473661176
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 11:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245413AbhHFLTX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:19:23 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39959 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242720AbhHFLTS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Aug 2021 07:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628248741; x=1659784741;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=KHg8Sra+YQiVG3zbWEreEoFHIL92ska5iKqjkGR69C8=;
  b=IZxJAI+wn5dfImz+/QMroGuA8iSoThzr1njBL0wYywJuYzNQk+Gzp4BK
   nuZnxZY2qbEfAlnF1URcbUly6Dl9cghjNFaFC7htJG4CC6WMbFhYE2jx3
   URQkndvui9XLNGa4YiOhA+QmH+Ar1bCUwigRc1qYoN04tXt2Lrp47sO38
   dowy2En0vAdkAo5Thm4D2au8IiqZrVNmrXuMI07SCFs0/VsjrNWDaJnPx
   gNLdmOx21v1mUT5g/h78wKwRE6KmJifJDpCPi4Hzb/gsCNw1LGHbgIUGW
   vJIZFsYxKf0XbBAhtnTEifnunLly/C4H0/53ayJuRnOop+Fq7H+gCXEcV
   w==;
X-IronPort-AV: E=Sophos;i="5.84,300,1620662400"; 
   d="scan'208";a="181309763"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2021 19:19:00 +0800
IronPort-SDR: o0Dlcb3t//QINL5XyfaLC5NnK3M2SmmMgZgC9+0jYjSoGrlYgPvwRzK0XXAMyh9w3tmwjj35Ta
 8pLH/X4EZ50S4eeV1NWf7WOa1EY+Ta0K3EmfuO/n/r8aLG7HGmscq9j4xQC3xgnJ5vQ4mWKbMi
 fbebmfEfQP55gwoxBkFhPRktsL0ddyX8oBixZG7ZuLZr9eSHz26WyYd8aVuVEVd692AAI143wb
 yXzEuDzbjz4Puap19CiainiFMTTbb1ITtvwl2fHENvPgkynA4ATN08ZDDYOSbjWqMt104C+uVE
 G5lCyx5hY05c0ovlNuv1TYc4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 03:54:38 -0700
IronPort-SDR: gcWMLSnrWNmtL36SOHHbhSiOjB70PU6s11tfT7w0ZQmsr0h4mvgyZDnvegbpX9BR25TIlOGRyA
 CkDI1MxysedBd9ifbugnc8To8dR0dlSSfCJ6+YaxwP06zsWIYJrNHRyuQO1fWzjpy776US/oem
 85n8zyZivyOHZ5XLFSuzU4Q9e1hn3RubAUPg5FczSGPp1FEuzgljovtlXFVMkkIBFt+Sf0lwN9
 DE/0JLLUCfYUWDLozRqRuWPXZDlUlewAztxy6NaT+oOm9CSfXQYTpKm1IsF9OlD8IHP9V64ixb
 3zg=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Aug 2021 04:19:02 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3 2/4] block: fix ioprio interface
Date:   Fri,  6 Aug 2021 20:18:55 +0900
Message-Id: <20210806111857.488705-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210806111857.488705-1-damien.lemoal@wdc.com>
References: <20210806111857.488705-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

An iocb aio_reqprio field is 16-bits (u16) but often handled as an int
in the block layer. E.g. ioprio_check_cap() takes an int as argument.
With such implicit int casting function calls, the upper 16-bits of the
int argument may be left uninitialized by the compiler, resulting in
invalid values for the IOPRIO_PRIO_CLASS() macro (garbage upper bits)
and in an error return for functions such as ioprio_check_cap().

Fix this by masking the result of the shift by IOPRIO_CLASS_SHIFT bits
in the IOPRIO_PRIO_CLASS() macro. The new macro IOPRIO_CLASS_MASK
defines the 3-bits mask for the priority class.

While at it, cleanup the following:
* Apply the mask IOPRIO_PRIO_MASK to the data argument of the
  IOPRIO_PRIO_VALUE() macro to ignore upper bits of the data value.
* Remove unnecessary parenthesis around fixed values in the macro
  definitions in include/uapi/linux/ioprio.h.
* Update the outdated mention of CFQ in the comment describing priority
  classes and instead mention BFQ and mq-deadline.
* Change the argument name of the IOPRIO_PRIO_CLASS() and
  IOPRIO_PRIO_DATA() macros from "mask" to "ioprio" to reflect the fact
  that an IO priority value should be passed rather than a mask.
* Change the ioprio_valid() macro into an inline function, adding a
  check on the maximum value of the class of a priority value as
  defined by the IOPRIO_CLASS_MAX enum value. Move this function to
  the kernel side in include/linux/ioprio.h.
* Remove the unnecessary "else" after the return statements in
  task_nice_ioclass().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/ioprio.h      | 15 ++++++++++++---
 include/uapi/linux/ioprio.h | 19 +++++++++++--------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index ef9ad4fb245f..9b3a6d8172b4 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -8,6 +8,16 @@
 
 #include <uapi/linux/ioprio.h>
 
+/*
+ * Check that a priority value has a valid class.
+ */
+static inline bool ioprio_valid(unsigned short ioprio)
+{
+	unsigned short class = IOPRIO_PRIO_CLASS(ioprio);
+
+	return class > IOPRIO_CLASS_NONE && class < IOPRIO_CLASS_MAX;
+}
+
 /*
  * if process has set io priority explicitly, use that. if not, convert
  * the cpu scheduler nice value to an io priority
@@ -25,10 +35,9 @@ static inline int task_nice_ioclass(struct task_struct *task)
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
index 77b17e08b0da..abc40965aa96 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -5,12 +5,15 @@
 /*
  * Gives us 8 prio classes with 13-bits of data for each class
  */
-#define IOPRIO_CLASS_SHIFT	(13)
+#define IOPRIO_CLASS_SHIFT	13
+#define IOPRIO_CLASS_MASK	0x07
 #define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
 
-#define IOPRIO_PRIO_CLASS(mask)	((mask) >> IOPRIO_CLASS_SHIFT)
-#define IOPRIO_PRIO_DATA(mask)	((mask) & IOPRIO_PRIO_MASK)
-#define IOPRIO_PRIO_VALUE(class, data)	(((class) << IOPRIO_CLASS_SHIFT) | data)
+#define IOPRIO_PRIO_CLASS(ioprio)	\
+	(((ioprio) >> IOPRIO_CLASS_SHIFT) & IOPRIO_CLASS_MASK)
+#define IOPRIO_PRIO_DATA(ioprio)	((ioprio) & IOPRIO_PRIO_MASK)
+#define IOPRIO_PRIO_VALUE(class, data)	\
+	(((class) << IOPRIO_CLASS_SHIFT) | ((data) & IOPRIO_PRIO_MASK))
 
 /*
  * These are the io priority groups as implemented by CFQ. RT is the realtime
@@ -23,14 +26,14 @@ enum {
 	IOPRIO_CLASS_RT,
 	IOPRIO_CLASS_BE,
 	IOPRIO_CLASS_IDLE,
-};
 
-#define ioprio_valid(mask)	(IOPRIO_PRIO_CLASS((mask)) != IOPRIO_CLASS_NONE)
+	IOPRIO_CLASS_MAX,
+};
 
 /*
  * 8 best effort priority levels are supported
  */
-#define IOPRIO_BE_NR	(8)
+#define IOPRIO_BE_NR	8
 
 enum {
 	IOPRIO_WHO_PROCESS = 1,
@@ -41,6 +44,6 @@ enum {
 /*
  * Fallback BE priority
  */
-#define IOPRIO_NORM	(4)
+#define IOPRIO_NORM	4
 
 #endif /* _UAPI_LINUX_IOPRIO_H */
-- 
2.31.1

