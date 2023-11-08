Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D6553A6
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZZiRpdU2"
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70861A5
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 22:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699426078; x=1730962078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9P7VeZSXy3Mm8PWse3SUibjGbadadqfb5RfNV3flLyw=;
  b=ZZiRpdU2s/NVqRXnwhHJdZj13n20Mrrn+Y6oAutki8CPtGGBsy7iqkPy
   uJUKAw9teeDeCE7FvNiSZApxrDlf9BEbhRo0Dne9iSi9qS+blPO2KgU4c
   S9B6FkL4Oj1oqpFfRRMRx65wj2FRD+/8eflBi+vwp80uIE0hnRp54mTAj
   HR8G0U7wlvqHnxKpbUAK5xxS7m4/qg5zBB4CI57Jul2Cv/5/NRwkmwzul
   MAbmv8bVBc54BiTqud/JO61Saori1KXRi/FsEli0kV5ggyF6BVppldb9O
   AiIMgds9YwkpzoccYUrojUUfWWXqRxTBMFmAGz4xo/brMnX3jvrAioPIt
   A==;
X-CSE-ConnectionGUID: MrrmMIYQTlOQgQGaFJCNvg==
X-CSE-MsgGUID: E+sDUdc7SuK4RlOt3RblPQ==
X-IronPort-AV: E=Sophos;i="6.03,285,1694707200"; 
   d="scan'208";a="1616008"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2023 14:47:57 +0800
IronPort-SDR: 8I7pexfyZtkHgEmvuabra3v9qvmRi0ZvuQVNzTdbS8RIYzP8gyUjYWxVClBt0Q0p8KkbC4/Y2K
 DluOhDCjSR1S4qmVDe5DwbcVxR4CR6eK+UJ9t6qZjwKn54IGmpKWbWePqgKkWOf3NlTluBUQG+
 ZwZdbpax/vzrnDmJ9poMAuxvdgIAbpu5fcp/vc6JsrngNo2VvlatdbfOUhIPcnima0w/r5YTdZ
 R1adTAz4m+wQbAEUaY+KX2yaNgnvD1TNW+5SaIazk8ymQHjlvk6kaZqYxxTNjJexiMT5qZuHC3
 cq8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2023 21:53:52 -0800
IronPort-SDR: r6xzVcNoPcKT6vnMNluwe0x1fG2OU3SsBOnq3ZePBjxMGSyhqZUNoZevgLhiE9houLSTuvTDQ2
 Is4CLmkn2UdvvXsDr89If8cSm9Ed1GhWNRkWUDjzrhMpZFORkJP8gwlp5Vbie1D+bXBcLWyeM+
 GWTdUdfQ8T3fklKpzaWpiA3sLct5oZ4UaWjRqGkkUkMFWvd0zjxYbsTxmTPuyPov5RbJJT7UG7
 l38CIgCYvomZbniEgNNz8yc1RVcw5f27EJX/if4L0WPX9o/WxLrw4N5Iot48WPOF2Dn4FJR/1A
 9+s=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2023 22:47:57 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagern@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/2] nvme: do not print subsystem NQN to stdout
Date: Wed,  8 Nov 2023 15:47:53 +0900
Message-ID: <20231108064753.1932632-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231108064753.1932632-1-shinichiro.kawasaki@wdc.com>
References: <20231108064753.1932632-1-shinichiro.kawasaki@wdc.com>
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
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/003.out | 1 -
 tests/nvme/004.out | 1 -
 tests/nvme/008.out | 1 -
 tests/nvme/009.out | 1 -
 tests/nvme/010.out | 1 -
 tests/nvme/011.out | 1 -
 tests/nvme/012.out | 1 -
 tests/nvme/013.out | 1 -
 tests/nvme/014.out | 1 -
 tests/nvme/015.out | 1 -
 tests/nvme/018.out | 1 -
 tests/nvme/019.out | 1 -
 tests/nvme/020.out | 1 -
 tests/nvme/021     | 2 +-
 tests/nvme/022     | 2 +-
 tests/nvme/023     | 2 +-
 tests/nvme/024     | 2 +-
 tests/nvme/025     | 2 +-
 tests/nvme/026     | 2 +-
 tests/nvme/027     | 2 +-
 tests/nvme/028     | 2 +-
 tests/nvme/029     | 2 +-
 tests/nvme/031     | 2 +-
 tests/nvme/033.out | 1 -
 tests/nvme/034.out | 1 -
 tests/nvme/035.out | 1 -
 tests/nvme/036.out | 1 -
 tests/nvme/037     | 2 +-
 tests/nvme/041.out | 2 --
 tests/nvme/042.out | 7 -------
 tests/nvme/043.out | 8 --------
 tests/nvme/044.out | 4 ----
 tests/nvme/045.out | 1 -
 tests/nvme/047     | 4 ++--
 tests/nvme/048.out | 1 -
 tests/nvme/rc      | 2 +-
 36 files changed, 14 insertions(+), 54 deletions(-)

diff --git a/tests/nvme/003.out b/tests/nvme/003.out
index beb3561..01b2756 100644
--- a/tests/nvme/003.out
+++ b/tests/nvme/003.out
@@ -1,3 +1,2 @@
 Running nvme/003
-NQN:nqn.2014-08.org.nvmexpress.discovery disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/004.out b/tests/nvme/004.out
index 2559905..1a4e8e4 100644
--- a/tests/nvme/004.out
+++ b/tests/nvme/004.out
@@ -1,3 +1,2 @@
 Running nvme/004
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/008.out b/tests/nvme/008.out
index 62342e7..5661be6 100644
--- a/tests/nvme/008.out
+++ b/tests/nvme/008.out
@@ -1,3 +1,2 @@
 Running nvme/008
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/009.out b/tests/nvme/009.out
index 853663f..f379f7f 100644
--- a/tests/nvme/009.out
+++ b/tests/nvme/009.out
@@ -1,3 +1,2 @@
 Running nvme/009
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/010.out b/tests/nvme/010.out
index 90468f5..2241818 100644
--- a/tests/nvme/010.out
+++ b/tests/nvme/010.out
@@ -1,3 +1,2 @@
 Running nvme/010
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/011.out b/tests/nvme/011.out
index a780def..9822451 100644
--- a/tests/nvme/011.out
+++ b/tests/nvme/011.out
@@ -1,3 +1,2 @@
 Running nvme/011
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/012.out b/tests/nvme/012.out
index ec4bea8..1a0c53e 100644
--- a/tests/nvme/012.out
+++ b/tests/nvme/012.out
@@ -1,3 +1,2 @@
 Running nvme/012
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/013.out b/tests/nvme/013.out
index 10b78ec..ffa7625 100644
--- a/tests/nvme/013.out
+++ b/tests/nvme/013.out
@@ -1,3 +1,2 @@
 Running nvme/013
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/014.out b/tests/nvme/014.out
index c431864..5d1a517 100644
--- a/tests/nvme/014.out
+++ b/tests/nvme/014.out
@@ -1,4 +1,3 @@
 Running nvme/014
 NVMe Flush: success
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/015.out b/tests/nvme/015.out
index 829cf40..0c521bd 100644
--- a/tests/nvme/015.out
+++ b/tests/nvme/015.out
@@ -1,4 +1,3 @@
 Running nvme/015
 NVMe Flush: success
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/018.out b/tests/nvme/018.out
index 6b0e814..8e098d9 100644
--- a/tests/nvme/018.out
+++ b/tests/nvme/018.out
@@ -1,3 +1,2 @@
 Running nvme/018
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/019.out b/tests/nvme/019.out
index a52325f..9e98455 100644
--- a/tests/nvme/019.out
+++ b/tests/nvme/019.out
@@ -1,4 +1,3 @@
 Running nvme/019
 NVMe DSM: success
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/020.out b/tests/nvme/020.out
index 9e293ab..9e2e214 100644
--- a/tests/nvme/020.out
+++ b/tests/nvme/020.out
@@ -1,4 +1,3 @@
 Running nvme/020
 NVMe DSM: success
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/021 b/tests/nvme/021
index 7dc6a41..82a4634 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -33,7 +33,7 @@ test() {
 		echo "ERROR: device not listed"
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/022 b/tests/nvme/022
index c70fbba..adef181 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -33,7 +33,7 @@ test() {
 		echo "ERROR: reset failed"
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/023 b/tests/nvme/023
index 4e4d838..00ea3bc 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -33,7 +33,7 @@ test() {
 		echo "ERROR: smart-log bdev-ns failed"
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/024 b/tests/nvme/024
index 2535a9a..0c4fb6b 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -32,7 +32,7 @@ test() {
 	if ! nvme smart-log "/dev/${nvmedev}" -n 1 >> "$FULL" 2>&1; then
 		echo "ERROR: smart-log file-ns failed"
 	fi
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/025 b/tests/nvme/025
index 46f6197..5b4fbf6 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -33,7 +33,7 @@ test() {
 		echo "ERROR: effects-log failed"
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/026 b/tests/nvme/026
index 5a7d992..9017ade 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -33,7 +33,7 @@ test() {
 		echo "ERROR: ns-desc failed"
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/027 b/tests/nvme/027
index 82b77a9..1a576a8 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -33,7 +33,7 @@ test() {
 		echo "ERROR: ns-rescan failed"
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/028 b/tests/nvme/028
index 0b49e20..874c1da 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -33,7 +33,7 @@ test() {
 		echo "ERROR: list-subsys"
 	fi
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/029 b/tests/nvme/029
index caed0f7..7c68d7f 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -70,7 +70,7 @@ test() {
 	test_user_io "$dev" 511 1023 > "$FULL" 2>&1 || echo FAIL
 	test_user_io "$dev" 511 1025 > "$FULL" 2>&1 || echo FAIL
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/031 b/tests/nvme/031
index ed5f196..a5c3808 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -44,7 +44,7 @@ test() {
 		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
 		_create_nvmet_host "${subsys}$i" "${def_hostnqn}"
 		_nvme_connect_subsys "${nvme_trtype}" "${subsys}$i"
-		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
+		_nvme_disconnect_subsys "${subsys}$i"
 		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
 		_remove_nvmet_subsystem "${subsys}$i"
 		_remove_nvmet_host "${def_hostnqn}"
diff --git a/tests/nvme/033.out b/tests/nvme/033.out
index eb508be..9648c73 100644
--- a/tests/nvme/033.out
+++ b/tests/nvme/033.out
@@ -1,3 +1,2 @@
 Running nvme/033
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/034.out b/tests/nvme/034.out
index 0a7bd2f..5c851b4 100644
--- a/tests/nvme/034.out
+++ b/tests/nvme/034.out
@@ -1,3 +1,2 @@
 Running nvme/034
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/035.out b/tests/nvme/035.out
index a602713..455110c 100644
--- a/tests/nvme/035.out
+++ b/tests/nvme/035.out
@@ -1,3 +1,2 @@
 Running nvme/035
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/036.out b/tests/nvme/036.out
index d294f86..58676b1 100644
--- a/tests/nvme/036.out
+++ b/tests/nvme/036.out
@@ -1,3 +1,2 @@
 Running nvme/036
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/037 b/tests/nvme/037
index a2815b3..b1ebe1e 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -26,7 +26,7 @@ test_device() {
 		nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" \
 				"${subsys}${i}")
 
-		_nvme_disconnect_subsys "${subsys}${i}" >>"${FULL}" 2>&1
+		_nvme_disconnect_subsys "${subsys}${i}"
 		_nvmet_passthru_target_cleanup "${subsys}${i}"
 	done
 
diff --git a/tests/nvme/041.out b/tests/nvme/041.out
index efee74c..1204173 100644
--- a/tests/nvme/041.out
+++ b/tests/nvme/041.out
@@ -1,6 +1,4 @@
 Running nvme/041
 Test unauthenticated connection (should fail)
-NQN:blktests-subsystem-1 disconnected 0 controller(s)
 Test authenticated connection
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/042.out b/tests/nvme/042.out
index 7d3d21a..1c3fc61 100644
--- a/tests/nvme/042.out
+++ b/tests/nvme/042.out
@@ -1,16 +1,9 @@
 Running nvme/042
 Testing hmac 0
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Testing hmac 1
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Testing hmac 2
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Testing hmac 3
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Testing key length 32
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Testing key length 48
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Testing key length 64
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/043.out b/tests/nvme/043.out
index 7419f91..f3f55a4 100644
--- a/tests/nvme/043.out
+++ b/tests/nvme/043.out
@@ -1,18 +1,10 @@
 Running nvme/043
 Testing hash hmac(sha256)
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Testing hash hmac(sha384)
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Testing hash hmac(sha512)
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Testing DH group ffdhe2048
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Testing DH group ffdhe3072
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Testing DH group ffdhe4096
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Testing DH group ffdhe6144
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Testing DH group ffdhe8192
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/044.out b/tests/nvme/044.out
index 53fdbe1..00bdcdb 100644
--- a/tests/nvme/044.out
+++ b/tests/nvme/044.out
@@ -1,10 +1,6 @@
 Running nvme/044
 Test host authentication
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test invalid ctrl authentication (should fail)
-NQN:blktests-subsystem-1 disconnected 0 controller(s)
 Test valid ctrl authentication
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test invalid ctrl key (should fail)
-NQN:blktests-subsystem-1 disconnected 0 controller(s)
 Test complete
diff --git a/tests/nvme/045.out b/tests/nvme/045.out
index 48f7e6b..565c563 100644
--- a/tests/nvme/045.out
+++ b/tests/nvme/045.out
@@ -8,5 +8,4 @@ Change DH group to ffdhe8192
 Re-authenticate with changed DH group
 Change hash to hmac(sha512)
 Re-authenticate with changed hash
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/047 b/tests/nvme/047
index 94d7d50..f5fb9f2 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -35,7 +35,7 @@ test() {
 	rand_io_size="$(_nvme_calc_rand_io_size 4M)"
 	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 		--nr-write-queues 1 \
@@ -43,7 +43,7 @@ test() {
 
 	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}"
 
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_nvmet_target_cleanup
 
diff --git a/tests/nvme/048.out b/tests/nvme/048.out
index 7f986ef..65ffa47 100644
--- a/tests/nvme/048.out
+++ b/tests/nvme/048.out
@@ -1,3 +1,2 @@
 Running nvme/048
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 4452274..7c6c303 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -430,7 +430,7 @@ _nvme_disconnect_ctrl() {
 _nvme_disconnect_subsys() {
 	local subsysnqn="$1"
 
-	nvme disconnect -n "${subsysnqn}"
+	nvme disconnect -n "${subsysnqn}" >> "$FULL" 2>&1
 }
 
 _nvme_connect_subsys() {
-- 
2.41.0

