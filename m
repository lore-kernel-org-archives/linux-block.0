Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E132C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 09:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A212087E
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 09:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aiSmtoax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfARJpI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:45:08 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34681 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbfARJpI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 04:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547804709; x=1579340709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xr1OyQaLlTmPYAsiFIzba9jjn+m6h3teH3K/mzCBlhc=;
  b=aiSmtoax9lxFeRFCNEZlOiQxQkY4RMLOhLweEhuujjBRjx16q8pvHnqc
   VtBI0iBSIyFqqBZoVO5oEZxQKEExaqacJe+HmjKn8G1VN47l0UmfqDH7Y
   rnXHsuT0g5/dAvbcTgzCEPvNxVzQYBOEeKdQ+by9pWgxr+4oT6VLTgHlO
   RJBS62mmW3UQdEI/t0Y9Z2jbHnR2pIzfYgIPhHip3KAmbatI4EpsXkZRT
   u/mW1co88uKn+lkz52XQo6eej8y6OA/ESchQjvaLAW2IC5idf9OWxPf8k
   mkY2XOxslgKfO0LF3C5rt+XIdQTzaYDbs8Gtf4nuOnQze3x8JzfwnAw1w
   g==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539619200"; 
   d="scan'208";a="100920244"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2019 17:45:07 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 18 Jan 2019 01:26:24 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2019 01:45:02 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v3 02/13] common: Introduce _have_fio_zbd_zonemode() helper function
Date:   Fri, 18 Jan 2019 18:44:42 +0900
Message-Id: <20190118094453.13773-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
References: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fio zbd zone mode is necessary for zoned block devices. Introduce the
helper function _have_fio_zbd_zonemode() to check that the installed
fio version supports the option --zonemode=zbd.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/fio | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/fio b/common/fio
index e407088..4c771fc 100644
--- a/common/fio
+++ b/common/fio
@@ -17,6 +17,15 @@ _have_fio() {
 	return 0
 }
 
+_have_fio_zbd_zonemode() {
+	_have_fio || return $?
+	if ! fio --cmdhelp=zonemode 2>&1 | grep -q zbd ; then
+		SKIP_REASON="Fio version too old (does not support --zonemode=zbd)"
+		return 1
+	fi
+	return 0
+}
+
 declare -A FIO_TERSE_FIELDS
 FIO_TERSE_FIELDS=(
 	# Read status
-- 
2.20.1

