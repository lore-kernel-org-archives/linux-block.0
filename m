Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF25C433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 08:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1B823134
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 08:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbhASInf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jan 2021 03:43:35 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:1485 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbhASInW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jan 2021 03:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611045801; x=1642581801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9HvijaTQugkaK/Jyk44XYPOkaB419ZkF5RTRogukLPY=;
  b=K4iKM9OPGIl0vCxtKzKvrJfDbK30M3jCuossE9cxqZiDRWH6fcI4Z9vk
   VbXVwLyUTLI/LO8DsVxSV+B4Nz3rAgfQgPeGJq3twpSGn3Z3JqjF3avCj
   ccP710L1ZmeIhB+fPN/osUoOhGKE2O2g+GGKXC/+qpLxDbuIXdyCBlqRX
   28qEbRuAc9JcKHglL/jf4Of8quMwoQumcS6c/WjgDYHIpv6ykjxYIk+pS
   W3hP6W0CnCtVk3v2e2nCPlSPusXSuWZFJX+7rgH3OObZIfq/toKVgEBhy
   4csP+//2y/yj1ykITMk1fSc2o0m/6teZCXRxl6ehk3PjCxGCDr1ZbYlaI
   Q==;
IronPort-SDR: oMEpNQy+djeELzSymfbC+FWieTEfCzzziA/bHGhfEPcPchARzIzT+74bO0FiHNb4qki8/y52qb
 nvqGHua0kvcuvZrt/WdiGYqzvFko1bM8Ft4r/769uCYZ9jQ+RM1WGyNWpdukUAKjoWt33WSjzi
 izDZ3Fxcborufu28VwXYWzhCE3/zyYlhwQUtX2zLBZve2kvnjVfliNApjn4KW6gqpjBCcXunkv
 5obL1z158BG6EuIWCXf8JSkegLO9H7AGvwbczawK48Lm4t2dODItKJFv0Ar1s/whnb/YKjD7E0
 xBg=
X-IronPort-AV: E=Sophos;i="5.79,358,1602518400"; 
   d="scan'208";a="268098205"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 16:41:06 +0800
IronPort-SDR: LPhKc5/kaKiYwL7S8bRQOWhe7yU7XqtSvfIbU9CCqP+5JZHeI0eDcba6kXvqGTzzhbTmv9XSrX
 uyqx/q509Gt5MqJE6pjrP6x2a6hz5NmHWof9etKKNDCFQyVu8xHVl8Cs0iapukVWVRQy76vnAL
 n146wvWH2EP+3OrCPVCjlmN2JJw4xE//nR3lMVtKAMK60BI9/NBeozyKh/2XbQ6xbhn31Lu6tF
 O/6xwOY2LzFq2Wm9YFMXsUO2NrBJn57k9AXUaFgujdqXTel+BVhFZV4wP+n6cDVOfuaoJYbhBL
 GB9UpeLAmXllo3Fu9voXG0Lj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 00:25:43 -0800
IronPort-SDR: aOTN4CO6wjbZ7/JnfX9iZx6gQHbtZpEdhmyOQIpzbm6YXhGMsh2Th7NPCbaRikrhyrVDtO+l2J
 RNR1qpvuQmKKaBPBVsC+cYzApogzsCdAUhw2wOETdIn4j4/XuShyeoFKdD7RuADzvppLI0ISS0
 okcPXtSpxXOsi9NtA8fNyjwuOpLmKtzDoZYjsMjNp5aHv/E1KRVS/xV22nnwEWXdaj0MD/lazZ
 C5xwGiEyVplcZ16kXaHA0S41Zq3vB2HlzkpksGjR27lQKXy8u+eiXDUe+MPm3MYEt49390MVJG
 9OQ=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jan 2021 00:41:05 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/2] block: document zone_append_max_bytes attribute
Date:   Tue, 19 Jan 2021 17:41:03 +0900
Message-Id: <20210119084103.1631698-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210119084103.1631698-1-damien.lemoal@wdc.com>
References: <20210119084103.1631698-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The description of the zone_append_max_bytes sysfs queue attribute is
missing from Documentation/block/queue-sysfs.rst. Add it.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 Documentation/block/queue-sysfs.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
index c8bf8bc3c03a..e730d1b1c11f 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -261,6 +261,12 @@ For block drivers that support REQ_OP_WRITE_ZEROES, the maximum number of
 bytes that can be zeroed at once. The value 0 means that REQ_OP_WRITE_ZEROES
 is not supported.
 
+zone_append_max_bytes (RO)
+--------------------------
+This is the maximum number of bytes that can be written to a sequential
+zone of a zoned block device using a zone append write operation
+(REQ_OP_ZONE_APPEND). This value if always 0 for regular block devices.
+
 zoned (RO)
 ----------
 This indicates if the device is a zoned block device and the zone model of the
-- 
2.29.2

