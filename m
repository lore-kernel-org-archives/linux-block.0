Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7FC134AB
	for <linux-block@vger.kernel.org>; Sat,  4 May 2024 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714810504; cv=none; b=EVKDvhX3RY7jP62ZjMc/6wvoVs8YVMaHibcnoW40BrDQO2hs6iCw8keK27RWOcjuTyUmvUu+beAgBBO7L+i9DcYAON/AMrwbxniTOKl4BVI8Wj1FucxLMxHAU2V5bye56KEtZpzt0O9s3dk6ODhDyoEi6cIoNDBEdij3Nu3shCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714810504; c=relaxed/simple;
	bh=c/S5dT+MmOcmngKIjal3kSxx82g8KSdp+1ofILTNgUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2NARubv/UuDRH0pau/0JIOZ8CnZ9e68VtHrzpugEsEyeGGxzRhftm4ItYtBLWr25fkEuIoZ21alKFCJJznoiN2dXbw7osNwTkrKGLSVzlNLHSyOOQyvXDc5BUR3PnzS2vba0B0chyglb8tbxzaHYN+w60Bv/pS7s1hNrF7PaVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TlBKsZVF; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TlBKsZVF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810503; x=1746346503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c/S5dT+MmOcmngKIjal3kSxx82g8KSdp+1ofILTNgUo=;
  b=TlBKsZVF2NgzHOX74SxvoFVEETAgBShLoXmwWKtC3coI7wH4t9JqEIyx
   ck69M43Pgis9vmYdwMvaWOEXirPZ2m0hzvfE/mgyWH3IdV9z/fivi3J/E
   MImacSQln3w+ZYHyQdYPNVF6YtR8rLfFqmZoSx/pG6kxApS3Wi9mcDaAB
   1NuSQ20F0gKlNN6rnZydvYTvnmb6YJyPiqTUQ3aI9o7x0NSbN/PbldZzI
   +91bbKstG40SVI5InTb2EoHbz1TlUtyy/QbwPlnRh1fttu0Z5CyInHW3e
   2ehHvQNxFnQEwaj9P0dzwO5HblFgox3YfcLY5C79zw3Jji3CRu50+i2Eb
   g==;
X-CSE-ConnectionGUID: JXLAk1SBRsuD0oV1JxuPAA==
X-CSE-MsgGUID: /4bYcyqiQnKt1k5hr76qGQ==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540317"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:15:00 +0800
IronPort-SDR: L1Oelgo87Jr7TwK/cu1qUKlWP+o59K0G/T+oPtLgAhK8Sppo0v1ZLUvZdNaaatmZKssN/RzzDk
 NxqWPBN7W/BeNnkFbHY3KlX/eiSokPObiz+CAfCd+W+HAvIkTJ1252Xs1ZfET20c8DWCVEPjCK
 WnzQbZW/NcaAJWyuNxGt2lCW//fLEjDkfwsGRWDdPyl7lnH/203p/t7AzNght9pNRvUANaYh8a
 Dt0ohbNsFOHmdqeaTlMR8CCZrQCKkQRUTqKaCV3Td1pE2cJl1yDIsqwvIA6b2bNoqzUadtWmgu
 QZA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:22:58 -0700
IronPort-SDR: uuJPZ7b7RDTfsZyUkbBq8OQ/RXajTUQ6eKuSamn3sOblFhkwB0kgEOs6dgVABsdYMAorLsr/42
 IqzbRFHnFlC8SnesGTEhjAwPkDejHiWk0Mft5BiGZ0DbiyoXAVNAc1ZLm9JvghOsDi3RZ82sfZ
 E5BtFrFP9XQbAAQJ9dGVjZsIuf/Ku8DssoZh/wbYREjpJcr0XV7i5fpyDrzftO9gRwPjPkmJRr
 8W6vH4FgsKKpgAPHSPolqEhF9/lhTN6cQaa04UNJwH102zObQrdylhpOl2mprn8sIq3KGaaxKi
 oew=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:14:59 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 08/17] nvme/rc: introduce NVMET_TRTYPES
Date: Sat,  4 May 2024 17:14:39 +0900
Message-ID: <20240504081448.1107562-9-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
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

Reviewed-by: Daniel Wagner <dwagner@suse.de>
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

