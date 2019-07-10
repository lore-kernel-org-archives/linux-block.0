Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613E8C74A21
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 15:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A3E2087F
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 15:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VKckY0Oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfGJP5r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:57:47 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:17045 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbfGJP5n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 11:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562774264; x=1594310264;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZMJYA93t5ZPNvDC8ldQOlUNs9dyqwjHpuHvWsuSSxi0=;
  b=VKckY0OehiTwvYTjOjhSBl2QYlp4sxjF6vw/idmedUIXFhC7dwobwoUD
   fqa8Uy+/qDovPKqJvuPQjVO5YRMDJexH2SYD/iqFmT8nffSuN1jkAE1Wf
   bdYJq/eEiOdnhDAm0+wXv9E5qKoEvqqCSKE2/rtnayk4wHRT58r2POrBP
   /CTcDaFU/d+xNyjkfIziyeX5FZzCMcyEkQzfMs0kQ4iboUra0n5NA8MFJ
   hPzpCVqXoui4YGIGuJ6qNKQ/DPNXLzJ5QQwv5Si+lEQtodPCV4ccfWkFo
   FYj2yzTujJMiH/bceptiuHoYX4exV//7HCM1ccKUD4Qsbh+qhm/HWRQqB
   w==;
IronPort-SDR: GvOCxMIfYCgWKZ4jLaZMvmApexPQSBeE/HDePOs0Bo5UwRj0HYOX++PEDE4/9tJueZuvNoNu0R
 fYxeTIi7WhUeGItl3H1TPeDYy0zuKH4zYm1xPPS0JStB+Yp1yHt0q20m0enoM8PnNEp6FgR8jR
 97phgnS0mYYtOAMkezcWpPXNuPac2rlWGpmplkzq4jPb7573T+UsDWMfA7IOL6c27OjuBcblYB
 5YlGsU5Df0G2pCxdNnY/ONsY6y5i+ocUcpIUxNgb1h2oHga6FxXu463RJsbBWQ2tiSSO/9LKZW
 Yhc=
X-IronPort-AV: E=Sophos;i="5.63,475,1557158400"; 
   d="scan'208";a="114296345"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 23:57:43 +0800
IronPort-SDR: WM/KjArt1EPUOscijVgxrwYbNnDqxaqU6x4rGqoVIyiMwv+eQFkOmH22Ib0RRh+9aCaJ3dtNyU
 HKmVD6IgOwZB0QKnKn8W5PdKCRJdIPiEPzbh3nkWtRyiEZ3uRpkwQb9tDshJZXaNojV0skcvcw
 ggZlPpRmbvOwR3c4jZ0QK5miWrFQajl03H+aTx4hIFC7F0MGPWyC7QG6pgrk0QJ2ZMYwoRhqG6
 peJAnfPm8T4f+P03u/Qt5IgCkkh50iF9StUlej9d0R47/F4LtMmbP3WwDkL1GEEO0fKyEwJgQ6
 NOseXIGamBydNago5QUVibCw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 10 Jul 2019 08:56:28 -0700
IronPort-SDR: BJ4+w8wKxS01LYFvEWVzlvgPJxZdqfEaWm02h8g+pHmy1qa7OTNeaE96FmOzd5HzS44Hy6G/ZL
 pGnjJZgf/6W68VogA7N0Y3Ln/jLu5vw8r+9kVlVgwMLUWbXQANJ9eGjCGHNshVMShGBSxNy7jD
 kjNXA3+vnlVLo1dXNau+uC3OGveo4hIUTG6MqF7p17OHU1AyHuKQFmbU542zKvB7P5NErW5d6P
 nN+dKYyKu+tkABJ/Ll6fnHfAPcTwPF3zmK3+rGbqPw8cV/zVSY3Of9a4irLeDecJAfTUA2AiCh
 7zo=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jul 2019 08:57:42 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: Fix elevator name declaration
Date:   Thu, 11 Jul 2019 00:57:41 +0900
Message-Id: <20190710155741.11292-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The elevator_name field in struct elevator_type is declared as an array
of characters (ELV_NAME_MAX size) but in practice used as a string
pointer with its initialization done statically within each
elevator elevator_type structure declaration.

Change the declaration of elevator_name to the more appropriate
"const char *" type.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 include/linux/elevator.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 9842e53623f3..b73e6f35fbad 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -75,7 +75,7 @@ struct elevator_type
 	size_t icq_size;	/* see iocontext.h */
 	size_t icq_align;	/* ditto */
 	struct elv_fs_entry *elevator_attrs;
-	char elevator_name[ELV_NAME_MAX];
+	const char *elevator_name;
 	const char *elevator_alias;
 	struct module *elevator_owner;
 #ifdef CONFIG_BLK_DEBUG_FS
-- 
2.21.0

