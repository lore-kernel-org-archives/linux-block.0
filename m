Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57DE277C9E
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771503761; cv=none; b=s/6nZ5tIeSF4sXSDZmnG1fQUCnKlPFiWJDJ/UgoF/bdr5yePZPDDPKkgcfag4nmU9xZQrSKmA/pjm247c0p8cCAt/1qFGdGvYwR86HBmZKwUdeBznqazTZ6vFaumD79ost/6bdeffyUVS2qbqlrTZshHDwAlkvgayE+l0KXPc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771503761; c=relaxed/simple;
	bh=t1jxowCMRVnWXhCvu55X0Pr/SHNWETwgfFMnMqXS/9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h60wBHL7MboX5QUMt7QEpzftnCPH78V29qML5x2WiRmXwM9nHmNNIYHUmDxFAMT1evK050NFE73IKikEj4h0FtV++7uLBhN6MQrGZdwAhd7S7FoyEMYkB0Ew/r534qa8nmu/8Tv053VIqk2WctkeaAcg5Wu3eLlugI8hgAV96PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=od9AEW/X; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="od9AEW/X"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771503756; x=1803039756;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t1jxowCMRVnWXhCvu55X0Pr/SHNWETwgfFMnMqXS/9o=;
  b=od9AEW/X6RVh5TdwbZElqKQkZuzDJ0PDIbQVpKrWmEt+ivMYjFHRiOf+
   0XABwb7+sZcn5Jr4NW3eWPTbJyy87sTY1wPZuLND2q2SxaZQRsudaeMKc
   AjImocCDD05B4qx/TAz8lxHOeWpJVW1tv4mlTeFYmAKF6prr7yZVvPVBY
   y5cXTx91rl4IH5riTpN+buObpfPVcmfJ14Vrz9JZRER2SvDc2WkrM9aiO
   P0eneiQJ70qYZyL77dhQA8r5iBoU3Vsh37smAdBEd+pkEh+sPjH7pqYjT
   v3NSwYgB0ZjqXjsjzpa+vOcldxzs+0I0DYZKuLFfkyTaYsulB/zPYSHvI
   g==;
X-CSE-ConnectionGUID: Vk4WyiwFRgucglDNSlAk9Q==
X-CSE-MsgGUID: t7X7Je4xQ3eycePFeaWTnA==
X-IronPort-AV: E=Sophos;i="6.21,299,1763395200"; 
   d="scan'208";a="140659069"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2026 20:22:30 +0800
IronPort-SDR: 69970087_hDBDbwzFwDvagwZrPS232QRdCHGwP3L2LojZJv1uEnqhU+y
 cynS3TdBDv5MtrAqLTpdS/uys4m0MFy/iaJ1/xg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Feb 2026 04:22:31 -0800
WDCIronportException: Internal
Received: from 5cg21741tt.ad.shared (HELO shinmob.wdc.com) ([10.224.109.91])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Feb 2026 04:22:30 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] zbd: do not handle write pointer values as numeric for full zones
Date: Thu, 19 Feb 2026 21:22:29 +0900
Message-ID: <20260219122229.174539-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the recent change in util-linux [1], the 'blkzone report' command
no longer reports numeric values for write pointers when zones are in
full condition. Currently, zbd test scripts assume that the write
pointer values are numeric, then the blkzone change triggered failures.
To avoid the failures, check the zone condition and handle the write
pointer values as numeric only when zones are not in the full condition.
Also, drop the "-i" option of the local variable 'wptr' declaration in
zbd/002 so that it can hold non-numerical values.

Link: [1] https://github.com/util-linux/util-linux/commit/b032247f48d8b6a13bf8541eb663c779e448f568
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/002 |  2 +-
 tests/zbd/rc  | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tests/zbd/002 b/tests/zbd/002
index 39c2ad5..ac83c46 100755
--- a/tests/zbd/002
+++ b/tests/zbd/002
@@ -25,7 +25,7 @@ _check_blkzone_report() {
 	local -i next_start=0
 	local -i len=0
 	local -i cap=0
-	local -i wptr=0
+	local wptr=0
 	local -i cond=0
 	local -i zone_type=0
 
diff --git a/tests/zbd/rc b/tests/zbd/rc
index 570928b..921cf62 100644
--- a/tests/zbd/rc
+++ b/tests/zbd/rc
@@ -141,15 +141,22 @@ _get_blkzone_report() {
 	fi
 
 	local _IFS=$IFS
-	local -i loop=0
+	local -i loop=0 cond
 	IFS=$' ,:'
 	while read -r -a _tokens
 	do
 		ZONE_STARTS+=($((_tokens[1])))
 		ZONE_LENGTHS+=($((_tokens[3])))
 		ZONE_CAPS+=($((_tokens[cap_idx])))
-		ZONE_WPTRS+=($((_tokens[wptr_idx])))
-		ZONE_CONDS+=($((${_tokens[conds_idx]%\(*})))
+		# The latest blkzone reports 'N/A' as write pointers for full
+		# zones. In that case, do not handle it as numeric.
+		cond=$((${_tokens[conds_idx]%\(*}))
+		if ((cond == ZONE_COND_FULL)); then
+			ZONE_WPTRS+=("${_tokens[wptr_idx]}")
+		else
+			ZONE_WPTRS+=($((_tokens[wptr_idx])))
+		fi
+		ZONE_CONDS+=("${cond}")
 		ZONE_TYPES+=($((${_tokens[type_idx]%\(*})))
 		if [[ ${ZONE_TYPES[-1]} -eq ${ZONE_TYPE_CONVENTIONAL} ]]; then
 			(( NR_CONV_ZONES++ ))
-- 
2.53.0

