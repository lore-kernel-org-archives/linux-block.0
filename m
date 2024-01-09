Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C770364B9
	for <linux-block@vger.kernel.org>; Tue,  9 Jan 2024 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cAwu4Vsh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704797124; x=1736333124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SUIOoFCll9V0/pcZKF+SuiSn1hTLxp15utr/HahGGus=;
  b=cAwu4Vsh/uKNmegffZ/BlgOlp6IFFDcomaRByV/DWNrcwCs/76TxV2Ii
   YIQrvfJ6ES0vDf06FsTX9Cp7wPc6MfvdmdL434NkeqXtwUlJQGKDZDVdf
   7zufDxLTFcJK7mCbJmsUwd/u7jWwulx/taoxU9kxGgAcGIoaaRVx/MWUK
   Kgk73JexU60uahCufFsWte7+JetZn41WOlJ4cKgzkMz39/6OThYozd1Uu
   40AXGndt57oT71GLRVPodIFMz0/9divE1YN0mQ/v8xbP2is4phF128iSw
   8y1n0DaFFeDwjeFC8Uyp8gKNiyjuc+alsX2Ti4h2F6y5MTa1sgg5lxx7Z
   Q==;
X-CSE-ConnectionGUID: AXrtVDP4SKCHT2C7ivFkDQ==
X-CSE-MsgGUID: XZGkl5/zT0SnRAqlt2EoHw==
X-IronPort-AV: E=Sophos;i="6.04,182,1695657600"; 
   d="scan'208";a="6473956"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2024 18:44:55 +0800
IronPort-SDR: 5TKmVgKmiZyAac9iL+zVXjmU87QgGyUV75SDlVnZsHaEcECes2jK8m6GeV0Aya8jBpEJhE1I98
 dEw+lJsBj9vQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2024 01:55:15 -0800
IronPort-SDR: EoeAS3mfOL8AQUQwnpj74WR5NyEfHEc0kacAZ5HEguZfCs8uxygyfqrRg05sNf5Gy+euEvTy8l
 BUH2VglfPUkg==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Jan 2024 02:44:55 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 2/2] block/031: allow to run with built-in null_blk driver
Date: Tue,  9 Jan 2024 19:44:53 +0900
Message-ID: <20240109104453.3764096-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109104453.3764096-1-shinichiro.kawasaki@wdc.com>
References: <20240109104453.3764096-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case block/031 sets null_blk parameter shared_tag_bitmap=1 for
testing. The parameter has been set as a module parameter then null_blk
driver must be loadable. However, null_blk allows to set
shared_tag_bitmap as a configfs parameter since the kernel commit
7012eef520cb ("null_blk: add configfs variables for 2 options"). Then
the test case now can be run with built-in null_blk driver by specifying
shared_tag_bitmap through configfs.

Modify the test case for that purpose. Refer null_blk feature list and
check if shared_tag_bitmap can be specified through configfs. If so,
specify the parameter as an option of _configure_null_blk and set it
through configfs. If not, check in requires() that shared_tag_bitmap can
be specified as a module parameter. Then call _init_null_blk() in test()
and specify shared_tag_bitmap=1 at null_blk module load.

Also change null_blk device name from nullb0 to nullb1 since the default
null_blk device name nullb0 is not usable with built-in null_blk driver.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/031 | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tests/block/031 b/tests/block/031
index d253af8..61a3502 100755
--- a/tests/block/031
+++ b/tests/block/031
@@ -11,30 +11,41 @@ DESCRIPTION="do IO on null-blk with a host tag set"
 TIMED=1
 
 requires() {
-	_have_fio && _have_null_blk && _have_module_param null_blk shared_tag_bitmap
+	_have_fio
+	_have_null_blk
+	if ! _have_null_blk_feature shared_tag_bitmap; then
+		_have_module_param null_blk shared_tag_bitmap
+	fi
 }
 
 test() {
 	local fio_status bs=512
+	local -a opts=(nullb1 completion_nsec=0 blocksize="$bs" size=1 \
+			      submit_queues="$(nproc)" memory_backed=1)
 
 	: "${TIMEOUT:=30}"
-	if ! _init_null_blk nr_devices=0 shared_tag_bitmap=1; then
-		echo "Loading null_blk failed"
-		return 1
+	if _have_null_blk_feature shared_tag_bitmap; then
+		opts+=(shared_tag_bitmap=1)
+	else
+		# Old kernel requires shared_tag_bitmap as a module parameter
+		# instead of configfs parameter.
+		if ! _init_null_blk shared_tag_bitmap=1; then
+			echo "Loading null_blk failed"
+			return 1
+		fi
 	fi
-	if ! _configure_null_blk nullb0 completion_nsec=0 blocksize=$bs size=1\
-	     submit_queues="$(nproc)" memory_backed=1 power=1; then
+	if ! _configure_null_blk "${opts[@]}" power=1; then
 		echo "Configuring null_blk failed"
 		return 1
 	fi
 	fio --verify=md5 --rw=randwrite --bs=$bs --loops=$((10**6)) \
 		--iodepth=64 --group_reporting --sync=1 --direct=1 \
 		--ioengine=libaio --runtime="${TIMEOUT}" --thread \
-		--name=block-031 --filename=/dev/nullb0 \
+		--name=block-031 --filename=/dev/nullb1 \
 		--output="${RESULTS_DIR}/block/fio-output-031.txt" \
 		>>"$FULL"
 	fio_status=$?
-	rmdir /sys/kernel/config/nullb/nullb0
+	rmdir /sys/kernel/config/nullb/nullb1
 	_exit_null_blk
 	case $fio_status in
 		0) echo "Passed";;
-- 
2.43.0

