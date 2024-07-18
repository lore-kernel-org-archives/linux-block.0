Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FEE4D8A1
	for <linux-block@vger.kernel.org>; Thu, 18 Jul 2024 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721301136; cv=none; b=IPA8hVKY8OjdvH0M9wKtCxm7H9z5J342X0EoPDiOoprDsQCgpisLQIixpjbw3kNV2/xUeRMo/VhqIibNUZIlkmAHxcoSvLxcahm6O9so3oURyHpovj8liukxuPHYPb2slmgUzu87twaw0ybW3iBgnyvruPkCI7+zNLHXzyTP4Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721301136; c=relaxed/simple;
	bh=DTmS+6O7O1eZq3aJCgHyvagxmYMDIEkYQB8dqTNt8j8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tnt5WS7xUBueEVP6vghp0+QJFRLkDpxgIpbxivAW4I2cLyVvQ6HSz4gPKwwEsZbE4mc75gHENgah6SWSb/yUZ4KmGnvhS2uI92VNMUt4rCK4KWZ777JSMazzMzKYZo9R+HbuycIJo6CJL2GP6pGEnR94pP2SR1rgGfMcjIxnMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cMqJSWx+; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cMqJSWx+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1721301135; x=1752837135;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DTmS+6O7O1eZq3aJCgHyvagxmYMDIEkYQB8dqTNt8j8=;
  b=cMqJSWx+vnTlX/D4Pn6dFgU4amv5+nlCWu46DMd7k5s2bwCZXFA0099w
   VwiBQCM/3CwD6uHLESCq72U3a3ymi0oeaXDDlpYPrp7pF3FFDWfas4QIr
   uqo3Zqj7XXn40sgoi7nWkgLzDNEB6XstdsRnsiHyfimR4xYM5YkGuE0D+
   LG2bqyttPevF5HSKjp5hDKOytaKnexKBBHFoDhA7DNWAyqkcHGVbY/a//
   dW13/ei2gS0M+tN/UhiV1e1GAqiGW+a8jLb4pKuw+hHUqMvxz4v0EEuyZ
   /LKWRhQ0vhWaDUbdPI+r8oj9OPCVglUC2MtP0xPzt/vUmPQQQZsN3ZF4n
   Q==;
X-CSE-ConnectionGUID: x8OJPKBzSHCpCuqhbp1i2Q==
X-CSE-MsgGUID: DnYYHkbjRySQpsWwTXDNYQ==
X-IronPort-AV: E=Sophos;i="6.09,217,1716220800"; 
   d="scan'208";a="21544099"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2024 19:12:08 +0800
IronPort-SDR: 6698ebfa_eTDosLcurxX/mdOfsxCy6nAuw/3WC1QiDjo2qE1Y1Lq18LK
 xexSFzHtv+qLiNf6m0wf8yY7fDbYs73yluMb3uQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2024 03:18:35 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jul 2024 04:12:07 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	nbd@other.debian.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nbd/rc: check nbd-server port readiness in _start_nbd_server()
Date: Thu, 18 Jul 2024 20:12:07 +0900
Message-ID: <20240718111207.257567-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, CKI project reported nbd/001 and nbd/002 failure with the
error message "Socket failed: Connection refused". It is suspected nbd-
server is not yet ready when nbd-client connects for the first time.

To avoid the failure, wait for the nbd-server start listening to the
port at the end of _start_nbd_server(). For that purpose, use
"nbd-client -l" command, which connects to the server and asks to list
available exports.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Link: https://github.com/osandov/blktests/issues/142
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nbd/rc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/nbd/rc b/tests/nbd/rc
index e96dc61..a56bae5 100644
--- a/tests/nbd/rc
+++ b/tests/nbd/rc
@@ -63,13 +63,24 @@ _wait_for_nbd_disconnect() {
 }
 
 _start_nbd_server() {
+	local i
+
 	truncate -s 10G "${TMPDIR}/export"
 	cat > "${TMPDIR}/nbd.conf" << EOF
 [generic]
+allowlist=true
 [export]
 exportname=${TMPDIR}/export
 EOF
 	nbd-server -p "${TMPDIR}/nbd.pid" -C "${TMPDIR}/nbd.conf"
+
+	# Wait for nbd-server start listening the port
+	for ((i = 0; i < 10; i++)); do
+		if nbd-client -l localhost &> "$FULL"; then
+			break
+		fi
+		sleep 1
+	done
 }
 
 _stop_nbd_server() {
-- 
2.45.2

