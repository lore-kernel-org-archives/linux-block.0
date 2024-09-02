Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A20513D8A0
	for <linux-block@vger.kernel.org>; Mon,  2 Sep 2024 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274504; cv=none; b=Pfk0fhAk1+Q82Io8by63A9oDpN3FRPuMUcCcyXL9sItY2K49Art/MF7Za3Ifjmkw3RL50ZN//iKzKi8F+Z1vBLYW09C8G8VayXzyIfOgap+pDPJEKEKEAtfQDyIeva1UA/8RvFnL5ip2AoPW0j8cBssqPaaJhr/zuX7lV2bYXdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274504; c=relaxed/simple;
	bh=JyPcls83KWw9SuUDl/7+enyapQXtuGJ/1njd0TwRkzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dYAIkSO0fQXhFMNtEJCnaEYTbEINldxJGgnQYOOXnN9BG/VG8wxt2+Ty8WU33AGuu8zueu9Ijr7ljdfwIggk0UyA7aSalwx+/erSN5sIQSS1kfWd9FuaoekL3uQeuT5P8kOTdSFPDiyYJypGEDSHOTSRyGCFgF/vU3D9rr319wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Nk3nliTd; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Nk3nliTd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725274502; x=1756810502;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JyPcls83KWw9SuUDl/7+enyapQXtuGJ/1njd0TwRkzY=;
  b=Nk3nliTdU09whqBQsQz3N79dye3oBs8XeI4LsDjVi0z5+1Ij0QjU7cCs
   hcJ7rnr1Ih25nUWpjl6DGuo+qR15ax1C0rXHzld93aFH/eugn9xKePI8Q
   FjVutS5KNWrZf8HecU2/tEuVj+o9xmrdMu5td3d2C+oIHQNM/HpYNZZxV
   eb6yjmrLw0mQ5vst+1848hmY/RzZPG11DdRVhSCAs2ki/DCjKHej+UkuF
   3FLov+zQsWnPvzz/jBd00WVWE/EaqLs6/EgLDyYtYp0tusH6OfPjHhmqA
   YqHB0D3sRxVmnZ2fUmXeF54yyKix7Namx5eTbQSNQ2YtBwfXCfK4kuCK7
   g==;
X-CSE-ConnectionGUID: x/KhaIWySJqfdawfbS2UvQ==
X-CSE-MsgGUID: lJjn0jNHQbKh2Ak1UArdLw==
X-IronPort-AV: E=Sophos;i="6.10,195,1719849600"; 
   d="scan'208";a="26096698"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2024 18:54:56 +0800
IronPort-SDR: 66d58b65_AMFVxkAIH0CFIvOaufWO+H1p5KPZZI3AaTdcHyG0uwHUh05
 4l/UK1D8hLr1Jp7sTDxqBT6LhXeBkFwj3Oa36qA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 02:54:46 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Sep 2024 03:54:55 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3] nvme/052: wait for namespace removal before recreating namespace
Date: Mon,  2 Sep 2024 19:54:54 +0900
Message-ID: <20240902105454.1244406-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CKI project reported that the test case nvme/052 fails occasionally
with the errors below:

  nvme/052 (tr=loop) (Test file-ns creation/deletion under one subsystem) [failed]
      runtime    ...  22.209s
      --- tests/nvme/052.out    2024-07-30 18:38:29.041716566 -0400
      +++
+/mnt/tests/gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/archive/production/kernel-t\
ests-production.zip/storage/blktests/nvme/nvme-loop/blktests
+/results/nodev_tr_loop/nvme/052.out.bad        2024-07-30 18:45:35.438067452 -0400
      @@ -1,2 +1,4 @@
       Running nvme/052
      +cat: /sys/block/nvme1n2/uuid: No such file or directory
      +cat: /sys/block/nvme1n2/uuid: No such file or directory
       Test complete

The test case repeats creating and removing namespaces. When the test
case removes the namespace by echoing 0 to the sysfs enable file, this
echo write does not wait for the completion of the namespace removal.
Before the removal completes, the test case recreates the namespace.
At this point, the sysfs uuid file for the old namespace still exists.
The test case misunderstands that the the sysfs uuid file would be for
the recreated namespace, and tries to read it. However, the removal
process for the old namespace deletes the sysfs uuid file at this point.
Then the read attempt fails and results in the errors.

To avoid the failure, wait for the namespace removal before recreating
the namespace. Modify nvmf_wait_for_ns() so that it can wait for
namespace creation and removal. Call nvmf_wait_for_ns() for removal
after _remove_nvmet_ns() call. While at it, reduce the wait time unit
from 1 second to 0.1 second to shorten test time.

The test case intends to catch the regression fixed by the kernel commit
ff0ffe5b7c3c ("nvme: fix namespace removal list"). I reverted the commit
from the kernel v6.11-rc4, then confirmed that the test case still can
catch the regression with this change.

Link: https://lore.kernel.org/linux-block/tczctp5tkr34o3k3f4dlyhuutgp2ycex6gdbjuqx4trn6ewm2i@qbkza3yr5wdd/
Fixes: 077211a0e9ff ("nvme: add test for creating/deleting file-ns")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v2:
* Avoided conditional stderr redirect of _find_nvme_ns

Changes from v1:
* Reused nvmf_wait_for_ns() instead of introuducing nvmf_wait_for_ns_removal()
* Added check of nvme_wait_for_ns() return value

 tests/nvme/052 | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tests/nvme/052 b/tests/nvme/052
index cf6061a..401f043 100755
--- a/tests/nvme/052
+++ b/tests/nvme/052
@@ -20,23 +20,27 @@ set_conditions() {
 	_set_nvme_trtype "$@"
 }
 
+# Wait for the namespace with specified uuid to fulfill the specified condtion,
+# "created" or "removed".
 nvmf_wait_for_ns() {
 	local ns
 	local timeout="5"
 	local uuid="$1"
+	local condition="$2"
 
-	ns=$(_find_nvme_ns "${uuid}")
+	ns=$(_find_nvme_ns "${uuid}" 2>> "$FULL")
 
 	start_time=$(date +%s)
-	while [[ -z "$ns" ]]; do
-		sleep 1
+	while [[ -z "$ns" && "$condition" == created ]] ||
+		      [[ -n "$ns" && "$condition" == removed ]]; do
+		sleep .1
 		end_time=$(date +%s)
 		if (( end_time - start_time > timeout )); then
 			echo "namespace with uuid \"${uuid}\" not " \
-				"found within ${timeout} seconds"
+				"${condition} within ${timeout} seconds"
 			return 1
 		fi
-		ns=$(_find_nvme_ns "${uuid}")
+		ns=$(_find_nvme_ns "${uuid}" 2>> "$FULL")
 	done
 
 	return 0
@@ -63,14 +67,21 @@ test() {
 		_create_nvmet_ns "${def_subsysnqn}" "${i}" "$(_nvme_def_file_path).$i" "${uuid}"
 
 		# wait until async request is processed and ns is created
-		nvmf_wait_for_ns "${uuid}"
-		if [ $? -eq 1 ]; then
+		if ! nvmf_wait_for_ns "${uuid}" created; then
 			echo "FAIL"
 			rm "$(_nvme_def_file_path).$i"
 			break
 		fi
 
 		_remove_nvmet_ns "${def_subsysnqn}" "${i}"
+
+		# wait until async request is processed and ns is removed
+		if ! nvmf_wait_for_ns "${uuid}" removed; then
+			echo "FAIL"
+			rm "$(_nvme_def_file_path).$i"
+			break
+		fi
+
 		rm "$(_nvme_def_file_path).$i"
 	}
 	done
-- 
2.45.2

