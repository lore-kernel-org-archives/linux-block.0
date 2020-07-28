Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B35C433E5
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57092083E
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pBptjkIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgG1KO7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:14:59 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:41078 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgG1KO6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 06:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595931298; x=1627467298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f3IZ03vSoX2zAi2YKhqJXLiULty70QYy71aJYyx545o=;
  b=pBptjkIqKQuglS+lyg9K9q7bkkfkPT8BLfz4UXGSfX+gc4aJCBByycax
   dDtV+e2k1Uk6jiJmAjNoq5FsLVOqCV5S0yCb7sCAYS41t9M0mVe/yYcrW
   LSPfTFWx++XXC2GDJO58FLIunaNMmuHqZc5GA1i1C+ppK+GL33w6Su81p
   JmLPIGIMpu8vwWxm/Fs+V9tsPHHIixU/yyaVznkzGaefrwKFY+N+9Ao8Y
   IGql9+GMy48xUuRi/O947UqUdknuk1IIvlfu+mkhPdE/JCt9iGZCtYwVp
   5Ht31uXRgmfB4YxiPjPMYIE8K1LCUKLbJy9j3onrKviyw3427q9Z0U7yd
   Q==;
IronPort-SDR: 6xwXbtmq65lFXdRweR/TwajRdUtb6h33UcedxqJPxTDIkXjMJINXqfj+hHykFsxFhUOz2gR2yI
 2DYtOTyYgpUDrYXwpRDIYyWfbwTw7EVpJJHDWdhqRjTjfqsgcjpWxgLryoBI4UdXBAgiFW6v9J
 kBKcXyrXTocnaHGMUDP2uhjoE5Qfu9AY2ybC7a+gdiiJsSTuAImfV+ovQCrDQGUa22jKNUs607
 kQ63kflqrIZpbd6+Y5CROBnZa7LWHrryq+qjZ6JMrpd9+LE73NLp6EG6CG9GDA3gA6DGbpT4s6
 C7Q=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="143543043"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 18:14:58 +0800
IronPort-SDR: GTSePXyNUYolT/K8oqT2leLTTOYcQ8R4AIqlo8sNaKUmDEvCV6UAX3HMV9mrQgCeXU2k6apI9D
 +ZJSuNOhr+Y/klywzsu0OWEW4sBySd1lk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 03:03:07 -0700
IronPort-SDR: tqq49VyBYs9WfRCPlHX+R/u/kJcRxq/mR6TBCG/U/Iz5FbiZiXpXkG4/+Yz9l0LffstVeWt6GE
 vl9FCPVCuk5Q==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.87])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jul 2020 03:14:57 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/5] zbd/004: Check zone boundary writes using zones without zone capacity gap
Date:   Tue, 28 Jul 2020 19:14:50 +0900
Message-Id: <20200728101452.19309-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
References: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test case zbd/004 checks zone boundary write handling by block layer
using two contiguous sequential write required zones. This test is valid
when the first zone has same zone capacity as zone size. However, if the
zone has zone capacity smaller than zone size, the write in the zone
beyond zone capacity limit causes write error and the test fails.

To avoid the write error, find the two zones with first zone that has
zone capacity same as zone size. If such zones are not found, skip the
test case.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/004 |  6 +++++-
 tests/zbd/rc  | 11 +++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tests/zbd/004 b/tests/zbd/004
index ac0cf50..f09ee31 100755
--- a/tests/zbd/004
+++ b/tests/zbd/004
@@ -46,7 +46,11 @@ test_device() {
 
 	# Find target sequential required zones and reset write pointers
 	_get_blkzone_report "${TEST_DEV}" || return $?
-	idx=$(_find_two_contiguous_seq_zones) || return $?
+	if ! idx=$(_find_two_contiguous_seq_zones cap_eq_len); then
+		SKIP_REASON="No contiguous sequential write required zones"
+		_put_blkzone_report
+		return
+	fi
 	_reset_zones "${TEST_DEV}" "${idx}" "2"
 
 	# Confirm the zones are initialized
diff --git a/tests/zbd/rc b/tests/zbd/rc
index dafd130..3fd2d36 100644
--- a/tests/zbd/rc
+++ b/tests/zbd/rc
@@ -253,21 +253,28 @@ _find_sequential_zone_in_middle() {
 	return 1
 }
 
-# Search zones and find two contiguous sequential required zones.
+# Search zones and find two contiguous sequential write required zones.
 # Return index of the first zone of the found two zones.
+# When the argument cap_eq_len is specified, find the two contiguous
+# sequential write required zones with first zone that has zone capacity
+# same as zone size.
 # Call _get_blkzone_report() beforehand.
 _find_two_contiguous_seq_zones() {
+	local cap_eq_len="${1}"
 	local -i type_seq=${ZONE_TYPE_SEQ_WRITE_REQUIRED}
 
 	for ((idx = NR_CONV_ZONES; idx < REPORTED_COUNT; idx++)); do
 		if [[ ${ZONE_TYPES[idx]} -eq ${type_seq} &&
 		      ${ZONE_TYPES[idx+1]} -eq ${type_seq} ]]; then
+			if [[ -n ${cap_eq_len} ]] &&
+				   ((ZONE_CAPS[idx] != ZONE_LENGTHS[idx])); then
+				continue
+			fi
 			echo "${idx}"
 			return 0
 		fi
 	done
 
-	echo "Contiguous sequential write required zones not found"
 	return 1
 }
 
-- 
2.26.2

