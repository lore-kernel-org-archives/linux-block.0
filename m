Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DAA25774
	for <linux-block@vger.kernel.org>; Tue, 25 Jun 2024 02:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719283907; cv=none; b=YM2lUlqnG7ti7XUQQ+p3ymLJzaHUR0veYr5bbeCRoW4Fjak24VYCT7JRCwmIo5ueVSXalS9w1RaC1R+49vU5Wgff812DJt8erGnUVb+0u8S7OmZMxkLCCNHmduzJnbfamS5YwgyZDEXwXkgcUSQNGTda/qJn0Jt6/Udk9tOkFro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719283907; c=relaxed/simple;
	bh=6x0MLYvdLV/fg3pFPUWxsxb/gzwvruJROEmqIcrkmvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWyAILJ0JF5QJtJXSocFUKMaojOtoQ7c2ZI/Uq5mR+3dsi+Mkp5G8MNewDLEYxi6mUE/Kg1wxVPMs6krokoTg23PPduDOxOxscyl/7jecxmuEum++9zE80trC+6w8rbCl8zsn0znUjcbj7Oyd5cVsc5hFYxzn48rFqLBp7/m55Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=f15634hw; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f15634hw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719283905; x=1750819905;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6x0MLYvdLV/fg3pFPUWxsxb/gzwvruJROEmqIcrkmvo=;
  b=f15634hw2nuGzsGJnMv/D2rFUo/1hj7kayn8xmF4Uaz7tdcRAamH5MpT
   9RzHJpyMiJKDNycAuyvOOeM+c6JvPDim8oLEOK4ZpteWZq6mrN/SN3Ap1
   IqfZzwNWVakxNGC+LJj8Z1hm1pBMddMNxiEiIyah75MQeZ1otycxU+4Hp
   lrwzXpoK3G9FZAshQQW0VbQv90/2Aiq441dwrbV5rHK03l1+NrMcVftvY
   JJuNCqribJqSBIWQqurMPd95dANA0n/QIOcrCFT3ahqXPZ9rYreJfecwD
   RfnpQZUlVxNDXDQhNwzW/7Pmp4KR59AJEyg3h2h6KbOQgiNKlkcKjIZhw
   w==;
X-CSE-ConnectionGUID: rrmD/oSQRe2BAeqWKpEhYw==
X-CSE-MsgGUID: YlHQ4iJ6SvyNARMvovWQzQ==
X-IronPort-AV: E=Sophos;i="6.08,263,1712592000"; 
   d="scan'208";a="19914508"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2024 10:51:44 +0800
IronPort-SDR: 667a2450_2wWuU7aDEIaQNNHZBJ1fn3OP/++O90G1bonscVc/ptkgyFe
 SEO9gQS+BHzokeNg1gp79VSLLPZ7r8+Jd0D1+Nw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jun 2024 18:58:40 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Jun 2024 19:51:44 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Bryan Gurney <bgurney@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] dm/002: do not assume 512 byte block size
Date: Tue, 25 Jun 2024 11:51:43 +0900
Message-ID: <20240625025143.405254-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case assumes that TEST_DEV would have 512 byte block size
always. However, TEST_DEV may have non 512 byte, 4k block size. In that
case, the test case fails with I/O errors.

To avoid the errors, refer to the block size of TEST_DEV. Also record
dd command output to the FULL file to help debug work in the future.

Reported-by: Christoph Hellwig <hch@lst.de>
Fixes: 7308e11c595a ("tests/dm: add dm-dust general functionality test")
Link: https://lore.kernel.org/linux-block/ZmqrzUyLcUORPdOe@infradead.org/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/dm/002 | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/dm/002 b/tests/dm/002
index 6635c43..fae3986 100755
--- a/tests/dm/002
+++ b/tests/dm/002
@@ -14,10 +14,12 @@ requires() {
 
 
 test_device() {
+	local sz bsz
 	echo "Running ${TEST_NAME}"
 
-	TEST_DEV_SZ=$(blockdev --getsz "$TEST_DEV")
-	dmsetup create dust1 --table "0 $TEST_DEV_SZ dust $TEST_DEV 0 512"
+	sz=$(blockdev --getsz "$TEST_DEV")
+	bsz=$(blockdev --getbsz "$TEST_DEV")
+	dmsetup create dust1 --table "0 $sz dust $TEST_DEV 0 $bsz"
 	dmsetup message dust1 0 addbadblock 60
 	dmsetup message dust1 0 addbadblock 67
 	dmsetup message dust1 0 addbadblock 72
@@ -30,7 +32,8 @@ test_device() {
 	dmsetup message dust1 0 addbadblock 72
 	dmsetup message dust1 0 countbadblocks
 	dmsetup message dust1 0 enable
-	dd if=/dev/zero of=/dev/mapper/dust1 bs=512 count=128 oflag=direct >/dev/null 2>&1 || return $?
+	dd if=/dev/zero of=/dev/mapper/dust1 bs="$bsz" count=128 oflag=direct \
+	   >"$FULL" 2>&1 || return $?
 	sync
 	dmsetup message dust1 0 countbadblocks
 	sync
-- 
2.45.0

