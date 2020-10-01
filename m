Return-Path: <SRS0=e+pS=DI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1830BC4727F
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 10:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5FCC21531
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 10:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oPNWeRkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgJAKPh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Oct 2020 06:15:37 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12424 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgJAKPh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Oct 2020 06:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601547336; x=1633083336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PjV/fuPF8j0sDLv3WHDb7H2GvbKmuptcZe9Of96ZMFo=;
  b=oPNWeRkNA3eu3eOIk3QsCiOli47yAtXBpF677HrynIiwBuWil/OB0/fn
   OoqvWGUFPgKc6tZog4uno6kooe1EJeY3cqMXtD0R+xxpqE0owJ2RF3cEb
   1+g/1dfbF20kXWGEpc2iTKUN7D/27ZDn9gEE6sW94dlij/F1a9zf5In6x
   HQrMwG4Z+BmMCG/lAsIiLMRYOuj0i9Y9qWNlD62327gpKGPI6Krvr+PBl
   hxtZF+DQohQOP3zrz8YtP8KCEWppWUx4Qrn9sq/0WJcrK53KLVUl8Q1gY
   x57Qazq1m0Gxr0neaGVub6h8DDmP0mQ39+ubRjb1N9a9Mbw9HlJH2wNih
   w==;
IronPort-SDR: aMMj8cq0Ft3pBVG2Pe5Hf5KJ8+shSnWnJ9KYR9JwNHmfRdDsX/x8KlA2UmyPnbv7blYpkM2qRJ
 1nHwQJoDF0XnNcbYk5ufYkInJsY9xkpmDWh5jO0MEsw4y9vFzWpv+VUq1xHRs2oJ/uFuv3YVkl
 Hhn8HyJLpmDqtrAd63fBP3OnEENQJm4aSzqqECi88oM9YyaoJ3aqHmdCIdiFGZmveZFOY0YT8z
 HreLY62NIng7vEXfPTm5LM47jeUiIrKwQNUnUYQIeid14Kq8QQlYagogh5TeDFH03znw/ivbjL
 dlE=
X-IronPort-AV: E=Sophos;i="5.77,323,1596470400"; 
   d="scan'208";a="258516738"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 18:15:36 +0800
IronPort-SDR: mHDHg0bqd/Ml1zq85eu5xI3NXG55rZzvX55HQW9dD2D1qFMQG+0yS1WGTT//yT3UXi65S56kc0
 AkEHjt+LhrUw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 03:02:27 -0700
IronPort-SDR: x+Nt+wNstSzPuUfxnVQq9SpMIJ/RAb+8g26qnfxjsQF8aAUhfMqLbGVZAItI1PglyMDIwKdymI
 qQovzXe4se7w==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com ([10.149.52.189])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 03:15:36 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/3] block/004: Provide max_active_zones to fio command
Date:   Thu,  1 Oct 2020 19:15:30 +0900
Message-Id: <20201001101531.333879-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001101531.333879-1-shinichiro.kawasaki@wdc.com>
References: <20201001101531.333879-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the test target devices is a zoned block device with max_active_zones
limit, the fio command in block/004 opens zones beyond the limit and
fails with I/O errors.

To avoid the failure, pass the limit value to fio using --max_open_zones
option. This option, which was introduced to fio together with
zonemode=zbd, keeps the number of open zones within the specified value.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/004 | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/block/004 b/tests/block/004
index d181725..6eff6ce 100755
--- a/tests/block/004
+++ b/tests/block/004
@@ -21,19 +21,18 @@ device_requires() {
 test_device() {
 	echo "Running ${TEST_NAME}"
 
-	local directio=""
-	local zbdmode=""
+	local -a opts=()
 
 	if _test_dev_is_zoned; then
 		_test_dev_queue_set scheduler deadline
-		directio="--direct=1"
-		zbdmode="--zonemode=zbd"
+		opts+=("--direct=1" "--zonemode=zbd")
+		opts+=("--max_open_zones=$(_test_dev_max_active_zones)")
 	fi
 
 	FIO_PERF_FIELDS=("write iops")
 	_fio_perf --bs=4k --rw=randwrite --norandommap --fsync=1 \
 		--number_ios=256 --numjobs=64 --name=flushes \
-		${directio} ${zbdmode} --filename="$TEST_DEV"
+		"${opts[@]}" --filename="$TEST_DEV"
 
 	echo "Test complete"
 }
-- 
2.26.2

