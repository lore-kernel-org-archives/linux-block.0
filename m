Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6613A5431
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774331421; cv=none; b=YIdybCmEz1goit8U2P6pnv1kcERcVXQO4to4skTToLV669nT3p4PHG3BNws9ugFA+Y3rLzvmm6X8jdWos1Z4sbQBsS+VRttupaJXkVsvoMf/2v+sTIkaeZvBjTQr0rbMq2bJelzpE9vS3rs648Kf6NCBU9Xk9r1hxxphayL9d/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774331421; c=relaxed/simple;
	bh=Eu7+uMG3CNJc1h9yN6TtORzSy4VDV2+yZOkUd3gdMng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Me8WqzldrUfaVKphmS7nNWnSuvTLNjJ8ALQQl6V5Lm6VoTqHV16u2PEpuEbMIZgqKOlAx2QPO938fQC3FWerXNw5w/RFGvdsGy08jORCXQJdoMcmxjMpMa6lXiZepTgvkntCR+jYN735xjt7VFWJQqFjFuHa8uqPowNNxBHoV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=S9YIjsKx; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S9YIjsKx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1774331418; x=1805867418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eu7+uMG3CNJc1h9yN6TtORzSy4VDV2+yZOkUd3gdMng=;
  b=S9YIjsKxE59Z+Pb3xoooUwIP2bm0qLVpDDIPO8j/+loH9UX3DkCDRiNc
   yWhmMG1EZ8KO+MLqQDziKS24u8iNj2sygQgqTufRECz9j60aFhbtSy9KG
   6/gMJqza9tVjK85ODsvOaPd2JziPAT9ckofdHgfmqQqcE78GUPUFvxATb
   utNkSKQNC3c8qPO8mjjjcndcKQ1vDYi+pK9azgXidASEhlNhLZMunDutw
   eTP+R/TbNDUVfZ1iT6xDYAy8O7IrWDV7tQeLc46U2PwTTPC7QjQfuWYfT
   L4nG5lKryiiwZBA1Ld7Ih9vTrzbXWiTRbYU+sS5J9wtdSf4jQgyuB2LI+
   w==;
X-CSE-ConnectionGUID: z1/3reEvQWutDeyfJ4Yh/g==
X-CSE-MsgGUID: 1mk5WWZfTC2RLKrWW87osQ==
X-IronPort-AV: E=Sophos;i="6.23,138,1770566400"; 
   d="scan'208";a="143614098"
Received: from unknown (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2026 13:50:07 +0800
IronPort-SDR: 69c22600_2+mipLoYPSsrSPkWr0ffPlJgXTjxnkz0UK3yqkSt5jKHEOW
 qcjltpCUoO167To1qkOmxpXRrsAjAUxqokMB+Rg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2026 22:49:53 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Mar 2026 22:49:53 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/7] check: do not create fallback device when other requirements are not met
Date: Tue, 24 Mar 2026 14:49:45 +0900
Message-ID: <20260324054949.3821569-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260324054949.3821569-1-shinichiro.kawasaki@wdc.com>
References: <20260324054949.3821569-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, fallback devices are prepared regardless of whether other
requirements are fulfilled. This is not always desired. For example,
when users already created scsi_debug devices, it is not good to create
a fallback scsi_debug device, because it unloads scsi_debug module and
remove the scsi_debug devices users created. To prevent such scenario,
confirm requirements by checking skip reasons before creating fallback
devices.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/check b/check
index 91064d7..fdc7ba7 100755
--- a/check
+++ b/check
@@ -721,6 +721,11 @@ _check_and_call_test_device() {
 	[[ -n $COND_DESC ]] && postfix=_${COND_DESC//[ =]/_}
 	for TEST_DEV in "${TEST_DEVS[@]}"; do
 		if [[ $TEST_DEV == fallback ]]; then
+			if [[ -v SKIP_REASONS ]]; then
+				_output_notrun "$TEST_NAME"
+				return 0
+			fi
+
 			if ! TEST_DEV=$(fallback_device); then
 				_warning "$TEST_NAME: fallback_device call failure"
 				return 0
-- 
2.49.0

