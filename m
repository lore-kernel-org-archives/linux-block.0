Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22A5C43334
	for <linux-block@archiver.kernel.org>; Tue, 19 Jul 2022 04:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbiGSESE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jul 2022 00:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiGSESD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 00:18:03 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2763F32BA6
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 21:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658204282; x=1689740282;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zkuCHrVb4V4it4GbTokF9rs1OebnigevQdi++WI+Ib4=;
  b=jQxb0+Rgpj/YkPKmQS6z5eoDuItVEoEKmynErTfa2+R7IGuovrq5pY8b
   7efhP8wR3SAOiBYIRqCgso0oexVidmCaMBfscp9Wpnte2cMdSYiHHgf6/
   8eYwFoIuJrrR3X5Xqsm7RZgaAQ2z78HFCJJRqr6rMh51sRmFcggcgyAzP
   WBFLGgVeVLNm1/vMiX2NUXSll3w7s04/prKy4ogoGJAskEIumnuSpEVPM
   0jww/gdv7yBAjSrwJqSK7mUhOqj7sxWuH+i8L11+oFVfz2xUZ6wg5F3+3
   7m1pAKxn2AeMseqPqdfnNYuGquyLRhdji+m0abEhQZnaps2RcmmQriMO/
   A==;
X-IronPort-AV: E=Sophos;i="5.92,282,1650902400"; 
   d="scan'208";a="310572292"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2022 10:52:17 +0800
IronPort-SDR: qMVmanhN6OQfjEk/JxOr6UYTuGM0QX8R/xo1gFBkdAqQbuT25Jul4Z4S51MZThG3yoLc9SqVyq
 sZQ936LG5tS8BDGJY1KvlIpgKYC/rPeyQXYS87EoN5703GVqPxNDZhagySgo0Rb74xqeIbYXo3
 oGUxTQvmbFmKZuZl62Ic39WD2pFfiMJpBwTVlI/hNEik+mtmBxi0ZogVjQtSVVyFApU04tPOhH
 14fTWj2pRf1szLJa8BdiZcI3Z8PL1YDnYWd0XQOC5NkVmjMlbg6MAB6igBx8Ru1xq2y4NMQIbb
 BrycJb14xMr6/1XBa9enwv2K
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2022 19:13:42 -0700
IronPort-SDR: ozSZ8qx8Rajmx9f0wXjBlgIggPqlCOC4/oM81TnuGWwO5EWep2LwtzXtkz31muinehPmOKc7hM
 9tMSY6lyGNpJtC7n8lnyWu9kYj503bwBZ0MRXH0SxhO8AI8mWdhjEr1l1T2OpAk3RLUmhERUem
 GRI3kIHyNQwcEJ3fiV4c+5DOXoH9+OKtAsvc8YUYfiK1yAI8oNiD8vRAg3UfKSRK/OwVBr2BF1
 oAyFPqADOdzVaeTnFtDcs8at81tBbIO8Uzb6MOPVZX1wFBttJDj10zChxpcmJ3mFFyLxajK1UU
 VG8=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jul 2022 19:52:17 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2] common/cpuhotplug: allow _offline_cpu() call in sub-shell
Date:   Tue, 19 Jul 2022 11:52:16 +0900
Message-Id: <20220719025216.1395353-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The helper function _offline_cpu() sets a value to RESTORE_CPUS_ONLINE.
However, the commit bd6b882b2650 ("block/008: check CPU offline failure
due to many IRQs") put _offline_cpu() call in sub-shell, then the set
value to RESTORE_CPUS_ONLINE no longer affects function caller's
environment. This resulted in off-lined CPUs not restored by _cleanup()
when the test case block/008 calls only _offline_cpu() and does not call
_online_cpu().

To fix the issue, set RESTORE_CPUS_ONLINE in _have_cpu_hotplug() in
place of _offline_cpu(). _have_cpu_hotplug() is less likely to be called
in sub-shell. In same manner, do not set RESTORE_CPUS_ONLINE in
_online_cpu() either. Check that RESTORE_CPUS_ONLINE is set in
_offline_cpu() to avoid unexpected CPUs left off-lined. This check also
avoids a shellcheck warning.

Fixes: bd6b882b2650 ("block/008: check CPU offline failure due to many IRQs")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v1:
* Change fix approach: fix _offline_cpu() instaed of block/008 test script.

 common/cpuhotplug | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/common/cpuhotplug b/common/cpuhotplug
index 7facd0d..e91c3bc 100644
--- a/common/cpuhotplug
+++ b/common/cpuhotplug
@@ -27,17 +27,20 @@ _have_cpu_hotplug() {
 		SKIP_REASONS+=("CPU hotplugging is not supported")
 		return 1
 	fi
+
+	RESTORE_CPUS_ONLINE=1
 	return 0
 }
 
 _online_cpu() {
-	# shellcheck disable=SC2034
-	RESTORE_CPUS_ONLINE=1
 	echo 1 > "/sys/devices/system/cpu/cpu$1/online"
 }
 
 _offline_cpu() {
-	# shellcheck disable=SC2034
-	RESTORE_CPUS_ONLINE=1
+	if [[ -z ${RESTORE_CPUS_ONLINE} ]]; then
+		echo "offlining cpu but RESTORE_CPUS_ONLINE is not set"
+		return 1
+	fi
+
 	echo 0 > "/sys/devices/system/cpu/cpu$1/online"
 }
-- 
2.36.1

