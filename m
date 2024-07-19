Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8A910E5
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 05:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721365651; cv=none; b=n+NpkFLwjHvt0y4vKBChDm+FvEL768R0i4Rv3rrJy+AdxjFv5Svik5zftqy49DPnHwMU56IedR4tlx80CPjJwVRnfxmetLRM9XzN70CeoEActX8e1+ZWuJ0k4KBjJZ6o9nKmiufvvoc24BX3Cjjk+DIC+hZ1ajmilaur6szj4hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721365651; c=relaxed/simple;
	bh=VV8Xy8zYZ0AbYsdY0Gz82RWxPJbZvsfroLpE0IFRuwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHOvNxp4dMFVeoQVhAn89CrOivjZhWYz3nNPakINtSWPQHJa/aAVlq/wt+Gb7f5cypFrDRAeE798ebhHe+0cyt2zO1fHrUbQgMKda1fKbYeJjW7IBzJrc0W7zKfwpv7yrZgfslb6ZgCNFNgUtBLJCA7zD3EYfCGFav61KXevkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gd53kfNG; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gd53kfNG"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1721365650; x=1752901650;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VV8Xy8zYZ0AbYsdY0Gz82RWxPJbZvsfroLpE0IFRuwI=;
  b=gd53kfNGaCtWUjIXvgf3BquNyiOm7Wsu+I+DgIc5Z1K2jdBjJQCbpcvQ
   QcqWW01zugdB0mqIY9eIkQ8BEQ9YXIQ5mXkj2icltFOZ0unnXhfIOCEju
   6q78YIJs+GjuskcGOaq8cNo6DleBTL+nlvDcOGoo8FcSY+Xqz2jLh8Q+b
   79yxrt/vJJKoHta3uJrTCvPY68doOdHqybzh+nfA77MFaI3xBKn6gc+Dr
   oXz7E4ifYWvF8QiB+NZn3r9poqSeYoMdoB74AwDE5EE5JiwWV4AgVIF8P
   CrIUEA7rlOnt0yplIWhfAIS2z3KiRbhFMZGo5rqnuhvCA7LUQrPEoqdkq
   Q==;
X-CSE-ConnectionGUID: cCLImNC9SIeVT8Cfe1mKNQ==
X-CSE-MsgGUID: 055oTG/0QtOBM7Mz80fhfw==
X-IronPort-AV: E=Sophos;i="6.09,219,1716220800"; 
   d="scan'208";a="21610742"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2024 13:07:28 +0800
IronPort-SDR: 6699e801_6OkCyylsBsPsHZjkn8pdQ/dbtF+YfxmJPE/4woZwk+9Olqv
 fYwb/xtX845LPXU5KIQ7DJbcwxjD4P0zWi+YRTw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2024 21:13:53 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jul 2024 22:07:28 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	nbd@other.debian.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2] nbd/rc: check nbd-server port readiness in _start_nbd_server()
Date: Fri, 19 Jul 2024 14:07:26 +0900
Message-ID: <20240719050726.265769-1-shinichiro.kawasaki@wdc.com>
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
Change from v1:
* Reduced sleep time from 1 second to 0.1 second

 tests/nbd/rc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/nbd/rc b/tests/nbd/rc
index e96dc61..e200ba6 100644
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
+	for ((i = 0; i < 100; i++)); do
+		if nbd-client -l localhost &> "$FULL"; then
+			break
+		fi
+		sleep .1
+	done
 }
 
 _stop_nbd_server() {
-- 
2.45.2

