Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EED1482FC
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834026; cv=none; b=ZhAicZ6pRdcVqE0JiLfenS0WU8Eo15XLBdwlEI68LC1jf2Pf6rrIax+sichRb/Kgz6pxcu6ewo4HkAbMbQv+5TSfkynGUDUhBhSN25qzYMzLcM2DhotlmllaBdIWCTsLoYvwCuMjA/vHeRGqrC/rjZaM+EuNK5daDoXdtHuEMD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834026; c=relaxed/simple;
	bh=oT1EVAZJnb4NrCk2dPNj7oAwzDeLFZ2N2iueMe6JpfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/AHtQjEg5UhulZTyYVgOZv35vl8zKyglruQa/XbfRZoGRX9WLfXNzyiffXrH+KuETj0hzbddl6tR5SrVlCvgMDBIg5opR7BZ2qWL6oBcLD2sZP4ghOlNDPXrktBt+bC329SB31Y2h0S+HTEzvnNCXoGiHj0DhH20YZYhxpLPso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=no2tfkh+; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="no2tfkh+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712834025; x=1744370025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oT1EVAZJnb4NrCk2dPNj7oAwzDeLFZ2N2iueMe6JpfU=;
  b=no2tfkh+nsRqL+FHpJ8uT685MOUiAsauAK31aK1QyDit01TqpuJzAMSf
   s+TSJJHSvmsHADXw0YWylnJxm7cfzzF3BbAyrOW1DksYtVtPQFFtVGopJ
   0DSDsTiV8kzR8LAuZjBekoHnkjPKaVpCaG02UjFo6stiWVREFxjls51jI
   2YUjLRPiBNsE1CF0aQjpwiI5vJfbunS2NTQFWy5Cvbix3bGJJ8IRBXSwi
   7YkmaoMnLiApb/+jKDH1VBymk0EZuNK16iD02xQwmIz/zSe3hgm4p/E1U
   Hd9mjj7E7RQXtmGlVbdOdRVbAonoCAHOO1NqukoYdFHIo3YJNoE+0wV4J
   g==;
X-CSE-ConnectionGUID: dNZFlUAzTmSENsKzmBHcIg==
X-CSE-MsgGUID: iqQwt1LCSzS3o7CQFZF5Yw==
X-IronPort-AV: E=Sophos;i="6.07,193,1708358400"; 
   d="scan'208";a="13579870"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 19:12:34 +0800
IronPort-SDR: 9K4JZO6pbny1897oS3wCYakhect97Zvr2hXYWmlShVfYTv7EpI8+E9Ja2M199J0I91vL8FvdjX
 fnwwNEE7htcA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 03:15:20 -0700
IronPort-SDR: bGUrxeWPs8AWgdiANTGQ3QrQgvAC6b12cva/q/4Cv2N4RHhLlS26xLEn1TIk2m1QF3fVQInAjQ
 JsK/kzVItxKg==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Apr 2024 04:12:34 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Date: Thu, 11 Apr 2024 20:12:22 +0900
Message-ID: <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
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

To avoid the drawbacks, introduce new configuration parameter
NVMET_TR_TYPES. This is an array, and multiple transport types can
be set like:

    NVMET_TR_TYPES=(loop tcp)

Also introduce _nvmet_set_nvme_trtype() which can be called from the
set_conditions() hook of the transport type dependent test cases.
Blktests will repeat the test case as many as the number of elements in
NVMET_TR_TYPES, and set nvme_trtype for each test case run.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md |  6 +++++-
 tests/nvme/rc                  | 30 +++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index ae80860..ede3a81 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -102,8 +102,12 @@ RUN_ZONED_TESTS=1
 
 The NVMe tests can be additionally parameterized via environment variables.
 
+- NVMET_TR_TYPES (array)
+  Set up NVME target backends with the specified transport.
+  Valid elements are 'loop', 'tcp', 'rdma' and 'fc'. Default value is '(loop)'.
 - nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
-  Run the tests with the given transport.
+  Run the tests with the given transport. This parameter is still usable but
+  replaced with NVMET_TR_TYPES. Use NVMET_TR_TYPES instead.
 - nvme_img_size: '1G' (default)
   Run the tests with given image size in bytes. 'm', 'M', 'g'
 	and 'G' postfix are supported.
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1f5ff44..df6bf77 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -18,10 +18,38 @@ def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
 def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
 export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
 
+# Check consistency of NVMET_TR_TYPES and nvme_trtype configurations.
+# If neither is configured, set the default value.
+first_call=${first_call:-1}
+if ((first_call)); then
+	if [[ -n $nvme_trtype ]]; then
+		if [[ -n $NVMET_TR_TYPES ]]; then
+			echo "Both nvme_trtype and NVMET_TR_TYPES are specified"
+			exit 1
+		fi
+		NVMET_TR_TYPES=("$nvme_trtype")
+	elif [[ -z ${NVMET_TR_TYPES[*]} ]]; then
+		nvme_trtype="loop"
+		NVMET_TR_TYPES=("$nvme_trtype")
+	fi
+	first_call=0
+fi
+
+_set_nvme_trtype() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo ${#NVMET_TR_TYPES[@]}
+		return
+	fi
+
+	nvme_trtype=${NVMET_TR_TYPES[index]}
+	COND_DESC="nvmet tr=${nvme_trtype}"
+}
+
 # TMPDIR can not be referred out of test() or test_device() context. Instead of
 # global variable def_flie_path, use this getter function.
 _nvme_def_file_path() {
-- 
2.44.0

