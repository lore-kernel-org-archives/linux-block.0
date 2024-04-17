Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933CD13C669
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350535; cv=none; b=SeLFu3gKp8j2xG9O7InbSKeVdGam/u1pm8kWKkGx9+YTkKdO5Nze2P6WGhR2t5kua6spIfJrYA0Z6e1stJSu6jXg69pGmwiZlEfCPHLde/oVKVFuDIPHLDNzrfNM1YRbSG4RcBGNCqsx7/JSsI5BmdoY9DxJJ1kVMSOmn1rRU0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350535; c=relaxed/simple;
	bh=g3fx1ZTkHRAoDOZOkdg+UOQMZLU5smY4eolMVN8yWPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7VMcPfqhOO27dNtu80Lixa1H3kk0MQj6hx+8/L0DpMraLxkfcCIB0xNilgef/RhbTuBaoHGWEvThIvZ20P7aQN1X74yL140FWDr0kMbk+7QcLGFTwxMgMomRfejOARgQdX9SauuRALZaHHnNwcQdzAaaqbdtM8jAQC31NnD4Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RXBDiRyl; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RXBDiRyl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713350533; x=1744886533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g3fx1ZTkHRAoDOZOkdg+UOQMZLU5smY4eolMVN8yWPg=;
  b=RXBDiRylX1HF6Io2bzZ3ug36wbY+7WlcW7IgLMkUhwPs/lzyABH5gHaz
   A5BFtFdqUeVHLdbuTrTxtBhqrwOTAKyrqcFCXrrDE7tafngWytCpoBQ2G
   uqyJrRQKFJC8YcnpXabpFwK4z+in55xKGXIfLKtEXypQbdVQss9GCquE2
   WL0wYkojFr1IXNEyJMIIb7yJsXUzXDiqWSUZjNaJRV1WS8vZ/b2e/XV2x
   spw4H9jyumFIV+D/bxM1sFedYZedWTNThQNiWx9JMz3kVEKZpkaxLJGo9
   TiDENAvKXnKhiRqa+/uw6ORjWcH/BboDxmV4IsMco8/wPpf3yXJ/nEm95
   A==;
X-CSE-ConnectionGUID: crJ0WLQMT8GXPGiltpLZxQ==
X-CSE-MsgGUID: seLPxtj4Q7yB601KdFMt8Q==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="14913462"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 18:42:12 +0800
IronPort-SDR: s0MLqSAiP9XP86Or1h9WNdkaZky1JDhb/Q+qFnXaO8SlhieqVpFm9mwPh5RQsy/wK6PhvQ69ZO
 L2hsb5dVPjJ1qCbtMknOSmxC9B7hlM9y7ktcXerDKs1l0XfFQJbansaC+qfaUxtYISaX098uqL
 O1m+2kdG0MsYNkhxerCy59ChflC0fOWMgl8ybWycUm1Karu9/AqsE/3c02OM0ZJCVDC9m2XFIe
 8GgxwMhuaJS6iyZ4biEoMEfw9/1Y8jJ/VbkuF4kZ3VyH6HUAuzAa/RQlFLnqX3I5BPfdO1fhOb
 mDw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2024 02:44:50 -0700
IronPort-SDR: TgN2iPQSnxWxnpydXPHereC4u1YXV0HsheYkj204Wsc1vXCoUPopvgdAkz/ZYWifaxsk3Ui0UC
 u+BhJIfslqPozNamHXM3+uFE+6w1nLrR3mmsdu3qBf6e9u4RK/LNqS/m7oojriPRh/QmcD2fCU
 RxCrYjLIiLD4NtbYu15OU+GA1MVGtpjppTzZ0jf+BgJmYJotTsH+j1fhJh6jcfmyNgeAocLIq+
 c/UIvwLREBZQatUW4vsadPXm+3/TtegnCwucqFUdCEtq0GEs7BEHG8mrL/6ZBF3H9cSn3AEBMW
 vnQ=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Apr 2024 03:42:11 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: nbd@other.debian.org,
	Josef Bacik <josef@toxicpanda.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 1/2] nbd/002: fix wrong -L/-nonetlink option usage
Date: Wed, 17 Apr 2024 19:42:08 +0900
Message-ID: <20240417104209.2898526-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417104209.2898526-1-shinichiro.kawasaki@wdc.com>
References: <20240417104209.2898526-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the commit 3c014acd5171 ("nbd/001: use -L for nbd-client") explains,
the nbd-client command uses the netlink interface instead of the ioctl
interface. The default interface changed at nbd version 3.17 in March
2018. Before that, the default was ioctl. After the change, the
nbd-client command requires -L or -nonetlink option to use the ioctl
interface.

The commit 3c014acd5171 adjusted nbd/001 test script to the default
interface change. However, it is not reflected to nbd/002. This caused
mismatch between the comments in the test case and the actual test. The
comments describe the first half as "Do it with ioctls", and the last
half as "Do it with netlink". However, the test script does opposite. It
specifies no option for the first half, then tests with netlink
interface. It specifies -L option for the last half, then tests with the
ioctl interface.

This makes it difficult to debug the failure of the test case. Fix the
nbd-client command option to match the comments. Also, use the long
option -nonetlink instead of -L for easier reading.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nbd/002 | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/nbd/002 b/tests/nbd/002
index fd992a0..968c9fa 100755
--- a/tests/nbd/002
+++ b/tests/nbd/002
@@ -53,11 +53,11 @@ test() {
 
 	echo "Testing IOCTL path"
 
-	nbd-client -N export localhost /dev/nbd0 >> "$FULL" 2>&1
+	nbd-client -nonetlink -N export localhost /dev/nbd0 >> "$FULL" 2>&1
 
 	if ! _wait_for_nbd_connect; then
 		echo "Connect didn't happen?"
-		nbd-client -d /dev/nbd0 >> "$FULL" 2>&1
+		nbd-client -nonetlink -d /dev/nbd0 >> "$FULL" 2>&1
 		_stop_nbd_server
 		return 1
 	fi
@@ -66,12 +66,12 @@ test() {
 
 	if ! stat /dev/nbd0p1 >> "$FULL" 2>&1; then
 		echo "Didn't have partition on ioctl path"
-		nbd-client -d /dev/nbd0 >> "$FULL" 2>&1
+		nbd-client -nonetlink -d /dev/nbd0 >> "$FULL" 2>&1
 		_stop_nbd_server
 		return 1
 	fi
 
-	nbd-client -d /dev/nbd0 >> "$FULL" 2>&1
+	nbd-client -nonetlink -d /dev/nbd0 >> "$FULL" 2>&1
 
 	udevadm settle
 
@@ -83,7 +83,7 @@ test() {
 
 	# Do it with netlink
 	echo "Testing the netlink path"
-	nbd-client -L -N export localhost /dev/nbd0 >> "$FULL" 2>&1
+	nbd-client -N export localhost /dev/nbd0 >> "$FULL" 2>&1
 
 	if ! _wait_for_nbd_connect; then
 		echo "Connect didn't happen?"
@@ -96,12 +96,12 @@ test() {
 
 	if  ! stat /dev/nbd0p1 >/dev/null 2>&1; then
 		echo "Didn't have partition on the netlink path"
-		nbd-client -L -d /dev/nbd0 >> "$FULL" 2>&1
+		nbd-client -d /dev/nbd0 >> "$FULL" 2>&1
 		_stop_nbd_server
 		return 1
 	fi
 
-	nbd-client -L -d /dev/nbd0 >> "$FULL" 2>&1
+	nbd-client -d /dev/nbd0 >> "$FULL" 2>&1
 
 	if ! _wait_for_nbd_disconnect; then
 		echo "Disconnect didn't happen?"
-- 
2.44.0

