Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479C31755C
	for <linux-block@vger.kernel.org>; Sat,  4 May 2024 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714810506; cv=none; b=BAmGg6QxYifAqW6kRV66ivm9TkEv6q2pWz9B/+WwcHlcbKIpCmNGljtVUGXluNUpI/3qgcTyb47g3ISbTg8FkfLVf0Ks0efIOV5ewoHDJahbSnr0fwtU6ETmgJll+w0agcBlvxRKNK4X9+EE5uUcNfJKPpV78FU+PGDEDD2QFvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714810506; c=relaxed/simple;
	bh=BFfaOX5p2iOl7nNSAnVbtqrbQDtOYPAQ2VME6QGOMfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuzL7E5kelO1eFSwUzl/oEYWsK5UF5b5UBmAt5oC7JGiQYru1q5PbPzV6tkFaub/mQII8vKXdgDvDv/P2gGsy0Siy8ZINvhWnVyNqcd1DrknJtm3Omi3SDwFHW//75iEgo2OPOcTdxu2mVQIbgOw5oLR5RHszsjURWAzZAdpI0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Pk74viun; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Pk74viun"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810505; x=1746346505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BFfaOX5p2iOl7nNSAnVbtqrbQDtOYPAQ2VME6QGOMfk=;
  b=Pk74viunu7SQtE2ypOmyfSpmorZ2Udz/fr+tcvsFs8wjmFPqZby41Vcn
   SmQUdxT3URqSLQ7pntDPZS+uq3L7uV1AeQeHAmfvO8RCAvKT4deNDd/VI
   s3WTjJ6WaCo52Gdu9LuJWX7/FNvWCif/e0c3mpa/Zi9fk2nlvodnR6emR
   2/U1TNBXvXaZQQDHdi2nBoegg77PO6q5qSU7wThGNtq6AjzWcwv2OYStN
   FHnRNRJNv3ehijLFD3qFd64uEk9dwKyMzSXaFAZakIhmQcEb+NFCCdfI3
   VOkyMVt81rYrEp1VpfWwk8iBx4FIoU+U9fUB7sLchgX2P3OkAfuruDSDN
   g==;
X-CSE-ConnectionGUID: Ze1Xh9mHRoOcghztZWQHsA==
X-CSE-MsgGUID: 50CyiIq1R9iutc/ry4DzKw==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540331"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:15:04 +0800
IronPort-SDR: gtuCrCm/i6fj7KT2c11oYtZYJcm4rso6TxTuasIEpnHU54gHWNEmPF7naNtV8broWpvTlJXAtG
 lOMkQscR2iHxCcvq2hCFAVqUzLPetE3+snJ3KlaH/sU/fAzfwoJYc4J0tzjsTkIy3mBVLq03KY
 npWp9SwKEqyDnDL78TnP4w26CDhYL0ZfyH2D2XuCjSeifWvfy2/GlKqzVdilciuMNl7nWNPqqU
 ySb7iiVH6wAHHeBa+/7vJBFxWP3UrMai6/cS/wfWcrhVXw6Miv8PSXJX/5kC9BsBjJdQNosHwp
 K8M=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:23:02 -0700
IronPort-SDR: SystkBEVl0eprf0RMbP5jdCF2A0SuSsHlQSZlZUlGyfT7qUPEwXMOxzF9ZZr2a6u+hB6k4YHt6
 BBvdtXp+84Wuzi4dg7IQ6QR8QiRqk/s3OjU5VIfbfozbMRFd3LlX1Qc9q1BQtVmJwwOMUXTZlD
 +Lv4ePv2Mj8Oc+NCH+T6xhtmnU5mhExcZMmLqTu7ARzKzPSXE8fwSmPetQQHUCaL6raV17XFBY
 NcZSK31Id8Wqo7KfOXXDJ+KuQcBQc3oowNBNKCREM8iXlQ872EXmSNJ7H4E1dAPRmpS9P+RqCE
 B+w=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:15:04 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 12/17] nvme/{006,008,010,012,014,019,023}: support NVMET_BLKDEV_TYPES
Date: Sat,  4 May 2024 17:14:43 +0900
Message-ID: <20240504081448.1107562-13-shinichiro.kawasaki@wdc.com>
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

Enable repeated test runs for the listed test cases for
NVMET_BLKDEV_TYPES. The default values of NVMET_BLKDEV_TYPES is
"device file". With this default set up, each of the listed test cases
are run twice. The second runs of the test cases for 'file' blkdev type
do exact same test as other test cases nvme/007, 009, 011, 013, 015, 020
and 024.

The test cases already support the repetition for NVMET_TRTYPES. Modify
the set_conditions() hooks to call both NVMET_BLKDEV_TYPES and
NVMET_TRTYPES using _set_combined_conditions(). When NVMET_BLKDEV_TYPES
and NVMET_TRTYPES are set as follows, the test cases are repeated
2 x 3 = 6 times each.

      NVMET_BLKDEV_TYPES="device file"
      NVMET_TRTYPES="loop rdma tcp"

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/006 | 2 +-
 tests/nvme/008 | 2 +-
 tests/nvme/010 | 2 +-
 tests/nvme/012 | 2 +-
 tests/nvme/014 | 2 +-
 tests/nvme/019 | 2 +-
 tests/nvme/023 | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/nvme/006 b/tests/nvme/006
index ff0a9eb..3f9d209 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/008 b/tests/nvme/008
index 1877d8a..247850c 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/010 b/tests/nvme/010
index 34914a7..c16587f 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/012 b/tests/nvme/012
index e06bf8d..e6674e2 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -20,7 +20,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/014 b/tests/nvme/014
index ff0ebfb..571c6f4 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/019 b/tests/nvme/019
index 31020d9..501256c 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/023 b/tests/nvme/023
index da99406..3c43c55 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
-- 
2.44.0

