Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E51C4320A
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 674876140D
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhHPBpo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:45:44 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37272 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhHPBpl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Aug 2021 21:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629078309; x=1660614309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1QPiYuHt5dV869F8QwhdTO7THa99Yx4op/JiyCqhLpQ=;
  b=Pi2NL+57EJOzQFN2KnxRfxB8fYLtk1r2xID1xX9NhF+enMt+5Chjv4Ud
   xM6ytyNzP9i1y/CInqL2SNHI8E2nUZ33n08zdz9tEN8iuKz1Cbuo8XWaQ
   Fa0K95owoayWPO9b57q5ENhYu3gRdRvC0rqURgdcPu8wkt2pIXvbYGJYY
   XmfBOlhVhf16+coClLVrAV7wziEwS9KYcvsDtQslhXv/0cZZq1XkHRw3H
   wUV0N+PWpnJOZ37Ye1JhTjkqek1pH1A8zrir+PV095zY5pDS5lCWRxC4a
   4Jp1Dp99hZD+qrijJLxdQ/Xafjn7JWMyNfrR1NvFgG71JwFJ4ZN4ojMP7
   g==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="177326723"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 09:45:06 +0800
IronPort-SDR: 9Obp+9vB8t1jK9jm16sPLOnRJ1bq7qgolUMsqtDM6TRc9Ysf3koUdufJcUyvxN8D5Y1LWQydZ3
 pNjlFCq2XraNK5o2cmIvjN8kBXEW/0lD6icQuzgs4NMkpqJc98szyixcKPsilTRh2u5IXCu1PW
 2C3cKLNQGny5+kh6WWkjffyfal+8AW6Wf4KTALKwJ3XPf2Y5fT1WmGmbLhb1K3ix3Lu6EYHXF4
 kKXi6mBAJ2btt3QjWdWp/7ZNCZhKWDuKnxKhh+HrG6WNtzHE7dHWamGhfrZCW9n8NpF/HhcyxW
 Nknx+392Xm0UbRi+kk2nCfQA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 18:20:33 -0700
IronPort-SDR: JHY5WUkwUQSVFcj3iWVDEr3aflsmgfHBsdFT0p9PVQQeuPNndl06FMvewwU5UOqhpXexfOTuS9
 nhasate5LspQXNQacTLZVZSvnGXBtCX2VlpvFqmOe7/gAjM9hwNuQhQoTnKPwJmHvJvK+ct+jO
 +u5pPVghzjahtCiz6ujvu2Opk8t+Jfn6sk080KTfx1VskG8sjbGb6faPofm+LULmTI7UT3fwv+
 ihHGTCfZg0KlY4LJXGbiSla1S/nhomJ6VGE3VhIPUD/G3+TKYScbVwdo1TyBeVtTADlXCbUPBc
 MyA=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2021 18:45:08 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v7 10/11] docs: sysfs-block-device: improve ncq_prio_enable documentation
Date:   Mon, 16 Aug 2021 10:44:55 +0900
Message-Id: <20210816014456.2191776-11-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816014456.2191776-1-damien.lemoal@wdc.com>
References: <20210816014456.2191776-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

NCQ priority is an optional feature of the NCQ feature set and should
not be confused with the NCQ feature set itself. Clarify the
description of the ncq_prio_enable attribute to avoid this confusion.

Also add the missing documentation for the equivalent
sas_ncq_prio_enable attribute.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 Documentation/ABI/testing/sysfs-block-device | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-block-device b/Documentation/ABI/testing/sysfs-block-device
index aa0fb500e3c9..cf1013df4b92 100644
--- a/Documentation/ABI/testing/sysfs-block-device
+++ b/Documentation/ABI/testing/sysfs-block-device
@@ -55,6 +55,20 @@ Date:		Oct, 2016
 KernelVersion:	v4.10
 Contact:	linux-ide@vger.kernel.org
 Description:
-		(RW) Write to the file to turn on or off the SATA ncq (native
-		command queueing) support. By default this feature is turned
-		off.
+		(RW) Write to the file to turn on or off the SATA NCQ (native
+		command queueing) priority support. By default this feature is
+		turned off. If the device does not support the SATA NCQ
+		priority feature, writing "1" to this file results in an error.
+
+
+What:		/sys/block/*/device/sas_ncq_prio_enable
+Date:		Oct, 2016
+KernelVersion:	v4.10
+Contact:	linux-ide@vger.kernel.org
+Description:
+		(RW) This is the equivalent of the ncq_prio_enable attribute
+		file for SATA devices connected to a SAS host-bus-adapter
+		(HBA) implementing support for the SATA NCQ priority feature.
+		This file does not exist if the HBA driver does not implement
+		support for the SATA NCQ priority feature, regardless of the
+		device support for this feature.
-- 
2.31.1

