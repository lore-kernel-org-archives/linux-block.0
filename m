Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278E1B974
	for <linux-block@vger.kernel.org>; Fri,  7 Jun 2024 05:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717738116; cv=none; b=cSl7cjY/5kPwfldF6yc0y2h4558gb/TNXm2lnUH4QxHM2mPNBZWuAbFJhh8IiGC+N0CelyWpz+zn3YKTOxu0iNSDJgc2VS9AwnzE7sZt6OXKys2TGBBZJK7ND9TvS54U6Ya8VDllz0U1rkoFD1R3ZNzFp7BEhc3qoei+XrnE70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717738116; c=relaxed/simple;
	bh=NveE7PPjdZ01AdU+QaASlmnBOhAaQEOvYc0b9IrC3sY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P92WPnO952kxRmmFh0R6K74qvJ2KHXUXIl0uDv5EwOThOZMQrEMwSWKJPLWY9SDN8JgA2sW/E//5hZRy1IlhRvV1m3ES3xNejnqW5Zaahzj0Rcl0ai4/wjQVqrPocIYa197bHwktQMYkpzQT8fP67KxWTJDjeRbWfZhnqde9+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fMPz7PLB; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fMPz7PLB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717738114; x=1749274114;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NveE7PPjdZ01AdU+QaASlmnBOhAaQEOvYc0b9IrC3sY=;
  b=fMPz7PLB0abvxaiUda0jHwSb01OMqOFt9QIDrl/3ufxQpYdUNfd9Rn/L
   6aMud6uRtP8zvvHV5ZZue2piGIppfhtMIYeKmozm4tv1SO9GK32CU/AMO
   HeFnsl2giyPyE4FU7X6UUyloH5VjWYAzSVrA58p5n1mYFuKQH6Px1LSCb
   8cJMRLLKVqzpQKq4RMKJH/5bAQCjKA5j2G8usLddeed3AIZvE/4y6RkIw
   tXKgOovnkcmwxn3QKMT3BOC1VdjlKqcj43UVyoE7hWWOL64fE70dHl4m9
   2gF+nk8RSGDsIylWje+IaFlgmfyBNtoBtghdRAJqD/vw94JFR/XI3DSaD
   A==;
X-CSE-ConnectionGUID: hRBdf4eMS0CMtJKMcAE2TA==
X-CSE-MsgGUID: FCjg9pQqR8KPGrVHV24v5A==
X-IronPort-AV: E=Sophos;i="6.08,220,1712592000"; 
   d="scan'208";a="18771149"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2024 13:28:27 +0800
IronPort-SDR: 66628ccc_cWr8YIz48zg6MOFrrHh1HwcTK991frns36VOyu8Z0543ITB
 0YXmoMzNCe8kHadMHK2Nzds+dYmYUEJS/yfzXWw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2024 21:30:05 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jun 2024 22:28:26 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	nbd@other.debian.org
Cc: Sun Ke <sunke32@huawei.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nbd/004: drop the check for "couldn't allocate config" message
Date: Fri,  7 Jun 2024 14:28:26 +0900
Message-ID: <20240607052826.249014-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case nbd/004 was created to confirm the fix by the kernel
commit 06c4da89c24e ("nbd: call genl_unregister_family() first in
nbd_cleanup()"). Originally, the test case was created to check that the
kernel commit avoided a BUG. But the BUG was not recreated on my system
even without the kernel commit, so I was not able to confirm that the
test case was working as expected. On the other hand, I found that the
kernel commit avoided the two other kernel messages "couldn't allocate
config" and "cannot create duplicate filename" on my test system. Then I
suggested adding the checks for those messages to the test case, and the
checks were added [1].

However, it turned out that the kernel commit did not totally avoid the
message "couldn't allocate config". The test case still makes the kernel
report the message with a low ratio. The failure is recreated when the
test case is repeated around 30 times. The CKI project reported that
nbd/004 fails due to the message [2].

When the failure happens, try_module_get() fails in nbd_genl_context():

nbd_genl_connect()
 nbd_alloc_and_init_config()
  try_module_get()            ... fails

This try_module_get() call checks that the module is not unloaded during
the connect operation. The test case does "module load/unload
concurrently with connect/disconnect" then the try_module_get() failure
is expected. It means the failure is false-positive.

Drop the wrong check for "couldn't allocate config" message. Still keep
the check for "cannot create duplicate filename".

[1] https://lore.kernel.org/linux-block/20220707124945.c2rd677hjwkd7mim@shindev/
[2] https://github.com/osandov/blktests/issues/140

Fixes: 349eb683fd06 ("nbd: add a module load and device connect test")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nbd/004 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nbd/004 b/tests/nbd/004
index 1758859..a866ea5 100755
--- a/tests/nbd/004
+++ b/tests/nbd/004
@@ -50,8 +50,8 @@ test() {
 
 	_stop_nbd_server_netlink
 
-	if _dmesg_since_test_start | grep -q -e "couldn't allocate config" \
-		-e "cannot create duplicate filename"; then
+	if _dmesg_since_test_start | \
+			grep --quiet "cannot create duplicate filename"; then
 			echo "Fail"
 	fi
 
-- 
2.45.0

