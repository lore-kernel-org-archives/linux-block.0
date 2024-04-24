Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11B0156C69
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945611; cv=none; b=QZ5AE7BA6h8V2zgOsVcFjzIWGoP3FHBFUS0dtCQVpmCztTWsv0cquwZyQanpK5cGgdq2pWTKWh1QQ3KfpfQCSgBu+EGlOvOxdtBEjRN2QvY+NheAGhxwRWdz8/rSpLTjDbUO6jfUzI73xEYOhC2UNUrRVMpolkrgKnsnbomTUB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945611; c=relaxed/simple;
	bh=8AhslQoyHiXqPtsxsMjtks4PAsu+KungIzCjBimCEE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnbN3lxOrZsKycQmPf0LSmKegbnOnIt1Zcd3RY0hVE78cB7GtkCRFQHYpbcakoFWIiQFgUgiPR+EjgfAmolnpy4gFZIOiM94v2eoBwmk7ha5tdq9emNhicfglXZUI0jKUi2gbtfdExqBSu5rmwkXE8NDetRmf+0Z8hLTo7/D2Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=F3OFwM1z; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F3OFwM1z"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945609; x=1745481609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8AhslQoyHiXqPtsxsMjtks4PAsu+KungIzCjBimCEE8=;
  b=F3OFwM1zo2qhlr2dsKCiMHOVIEa+rjx+Av1qnSYDy2mlqKla7iuN8LXz
   x/n/1PwlfsC29FIU50Rb0Q0+lr7Uf1UTHvIKIm9B+c4hTeYfUsHG+AMWJ
   wAJpbo3MlmP7kHKSLHgUzEFr9F3tWOKTqTLlOmBNPhj4oEV2FyEMV67XA
   lSaYONm4+4oargfuWAGMJWuSeobb9YfTxtmEUV/OuACISt1eQ2a/Jvxtt
   Ff7UFb2JyLVtdd0bKtGIlHcEJmTXqZ3dxHeBAxpMbdnJYF41pJfh723A2
   zhrsX4xln8VxLyGCtqroDTblNb5otOcaoUoUQx3Qs9nRGP9+xMicm4I0T
   Q==;
X-CSE-ConnectionGUID: lNNn3pToSpCi5vxHhG9wFQ==
X-CSE-MsgGUID: 4ERLIYaoTreWDUO7Ta0CDQ==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14515690"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:03 +0800
IronPort-SDR: 0MIoRPnGBKp+FB0/ook2hc4mOpv4pPPSQKzPr3xUMQKy5FukBdyjDhGQ7XOJKenYLiprBynOQh
 iikhp8CcEAMFGaW52hdd9D9VRjNkBsRayJ9hkb1Pj0WL1WmTL1wtrZxdzMqV78DLdaMcW8Ra+o
 I39ae9bHx1785rMYF3zCH0kzGZ7C0IRDI6FRucATNaVE7TDPQxRwy/KYuc2eNw7D+3oIZWIt0x
 5GT2x+5aWZCXiDHNRgXokAEEQY2ycagg2gvxQvI3US6yRa/kUt+895B3+uvLNNlKH9pp5ohRdj
 xYg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:13 -0700
IronPort-SDR: e0zR8Jg61eGL9i1fBhmIbWTW9FM4CMn0LqyDQfnL42ZXSJhoi2lr25xY7HzzVrN8K5B5QoAo2K
 cnB9tSNstd130Kw0qnZusqpO4NFgR/xwxkYJbPPhchd5vDhwSRf2ynUdziBL+WWFIyEs+zHodv
 Inngov/pQ8rDEMEMgM4CoYGC4iIcWzoFmfUkrsDjJVesLz7Qi39NtLkkYLeWWfWbcE+scpKCUf
 1Fdr8tZmeu0xwARefHb/65whGNsirXbZa44JxWueb9jnzuYow2uD2jejhulE/4uf9CUUgqHBq2
 oo8=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:02 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 06/15] nvme/rc: introduce NVMET_TRTYPES
Date: Wed, 24 Apr 2024 16:59:46 +0900
Message-ID: <20240424075955.3604997-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the test cases in nvme test group can be run under various nvme
target transport types. The configuration parameter nvme_trtype
specifies the transport to use. But this configuration method has two
drawbacks. Firstly, the blktests check script needs to be invoked
multiple times to cover multiple transport types. Secondly, the test
cases irrelevant to the transport types are executed exactly same
conditions in the multiple blktests runs.

To avoid the drawbacks, allow setting multiple transport types. Taking
this chance, rename the parameter from nvme_trtype to NVMET_TRTYPES to
follow the uppercase letter naming guide for environment variables.
NVMET_TRTYPES can take multiple transport types like:

    NVMET_TRTYPES="loop tcp"

Introduce _nvmet_set_nvme_trtype() which can be called from the
set_conditions() hook of the transport type dependent test cases.
Blktests will repeat the test case as many as the number of elements in
NVMET_TRTYPES, and set nvme_trtype for each test case run.

Also introduce _NVMET_TRTYPES_is_valid() to check NVMET_TRTYPES value
before test run.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md | 12 +++++++----
 tests/nvme/rc                  | 37 ++++++++++++++++++++++++++++++----
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index ae80860..571ee04 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -102,8 +102,12 @@ RUN_ZONED_TESTS=1
 
 The NVMe tests can be additionally parameterized via environment variables.
 
-- nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
-  Run the tests with the given transport.
+- NVMET_TRTYPES: 'loop' (default), 'tcp', 'rdma' and 'fc'
+  Set up NVME target backends with the specified transport. Multiple transports
+  can be listed with separating spaces, e.g., "loop tcp rdma". In this case, the
+  tests are repeated to cover all of the transports specified.
+  This parameter had an old name 'nvme_trtype'. The old name is still usable,
+  but not recommended.
 - nvme_img_size: '1G' (default)
   Run the tests with given image size in bytes. 'm', 'M', 'g'
 	and 'G' postfix are supported.
@@ -117,11 +121,11 @@ These tests will use the siw (soft-iWARP) driver by default. The rdma_rxe
 
 ```sh
 To use the siw driver:
-nvme_trtype=rdma ./check nvme/
+NVMET_TRTYPES=rdma ./check nvme/
 ./check srp/
 
 To use the rdma_rxe driver:
-use_rxe=1 nvme_trtype=rdma ./check nvme/
+use_rxe=1 NVMET_TRTYPES=rdma ./check nvme/
 use_rxe=1 ./check srp/
 ```
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1f5ff44..f35ed09 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -18,10 +18,41 @@ def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
 def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
 export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-nvme_trtype=${nvme_trtype:-"loop"}
+_check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
 
+_NVMET_TRTYPES_is_valid() {
+	local type
+
+	for type in $NVMET_TRTYPES; do
+		case $type in
+		loop | rdma | tcp | fc)
+			;;
+		*)
+			SKIP_REASONS+=("Invalid NVMET_TRTYPE value: $type")
+			return 1
+			;;
+		esac
+	done
+	return 0
+}
+
+_set_nvme_trtype() {
+	local index=$1
+	local -a types
+
+	read -r -a types <<< "$NVMET_TRTYPES"
+
+	if [[ -z $index ]]; then
+		echo ${#types[@]}
+		return
+	fi
+
+	nvme_trtype=${types[index]}
+	COND_DESC="nvmet tr=${nvme_trtype}"
+}
+
 # TMPDIR can not be referred out of test() or test_device() context. Instead of
 # global variable def_flie_path, use this getter function.
 _nvme_def_file_path() {
@@ -61,9 +92,6 @@ _nvme_requires() {
 		_have_configfs
 		def_adrfam="fc"
 		;;
-	*)
-		SKIP_REASONS+=("unsupported nvme_trtype=${nvme_trtype}")
-		return 1
 	esac
 
 	if [[ -n ${nvme_adrfam} ]]; then
@@ -92,6 +120,7 @@ _nvme_requires() {
 
 group_requires() {
 	_have_root
+	_NVMET_TRTYPES_is_valid
 }
 
 group_device_requires() {
-- 
2.44.0

