Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB13F4132
	for <linux-block@vger.kernel.org>; Fri, 15 May 2026 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823090; cv=none; b=oThflhs/a/pxgHWep2C0ulC9xe7xmA9dcztyrkP/0dnQT8LIPhr3/LwW5LzvzfnQ0dUSFHLIvy/+ru+4ALySIkCA5NxGWMX4DVmH0m3wHKaIfL7Fh4vGnhqfSR9pLpqvXNNefytc1R/nyjgVckMEcnRPQt//PqhpaqxBPwzgAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823090; c=relaxed/simple;
	bh=v8pNUrpcBdGVPpVECnZ6fIbKfIHozyqVx+b1cP5wYNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p75QGQqIAP18+0yiDVhmcVC09K6mJUjCv3GOr4CMMbHEfYTRUXyEk5yVwkhckucHxIEWIACLEVgcC9LSglR1HcA/b6baXsqAhefAlK1+GjI80UuvBszIwFnCYrOoswK5uI+aP6g2/bEGF7Q9zmqY/wfLGOl/jIVD81GTEcQrDTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ge51HZ8w; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ge51HZ8w"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1778823088; x=1810359088;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v8pNUrpcBdGVPpVECnZ6fIbKfIHozyqVx+b1cP5wYNc=;
  b=ge51HZ8wsXgcucltlbt2VOhh8d41n8+2+amhPVfZHnAX2zXE2RB7Lm+3
   TVrJsZ3ms0E/jq7IgQeREI878TLgCcjv+Japy/jOX8ZMla/QQ2FhE05j8
   RUiziPc9UYE7FTGMrgMAY/Oj5fjR/dAZ+qOaJY11qrNh7XkV5oXeoLPHW
   rI3zyxReIqjMpwmr/EYoGa5XhqpslrK8y+oAVQO7TFoQF4e0PCYa1u4VA
   8hcb5lPNfE4c4utgrXAyYH3W5+rxZyelCWbIeXFOiDP20xIbkvTJNdpXT
   ndCJD7sKbaAyD3VQnVxZNUSO0OeyFlZjrjLn+K73v7sNnYjFCDKg6GHdk
   A==;
X-CSE-ConnectionGUID: PLcTFdqvSU2++WuLnnA1iA==
X-CSE-MsgGUID: 4dWx2prkQEqmLama3cgrLA==
X-IronPort-AV: E=Sophos;i="6.23,235,1770566400"; 
   d="scan'208";a="146052015"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2026 13:31:19 +0800
X-CSE-ConnectionGUID: x1hObSytRqqbaCIPcY1GJQ==
X-CSE-MsgGUID: RvtechrsTSy2l1je0RgcoQ==
IronPort-SDR: 6a06af89_UUEF6oM794BopLlrnAdAM3pka7x0hGtynpT1CxVYHmAiBIw
 g4+fqfk37MqzgT4ItL95e6JjqL8X28dQCYF5QyQ==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2026 22:30:48 -0700
X-CSE-ConnectionGUID: WIKwhuzVRmCRp2kfenYGCg==
X-CSE-MsgGUID: o0TWEpVETiq7o0jCztdHkw==
WDCIronportException: Internal
Received: from 5cg10868bz.ad.shared (HELO shinmob.iptvf.jp) ([10.224.105.166])
  by uls-op-esai1-o.wdc.com with ESMTP; 14 May 2026 22:30:49 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	nbd@other.debian.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nbd/rc: redirect nbd-server stderr
Date: Fri, 15 May 2026 14:30:47 +0900
Message-ID: <20260515053047.64075-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent nbd commit da5e07c057ab ("Reimplement daemonize() without using
daemon()") changed how nbd-server daemonizes itself. After this commit,
nbd-server prints messages to stderr after daemonization. This caused
nbd test cases to fail due to unexpected stderr output.

nbd/001 (resize a connected nbd device)                      [failed]
    runtime  0.865s  ...  0.883s
    --- tests/nbd/001.out	2025-04-22 13:13:27.727873155 +0900
    +++ /home/shin/Blktests/blktests/results/nodev/nbd/001.out.bad	2026-05-15 11:44:46.269000000 +0900
    @@ -1,4 +1,5 @@
     Running nbd/001
    +Error: Session terminated by client
     Disk /dev/nbd0: 10.7GB
     nbd0 43:0 0 10G 0 disk
     Setting size to 1gib

The commit is in nbd version v3.27, which is included in Fedora 44.

To avoid the failures, redirect nbd-server stderr to .full files.

Link: https://github.com/NetworkBlockDevice/nbd/commit/da5e07c057ab
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nbd/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nbd/rc b/tests/nbd/rc
index e200ba6..6205c49 100644
--- a/tests/nbd/rc
+++ b/tests/nbd/rc
@@ -72,7 +72,7 @@ allowlist=true
 [export]
 exportname=${TMPDIR}/export
 EOF
-	nbd-server -p "${TMPDIR}/nbd.pid" -C "${TMPDIR}/nbd.conf"
+	nbd-server -p "${TMPDIR}/nbd.pid" -C "${TMPDIR}/nbd.conf" 2> "$FULL"
 
 	# Wait for nbd-server start listening the port
 	for ((i = 0; i < 100; i++)); do
-- 
2.54.0

