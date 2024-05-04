Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4D311C83
	for <linux-block@vger.kernel.org>; Sat,  4 May 2024 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714810503; cv=none; b=TUxP3lfRgGJPwDRXzl8I2bf/llkFGGfWvxecjP8JhGj26zLiybVI9i4uYBDO8dTZSArVDo/JtBhCG5nWKK6Rj64+hLZZPyixefKmFt2HbugTBLGTp5WUO4WX7tEiKQIKui0g6gm+9+2HXaDXQVX0Qgfrr+8YyHFchI30U7jnGH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714810503; c=relaxed/simple;
	bh=scNjPLcz5U6Sk7MLBNiJnev4lHFJRKq4VGZH2fiaUaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUC/0CWuUUaAwCuuOSX+m3RWJE9oKTZuyeXzuKen3byDeSjf9+wqmR4A7JaYb+ieAlrbsOc0YyPeIpqNxIBoUqDaLmkpmEyaXATYPZycgZb0TL52kQEkkGhpItwj/VwC5/sdRUtWvUg5mpF2KHnvazKZvp5gSHrRey36WQGWZng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aa5xQARN; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aa5xQARN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810501; x=1746346501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=scNjPLcz5U6Sk7MLBNiJnev4lHFJRKq4VGZH2fiaUaE=;
  b=aa5xQARN3okUzst4wtuCiXUj3RdvPNBDr61jSqKF2Ybp4tJq4pW+Arlq
   E8MHPCFBNjun5MkxlNzID3443DAN9Pyx+RFfATpQTAm5YEOBjyt8oSZFl
   VhGeofSGf7fmNLE4vxbcWJx73PTV89cQ9/l11j3kYW2Qxo9svA7uGMtl9
   liIZSoL9TUW2FwbBqTKmX0ncVH48MEDpBnqm/U0felVwCEIRj1IzBhYsy
   imXYvTZwYEU0IQpW06rGM+9qjYTgIUOLjI4Di2nbO73zYtbc+FYn/RIyp
   LcG2/On5oTNNMJh7Xde9vcaZaYiZ9nZkhhAnRPep9dWoUaFUnIaXLX2xy
   A==;
X-CSE-ConnectionGUID: Up2H6C/1Rm2VwNoxtJBCEw==
X-CSE-MsgGUID: YLL05JNGTXSApznFWkR1yw==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540309"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:14:57 +0800
IronPort-SDR: TZ35dP5LW1XsDl8ykYF5zjENKFyAzAc/HMajB0rnk6j4ZLtbe5SbXXX/T3XjEo41XRrl5Z9GxJ
 aRVWtsoguKdCw/XIr6Qop5vsddfOCNY8CnR5SVeFNyZqgzxiDERC8RWWS47QUnptWoYdUe2RS3
 c9o32Y7yUBxoHCyqml6mkAGLvvExjFccq7Vpusl8W10cP6P9mhlDMFidaAvacAUyAqJ6bEkqqE
 B7CrqZst72AN24afzQQcaRIABBdWG0AzHL1i92rscj7n1JoM+rjA78QlQc8zvyQ5zfluMAEm6S
 2YQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:22:55 -0700
IronPort-SDR: SzDKZTS73O5IilMQMl5Z5uonEhDgwVnsGdwYRVSSmYGpF6PSLg0zS2t+Z3W1bUlGyFFeDlSGyi
 ITiww7CqspRfSKPebtDuYtjpjgjL6oAml7ZIpj2uEqa7lxjTY/vy8XfWfTcYRQidVJEIL7Cg2W
 8fHptq7jwd4pLX6aQUHA1UveKLEP7cWIBQ8E9ueKhy9J01YnY/RZBSIq7hjZklpkZNEXIw89zZ
 2uIx1LlE/tx2ClKSZdco/+0tP4OJatBA2PCmXZT267eYC/QShJpXKoiIY6Ppv+dj0OeI+WtHtS
 P/U=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:14:56 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 06/17] meta/{018,019}: add test cases to check _set_combined_conditions
Date: Sat,  4 May 2024 17:14:37 +0900
Message-ID: <20240504081448.1107562-7-shinichiro.kawasaki@wdc.com>
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

Add test cases to confirm that the helper _set_combined_conditions is
working. meta/018 combines two hooks, and meta/019 combines three hooks.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/meta/018     | 43 ++++++++++++++++++++++++++++++++++++
 tests/meta/018.out |  2 ++
 tests/meta/019     | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/meta/019.out |  2 ++
 tests/meta/rc      |  5 +++++
 5 files changed, 107 insertions(+)
 create mode 100755 tests/meta/018
 create mode 100644 tests/meta/018.out
 create mode 100755 tests/meta/019
 create mode 100644 tests/meta/019.out

diff --git a/tests/meta/018 b/tests/meta/018
new file mode 100755
index 0000000..4b62d82
--- /dev/null
+++ b/tests/meta/018
@@ -0,0 +1,43 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Western Digital Corporation or its affiliates.
+#
+# Test _set_combined_conditions() helper
+
+. tests/meta/rc
+
+DESCRIPTION="combine two set_conditions() hooks"
+
+conditions_x() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo 2
+		return
+	fi
+
+	meta_x_index=$index
+	COND_DESC="x=$index"
+}
+
+conditions_y() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo 2
+		return
+	fi
+
+	meta_y_index=$index
+	COND_DESC="y=$index"
+}
+
+set_conditions() {
+	_set_combined_conditions conditions_x conditions_y "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+	echo "(x,y)=(${meta_x_index},${meta_y_index})" >> "$FULL"
+	echo "Test complete"
+}
diff --git a/tests/meta/018.out b/tests/meta/018.out
new file mode 100644
index 0000000..e1af26b
--- /dev/null
+++ b/tests/meta/018.out
@@ -0,0 +1,2 @@
+Running meta/018
+Test complete
diff --git a/tests/meta/019 b/tests/meta/019
new file mode 100755
index 0000000..2ec1ed9
--- /dev/null
+++ b/tests/meta/019
@@ -0,0 +1,55 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Western Digital Corporation or its affiliates.
+#
+# Test _set_combined_conditions() helper
+
+. tests/meta/rc
+
+DESCRIPTION="combine three set_conditions() hooks"
+
+conditions_x() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo 2
+		return
+	fi
+
+	meta_x_index=$index
+	COND_DESC="x=$index"
+}
+
+conditions_y() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo 2
+		return
+	fi
+
+	meta_y_index=$index
+	COND_DESC="y=$index"
+}
+
+conditions_z() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo 2
+		return
+	fi
+
+	meta_z_index=$index
+	COND_DESC="z=$index"
+}
+
+set_conditions() {
+	_set_combined_conditions conditions_x conditions_y conditions_z "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+	echo "(x,y,z)=(${meta_x_index},${meta_y_index},${meta_z_index})" >> "$FULL"
+	echo "Test complete"
+}
diff --git a/tests/meta/019.out b/tests/meta/019.out
new file mode 100644
index 0000000..d8828ab
--- /dev/null
+++ b/tests/meta/019.out
@@ -0,0 +1,2 @@
+Running meta/019
+Test complete
diff --git a/tests/meta/rc b/tests/meta/rc
index 3a472be..a2f556e 100644
--- a/tests/meta/rc
+++ b/tests/meta/rc
@@ -57,3 +57,8 @@ EOF
 		echo "$line" >> /dev/kmsg
 	done < "$TMPDIR/dmesg"
 }
+
+# Global variables shared between set_conditions() and test()
+export meta_x_index=
+export meta_y_index=
+export meta_z_index=
-- 
2.44.0

