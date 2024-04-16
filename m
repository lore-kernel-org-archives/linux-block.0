Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE98127E20
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263535; cv=none; b=cVdj3LNlb+dao7hpKKxW4YS7f8/AmrbAkWZyAinv5buMsdUywAp4754QoaM8NlHPiSyS2w25/SkoiZE4ZvhSyfa5fXrP8cSwPtqSPYF2kQN+AazKvz6K1GJpYpNaCHBEJpQbShTqA3ttp9P8w8Po7SoXhGGwSxqgxc5tw6yXx7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263535; c=relaxed/simple;
	bh=HncKKmC+QVZ0Aq+UWgdlyuRlINtlt7Qu9LbWVThxhGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3J2hEyhHeK2JMgeM9U5ZcTu7MKXXWmttZrT7iS/Y2H57b8ik3+oWal4b/tWs+iiSUQ9G2ADgQein5meiyn/dPsOeP8b2UkL5yxxGvy2CfEFTVDs+B5/+Z7vtJsbtcwT8Gut4WjC4Ghsq1ki8F7LuTKGIKOjG8YaIXbEC19o9Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AcOc0yXW; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AcOc0yXW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263533; x=1744799533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HncKKmC+QVZ0Aq+UWgdlyuRlINtlt7Qu9LbWVThxhGE=;
  b=AcOc0yXWlz+fkhWIw+YsqcObwFjauU3qbDneqCsDCIwqy1LahE9Icrq4
   sHZzvu8FUs67Lne6kM8pnGI7cpN1LPkFnLN1xO5UUf7W1CPoHfHJ0b6Ke
   y/Aq9Cr4tV9g2teYZBlsOjwzZ2YEav+peGLKDk7xQiWMEyEPFnHYDyNs6
   xRU76T8ob81SpD4pW36ChPRqP02nVLTOJyoqLRi4yVbK4GQ3AMwoa4spK
   qimr7kbj1qSH5mgBiqivcQemEgnb68w8Z+z05sRb/bzRBMM5nghk6nXFE
   ALQ/P55rA3cEeAepM4IzpfY/Pt/ttS5wLqQ5swQiX1hxo6CkLKP1EfoBj
   A==;
X-CSE-ConnectionGUID: uJuc4bWIRluTdy+oXsI8LQ==
X-CSE-MsgGUID: dK14PW2hTnOv7W5ynMbvCA==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14322615"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:32:13 +0800
IronPort-SDR: rTUoevyEJTM63QYF+xt1Gwa3At16xwM+PrEXJrldok1XAshudk0TdHmP2hSO4VIBaUZCbiWmex
 FD7b2hDFUOl0vUXtanaYWNUzIVsyLjOhlUOVjEEiqLOMxT0wfId8PyyNVM5ZjpkdjtmOnEBwn5
 7nIdylGrM3TmojTzozwxlRbB4jhN7uWb9MPC7k0pWH4yKAyVOoQ6LbLO+OLUsvHMfYbh5eqoMy
 YERSz8V5It7BJCLEzghowY8mkwI2h9xrgKL89uxSZPS3hbdUsjlTdaXj1Xfbyjw34XPFruLU5l
 t2Q=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:40:33 -0700
IronPort-SDR: TWn9qJPK8wwIoU3pfmqgYjZgyT2caZ0FA+Uu97wqqnlxYe6AAb9VFPpzeequb7v3j8cnKcrCDB
 QT5GPF7sCcc4y6DkZ2NhXYrpYgGoZ0X7sjgZRdzF3Hu59XoshxpJcum4qvJKPia/HR+eDqs2eR
 tzLrpRQW+gdgudTtnP0WwLiEuDWNA6RcY4M1StY+khtk6QQSOjkmJIZ+oV2RsSu1poep/+fNUn
 VdpY2OpgafU7KhgNSLumFkDvHKJUivjDwyaRPD4Aw9ivVoaYA2uHzblH1AANIEzCagqbE3S396
 G44=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2024 03:32:13 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 05/11] nvme/rc: introduce NVMET_TRTYPES
Date: Tue, 16 Apr 2024 19:32:01 +0900
Message-ID: <20240416103207.2754778-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
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

To avoid the drawbacks, introduce the new configuration parameter
NVMET_TRTYPES. This parameter can take multiple transport types like:

    NVMET_TRTYPES="loop tcp"

Also introduce _nvmet_set_nvme_trtype() which can be called from the
set_conditions() hook of the transport type dependent test cases.
Blktests will repeat the test case as many as the number of elements in
NVMET_TRTYPES, and set nvme_trtype for each test case run.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md | 11 ++++++++---
 tests/nvme/rc                  | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index ae80860..144acd1 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -102,8 +102,13 @@ RUN_ZONED_TESTS=1
 
 The NVMe tests can be additionally parameterized via environment variables.
 
+- NVMET_TRTYPES: 'loop' (default), 'tcp', 'rdma' and 'fc'
+  Set up NVME target backends with the specified transport. Multiple transports
+  can be listed with separating spaces, e.g., "loop tcp rdma". In this case, the
+  tests are repeated to cover all of the transports specified.
 - nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
-  Run the tests with the given transport.
+  Run the tests with the given transport. This parameter is still usable but
+  replaced with NVMET_TRTYPES. Use NVMET_TRTYPES instead.
 - nvme_img_size: '1G' (default)
   Run the tests with given image size in bytes. 'm', 'M', 'g'
 	and 'G' postfix are supported.
@@ -117,11 +122,11 @@ These tests will use the siw (soft-iWARP) driver by default. The rdma_rxe
 
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
index 1f5ff44..34ecdde 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -18,10 +18,41 @@ def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
 def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
 export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
 
+# Check consistency of NVMET_TRTYPES and nvme_trtype configurations.
+# If neither is configured, set the default value.
+first_call=${first_call:-1}
+if ((first_call)); then
+	if [[ -n $nvme_trtype ]]; then
+		if [[ -n $NVMET_TRTYPES ]]; then
+			echo "Both nvme_trtype and NVMET_TRTYPES are specified"
+			exit 1
+		fi
+		NVMET_TRTYPES="$nvme_trtype"
+	elif [[ -z $NVMET_TRTYPES ]]; then
+		nvme_trtype="loop"
+		NVMET_TRTYPES="$nvme_trtype"
+	fi
+	first_call=0
+fi
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
-- 
2.44.0

