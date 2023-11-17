Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CwoaKeiJ"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD01CE
	for <linux-block@vger.kernel.org>; Fri, 17 Nov 2023 04:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700222755; x=1731758755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iuYnZZ5x+m52xnq562/ihVwo+5QcU88vr1++Wc5eE8A=;
  b=CwoaKeiJgqVeKHwbr2uv0zeeUBX3+WSI14X8x9Tl9eNl6YfL+yDXuRJ7
   khiwKtJAUWhFxPfNED95R4rcugn2n0ZaFY8GC6WAFQyVL2rDos/ELhKRH
   oxXgEomxi99VhcQGqyuEQAaT7PZ06QpWK67N7i4a3CtPD0Rom7gJgLXXe
   DL+ecCL3DnHp6jRLcLXWZ2aKg79Hd1+Z6FBAjCEHo/S04gYOyYcLyAsZn
   +psL9Fg18yCj7G4aoAGFANKqJNwhxYrDLVWKsmnpk3tZ23cCPaRFZJNo6
   xecoAWybKFOJM7NhJMc1BsQtTjn7vBlnQIUEERP2HqfRKixBqVg69hRNa
   w==;
X-CSE-ConnectionGUID: MptpsSehQdSdGyaEjF/0Bg==
X-CSE-MsgGUID: KXXijhnOQ/qChinN8Zgh/w==
X-IronPort-AV: E=Sophos;i="6.04,206,1695657600"; 
   d="scan'208";a="2575197"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2023 20:05:54 +0800
IronPort-SDR: LSWF7VLeAQZwGsOADn4BUe6tKzzQ8uatTQlWAE7ZNL5hvPvFgGLLTAAB5Mrhl9UI1mrTzU/ukG
 E+gJTQksYbhiaadulmrkiAsdpm72VKrsVda8bhi2IJ3S81u9JTgMGhjzrcnAYadG9pg2PPcO8l
 3GpHOMI3eenDvxJmYbiUKgA9G5Ytdfs2jjBUS6MPeoLlNgQtEsT3EBaYDZwlU8V9gVVay/aHNq
 INCbSA83yd4Dn7XrO3WlRf1VaGCUyhMkOs6fxxUjmeTlCdgpJH5wTO4upCIL8Uh1v2Mf7GeKod
 9tU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2023 03:11:37 -0800
IronPort-SDR: prqoUH4AvALcF4lMZkLMwcFKpQaWkFwN21HEk+/klmxiCSWabMz+BYYe72NQqlvX8nBBvNZOAp
 /tSoLON524UujyOgf320zNorcaaI8DqHBiwvqM6YArILOCU8MryjXUZ4YX5243CtI0yp758Sqw
 xSx6J9xvvlqgGU5dFSPdB/q6M8BM1lXEExhY87ff8IeMsKZM951cP0tQBdur85KNMtWVN03HTZ
 ehcG8BLsKZURqisV5b3jMx6fFx4PcnG/CEoH5anCguV/zl75V2im1PvvPPDdc6651lbx43+MgA
 GJM=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Nov 2023 04:05:53 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagern@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 2/2] nvme: do not print subsystem NQN to stdout
Date: Fri, 17 Nov 2023 21:05:50 +0900
Message-ID: <20231117120550.2993743-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117120550.2993743-1-shinichiro.kawasaki@wdc.com>
References: <20231117120550.2993743-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@suse.de>

The subsystem NQN might be changed from the default value, but
that shouldn't cause the tests to fail. So don't register the
subsystem NQN in the 'out' files to avoid a false positive.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[Shin'ichiro: remove only subsystem NQN from nvme disconnect message]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/003.out |  2 +-
 tests/nvme/004.out |  2 +-
 tests/nvme/008.out |  2 +-
 tests/nvme/009.out |  2 +-
 tests/nvme/010.out |  2 +-
 tests/nvme/011.out |  2 +-
 tests/nvme/012.out |  2 +-
 tests/nvme/013.out |  2 +-
 tests/nvme/014.out |  2 +-
 tests/nvme/015.out |  2 +-
 tests/nvme/018.out |  2 +-
 tests/nvme/019.out |  2 +-
 tests/nvme/020.out |  2 +-
 tests/nvme/033.out |  2 +-
 tests/nvme/034.out |  2 +-
 tests/nvme/035.out |  2 +-
 tests/nvme/036.out |  2 +-
 tests/nvme/041.out |  4 ++--
 tests/nvme/042.out | 14 +++++++-------
 tests/nvme/043.out | 16 ++++++++--------
 tests/nvme/044.out |  8 ++++----
 tests/nvme/045.out |  2 +-
 tests/nvme/048.out |  2 +-
 tests/nvme/rc      |  3 ++-
 24 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/tests/nvme/003.out b/tests/nvme/003.out
index beb3561..dc45bc4 100644
--- a/tests/nvme/003.out
+++ b/tests/nvme/003.out
@@ -1,3 +1,3 @@
 Running nvme/003
-NQN:nqn.2014-08.org.nvmexpress.discovery disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/004.out b/tests/nvme/004.out
index 2559905..177185d 100644
--- a/tests/nvme/004.out
+++ b/tests/nvme/004.out
@@ -1,3 +1,3 @@
 Running nvme/004
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/008.out b/tests/nvme/008.out
index 62342e7..f7411f8 100644
--- a/tests/nvme/008.out
+++ b/tests/nvme/008.out
@@ -1,3 +1,3 @@
 Running nvme/008
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/009.out b/tests/nvme/009.out
index 853663f..4d53a8e 100644
--- a/tests/nvme/009.out
+++ b/tests/nvme/009.out
@@ -1,3 +1,3 @@
 Running nvme/009
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/010.out b/tests/nvme/010.out
index 90468f5..18b52d8 100644
--- a/tests/nvme/010.out
+++ b/tests/nvme/010.out
@@ -1,3 +1,3 @@
 Running nvme/010
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/011.out b/tests/nvme/011.out
index a780def..ebbb4f7 100644
--- a/tests/nvme/011.out
+++ b/tests/nvme/011.out
@@ -1,3 +1,3 @@
 Running nvme/011
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/012.out b/tests/nvme/012.out
index ec4bea8..5074d3b 100644
--- a/tests/nvme/012.out
+++ b/tests/nvme/012.out
@@ -1,3 +1,3 @@
 Running nvme/012
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/013.out b/tests/nvme/013.out
index 10b78ec..a727170 100644
--- a/tests/nvme/013.out
+++ b/tests/nvme/013.out
@@ -1,3 +1,3 @@
 Running nvme/013
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/014.out b/tests/nvme/014.out
index c431864..a6f98a3 100644
--- a/tests/nvme/014.out
+++ b/tests/nvme/014.out
@@ -1,4 +1,4 @@
 Running nvme/014
 NVMe Flush: success
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/015.out b/tests/nvme/015.out
index 829cf40..f854f0b 100644
--- a/tests/nvme/015.out
+++ b/tests/nvme/015.out
@@ -1,4 +1,4 @@
 Running nvme/015
 NVMe Flush: success
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/018.out b/tests/nvme/018.out
index 6b0e814..94b937a 100644
--- a/tests/nvme/018.out
+++ b/tests/nvme/018.out
@@ -1,3 +1,3 @@
 Running nvme/018
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/019.out b/tests/nvme/019.out
index a52325f..710f15a 100644
--- a/tests/nvme/019.out
+++ b/tests/nvme/019.out
@@ -1,4 +1,4 @@
 Running nvme/019
 NVMe DSM: success
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/020.out b/tests/nvme/020.out
index 9e293ab..61be280 100644
--- a/tests/nvme/020.out
+++ b/tests/nvme/020.out
@@ -1,4 +1,4 @@
 Running nvme/020
 NVMe DSM: success
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/033.out b/tests/nvme/033.out
index eb508be..c9614cc 100644
--- a/tests/nvme/033.out
+++ b/tests/nvme/033.out
@@ -1,3 +1,3 @@
 Running nvme/033
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/034.out b/tests/nvme/034.out
index 0a7bd2f..e342d97 100644
--- a/tests/nvme/034.out
+++ b/tests/nvme/034.out
@@ -1,3 +1,3 @@
 Running nvme/034
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/035.out b/tests/nvme/035.out
index a602713..8cbdea4 100644
--- a/tests/nvme/035.out
+++ b/tests/nvme/035.out
@@ -1,3 +1,3 @@
 Running nvme/035
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/036.out b/tests/nvme/036.out
index d294f86..c14b0e1 100644
--- a/tests/nvme/036.out
+++ b/tests/nvme/036.out
@@ -1,3 +1,3 @@
 Running nvme/036
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/041.out b/tests/nvme/041.out
index efee74c..1d0a5cd 100644
--- a/tests/nvme/041.out
+++ b/tests/nvme/041.out
@@ -1,6 +1,6 @@
 Running nvme/041
 Test unauthenticated connection (should fail)
-NQN:blktests-subsystem-1 disconnected 0 controller(s)
+disconnected 0 controller(s)
 Test authenticated connection
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/042.out b/tests/nvme/042.out
index 7d3d21a..e042095 100644
--- a/tests/nvme/042.out
+++ b/tests/nvme/042.out
@@ -1,16 +1,16 @@
 Running nvme/042
 Testing hmac 0
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing hmac 1
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing hmac 2
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing hmac 3
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing key length 32
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing key length 48
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing key length 64
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/043.out b/tests/nvme/043.out
index 7419f91..a4a9a66 100644
--- a/tests/nvme/043.out
+++ b/tests/nvme/043.out
@@ -1,18 +1,18 @@
 Running nvme/043
 Testing hash hmac(sha256)
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing hash hmac(sha384)
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing hash hmac(sha512)
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing DH group ffdhe2048
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing DH group ffdhe3072
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing DH group ffdhe4096
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing DH group ffdhe6144
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing DH group ffdhe8192
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/044.out b/tests/nvme/044.out
index 53fdbe1..58f296d 100644
--- a/tests/nvme/044.out
+++ b/tests/nvme/044.out
@@ -1,10 +1,10 @@
 Running nvme/044
 Test host authentication
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test invalid ctrl authentication (should fail)
-NQN:blktests-subsystem-1 disconnected 0 controller(s)
+disconnected 0 controller(s)
 Test valid ctrl authentication
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test invalid ctrl key (should fail)
-NQN:blktests-subsystem-1 disconnected 0 controller(s)
+disconnected 0 controller(s)
 Test complete
diff --git a/tests/nvme/045.out b/tests/nvme/045.out
index 48f7e6b..84a69ef 100644
--- a/tests/nvme/045.out
+++ b/tests/nvme/045.out
@@ -8,5 +8,5 @@ Change DH group to ffdhe8192
 Re-authenticate with changed DH group
 Change hash to hmac(sha512)
 Re-authenticate with changed hash
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/048.out b/tests/nvme/048.out
index 7f986ef..c1c0979 100644
--- a/tests/nvme/048.out
+++ b/tests/nvme/048.out
@@ -1,3 +1,3 @@
 Running nvme/048
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 4452274..34a144f 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -430,7 +430,8 @@ _nvme_disconnect_ctrl() {
 _nvme_disconnect_subsys() {
 	local subsysnqn="$1"
 
-	nvme disconnect -n "${subsysnqn}"
+	nvme disconnect -n "${subsysnqn}" |& tee -a "$FULL" |
+		grep -o "disconnected.*"
 }
 
 _nvme_connect_subsys() {
-- 
2.41.0

