Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84524A066
	for <linux-block@vger.kernel.org>; Fri, 26 Sep 2025 03:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758858104; cv=none; b=Cpc/7VZK60p1kou9vnRrGOCTdnU7Xia9Jv/r9AJFfyfq9oHmGuGr6+Fw9XQETi9S0uT09nfRmk6aL6gudIly1Hk8Iz0cJHIKBYWG/XwAXGusRsYDW3S5rd+QXIROdosS2lKuMt+DnwDAn43qw8B+Ov+ntLWDPiyCgrxs5suS8QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758858104; c=relaxed/simple;
	bh=Qyw24AhaPUxLAeljzHMjJydwZ93vm00LM9fy1mf2ir8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HtuZqydvx54rl5Lsvagf8uKHHislZLMB1Ggije6CVUGqpRkdw7Ak2U7KFbVtPH6DgU99g++8FLgfusYrHQ7dqcdSbukvryVNliKRlGAAt92SbJEPy15+olgxpUR9ikmI8wjGHl3jBxIF3S5ihYHGizRhmrRer3mn+FqONGRKddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hnGtrbkZ; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hnGtrbkZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758858103; x=1790394103;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qyw24AhaPUxLAeljzHMjJydwZ93vm00LM9fy1mf2ir8=;
  b=hnGtrbkZILWu5Uufdu1YEQC8kZWswijNpy/kF6qK+7Dlng9mcFo0+V6K
   mx7vw4jj5RfBumCYuC+yCcgsUttFLandse/2TeMyPMWu/dHRwBO6e3gx5
   K9/fjL9ElyiOwYgHK1W3b7YUQRUNIXftsZN9Y7NsJVAf2kpf6+BlEyKlq
   x3dLtUQN7uSPGFsXQmH0e5K1LnKLyRkfB3rzrm23G+Rf7al/XuateMKzN
   FjyPry2gjjudUC4t5n3gvDzsF8nPj2QadKEV8iDx/Skn6EXjjt/mA+Fos
   EVxVoMPDrD6Rls0/DynVm0PnYM7hG7a4ck4h0xi5DPGo1+Gz/Ba3mdoXJ
   Q==;
X-CSE-ConnectionGUID: pFzcZqt0R1Ofelra2JAhqA==
X-CSE-MsgGUID: p1N+NdjJQnGRAEKpbmu6KA==
X-IronPort-AV: E=Sophos;i="6.18,294,1751212800"; 
   d="scan'208";a="129516934"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2025 11:40:35 +0800
IronPort-SDR: 68d60b33_JiMOSJHHIjeeF4lo/ZmQBDkxGuEs/FeyM5jZDGrIkW31DSa
 yVe/48vGjtTrRSz1ihb6qlRa1M51lzXUgy/RQKA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 20:40:35 -0700
WDCIronportException: Internal
Received: from wdap-k4u0akeroz.ad.shared (HELO shinmob.wdc.com) ([10.224.173.82])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 20:40:34 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] md/rc: use --run option instead of "echo y"
Date: Fri, 26 Sep 2025 12:40:33 +0900
Message-ID: <20250926034033.176349-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As explained in the commit 0e7aabe55e8a ("md/002: use --run option
instead of "echo y""), "echo y" and pipe no longer work with the mdadm
command since mdadm version 4.4. The commit fixed this problem. However,
when the commit cefc4288c469 ("md/rc: add _md_atomics_test") introduced
the helper function _md_atomics_test to factor out the test content in
md/002, the fix was not propagated. Then, md/002 and md/003 do not work
with mdadm version 4.4 again.

Fix it again by using --run option instead of "echo y".

Fixes: cefc4288c469 ("md/rc: add _md_atomics_test")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/md/rc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/md/rc b/tests/md/rc
index 14f4170..d48282f 100644
--- a/tests/md/rc
+++ b/tests/md/rc
@@ -201,10 +201,10 @@ _md_atomics_test() {
 
 			if [ "$personality" = raid0 ] || [ "$personality" = raid10 ]
 			then
-				echo y | mdadm --create /dev/md/blktests_md --level=$personality \
-					 --chunk="${md_chunk_size_kb}"K \
-					--raid-devices=4 --force /dev/"${dev0}" /dev/"${dev1}" \
-					/dev/"${dev2}" /dev/"${dev3}" 2> /dev/null 1>&2
+				mdadm --create /dev/md/blktests_md --level=$personality \
+				      --run --chunk="${md_chunk_size_kb}"K \
+				      --raid-devices=4 --force /dev/"${dev0}" /dev/"${dev1}" \
+				      /dev/"${dev2}" /dev/"${dev3}" 2> /dev/null 1>&2
 
 				atomics_boundaries_unit_max=$(_md_atomics_boundaries_max "$raw_atomic_write_boundary" $md_chunk_size "1")
 				atomics_boundaries_max=$(_md_atomics_boundaries_max "$raw_atomic_write_boundary" "$md_chunk_size" "0")
@@ -220,9 +220,9 @@ _md_atomics_test() {
 
 			if [ "$personality" = raid1 ]
 			then
-				echo y | mdadm --create /dev/md/blktests_md --level=$personality \
-					--raid-devices=4 --force /dev/"${dev0}" /dev/"${dev1}" \
-					/dev/"${dev2}" /dev/"${dev3}" 2> /dev/null 1>&2
+				mdadm --create /dev/md/blktests_md --level=$personality \
+				      --run --raid-devices=4 --force /dev/"${dev0}" /dev/"${dev1}" \
+				      /dev/"${dev2}" /dev/"${dev3}" 2> /dev/null 1>&2
 
 				md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
 			fi
-- 
2.51.0

