Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF06236431
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577755; cv=none; b=VCVVuHqrRtbxqu/716lTb985efq6VoFE6bYiqQ4O4CfJRbp0nYzE4XRZzrLVV2J5WVD43Z0ZtLy7SUricjkgPV5eELjGx0jtGUx63mvgq5F+c5yivEDbEXW/QlDMii5+OColyb6YF7S1itcdK0wc6J/2273QvnaqzXqpVEDOIag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577755; c=relaxed/simple;
	bh=VrB4fyxXXV8fR9OLATgUooSVYgD6QeH7LZfh/6lSCFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3LVJfCf5+BWfk9/dhDm+yZkgDPtQK4P4vXR4jCs/UiOFN50FAYpvoEweL4gxB1vuenDxe0QqF7R06fFrbtWEc/OILCPfmwoYzgZY9qwDrnHbX006XvklxcL08vq1jA0d+91w4ESqIrmWYMgFl3JeBW+gRzvh2+3MdEZHELnHMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iAA7cSSB; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iAA7cSSB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577753; x=1775113753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VrB4fyxXXV8fR9OLATgUooSVYgD6QeH7LZfh/6lSCFQ=;
  b=iAA7cSSBMc2HL5LHUAWqAouG9n5uX2P32F8Gbi7XQQzauN1dKuiBCUEq
   vzx+P+g+RCiN3Au8GWFyAWGQv1ppd1EPrtzr046o9br0yW1LJSawKlAjG
   JWuSCz5ZXDL9BB+dTpvd1FNK39/dtDhraTBg2td/DOF8uwSpRTHUkEWv3
   v4uhlTNp2VCd9aGjvykRbDdgkWFgSdLTWc9k+dV+ovl00xQZ+PqWUT6fh
   r+c9AlA6WO0A4DNVcDrN+xmA1WI4QdNxcvDMEMqsygTqz6/3OXs1xpM5q
   kzNJ7wq1o2tJk9RSLTpk7B5VJHzOoxt5IsJIOixBA+r4YRH8OwY0OT7wS
   A==;
X-CSE-ConnectionGUID: ax/Qu9OVQQeOKVbR51rNfA==
X-CSE-MsgGUID: 1Ad7VO9LRCC1m/b+wHujQQ==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="71367593"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:11 +0800
IronPort-SDR: 67ecd4a0_W1Ciycq0G/AscWahbFiAXedhK20kdMZQaYl2RMj45U+h7b2
 dE010LoQDqnXQGmcccgWq58d/6OSROFg+CQAARw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:37 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:12 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 03/10] common/rc,fio: factor out _compare_three_version_numbers()
Date: Wed,  2 Apr 2025 16:08:59 +0900
Message-ID: <20250402070906.393160-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
References: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper functions _have_kver() and _have_fio_ver() have the common
logic that compares three numbers with the version string in the format
"a.b.c". Factor out the common logic to the new helper function
_compare_three_version_numbers(). This prepares for to introduce more
functions for version checks.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/fio |  9 +++------
 common/rc  | 25 +++++++++++++++++++------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/common/fio b/common/fio
index 046791f..7c88460 100644
--- a/common/fio
+++ b/common/fio
@@ -28,14 +28,11 @@ _have_fio_zbd_zonemode() {
 
 # Check whether the version of the fio is greater than or equal to $1.$2.$3
 _have_fio_ver() {
-	local d=$1 e=$2 f=$3
-
 	_have_fio || return $?
 
-	IFS='.' read -r a b c < <(fio --version | cut -c 5- | sed 's/-.*//')
-	if [ $((a * 65536 + b * 256 + c)) -lt $((d * 65536 + e * 256 + f)) ];
-	then
-		SKIP_REASONS+=("fio version too old")
+	if _compare_three_version_numbers \
+	     "$(fio --version | cut -c 5- | sed 's/-.*//')" "$1" "$2" "$3"; then
+		SKIP_REASONS+=("fio version is older than ${1}.${2}.${3:-0}")
 		return 1
 	fi
 	return 0
diff --git a/common/rc b/common/rc
index 068a676..ff3f0a3 100644
--- a/common/rc
+++ b/common/rc
@@ -226,15 +226,28 @@ _have_kernel_option() {
 	return 0
 }
 
+# Compare the version string in $1 in "a.b.c" format with "$2.$3.$4".
+# If "a.b.c" is smaller than "$2.$3.$4", return true. Otherwise, return
+# false.
+_compare_three_version_numbers() {
+	local -i a b c d e f
+
+	IFS='.' read -r a b c <<< "$1"
+	d=${2:0}
+	e=${3:0}
+	f=${4:0}
+	if ((a * 65536 + b * 256 + c < d * 65536 + e * 256 + f)); then
+		return 0
+	fi
+	return 1
+}
+
 # Check whether the version of the running kernel is greater than or equal to
 # $1.$2.$3
 _have_kver() {
-	local d=$1 e=$2 f=$3
-
-	IFS='.' read -r a b c < <(uname -r | sed 's/-.*//;s/[^.0-9]//')
-	if [ $((a * 65536 + b * 256 + c)) -lt $((d * 65536 + e * 256 + f)) ];
-	then
-		SKIP_REASONS+=("Kernel version too old")
+	if _compare_three_version_numbers \
+	     "$(uname -r | sed 's/-.*//;s/[^.0-9]//')" "$1" "$2" "$3"; then
+		SKIP_REASONS+=("Kernel version is older than ${1}.${2}.${3}")
 		return 1
 	fi
 }
-- 
2.49.0

