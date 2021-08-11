Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E0CC4320A
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 03:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E65760F11
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 03:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhHKDhs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 23:37:48 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34657 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhHKDhd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 23:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628653030; x=1660189030;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=TLB12hws/We5+bFUS7lZWqDMzP/Axao9rVRwnxqY1E4=;
  b=KKkt789oNdkvhNApEuZBQFegoPo32klJuLBDLyqaJNjGd102B0tVLGV4
   KONOBLDYJ5u+KeJ6xMpJsWLOZhySIuisRVy5hq1LGF5gXbezUQY04UEGl
   uAKzPdeQ+2vEKhtjZOP+YR/K9dGmyjyy/LCT7IBaEWnb8ucYUGicT468N
   KbzQYPU8fknifCljXj5ic5QjrNh8uP2UdmGx52mgLhAKsorgWOeVJKcNk
   kQYctAdJkO4A7wcHSQWlXNqLYBOVVf2pcs1eg8+lBdi9k31NaeSnHa2fT
   Afh21StX3o+6yaN7rqdRF2Q4OxiujzwG++ylYx3AuUcCUrIQEfkel+49y
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,311,1620662400"; 
   d="scan'208";a="177454817"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 11:37:10 +0800
IronPort-SDR: ZqWnGexNqaWCg/W4kKxmFtE2/4dOXzOeYb9IPAtY96awotkDp6JDeqLKuQhq7TeN859na5Btvt
 0pnyTFH5WWt30AQAMlvoKWFei1U3GQX+Hd8Dp2ej//vcZb4zC4HphD9/0HX+nI6WAOz+I/s+ka
 yAqXW0+Q9aE03ezYT1WqkiQ7x8CI0k/83eDycA01SZYUG/NTclD0hTXrOctUMX65qXQIyEKR4Y
 NTndsep9D/IPrXlXzA8je8Fq5OZlZE/TI1CpQ2YNA/EoHbICKY8PJwKb9H2CaMMV1HIqhSiFQ4
 aVEowrtb8K5kEQhXOnxSnEJr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 20:14:30 -0700
IronPort-SDR: poaSQOX8guMoDEMVP4Z35+CJM/Vx+6J1kh3uYqQdi7arVOzPoixAfVoXto8nOL5jKzf6dOUlD3
 uKvdzRIRCCV6m99xWYt+NLKotFSP5I5FlIbRDr88E7OP3XLWs29WP+yApBy9+IXhJZFkxrpMXj
 lcL8951untx1ZeZIE3qTn1Kh4gc9OjWcqDtlRGCA3d50OB0xFs+4RGoi7YB64BN1N39Bi8Kott
 ri1LAmJ29wNRO1sqNEwPP9IbUzr62hZlYdXMoYpH1fn0UfGr80aMGsZMVC+9lzVQ9M/7+3TOix
 t58=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2021 20:37:08 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v4 4/6] block: fix IOPRIO_PRIO_CLASS() and IOPRIO_PRIO_VALUE() macros
Date:   Wed, 11 Aug 2021 12:37:00 +0900
Message-Id: <20210811033702.368488-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210811033702.368488-1-damien.lemoal@wdc.com>
References: <20210811033702.368488-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The ki_ioprio field of struct kiocb is 16-bits (u16) but often handled
as an int in the block layer. E.g. ioprio_check_cap() takes an int as
argument.

With such implicit int casting function calls, the upper 16-bits of the
int argument may be left uninitialized by the compiler, resulting in
invalid values for the IOPRIO_PRIO_CLASS() macro (garbage upper bits)
and in an error return for functions such as ioprio_check_cap().

Fix this by masking the result of the shift by IOPRIO_CLASS_SHIFT bits
in the IOPRIO_PRIO_CLASS() macro. The new macro IOPRIO_CLASS_MASK
defines the 3-bits mask for the priority class.
Similarly, apply the IOPRIO_PRIO_MASK mask to the data argument of the
IOPRIO_PRIO_VALUE() macro to ignore the upper bits of the data value.
The IOPRIO_CLASS_MASK mask is also applied to the class argument of this
macro before shifting the result by IOPRIO_CLASS_SHIFT bits.

While at it, also change the argument name of the IOPRIO_PRIO_CLASS()
and IOPRIO_PRIO_DATA() macros from "mask" to "ioprio" to reflect the
fact that a priority value should be passed rather than a mask.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 include/uapi/linux/ioprio.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index 5064e230374c..936f0d8f30e1 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -5,12 +5,16 @@
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
+	((((class) & IOPRIO_CLASS_MASK) << IOPRIO_CLASS_SHIFT) | \
+	 ((data) & IOPRIO_PRIO_MASK))
 
 /*
  * These are the io priority groups as implemented by the BFQ and mq-deadline
-- 
2.31.1

