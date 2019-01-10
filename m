Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E14C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE9D214DA
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cWuVeDFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfAJJhr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:37:47 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:25551 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfAJJhr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 04:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547113106; x=1578649106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m8TUMuU0WrSV2cObnHoEtD5GaIIGOGegE+ezFeuOKDE=;
  b=cWuVeDFAQVEmFAXuUm+a9VHCe37VWQ+agTC3ZklOwIN0E0Fb9w2XzpgD
   Y61lxByGKZmIOXnizxRjnwMSXgbV07Lo/exCkUbOJvrxPC3hkos3C2mXk
   8muAeCRn5wN5beNAiQr4jXuJd6+KiZZaNNTv5+oEyV4MGNtlj0dhlGQmU
   7oT8m92WAtclZatZ8YVlrWznni4kt48y1XsTAkV39qnmrHih6A4sOgvNE
   MyV8GpH+bUa4nurDzZK2mIpVkgDPwcRVGK7emJGmLfxgPWAx4A+BCgCzx
   g0Zw+1CgqAE5vU1SrsATPVa0RsICFXQRpCm+RhtY4WKd0MqjmsmlLr9H3
   g==;
X-IronPort-AV: E=Sophos;i="5.56,460,1539619200"; 
   d="scan'208";a="196468978"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2019 17:38:25 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 10 Jan 2019 01:19:17 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jan 2019 01:37:43 -0800
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
Subject: [PATCH blktests v2 04/16] common: Introduce _have_fio_zbd_zonemode() helper function
Date:   Thu, 10 Jan 2019 18:37:13 +0900
Message-Id: <20190110093725.32675-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
References: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
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
 common/fio | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/fio b/common/fio
index e407088..44d9c86 100644
--- a/common/fio
+++ b/common/fio
@@ -17,6 +17,18 @@ _have_fio() {
 	return 0
 }
 
+_have_fio_zbd_zonemode() {
+	local -a v
+
+	_have_fio || return $?
+	mapfile -t v < <(fio --version | tr -s -c "[:digit:]" "\n")
+	if [[ ${v[1]} -lt 3 || ( ${v[1]} -eq 3 && ${v[2]} -lt 9 ) ]]; then
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

