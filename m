Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFB73D9666
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671438; cv=none; b=iTCb4k2dFmdaW68kl2E3GtJKVyWIL9//nd+JH2FJPua81G2I49fHGeT4A6SAIIpLa2bG0p1Y7176LUg0h6kwUXrfAhuRwWPdov/pqpuy9kzel6WgAbxJOpxNLOyTkcNmg0KsqsjzgWrMRznT+BQ0KPDu16uI8zcfpHBHuzWvTa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671438; c=relaxed/simple;
	bh=MBvNMa93C+K5gfKb76R2nR0N55+okXWDE1G4PhAM1kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFM7zv0w3CA6UL44WDJP2Yn9/1iQJfG1v1klKpfwKRg9JV15TjHtXMaUrncYytQz/AkXZZJgv1OLnD7BCzxG66Ta1bXJCL/YdjNRiEAad2ctTs7GYGuWBryFgTETO00OiQCEZn2+ahYe4anO1YDvVCYxtUxrngiQdkNwD20VOrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LsIqKyYJ; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LsIqKyYJ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1778671437; x=1810207437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MBvNMa93C+K5gfKb76R2nR0N55+okXWDE1G4PhAM1kg=;
  b=LsIqKyYJK75WwADL4Mgjvv8gi4kYR2VQUzRm4GGUo6E58fIzRdBqSfy0
   bMmruCwirlVT5afA4EkXKO/beIsxn9kU23BPjLOvxyBOWQcKla5Owx3VN
   tcxEbReIWBp3uoo84sKiWSsjSqrgaow4YFF5G6Z65UEBuW9pSTme2DAfq
   mhyZgsdCO3hESnQIU825VjesUem2Bb8TJ4FCa++IqDmwxI5TPMNRTxX5U
   jH86b2Fdqg2YjkKPruBHv765V4UWh0kV/xvEVvzCzTPAkL61BEo+Bmc3K
   4jUvLYbIO49U6+SI6p6yXifCghG1PxHdaflzSf/1OTUcynfdmGt+9mwRp
   Q==;
X-CSE-ConnectionGUID: KGPJlbNsS96E4oGmj7L88Q==
X-CSE-MsgGUID: BW7zVkzQSSudgFi5wa/kIA==
X-IronPort-AV: E=Sophos;i="6.23,232,1770566400"; 
   d="scan'208";a="145918710"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2026 19:23:54 +0800
X-CSE-ConnectionGUID: WeT+srYKSYCzIHpLelwAwQ==
X-CSE-MsgGUID: B75ziZmcRYm7xqdkAsP6Bg==
IronPort-SDR: 6a045f31_JmxPcaMB2jGCx1p6GtkG13F1raXxJH71cXX+ZFL5Hi62A0/
 51oJlag3BuMCVQ6FVAgdxF1Dog6F8NAvgdE/vKQ==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 May 2026 04:23:28 -0700
X-CSE-ConnectionGUID: Mget5pCGRJ6lhbfZ2pMA8g==
X-CSE-MsgGUID: NPG+vUPhR0yJvB+at5Mf8Q==
WDCIronportException: Internal
Received: from wdap-o209afpuln.ad.shared (HELO shinmob.iptvf.jp) ([10.224.105.138])
  by uls-op-esai2-o.wdc.com with ESMTP; 13 May 2026 04:23:28 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/3] check: add --cmd-trace option
Date: Wed, 13 May 2026 20:23:24 +0900
Message-ID: <20260513112326.584256-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513112326.584256-1-shinichiro.kawasaki@wdc.com>
References: <20260513112326.584256-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test cases that use helper functions can be difficult to understand due
to deep nesting. To make test execution easier to follow, add a new
--cmd-trace (or -t) option to record the commands executed during test
runs.

The trace is implemented using bash's xtrace feature. Enable xtrace with
`set -x` before each test case and redirect the trace output to a
`.cmdtrace` file in the result directory.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/check b/check
index c166fae..a68049b 100755
--- a/check
+++ b/check
@@ -458,7 +458,17 @@ _call_test() {
 
 		TIMEFORMAT="%Rs"
 		pushd . >/dev/null || return
+		if ((CMD_TRACE)); then
+			exec 8>"${seqres}.cmdtrace"
+			export BASH_XTRACEFD=8
+			set -x
+		fi
 		{ time "$test_func" >"${seqres}.out" 2>&1; } 2>"${seqres}.runtime"
+		if ((CMD_TRACE)); then
+			set +x
+			unset BASH_XTRACEFD
+			exec 8>&-
+		fi
 		TEST_RUN["exit_status"]=$?
 		popd >/dev/null || return
 		TEST_RUN["runtime"]="$(cat "${seqres}.runtime")"
@@ -1157,7 +1167,7 @@ Miscellaneous:
 
 _check_dependencies
 
-if ! TEMP=$(getopt -o 'do:q::x:c:h' --long 'device-only,quick::,exclude:,output:,config:,help' -n "$0" -- "$@"); then
+if ! TEMP=$(getopt -o 'do:q::x:c:th' --long 'device-only,quick::,exclude:,output:,config:,cmd-trace,help' -n "$0" -- "$@"); then
 	exit 1
 fi
 
@@ -1165,6 +1175,7 @@ eval set -- "$TEMP"
 unset TEMP
 
 LOADED_CONFIG=0
+CMD_TRACE=0
 OPTION_EXCLUDE=()
 while true; do
 	case "$1" in
@@ -1192,6 +1203,10 @@ while true; do
 			LOADED_CONFIG=1
 			shift 2
 			;;
+		'-t'|'--cmd-trace')
+			CMD_TRACE=1
+			shift
+			;;
 		'-h'|'--help')
 			usage out
 			;;
-- 
2.54.0

