Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017F2CA8
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VjUDFeAg"
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1331A7
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 22:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699426076; x=1730962076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xj2THKMmrJYzY/PlXat29h9g1cM5TKiU1HV8EABrK2U=;
  b=VjUDFeAgxD3rC6HnoMJMnRjfxys+EYZ+hZdicjDzf3nsyZpwg61m3Sdy
   cI+9OId9mwnm/9JZSiAgZW1ho/21fqwvPZdbLRnF6WqzGsnfCvXw+whUY
   7OxTIufxzepDb66IZBgekWez6Sj/+Qp0hcR++xHMd/nFedCut5fkvnBzf
   ssu8qTS3rtTQkJWcg93xbjcyXp7ERpDX3s5cOOMGQ2uuHRZUBcFBWaugx
   TGVAT4N+16Zv9w3gRqZpZ4+1HYk47ySpNtljCsLldAsZXGvcZs6R7+RIN
   UBn4J/dD0kw1GqOI963SxvXXiXIXNk/+8yix1KOFcbqgbRDTHTkYaG309
   g==;
X-CSE-ConnectionGUID: in/F216xTyGRarLw59iBYA==
X-CSE-MsgGUID: SaP7RNViSD2D9bHmg/uiww==
X-IronPort-AV: E=Sophos;i="6.03,285,1694707200"; 
   d="scan'208";a="1616006"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2023 14:47:56 +0800
IronPort-SDR: TRwu/DRNMD5SDfQZjNMxLOIbvHqKl6ggemmXejWfktJolALF3zK4QxBJI7+T9mCWWGDM/nhKzE
 8c+8PD9gyt+zIcq4NRGMIIJFg6KSoKhMYG1MkofZcRtrrMXpldTNZcc02xjAtsp6h99JwMVGFR
 lokkVz9Z0ObbX4gXhAsA2+VpIdt7pKRBZi1Oa5d+B5mRUu6gNftHAenFgmKeSoNcqnFCa3hgvW
 HmASCUbah/rmST7nbJuMQ46xH/o+kP3Ir9dGBlu5I/leyakoC00wL/pxTsWN5EIDWmh7rmabKN
 Uhk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2023 21:53:51 -0800
IronPort-SDR: MLUpi5QYDKWlxYH7/bGMhGB5QrvQfrACA/QX6UkaCJKbzj+wEKE9A1IVOYVIZ8m0aS7NgdxkLY
 eJyVxsJsWuvR9EISXxJ26OF84DgCLUNy88RDEtuTOM2BoKziwzwXdyaUC9P1mpwNvki4omBBBB
 ZfjOU/kEoRFlnILxU4sPwyVLiGssxgqKd4d5BTUgCXR+RCwysrhSoHQ6c9cUnW/a0o/ij+mNPw
 kPhW5ifVVjul/Qs91bqsTGCFbQ96F9Gp0NrOfKfVA5Jl4V9lOvvj4sedrG8o8/MPWopnYgNVBv
 riw=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2023 22:47:56 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagern@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/2] nvme: do not print UUID to log files
Date: Wed,  8 Nov 2023 15:47:52 +0900
Message-ID: <20231108064753.1932632-2-shinichiro.kawasaki@wdc.com>
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

The UUID/wwid of a namespace might be assigned externally, so
we shouldn't register it in the 'out' files.
The current checks for UUID/wwid are just there to ensure that
if a UUID is present is should match the wwid setting.
So rather add a function _check_uuid() which does exactly that
and don't register the actual UUID in the 'out' files.

[Shin'ichiro: added check against def_subsys_uuid in _check_uuid()]
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/004     |  3 +--
 tests/nvme/004.out |  2 --
 tests/nvme/008     |  3 +--
 tests/nvme/008.out |  2 --
 tests/nvme/009     |  3 +--
 tests/nvme/009.out |  2 --
 tests/nvme/010     |  3 +--
 tests/nvme/010.out |  2 --
 tests/nvme/011     |  3 +--
 tests/nvme/011.out |  2 --
 tests/nvme/012     |  3 +--
 tests/nvme/012.out |  2 --
 tests/nvme/013     |  3 +--
 tests/nvme/013.out |  2 --
 tests/nvme/014     |  3 +--
 tests/nvme/014.out |  2 --
 tests/nvme/015     |  3 +--
 tests/nvme/015.out |  2 --
 tests/nvme/018     |  3 +--
 tests/nvme/018.out |  2 --
 tests/nvme/019     |  3 +--
 tests/nvme/019.out |  2 --
 tests/nvme/020     |  3 +--
 tests/nvme/020.out |  2 --
 tests/nvme/021     |  3 +--
 tests/nvme/021.out |  2 --
 tests/nvme/022     |  3 +--
 tests/nvme/022.out |  2 --
 tests/nvme/023     |  3 +--
 tests/nvme/023.out |  2 --
 tests/nvme/024     |  3 +--
 tests/nvme/024.out |  2 --
 tests/nvme/025     |  3 +--
 tests/nvme/025.out |  2 --
 tests/nvme/026     |  3 +--
 tests/nvme/026.out |  2 --
 tests/nvme/027     |  3 +--
 tests/nvme/027.out |  2 --
 tests/nvme/028     |  3 +--
 tests/nvme/028.out |  2 --
 tests/nvme/029     |  3 +--
 tests/nvme/029.out |  2 --
 tests/nvme/rc      | 24 ++++++++++++++++++++++++
 43 files changed, 45 insertions(+), 84 deletions(-)

diff --git a/tests/nvme/004 b/tests/nvme/004
index 31af873..cc5310e 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -29,8 +29,7 @@ test() {
 
 	local nvmedev
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	_nvme_disconnect_subsys ${def_subsysnqn}
 
diff --git a/tests/nvme/004.out b/tests/nvme/004.out
index 51f6052..2559905 100644
--- a/tests/nvme/004.out
+++ b/tests/nvme/004.out
@@ -1,5 +1,3 @@
 Running nvme/004
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/008 b/tests/nvme/008
index f4b45b2..6ff3362 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
diff --git a/tests/nvme/008.out b/tests/nvme/008.out
index b05b46d..62342e7 100644
--- a/tests/nvme/008.out
+++ b/tests/nvme/008.out
@@ -1,5 +1,3 @@
 Running nvme/008
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/009 b/tests/nvme/009
index 905de03..4ea0063 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -26,8 +26,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
diff --git a/tests/nvme/009.out b/tests/nvme/009.out
index 7fd27ff..853663f 100644
--- a/tests/nvme/009.out
+++ b/tests/nvme/009.out
@@ -1,5 +1,3 @@
 Running nvme/009
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/010 b/tests/nvme/010
index e782a9b..5ed6cb5 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	_run_fio_verify_io --size="${nvme_img_size}" \
 		--filename="/dev/${nvmedev}n1"
diff --git a/tests/nvme/010.out b/tests/nvme/010.out
index 788ea96..90468f5 100644
--- a/tests/nvme/010.out
+++ b/tests/nvme/010.out
@@ -1,5 +1,3 @@
 Running nvme/010
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/011 b/tests/nvme/011
index 56658f4..f9150e0 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	_run_fio_verify_io --size="${nvme_img_size}" \
 		--filename="/dev/${nvmedev}n1"
diff --git a/tests/nvme/011.out b/tests/nvme/011.out
index ab29fa2..a780def 100644
--- a/tests/nvme/011.out
+++ b/tests/nvme/011.out
@@ -1,5 +1,3 @@
 Running nvme/011
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/012 b/tests/nvme/012
index 6072eed..c5e0eb9 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -31,8 +31,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
 
diff --git a/tests/nvme/012.out b/tests/nvme/012.out
index 581e686..ec4bea8 100644
--- a/tests/nvme/012.out
+++ b/tests/nvme/012.out
@@ -1,5 +1,3 @@
 Running nvme/012
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/013 b/tests/nvme/013
index 60441ca..3ec280f 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -30,8 +30,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
 
diff --git a/tests/nvme/013.out b/tests/nvme/013.out
index f7285a9..10b78ec 100644
--- a/tests/nvme/013.out
+++ b/tests/nvme/013.out
@@ -1,5 +1,3 @@
 Running nvme/013
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/014 b/tests/nvme/014
index d49e8f3..31bfeb7 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -30,8 +30,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	size="$(blockdev --getsize64 "/dev/${nvmedev}n1")"
 	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
diff --git a/tests/nvme/014.out b/tests/nvme/014.out
index 0285826..c431864 100644
--- a/tests/nvme/014.out
+++ b/tests/nvme/014.out
@@ -1,6 +1,4 @@
 Running nvme/014
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NVMe Flush: success
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/015 b/tests/nvme/015
index 0813bcf..4315ffa 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -30,8 +30,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	size="$(blockdev --getsize64 "/dev/${nvmedev}n1")"
 	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
diff --git a/tests/nvme/015.out b/tests/nvme/015.out
index 23763f1..829cf40 100644
--- a/tests/nvme/015.out
+++ b/tests/nvme/015.out
@@ -1,6 +1,4 @@
 Running nvme/015
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NVMe Flush: success
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/018 b/tests/nvme/018
index 00531cf..e901730 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -28,8 +28,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	local sectors
 	local bs
diff --git a/tests/nvme/018.out b/tests/nvme/018.out
index 68a0194..6b0e814 100644
--- a/tests/nvme/018.out
+++ b/tests/nvme/018.out
@@ -1,5 +1,3 @@
 Running nvme/018
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/019 b/tests/nvme/019
index 15e98c4..a1035ff 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -29,8 +29,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
 
diff --git a/tests/nvme/019.out b/tests/nvme/019.out
index 3e649a4..a52325f 100644
--- a/tests/nvme/019.out
+++ b/tests/nvme/019.out
@@ -1,6 +1,4 @@
 Running nvme/019
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NVMe DSM: success
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/020 b/tests/nvme/020
index 59c1179..ba3f4c8 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -28,8 +28,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
 
diff --git a/tests/nvme/020.out b/tests/nvme/020.out
index 113c177..9e293ab 100644
--- a/tests/nvme/020.out
+++ b/tests/nvme/020.out
@@ -1,6 +1,4 @@
 Running nvme/020
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 NVMe DSM: success
 NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/021 b/tests/nvme/021
index 2277fe5..7dc6a41 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	if ! nvme list 2>> "$FULL" | grep -q "${nvmedev}n1"; then
 		echo "ERROR: device not listed"
diff --git a/tests/nvme/021.out b/tests/nvme/021.out
index b6b1a7c..c86ee74 100644
--- a/tests/nvme/021.out
+++ b/tests/nvme/021.out
@@ -1,4 +1,2 @@
 Running nvme/021
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 Test complete
diff --git a/tests/nvme/022 b/tests/nvme/022
index a74eba3..c70fbba 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	if ! nvme reset "/dev/${nvmedev}" >> "$FULL" 2>&1; then
 		echo "ERROR: reset failed"
diff --git a/tests/nvme/022.out b/tests/nvme/022.out
index 1d393db..dace761 100644
--- a/tests/nvme/022.out
+++ b/tests/nvme/022.out
@@ -1,4 +1,2 @@
 Running nvme/022
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 Test complete
diff --git a/tests/nvme/023 b/tests/nvme/023
index c8d1e46..4e4d838 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	if ! nvme smart-log "/dev/${nvmedev}" -n 1 >> "$FULL" 2>&1; then
 		echo "ERROR: smart-log bdev-ns failed"
diff --git a/tests/nvme/023.out b/tests/nvme/023.out
index 47c99ca..aa5d290 100644
--- a/tests/nvme/023.out
+++ b/tests/nvme/023.out
@@ -1,4 +1,2 @@
 Running nvme/023
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 Test complete
diff --git a/tests/nvme/024 b/tests/nvme/024
index d21bcce..2535a9a 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	if ! nvme smart-log "/dev/${nvmedev}" -n 1 >> "$FULL" 2>&1; then
 		echo "ERROR: smart-log file-ns failed"
diff --git a/tests/nvme/024.out b/tests/nvme/024.out
index 0b1a350..76c3e29 100644
--- a/tests/nvme/024.out
+++ b/tests/nvme/024.out
@@ -1,4 +1,2 @@
 Running nvme/024
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 Test complete
diff --git a/tests/nvme/025 b/tests/nvme/025
index 5912e5d..46f6197 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	if ! nvme effects-log "/dev/${nvmedev}" >> "$FULL" 2>&1; then
 		echo "ERROR: effects-log failed"
diff --git a/tests/nvme/025.out b/tests/nvme/025.out
index f15ff2f..66d646e 100644
--- a/tests/nvme/025.out
+++ b/tests/nvme/025.out
@@ -1,4 +1,2 @@
 Running nvme/025
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 Test complete
diff --git a/tests/nvme/026 b/tests/nvme/026
index b6bc779..5a7d992 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	if ! nvme ns-descs "/dev/${nvmedev}" -n 1 >> "$FULL" 2>&1; then
 		echo "ERROR: ns-desc failed"
diff --git a/tests/nvme/026.out b/tests/nvme/026.out
index c934cac..69a05de 100644
--- a/tests/nvme/026.out
+++ b/tests/nvme/026.out
@@ -1,4 +1,2 @@
 Running nvme/026
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 Test complete
diff --git a/tests/nvme/027 b/tests/nvme/027
index 3993fb5..82b77a9 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	if ! nvme ns-rescan "/dev/${nvmedev}" >> "$FULL" 2>&1; then
 		echo "ERROR: ns-rescan failed"
diff --git a/tests/nvme/027.out b/tests/nvme/027.out
index 5c6ed26..621a404 100644
--- a/tests/nvme/027.out
+++ b/tests/nvme/027.out
@@ -1,4 +1,2 @@
 Running nvme/027
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 Test complete
diff --git a/tests/nvme/028 b/tests/nvme/028
index e522381..0b49e20 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -27,8 +27,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	if ! nvme list-subsys 2>> "$FULL" | grep -q "${nvme_trtype}"; then
 		echo "ERROR: list-subsys"
diff --git a/tests/nvme/028.out b/tests/nvme/028.out
index 536067f..7cfd2d3 100644
--- a/tests/nvme/028.out
+++ b/tests/nvme/028.out
@@ -1,4 +1,2 @@
 Running nvme/028
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 Test complete
diff --git a/tests/nvme/029 b/tests/nvme/029
index bbc4814..caed0f7 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -60,8 +60,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	cat "/sys/block/${nvmedev}n1/uuid"
-	cat "/sys/block/${nvmedev}n1/wwid"
+	_check_uuid "${nvmedev}"
 
 	local dev="/dev/${nvmedev}n1"
 	test_user_io "$dev" 1 512 > "$FULL" 2>&1 || echo FAIL
diff --git a/tests/nvme/029.out b/tests/nvme/029.out
index 0021003..745f142 100644
--- a/tests/nvme/029.out
+++ b/tests/nvme/029.out
@@ -1,4 +1,2 @@
 Running nvme/029
-91fdba0d-f87b-4c25-b80f-db7be1418b9e
-uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
 Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1cff522..4452274 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -959,6 +959,30 @@ _check_genctr() {
 	echo "${genctr}"
 }
 
+_check_uuid() {
+	local nvmedev=$1
+	local nr_nsid=0
+
+	for ns in "/sys/block/${nvmedev}n"* ; do
+		[ -e "${ns}/wwid" ] || continue
+		nr_nsid=$((nr_nsid + 1))
+		[ -e "${ns}/uuid" ] || continue
+		uuid=$(cat "${ns}/uuid")
+		wwid=$(cat "${ns}/wwid")
+		if [ "${uuid}" != "${wwid#uuid.}" ]; then
+			echo "UUID ${uuid} mismatch (wwid ${wwid})"
+			return 1
+		elif [ "${uuid}" != "${def_subsys_uuid}" ]; then
+			echo "UUID ${uuid} mismatch with ${def_subsys_uuid})"
+			return 1
+		fi
+	done
+	if [ $nr_nsid -eq 0 ] ; then
+		echo "No namespaces found"
+		return 1
+	fi
+}
+
 declare -A NS_DEV_FAULT_INJECT_SAVE
 declare -A CTRL_DEV_FAULT_INJECT_SAVE
 
-- 
2.41.0

