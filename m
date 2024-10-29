Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3F23207
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 05:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730178921; cv=none; b=nXiCe4Ht4prMrdSMB+Gp5P49mUbCweBbyxZmoZ9yMkQCP37L5dq/quibv1bwgLyrXhj68bS7KTwwKbC10EMwRuM1czGFP8cngof04sR6/LSfYoeo24Ge2uBtw5S25tiemJqmbvVurCTe6cBPouyFKgULRVOJGbtmFqO9o4MxeSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730178921; c=relaxed/simple;
	bh=cJA6s4E3ZEhKfKpVZuPyACiHIBUu67Q4MOzHkmwK0FU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k23dWYntz7NhM8iTDfMnuDBchepNDcJUYbGvqhHBu3N2MKKHN0RwIKtPpGJmGD32Q7eH+pOLbijbxF8Wu1RyBjfAUj6M7t/O43DDu230YyRgwgY0AgJTAyvGSbiH2eAyUG6oo937Jc/r3ewZ77g6KD7g1oJlumJR7NUNqcMT4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=i0421iGZ; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="i0421iGZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1730178920; x=1761714920;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cJA6s4E3ZEhKfKpVZuPyACiHIBUu67Q4MOzHkmwK0FU=;
  b=i0421iGZGcPiHtbnXvP9fU07cQVFXJymOFf1M9RJTyWJsqoUcMkjnB7b
   fmbq6NK9aOodAoIEiTCvySLkSWblo+y6FYA8QRrGg8SPYFK8C3iOyUsaG
   eDatPmDx/t8nKoYOmWnHAwbADYQob8liyYT2fGlBlsoQfKjPbYVNjyQf+
   2IXOWwtjDxxfsLSv7Fb3orLbccaIDrGi7rTFFDYtlybrU6TdAryxvKsrm
   0Z+CS6x4YjduDLcSn2BJfIrgFbuRF8PTkMHVmnyBe+C2ZMp6i3kCHoHrV
   1RMTZZznGNiY/FU19V9cM/zOR3MM3T1UlT0gPGdo1dEH6p5z0GwhGd8ON
   w==;
X-CSE-ConnectionGUID: uD40vKdmQRaeEZ3e+HR4mQ==
X-CSE-MsgGUID: qqOwbJwZThGmY7vSBGqczA==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="178352982"
X-IronPort-AV: E=Sophos;i="6.11,241,1725289200"; 
   d="scan'208";a="178352982"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 14:15:11 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9634FD800D
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 14:15:08 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 916AFD8B84
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 14:15:07 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 150E120071A23
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 14:15:07 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 7B97D1A000B;
	Tue, 29 Oct 2024 13:15:06 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH blktests] common/rc: Uniform the style of skip reasons
Date: Tue, 29 Oct 2024 13:15:51 +0800
Message-ID: <20241029051551.68260-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28760.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28760.005
X-TMASE-Result: 10--6.956600-10.000000
X-TMASE-MatchedRID: I9ykbN1Sk6oKm5kt79XbMUrOO5m0+0gEwJjn8yqLU6IN76LiU8znttko
	t/+2LaVUIvrftAIhWmLy9zcRSkKatfKr9yWLaG8NkbMiEOIxZesbdKgBZxTjZUuzcQ+Ei1EduIV
	Zbzw4/Ft3VlnbOGqjUnQJpsmqtg2cHxPMjOKY7A8LbigRnpKlKSPzRlrdFGDwRpbXPFk2zk/mIJ
	65vdzhcNHE8fs6mvK3PBtZ/JDdZSNt6nh0ne7HIQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Before:
srp/***                                                      [not run]
    driver scsi_dh_alua is not available
    driver scsi_dh_emc is not available
    driver scsi_dh_rdac is not available
    dm_multipath module is not available
    dm_queue_length module is not available
    dm_service_time module is not available
    ib_srpt module is not available
    ib_umad module is not available
    null_blk module is not available
    scsi_debug module is not available
    target_core_iblock module is not available
    sg_reset is not available

After:
srp/***                                                      [not run]
    driver scsi_dh_alua is not available
    driver scsi_dh_emc is not available
    driver scsi_dh_rdac is not available
    module dm_multipath is not available
    module dm_queue_length is not available
    module dm_service_time is not available
    module ib_srpt is not available
    module ib_umad is not available
    module null_blk is not available
    module scsi_debug is not available
    module target_core_iblock is not available
    command sg_reset is not available

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 common/rc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index 6a9a26c..b2e68b2 100644
--- a/common/rc
+++ b/common/rc
@@ -70,7 +70,7 @@ _have_driver()
 # built-in the kernel.
 _have_module() {
 	if ! _module_file_exists "${1}"; then
-		SKIP_REASONS+=("${1} module is not available")
+		SKIP_REASONS+=("module ${1} is not available")
 		return 1
 	fi
 	return 0
@@ -84,7 +84,7 @@ _have_module_param() {
 	fi
 
 	if ! modinfo -F parm -0 "$1" | grep -q -z "^$2:"; then
-		SKIP_REASONS+=("$1 module does not have parameter $2")
+		SKIP_REASONS+=("module $1 does not have parameter $2")
 		return 1
 	fi
 	return 0
@@ -106,7 +106,7 @@ _have_module_param_value() {
 
 	value=$(cat "/sys/module/$modname/parameters/$param")
 	if [[ "${value}" != "$expected_value" ]]; then
-		SKIP_REASONS+=("$modname module parameter $param must be set to $expected_value")
+		SKIP_REASONS+=("module $modname parameter $param must be set to $expected_value")
 		return 1
 	fi
 
@@ -117,7 +117,7 @@ _have_program() {
 	if command -v "$1" >/dev/null 2>&1; then
 		return 0
 	fi
-	SKIP_REASONS+=("$1 is not available")
+	SKIP_REASONS+=("command $1 is not available")
 	return 1
 }
 
-- 
2.44.0

