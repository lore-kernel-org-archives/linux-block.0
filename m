Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D93C146588
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 01:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763689031; cv=none; b=ApVEEGMNI/PSxTkAj9Dd3sFGdgvsuJqHBWSwwU3Vm98R+vBKxnUmsc6SH4aNtVkKjUYsUOFITYPOMhU4GXRMwnZj0E0gslcT5QHnIFA1yniIzW1IAlg6DaiAfxOOi/4aQnetuWy9I+OJYrVCtla+spl9tCbnrnPfyG+CPz3zV8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763689031; c=relaxed/simple;
	bh=Uc7jIkrMgAl9SH4f+7NR2MK8dm0clE7gu5zabJEqs54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VGpmzsV6GgM4aFx9giFBvPF3inMf5Kp2zjGDNB3QHVq59m6YVaBBVP7IWFBSjk2SydTamRdbi3+UsoBYQZdV/3Z8ylhTyuka+jHujoq2sESk+3QUR8vafv6PhkBdHSERCqKuEL+YwefdRfJF/wwgP7ge5Fr1iaXWwmGTjT0BnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=RDF1FEP+; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="RDF1FEP+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1763689030; x=1795225030;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Uc7jIkrMgAl9SH4f+7NR2MK8dm0clE7gu5zabJEqs54=;
  b=RDF1FEP+mLSkLnVxe5tS6cWjLcY9OZPlveDsbawZu24Fl5UevgAilcAa
   jF7Yb9CYWo8CYteMVM0PwgJzpthVu5YcW1ZhnVj7jCR8ikuy2g2MFQSpS
   F6FwX2sfinLp6LQ71W4LNexh5olwxkUv3YKVNfGmJGlFq0LXdyL6Atfe0
   nyRwD1CUaAnit6GaHLRVZHaPrv2DveNGYjeAcwSXCSG3/c4Rm5URCkWUa
   i4wfk2mkZ6WnNubNgNi53xrDnqrjbjFCqc2d+55vcAcudF7gr7/DxycWF
   7My9Tq0jriEke4uoTNmN4RqgWJkK6ZOH6ktv1rnNxhUPtdy+xkyI2HpbL
   A==;
X-CSE-ConnectionGUID: CGM6vfnzSJmbHsiW0DsGqg==
X-CSE-MsgGUID: 0OmboDmhSXOeEl19LMVH+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="219922714"
X-IronPort-AV: E=Sophos;i="6.20,214,1758553200"; 
   d="scan'208";a="219922714"
Received: from unknown (HELO az2nlsmgr3.o.css.fujitsu.com) ([51.138.80.169])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 10:36:00 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr3.o.css.fujitsu.com (Postfix) with ESMTPS id 7576B1000353
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 01:36:00 +0000 (UTC)
Received: from az2nlsmom1.o.css.fujitsu.com (az2nlsmom1.o.css.fujitsu.com [10.150.26.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id 363311809AD9
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 01:36:00 +0000 (UTC)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by az2nlsmom1.o.css.fujitsu.com (Postfix) with ESMTP id 9BCDB829F00;
	Fri, 21 Nov 2025 01:35:57 +0000 (UTC)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH blktests] test/throtl: Adjust scsi_debug sector_size for large PAGE_SIZE hosts
Date: Fri, 21 Nov 2025 09:38:20 +0800
Message-ID: <20251121013820.3854576-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, `scsi_debug` only supported a maximum `sector_size` of 4096
bytes. However, on systems with a `PAGE_SIZE` greater than 4KB, some
`throtl` tests (002, 003, and 007) attempt to load `scsi_debug`
with `sector_size=$PAGE_SIZE`.

This mismatch causes `scsi_debug` module loading to fail, resulting in
test failures such as:

throtl/003 (sdebug) (bps limit over IO split)                [failed]
    runtime  0.147s  ...  0.146s
    --- tests/throtl/003.out    2025-04-04 04:36:43.175999880 +0800
    +++ /root/blktests/results/nodev_sdebug/throtl/003.out.bad  2025-11-16 09:26:07.287964459 +0800
    @@ -1,4 +1,3 @@
     Running throtl/003
    -1
    -1
    -Test complete
    +modprobe: ERROR: could not insert 'scsi_debug': Invalid argument
    +Loading scsi_debug dev_size_mb=1024 sector_size=65536 failed

To address this, introduce a `fixup_sedebug_sector_size` helper function.
This function checks the requested `sector_size` for `scsi_debug`. If the
value exceeds 4096, it defaults to a supported value of 2048 to ensure
successful module loading and test execution on hosts with larger
`PAGE_SIZE`.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tests/throtl/rc | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/throtl/rc b/tests/throtl/rc
index d1afefd..fd83fb9 100644
--- a/tests/throtl/rc
+++ b/tests/throtl/rc
@@ -41,6 +41,17 @@ _set_throtl_blkdev_type() {
 	COND_DESC="${throtl_blkdev_type}"
 }
 
+# Only 512, 1024, 2048, 4096 are supported, see drivers/scsi/scsi_debug.c
+fixup_sdebug_sector_size() {
+	local sector_size=$1
+
+	if [[ $sector_size -gt 4096 ]]; then
+		echo 2048
+	else
+		echo $sector_size
+	fi
+}
+
 # Prepare null_blk or scsi_debug device to test, based on throtl_blkdev_type.
 _configure_throtl_blkdev() {
 	local sector_size=0 memory_backed=0
@@ -76,7 +87,8 @@ _configure_throtl_blkdev() {
 		;;
 	sdebug)
 		args=(dev_size_mb=1024)
-		((sector_size)) && args+=(sector_size="${sector_size}")
+		((sector_size)) &&
+		args+=(sector_size="$(fixup_sdebug_sector_size $sector_size)")
 		if _configure_scsi_debug "${args[@]}"; then
 			THROTL_DEV=${SCSI_DEBUG_DEVICES[0]}
 			return
-- 
2.44.0

