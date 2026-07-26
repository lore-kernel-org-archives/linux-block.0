Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA32333442
	for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 05:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785043967; cv=none; b=mGD/ns8lY9hB5YhQMTFz+6N5+D32gGaHkQWMsZx0dndafvSBjwop99YUY7xziOR4VMBNA6Ycbzts3Lp1bK6NKLtjdcu+ZtQm1vEM/6CEoaAA6z1UtEjKGmY32fAAq4zxAwGwxeoc2oF5t6jmGTEa9m9t+ox//uqphu3Wlh2FjDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785043967; c=relaxed/simple;
	bh=yDaDKIXcjR/tHALfTbXDKvlW0AUiNBJvtqIXZ74UsnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wjd4p19HIhx/W2+nFHL6WRtIEk1lIp+cTqrLRX5NLHOa1ASvsxEtpP9lqTZxpJ6KbyANkrZ9b3GZHjHlcWopZKiJ6Ly0MIB5y4ID/YMC4zY3Gm0Tx0LuRRrP/knFW5bzNFK1mdpAnjCSsY1XJAyzuycD0FqiY3m3sOc1LXIJemk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nwUNgK9t; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nwUNgK9t"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1785043969; x=1816579969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yDaDKIXcjR/tHALfTbXDKvlW0AUiNBJvtqIXZ74UsnM=;
  b=nwUNgK9toDplnvy+aTormEgzPYmd0ysZusOkXhhjD1pGOZHR5R0EiulS
   IcODHwLgI/j9SJqrWAfEOVDX4CcZtWjR6qRmERIXXN7gRaZSlcHXhkNXb
   uZAIMed3z54N1hk1RYUnbk/rUtcfQp/8ui0Ow8Nr4sF37AMn3yw7eDEBq
   FkIzGd75Pkeyxo0xaTpvgtrouap9i+YUJtWK+tuNI1KZEjPWrzb1rQHoL
   pZ+xE94rnp2ClahzISn2Nt23YqY7C8ojv4zaf8nP3iK0yQIWa9aHsW6by
   pXNE3PJ7Yv/RUirEtbioBZw0g2NCvOQP0BvMwgKCwD4dmSP7+fLPwQ6Rv
   A==;
X-CSE-ConnectionGUID: GV2hNg6ASxWLj8s1h8Yw2g==
X-CSE-MsgGUID: GtIxYSkQTX2S3UngDnWGkA==
X-IronPort-AV: E=Sophos;i="6.25,185,1779120000"; 
   d="scan'208";a="150242811"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2026 13:32:41 +0800
X-CSE-ConnectionGUID: 66znzAdpT66jVxhujKb7jg==
X-CSE-MsgGUID: WuTIGNraS0O4phSB+1+QDQ==
IronPort-SDR: 6a659bda_Bdgknvxfw44goFQB+PoiwXoE1QNe23o0H//gRb8Io5n91d6
 uGiCWqhPbrBO7+lestgNWFylXL7CNch3YslH+Gg==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2026 22:32:10 -0700
X-CSE-ConnectionGUID: +iKFxk4FStmlc4vomIaZiA==
X-CSE-MsgGUID: eQP/9jwXQeymL608VTnk1g==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai2-o.wdc.com with ESMTP; 25 Jul 2026 22:32:10 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/3] check: introduce _write_queue_sched() to repeat queue/scheduler writes
Date: Sun, 26 Jul 2026 14:32:06 +0900
Message-ID: <20260726053207.1673066-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260726053207.1673066-1-shinichiro.kawasaki@wdc.com>
References: <20260726053207.1673066-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the kernel commit 4ff58d6bc9dd ("block: serialize elevator changes
for the same queue using a writer lock"), concurrent writes to the sysfs
attribute file queue/scheduler of single block device may fail with
-EBUSY. Such failure is observed when udevd writes to the file while
block/005 is running. The write failure causes blktests test case
failures. To avoid it, check the error of the writes, and if the error
is -EBUSY, retry the write.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/check b/check
index 61524a5..e7eca84 100755
--- a/check
+++ b/check
@@ -385,6 +385,28 @@ _output_test_run() {
 	fi
 }
 
+# Writes to queue/scheduler may fail with -EBUSY when udevd does concurrent
+# write. Retry the writes when -EBUSY is returned.
+_write_queue_sched() {
+	local value="$1"
+	local path="$2"
+	local log
+	local i
+
+	for ((i = 0; i < 5; i++)); do
+		if log=$({ echo "$value" > "$path" ;} 2>&1); then
+			break
+		fi
+		if [[ ! $log =~ "Device or resource busy" ]]; then
+			echo "$log"
+		fi
+	done
+	if ((i > 5)); then
+		echo "echo ${value} > ${path} failed"
+		return 1
+	fi
+}
+
 _register_test_cleanup() {
 	TEST_CLEANUP=$1
 }
@@ -402,7 +424,7 @@ _cleanup() {
 	local key value
 	for key in "${!SYSFS_QUEUE_SAVED[@]}"; do
 		value="${SYSFS_QUEUE_SAVED["$key"]}"
-		echo "$value" >"${key}"
+		_write_queue_sched "$value" "${key}"
 		unset "SYSFS_QUEUE_SAVED[$key]"
 	done
 
-- 
2.54.0

