Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE618CC17
	for <linux-block@vger.kernel.org>; Tue, 20 Aug 2024 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149286; cv=none; b=GqyD9lPuhfoqk0N1Lj6oWnZl2uTE2zJbU6HbhFq7spL2R1Zl3E7zZSXwLG0sJ6WD+VKvpBUZnd7s1W6vdPEbDTXf7YTJ+FaT9MA2Xa3+WZLmUBWWI5VCqmgjI4cCqouumumavmxZkPqU0ofMgKmn8rimy0gopXqG3LRtgWTy4LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149286; c=relaxed/simple;
	bh=4o+DhSlo/OhU/pk4QGtJc7Pdkc2s297MR/AIhOIm2/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D2aLyKuYpFFTAtFTTPRSQbnqvA6FO0JJpkeezyLgxtSkrOzsgPRpUKSyo2VFsE1r4CJgcG30pQ1wzdBfhpoPW0JxmyfbJiY6PEOTTREytUUlKKBULbPR9q29bqZ3pJrthHG3XgCkGw/836YaMloKTD/cZmQtAcRhTbOwzgqnpzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jCZZs8Eg; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jCZZs8Eg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724149283; x=1755685283;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4o+DhSlo/OhU/pk4QGtJc7Pdkc2s297MR/AIhOIm2/8=;
  b=jCZZs8EgAv/ufrWu9AqQJxMyNt1+KPjuIYbDpSiwmdMxFshVQjOMvdXy
   ugMgbXL2SBIXWSyEKm7AzGAOxJH8zLa/B/hX7X9VZPB/zUBOt8M2UnGxP
   1QxGxAMoFsmK/QN5zNSISA6EBu8F1T5KUpFJOVyEPk82Jxh5RlZIzlwpQ
   /TzJSt9mNZsBRLjdGk4hAo+AuP6jzSFOnuPEsEYZ7Sw9rnTv7GhULAke4
   Ky5W/cY2cq/rMCbQLz82sHu2jDuPg0o61NMLJXlC7LJBWomPcq/1fK78P
   qP/s2RHlcesR+/UMChtjgfaDm9TwvMs3jO3KD6z23SmP3oqE0vaPD8141
   Q==;
X-CSE-ConnectionGUID: PexZCQ+bQsiar0i7abjpNg==
X-CSE-MsgGUID: x4s3opCtQEy7Vm+v7aqDjQ==
X-IronPort-AV: E=Sophos;i="6.10,161,1719849600"; 
   d="scan'208";a="25463055"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2024 18:20:14 +0800
IronPort-SDR: 66c46128_IhCx+2lzXeT+53fZuO7Od+VDqLbSnF189yi/hgzMAQtsJY1
 uSH5HuAT6WB1u2JFQer5OxVrLPDIO2bwL0+JqEQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2024 02:26:01 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Aug 2024 03:20:14 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/052: wait for namespace removal before recreating namespace
Date: Tue, 20 Aug 2024 19:20:13 +0900
Message-ID: <20240820102013.781794-1-shinichiro.kawasaki@wdc.com>
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
the namespace. For this purpose, add the new helper function
nvmf_wait_for_ns_removal(). To specify the namespace to wait for, get
the name of the namespace from nvmf_wait_for_ns(), and pass it to
nvmf_wait_for_ns_removal().

The test case intends to catch the regression fixed by the kernel commit
ff0ffe5b7c3c ("nvme: fix namespace removal list"). I reverted the commit
from the kernel v6.11-rc4, then confirmed that the test case still can
catch the regression with this change.

Link: https://lore.kernel.org/linux-block/tczctp5tkr34o3k3f4dlyhuutgp2ycex6gdbjuqx4trn6ewm2i@qbkza3yr5wdd/
Fixes: 077211a0e9ff ("nvme: add test for creating/deleting file-ns")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Nelay, Yi, thank you for the feedbacks for the discussion
thread at the Link. Here's the formal fix patch.

 tests/nvme/052 | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/052 b/tests/nvme/052
index cf6061a..e1ac823 100755
--- a/tests/nvme/052
+++ b/tests/nvme/052
@@ -39,15 +39,32 @@ nvmf_wait_for_ns() {
 		ns=$(_find_nvme_ns "${uuid}")
 	done
 
+	echo "$ns"
 	return 0
 }
 
+nvmf_wait_for_ns_removal() {
+	local ns=$1 i
+
+	for ((i = 0; i < 10; i++)); do
+		if [[ ! -e /dev/$ns ]]; then
+			return
+		fi
+		sleep .1
+		echo "wait removal of $ns" >> "$FULL"
+	done
+
+	if [[ -e /dev/$ns ]]; then
+		echo "Failed to remove the namespace $ns"
+	fi
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
 	_setup_nvmet
 
-	local iterations=20
+	local iterations=20 ns
 
 	_nvmet_target_setup
 
@@ -63,7 +80,7 @@ test() {
 		_create_nvmet_ns "${def_subsysnqn}" "${i}" "$(_nvme_def_file_path).$i" "${uuid}"
 
 		# wait until async request is processed and ns is created
-		nvmf_wait_for_ns "${uuid}"
+		ns=$(nvmf_wait_for_ns "${uuid}")
 		if [ $? -eq 1 ]; then
 			echo "FAIL"
 			rm "$(_nvme_def_file_path).$i"
@@ -71,6 +88,7 @@ test() {
 		fi
 
 		_remove_nvmet_ns "${def_subsysnqn}" "${i}"
+		nvmf_wait_for_ns_removal "$ns"
 		rm "$(_nvme_def_file_path).$i"
 	}
 	done
-- 
2.45.2

