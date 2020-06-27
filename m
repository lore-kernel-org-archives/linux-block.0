Return-Path: <SRS0=phs8=AI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA646C433E0
	for <linux-block@archiver.kernel.org>; Sat, 27 Jun 2020 10:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5149208B6
	for <linux-block@archiver.kernel.org>; Sat, 27 Jun 2020 10:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgF0Kb0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Jun 2020 06:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgF0Kb0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Jun 2020 06:31:26 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04700C03E979;
        Sat, 27 Jun 2020 03:31:26 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id B4757BC130;
        Sat, 27 Jun 2020 10:31:22 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        corbet@lwn.net, axboe@kernel.dk, mchehab+samsung@kernel.org,
        drbd-dev@lists.linbit.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: DRBD driver
Date:   Sat, 27 Jun 2020 12:31:11 +0200
Message-Id: <20200627103111.71771-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See https://lkml.org/lkml/2020/6/26/837

 Documentation/admin-guide/blockdev/drbd/index.rst | 2 +-
 Documentation/admin-guide/blockdev/floppy.rst     | 6 +++---
 drivers/block/drbd/Kconfig                        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/drbd/index.rst b/Documentation/admin-guide/blockdev/drbd/index.rst
index 68ecd5c113e9..561fd1e35917 100644
--- a/Documentation/admin-guide/blockdev/drbd/index.rst
+++ b/Documentation/admin-guide/blockdev/drbd/index.rst
@@ -10,7 +10,7 @@ Description
   clusters and in this context, is a "drop-in" replacement for shared
   storage. Simplistically, you could see it as a network RAID 1.
 
-  Please visit http://www.drbd.org to find out more.
+  Please visit https://www.drbd.org to find out more.
 
 .. toctree::
    :maxdepth: 1
diff --git a/Documentation/admin-guide/blockdev/floppy.rst b/Documentation/admin-guide/blockdev/floppy.rst
index 4a8f31cf4139..0328438ebe2c 100644
--- a/Documentation/admin-guide/blockdev/floppy.rst
+++ b/Documentation/admin-guide/blockdev/floppy.rst
@@ -6,7 +6,7 @@ FAQ list:
 =========
 
 A FAQ list may be found in the fdutils package (see below), and also
-at <http://fdutils.linux.lu/faq.html>.
+at <https://fdutils.linux.lu/faq.html>.
 
 
 LILO configuration options (Thinkpad users, read this)
@@ -220,11 +220,11 @@ It also contains additional documentation about the floppy driver.
 
 The latest version can be found at fdutils homepage:
 
- http://fdutils.linux.lu
+ https://fdutils.linux.lu
 
 The fdutils releases can be found at:
 
- http://fdutils.linux.lu/download.html
+ https://fdutils.linux.lu/download.html
 
  http://www.tux.org/pub/knaff/fdutils/
 
diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 52d885cdccb5..cbacddc55a1d 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -35,7 +35,7 @@ config BLK_DEV_DRBD
 	  cache coherency.
 
 	  For automatic failover you need a cluster manager (e.g. heartbeat).
-	  See also: http://www.drbd.org/, http://www.linux-ha.org
+	  See also: https://www.drbd.org/, http://www.linux-ha.org
 
 	  If unsure, say N.
 
-- 
2.27.0

