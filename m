Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E61115E98
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q6xl196w"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704963642; x=1736499642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pPdBVcBRM3rAxNgK06Xf/7UWjfKPxy3EKWsALYFZDSw=;
  b=Q6xl196wfdhlZhoQ8Jh6OzZl5i4oBISocdnCppdTt6lcTS+dCkXb0LUN
   Js+T148AX0hv78bN1vQ6EY/i+5c/Nx8h6QagcM0w+8BqEeKB0kcQb89+J
   rWZRJ1eyHqTe1pGY0qM1GSzxcEC2wxNKGmLrgwch9IfIMqqbUlDBI69/y
   y0tJ9sWqvSGujefrSJSETKtGpF5cbYAFWwEU5NNodr2JVYA7BZCny80pL
   6eUk9dFeJ1NQ4wjMY0qmt1Fplb6zWNHPFndL9r9/hW+GM1D7i0sEe1wii
   0sOIOd29KZ3rqJs52yJnB8W+5nQALe8ZSE/ly9SDDqKwOuoHnpNQvRYqu
   g==;
X-CSE-ConnectionGUID: S04/JzFuRVeeB9QbG63MLA==
X-CSE-MsgGUID: Rm4DNOgkTcu2Tuon9G0Kag==
X-IronPort-AV: E=Sophos;i="6.04,185,1695657600"; 
   d="scan'208";a="6654459"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2024 17:00:41 +0800
IronPort-SDR: CAoAMmTLFzaKoh1C63Unigg9UxJaZ43/hP1s2dfAeYpSVT0E70/W/r0Iw+VwxomXOiKGLG5+Eh
 l4smI+caTHNQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jan 2024 00:05:18 -0800
IronPort-SDR: wTaB7MMdh7MCmhzvtjUgQcxT8TQR0oLZoC7eJLaQu0M1LYNFb3gfSgQpl6saLi6YV7PTyYsZI2
 +Zy2OfrA8+3w==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2024 01:00:40 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3 2/2] block/031: allow to run with built-in null_blk driver
Date: Thu, 11 Jan 2024 18:00:38 +0900
Message-ID: <20240111090038.4045250-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111090038.4045250-1-shinichiro.kawasaki@wdc.com>
References: <20240111090038.4045250-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case block/031 sets the null_blk parameter shared_tag_bitmap=1
for testing. The parameter has been set as a module parameter, so the
null_blk driver must be loadable. However, null_blk allows you to set
shared_tag_bitmap as a configfs parameter since the kernel commit
7012eef520cb ("null_blk: add configfs variables for 2 options"). The
test case can now be run with the built-in null_blk driver by specifying
shared_tag_bitmap through configfs.

Modify the test case for that purpose. Refer to the null_blk feature
list and check if shared_tag_bitmap can be specified through configfs.
If so, specify the parameter as an option of _configure_null_blk and set
it through configfs. If not, check in requires() that shared_tag_bitmap
can be specified as a module parameter. Then call _init_null_blk() in
test() and specify shared_tag_bitmap=1 at null_blk module load.

Also, change the null_blk device name from nullb0 to nullb1 since the
default null_blk device name nullb0 is not usable with the built-in
null_blk driver.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/031 | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/tests/block/031 b/tests/block/031
index d253af8..5ad6d88 100755
--- a/tests/block/031
+++ b/tests/block/031
@@ -11,30 +11,43 @@ DESCRIPTION="do IO on null-blk with a host tag set"
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
+	# _configure_null_blk() sets null_blk parameters via configfs, while
+	# _init_null_blk() sets null_blk parameters as module parameters. Old
+	# kernels require shared_tag_bitmap as a module parameter. In that case,
+	# call _init_null_blk() for shared_tag_bitmap.
+	if _have_null_blk_feature shared_tag_bitmap; then
+		opts+=(shared_tag_bitmap=1)
+	else
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

