Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F22C433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 14:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E07A20DD4
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 14:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391208AbhASOju (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:39:50 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:36901 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730106AbhASJls (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jan 2021 04:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611049807; x=1642585807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gf41tJSgK06B/Ga4VjMMXYqoISVLe/c4wgOY899USOM=;
  b=Xpuq4YwKBhK5mr0FVX5LURtse2AOw3sn8fUWeqbn5pPxmLcAxZMfAATg
   xKN//XibR7FdYmfJoL/IPI9S+j1cgGi2OwuH1sCpgTVU6uE+JzQSjnuPe
   4fDsTs3Jej7EG/iNiMUDnv3eZMlIah4rWabT9Eh78dt6IJfa2ypSt4Yed
   kY3LHLvngZPIQFVl1t0yzYwjX8PYbZpYIwJjUvp0qXy3qZ4eJDOD74vCw
   pHQthRzrL7Wd06rkSGlDL+DzufA8t/z8itDg7NP1WN2+ZE3fqXE6vdVPC
   xefrvzJD5aMjYw0MOVP1XLNYRqscZMMooZzrPN+k21XKBg2K5d/QleNCR
   A==;
IronPort-SDR: hezkYgGg1unwe+41YcWGJ0rTblGMJ5Jch6EJPah6sK75B2RCvbBJMhiLkqQvG4T7DpKAu5RvgP
 kyaa16wiOeZus09sIzoE8u8Tw2Hto6CSLMXZwS6tx4H56E0YACBteOJYM4rqoMDrBIdikUBDC2
 plpTy6qND9zGP8V9EGIGyrwMM9sgR01AjzafaYfqOMBHB45XWvW4S+K//Z5XC40yA0vHnPo8T9
 Ta+KEWxz2136YSxxoxEuxnE1LPmwdwnhktphYE4suOqC86qzAXkqaLoo0XpwlvDL1N3Bjw5fP2
 eD8=
X-IronPort-AV: E=Sophos;i="5.79,358,1602518400"; 
   d="scan'208";a="261745164"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 17:45:51 +0800
IronPort-SDR: kMv+UtXFqylEi1HE1pNur+CS2ezi3pWNrJIPs0rtD39PH/DfK8zEqfnWVHqGZv0cR1YhFoYwOU
 thzqqGO7SWjC0I51j4jg8Y7yvDNLkBq5hsmkxWxPLIvsVvOPWTlDxkRAGgImE67QXMilTS98+n
 O9tk3gp0UEc8ZJdoCymcEX0IFYwmPtfKc15pyl/9WkoE/iz69T6jomR50j2zzv0MAeWHnqVX/0
 gPo0hYZz+wihms38OpvjSYEbgobp9v6K0RzgrTCYdiHZ8qDd3J+igJ97fcYbo3PPnyWmIeG5UL
 LTXxaZmAhm7OiSB9yFqhKxM4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 01:23:35 -0800
IronPort-SDR: xIDxcBheQlgXo7ZUms0qQyLNEdYsboFRp17WDB1JXkkAD5fs5ESUVcU4h96k9BkShlr32PIxbs
 l226qLi3nmQe3bW2biWVEIPPGXS2ZYuoVI1F5c/wKVkDi0zU3N8fC27qygcSi65qFOZ4AMeq+h
 O+K/2xEn4j3JtFLfpmqcvrWBbaEwogH76ACSBKaKqkN7GP/N0BfxpqjaHXIcLOUbNxMlJRM5oG
 CNRDB6n26SxqQgcHgEa/kUaF+2b993sMM5CFQKdZBdrVSZr2ZVn8Ix8o+F8vQVvDMfNsJHnVY1
 vm0=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Jan 2021 01:38:57 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v2 2/2] block: document zone_append_max_bytes attribute
Date:   Tue, 19 Jan 2021 18:38:55 +0900
Message-Id: <20210119093855.1633232-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210119093855.1633232-1-damien.lemoal@wdc.com>
References: <20210119093855.1633232-1-damien.lemoal@wdc.com>
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
index c8bf8bc3c03a..4dc7f0d499a8 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -261,6 +261,12 @@ For block drivers that support REQ_OP_WRITE_ZEROES, the maximum number of
 bytes that can be zeroed at once. The value 0 means that REQ_OP_WRITE_ZEROES
 is not supported.
 
+zone_append_max_bytes (RO)
+--------------------------
+This is the maximum number of bytes that can be written to a sequential
+zone of a zoned block device using a zone append write operation
+(REQ_OP_ZONE_APPEND). This value is always 0 for regular block devices.
+
 zoned (RO)
 ----------
 This indicates if the device is a zoned block device and the zone model of the
-- 
2.29.2

