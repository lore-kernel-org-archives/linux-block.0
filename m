Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B355AC433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EAD464EDC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhBBFhz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:37:55 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43351 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhBBFhy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244273; x=1643780273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bkIkuiAG01FhQkjjNsCxwfUCtamHqgx5K9UDoQu2S9c=;
  b=L/MYMXI8wjOyI7sD5+F52Yhmg3RscYawqbKSj/RXdoeQDR7JxT7/ftlX
   NO7MAqHMHEBlyA+brpA0R3CLCQ8ls30uhr/gbaYa+gf22qowKCrF3kKo2
   IPPh4uGyxbUCw+45iTfnjQBLCoxYIq1V41lMqRrRQ2TBj430zUeOfk44l
   H2vq8mWY2Yt/8Ln1xxwRvyVhc0Q/gKUkply5b1mBw9bHMN/QukXRRxPv5
   /PQX3M3H/8g36ihlr4nScV/LTX/i0MAAxOskcWUpVadmM4v++qm3b8pfu
   3/0NBbFEe7qZz8gP7PtEG9SVnG87hznBuA3wKT/W+pn0nqZCUNZxeJP93
   g==;
IronPort-SDR: HydpIzew74hTs0EQdX6VrYv5caYbbeBHi13bvD0+UVTbooTPkhZZ03AiKqIWb477XFcehtJOZh
 IxzYCTPMFSx2WbX19vgClN+WvI9+AfvVIPss+whHJXroEoCUUxMsxfm3jMJmcJl8huz6AXpDly
 qnpfcmPXC02Y2w2U5TSrKW0QEaJRK95AsW5C3uEFYnByC7D1bMMdtIzJJpcQqpID90nv1Z58jp
 iOS+WieblqQJ2Po9idTQ7/vqKLZBQjR6sZAVIvhCJAtinsG8VqGJbdzVmUvLU/cmueVs+3Ngwp
 ZMU=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163334305"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:36:40 +0800
IronPort-SDR: sRl8UN3jn7PLP1HQU/ERNT5+FR6HFiUalAGsIxL34FTwFTHvaCsQXwRi1xyI1t7BoWiiffEOJZ
 Wp4W/a1i1F3/CbLmd1P740KoBbpC7y6B2FnG/4iFIzmtoNsPU+wUUZFTOLg6cPWG32Ebdu1Zao
 V5R5hcYJcNJ7RoORxw2Vrid9wECF8IBXb7uXic6Kxfw1bJlOQPL3Hd2+w4G1TJ8IQA6TbvNInq
 iWBq+s6gunSPsvgN91GXKplC9OcR+XyXGvOc4qfIwkZ3HlbgbY9IgVqKn0oIFOiq1PG+1ji2NW
 Spoa+AahvLF9ZhJjzqwnwrZa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:20:49 -0800
IronPort-SDR: oxPdTtIskpPSdb1F5rYWHN+L9w1GEDC8E31WYZ5SYqfb3jOpdAkKkojoUuY6shFskBZ1lzta0t
 EisgYWJdRiD3vvyZ2YQyMZXdLIeXlTT7K/ELlQwuos+vtW1qXokC7nShOW94ooV4wlreuwIKjr
 PgeZLl1NBpL1UVrx0MQ7CfZwPahoWZknvnLUcR+wif62kaS1CF9gqEqu0JNBGQQecZSiSbGGo/
 xVgcppkkgbuEnKIvAexfT2gDX6XUi0FyMYnJ8VkSJgnADNFbhuHSORSxO4Xj7GBMY/0iluQxmX
 zNA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:36:40 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 06/20] loop: add newline after variable declaration
Date:   Mon,  1 Feb 2021 21:35:38 -0800
Message-Id: <20210202053552.4844-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a new line after variable declaration at the start of the function
just like we have in the block layer code.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3f8d9bdfc16e..9e59adfd11ff 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -457,6 +457,7 @@ static int lo_req_flush(struct loop_device *lo, struct request *rq)
 {
 	struct file *file = lo->lo_backing_file;
 	int ret = vfs_fsync(file, 0);
+
 	if (unlikely(ret && ret != -EINVAL))
 		ret = -EIO;
 
@@ -1584,6 +1585,7 @@ static int loop_set_capacity(struct loop_device *lo)
 static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 {
 	int error = -ENXIO;
+
 	if (lo->lo_state != Lo_bound)
 		goto out;
 
-- 
2.22.1

