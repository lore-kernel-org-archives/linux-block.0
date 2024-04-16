Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1751127E38
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263537; cv=none; b=H7pKX2pDmlahbUGYB7iN1sbsg5o/YcilhIR6t+kpSWYWvALAelkpxQFkwidm5uCVUnnprnU4khDiBlHX1LlXzQ+q/nvHTb/OGAanGkDoW247u1z93OE0xCgT30LXyR8pOd/sS/QGynV+c/gAkMXA+m3Ce+IWNWTRUKVldTpZJzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263537; c=relaxed/simple;
	bh=iSWpKJYKZ6ojughWXi5bAnIYQCqtRZAVPjo0ZXW3z2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwhSo2U3vnBAHoP22BVoxgJBhJvd4gT7Iy5OkWZa9vWhs8FSNu7F/2Mgk3liutxgI3R2rq/kJu0FwxMJjRSnGyAnNp7sPnAL0tKKzO33lCWK2tCG62CetCXFfTMDT0sHYk0NzCYFs+HsPYS3KStKDGjrz3HgvUVZY4O8hR+WlLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qjKyczNN; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qjKyczNN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263535; x=1744799535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iSWpKJYKZ6ojughWXi5bAnIYQCqtRZAVPjo0ZXW3z2c=;
  b=qjKyczNN+sdIZwgpGqp2e/1KiE95z6yXMiLmhRuSJb/W8eDDVN7A1goP
   v1XING4ILbXrXSauSwaE2a6FRiSNQ93KLOYRE+VYFq1xJBX3Io3vUc+uI
   WGnWM07GvFsR9sil5HX08qzHcoC4gHaEIEncihhy/hsojDWlGkvu5Ffks
   6jO28YUzAjtvydpaolJIEu9ETKbvUuXue+c6YWAzerB9hxAmDiKWj967w
   LEpV11SU6Jw4xYb5fMML5tZWRt0GVqqp/nbZ20bJ638Y2gQ6jmsOukZC7
   BTU79AQKmnFqsKHKXKcttd10XIw+VWfA/3frVm6cTJNio0zyAO6xQ6Npo
   Q==;
X-CSE-ConnectionGUID: PrJjitjqT/eMjhsOt5RC7g==
X-CSE-MsgGUID: EZqoW8ItTemEjMeObRV1QQ==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14322618"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:32:15 +0800
IronPort-SDR: h/8Nb5esDIuOoE8pg4cv3RubntOeot2TuSmpIYW9juP2jieFYEZRWhrkjinlakvY5DBIv+HKUw
 8Un7HM15gT+tZ5VWqeAxRuzLvMA+kg7psNYGRTlJY5ILkmzEIVRXIEEZ4XH9UTFaoQpEusNIHu
 iaCGWltBIMqwVWz4vkhFlq8auU3b2v4hWC1VzYKjyWLF1TPxPYiV5NveOCWH5ulhf4iR7ahne9
 bsHFEoYfvzt7pJylajfOVcmDk35VLHkdmLgwnHGPab5V1GgYh4H+XxBSEn+43tTCM6Qm8ujdrn
 Pz0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:40:35 -0700
IronPort-SDR: gdDVjzw5yeREpsJsPl6S4V0Vd7JglNw+93JGKMAg6SjK8W7fbPpuTnhIFLlZSCpYEDThY/x1tY
 Jw5Lff2+HtTmmK75DlYezQGRLhpoDmdVBRK5KOevrLuO8EIH2BMhUUy4CvdpBC2jlbP+LomfAc
 4GjKFbA58P9XjyxFAbQRnAogXsxA3vzv9jhP2lQG7rdJwxi+/LEVFH21ydb1l/lxJH8L7a6/6p
 3ogW5YKOGiELbtw7ICuzMG8Q/7VS0KZPhtdYAfmK3OD7+bMZh8SF5F5GFvv2Jnv+f4ltf9ZT2v
 cZE=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2024 03:32:14 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 07/11] nvme/rc: introduce NVMET_BLKDEV_TYPES
Date: Tue, 16 Apr 2024 19:32:03 +0900
Message-ID: <20240416103207.2754778-8-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some of the test cases in nvme test group do the exact same test for two
blkdev types: device type and file type. Except for this difference, the
test cases are pure duplication. It is desired to avoid the duplication.
When the duplication is avoided, it is required to control which
condition to run the test.
    
To avoid the duplication and also to allow the blkdev type control,
introduce a new configuration parameter NVMET_BLKDEV_TYPES. This
parameter specifies which blkdev type to setup for the tests. It can
take one of the blkdev types. Or it can take both types, which is the
default. When both types are specified, the test cases are repeated
twice to cover the types.
    
Also add the helper function _set_nvme_trtype_and_nvmet_blkdev_type().
It sets up nvmet_blkdev_type variable for each test case run from
NVMET_BLKDEV_TYPES. It also sets nvme_trtype from NVMET_TRTYPES.

When NVMET_BLKDEV_TYPES and NVMET_TRTYPES are set as follows, the test
case with _set_nvme_trtype_and_nvmet_blkdev_type in set_condition() hook
is called 2 x 3 = 6 times.

  NVMET_BLKDEV_TYPES="device file"
  NVMET_TRTYPES="loop rdma tcp"

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md |  5 +++++
 tests/nvme/rc                  | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 144acd1..6d2f8ae 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -109,6 +109,11 @@ The NVMe tests can be additionally parameterized via environment variables.
 - nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
   Run the tests with the given transport. This parameter is still usable but
   replaced with NVMET_TRTYPES. Use NVMET_TRTYPES instead.
+- NVMET_BLKDEV_TYPES: 'device', 'file'
+  Set up NVME target backends with the specified block device type. Multiple
+  block device types can be listed with separating spaces. In this case, the
+  tests are repeated to cover all of the block device types specified. Default
+  value is "device file".
 - nvme_img_size: '1G' (default)
   Run the tests with given image size in bytes. 'm', 'M', 'g'
 	and 'G' postfix are supported.
diff --git a/tests/nvme/rc b/tests/nvme/rc
index d44a1c1..f678128 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,7 @@ export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
 nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
+NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
 
 # Check consistency of NVMET_TRTYPES and nvme_trtype configurations.
 # If neither is configured, set the default value.
@@ -54,6 +55,27 @@ _set_nvme_trtype() {
 	COND_DESC="nvmet tr=${nvme_trtype}"
 }
 
+_set_nvme_trtype_and_nvmet_blkdev_type() {
+	local index=$1
+	local bd_index tr_index
+	local -a blkdev_types
+	local -a trtypes
+
+	read -r -a blkdev_types <<< "$NVMET_BLKDEV_TYPES"
+	read -r -a trtypes <<< "$NVMET_TRTYPES"
+
+	if [[ -z $index ]]; then
+		echo $(( ${#trtypes[@]} * ${#blkdev_types[@]} ))
+		return
+	fi
+
+	bd_index=$((index / ${#trtypes[@]}))
+	tr_index=$((index % ${#trtypes[@]}))
+	nvmet_blkdev_type=${blkdev_types[bd_index]}
+	nvme_trtype=${trtypes[tr_index]}
+	COND_DESC="nvmet bd=${nvmet_blkdev_type} tr=${nvme_trtype}"
+}
+
 # TMPDIR can not be referred out of test() or test_device() context. Instead of
 # global variable def_flie_path, use this getter function.
 _nvme_def_file_path() {
-- 
2.44.0

