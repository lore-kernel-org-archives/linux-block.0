Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AC44404
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j1+H6nLD"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF838E
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 21:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700027542; x=1731563542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4jNWZ5+60jJVVgZkKb721hlGX5UTRssjK9g4ZxZnfEQ=;
  b=j1+H6nLDoodv4m2p4XX0Hr+BVA4IjzfR7vPSGaZ3dYpYTBhyib9MDlhe
   cFhRQqaZjKExJdTqdAHo5jelfbChWbN4s+v/p9c3ohP218EsQO3xdQXk0
   ugk+vdXto0fL+4AzyRSVTUFWvBWHjOzhqgxk2vPT1VegMtRZ2x/d0cixV
   YphylGZc1cLcfl+mfuLR15QT77jMpxQZsCS4X6rT347zPkqgXdlP0VYBG
   vsHJ9eNAdk6FUHMRjPz22eUg6CPeFaPlTcVgUKeHNneTAfiShZwTR/WFD
   T9DaMLGMc4xigv1ZUgTUFz2RFDThOrZ52HCU3k77rcuIelEp4gkPsWp5P
   w==;
X-CSE-ConnectionGUID: 4H0xjzk+TkSG3THb0h7fDg==
X-CSE-MsgGUID: 1VpJcfmzT6mgZBNpvm5xHw==
X-IronPort-AV: E=Sophos;i="6.03,304,1694707200"; 
   d="scan'208";a="2334147"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2023 13:52:22 +0800
IronPort-SDR: GugmCs5xL5tHUnv3bQBGTxRgqSrDBPhd8asH2Tm6JPDuIc2OHWhtFuEfAb/PS+D9npcRRtM740
 rzHpEcnb98FB7iOWoI9oF3zSjwu19ffCrxGfuYyGGSqpKCZTpBvXg0b2bJIMHd29JaGwNqYsox
 Aq4f7ZZFBxIXiKpmC21khAKCSWrdb4lji0NSJ/fIIdzkh6ZSc1vUMr5WGZioQMRUIAPOyJ+AXZ
 59bN9Sbvdn0UhxZeZQ/Jtgb+VCUcK4qso5tHooV0jwt54GXF2CzLlh6YtI5oM9UA9B+KEqFaly
 AUs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2023 21:03:49 -0800
IronPort-SDR: Yne2acu87n1pBhflC4zb2qGLmJyAZ3fIBqQX+AvPKHxs2gC7qy7CG8fBy5/JlsTfVlukEUGXza
 2XkuN09TFkQz8uYFN1qkZ9MIf86SIYCVtpPYyyg8k1dimTRQHZ5NkddJwA4aaZwtTHnhHubc/3
 s8Q39vwUlGVrFhynI7TiUNO7WUyvS4bt7PvTvFrGHMbeBNwIORR/k4dff3CQxbwIEy/EPdP82H
 kX5rjDTKSJ8LsCwrAjIyGdYT2hY3WbW+5yssNUg1HsN+LEH0MEsDrKZ8f/hVo+jgK4Me2IGY4P
 1t0=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Nov 2023 21:52:22 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/2] common/rc: introduce _kver_gt_or_eq
Date: Wed, 15 Nov 2023 14:52:19 +0900
Message-ID: <20231115055220.2656965-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115055220.2656965-1-shinichiro.kawasaki@wdc.com>
References: <20231115055220.2656965-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To adjust test conditions per kernel version, introduce the new helper
function _kver_gt_or_eq. Also simplify the similar function _have_kver
using _kver_gt_or_eq.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/common/rc b/common/rc
index c3680f5..a3cdfa6 100644
--- a/common/rc
+++ b/common/rc
@@ -206,15 +206,22 @@ _have_kernel_option() {
 
 # Check whether the version of the running kernel is greater than or equal to
 # $1.$2.$3
-_have_kver() {
+_kver_gt_or_eq() {
+	local a b c
 	local d=$1 e=$2 f=$3
 
 	IFS='.' read -r a b c < <(uname -r | sed 's/-.*//;s/[^.0-9]//')
-	if [ $((a * 65536 + b * 256 + c)) -lt $((d * 65536 + e * 256 + f)) ];
-	then
-		SKIP_REASONS+=("Kernel version too old")
-		return 1
+	(((a * 65536 + b * 256 + c) >= (d * 65536 + e * 256 + f)))
+}
+
+# Check whether the version of the running kernel is greater than or equal to
+# $1.$2.$3 and set SKIP_REASONS.
+_have_kver() {
+	if _kver_gt_or_eq "$1" "$2" "$3"; then
+		return 0
 	fi
+	SKIP_REASONS+=("Kernel version too old")
+	return 1
 }
 
 _have_tracefs() {
-- 
2.41.0

