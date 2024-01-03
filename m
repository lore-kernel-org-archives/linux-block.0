Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986F818EA5
	for <linux-block@vger.kernel.org>; Wed,  3 Jan 2024 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iwYDQyI1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704282589; x=1735818589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SUIOoFCll9V0/pcZKF+SuiSn1hTLxp15utr/HahGGus=;
  b=iwYDQyI1l4fS9Kg463s3ZHlkk/JRfNQl6MBgMrpQXCX8KUj8CFUZvbu5
   4HXzcPg9fhjv4usILvwxT62GUDZH9urJSNIe9E7UkLqZ8C/M7fGSJhw+y
   tr2FKuNpINIHN+pILlPlhjAYvguNtxKTLTDWWrtTXkJ+dzhz3+RW3nJdZ
   l9Y+q3xmZ2OL7pbHe7ZBN28QT/PxDd6QO0X8ZaFYKr3Tb+yQS5Ile54ar
   3IgA/VCJSrrGlVjAJb0pYzFsWIairpvUEqLBQjGv+He66UH+aclWuK07p
   vjoC/C6ysMhYBi2XjAQpS0eem5JCEj5R4v1nApUx8doHqy/ppgWvqupln
   w==;
X-CSE-ConnectionGUID: 8/RNxH32RAO9IbsQTEVyYw==
X-CSE-MsgGUID: lp8gzJl3TWKdnD0/QlG8dQ==
X-IronPort-AV: E=Sophos;i="6.04,327,1695657600"; 
   d="scan'208";a="6081460"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2024 19:49:47 +0800
IronPort-SDR: haKak8ZGYS+osQsxb1OhpBh2JtZ3u5XMndHh8In97JB5G7AMXb3dmem++DsUnYyjw7ftPLnJx0
 NHVEZqNQ+JsQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jan 2024 03:00:12 -0800
IronPort-SDR: 6J4qXR2+slyMX9jVXNNBsqOmicIjKdk+fPaaclaFeXfEjrRdZI5Dclwdx8w8oihZWrTwoCb1Ak
 qV3HibxLNV5A==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Jan 2024 03:49:42 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/2] block/031: allow to run with built-in null_blk driver
Date: Wed,  3 Jan 2024 20:49:40 +0900
Message-ID: <20240103114940.3000366-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103114940.3000366-1-shinichiro.kawasaki@wdc.com>
References: <20240103114940.3000366-1-shinichiro.kawasaki@wdc.com>
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

