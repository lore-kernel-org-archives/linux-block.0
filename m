Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CEE3D6691
	for <linux-block@vger.kernel.org>; Sat, 16 May 2026 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778933334; cv=none; b=agJwk2p/SP7VKAxGpzGI8vU4nLjAB3UUdcxt/MK30ldmTcn03KF+7DLiHYT3wSlh5dJLM/8McCMWwsLpWT66nAdJ+ZDdad8HSfNbUlIKSxeTArTMSOVVz1ucBjJKyv86vBorLR4rGGH1+qRkvvk6zOc+tlULsrnKOBKY8coXv9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778933334; c=relaxed/simple;
	bh=MBvNMa93C+K5gfKb76R2nR0N55+okXWDE1G4PhAM1kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1cFWFtv/v5Hc8akDoogcz4ffuaa3FmovjMCko0fjVdVtZBJI9Iv2hnHuwr94baK31qm13AZvZyaBuqnosAtfyuhR7v9bN3b6n7qicEUhTMxm9a+sKZLeoJco5ohyE3mG6BH0lXaPsh0t33cLYGX2KRbSFTBTKlAN+mUp2RyJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Amxy5uQl; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Amxy5uQl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1778933332; x=1810469332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MBvNMa93C+K5gfKb76R2nR0N55+okXWDE1G4PhAM1kg=;
  b=Amxy5uQlhvQ1+fZVdB1J5jRc4hs946IrsrILFG2IZKQihEW1U3u5BtoB
   Relwp4R0a8BeEgeGGLl6UG0Vj4qkQ4VtWLeRl0gApqBMlFWR9S08rWnE3
   vrJHXl4Mi/4jbLDZb+ciSjYErjFzcs/w+odmjOPpE0puOQTzbfKeLJo5I
   qwD+GVORaLBxNzO31FiZ5yQ4bLGf/N5y+UH0xJO/uSEyCpFDL1nDhfXB8
   J0GQVR9eaF+hNyNYxmYEr4Nb7pFEHbDTjPVT3JqkJoJR9fHuBZr7m+s7T
   4C3J/XjNIvgVZeal+TvpND+OVDGL7up+sfd2H2O4uQTPyfC6lNOl4CuT8
   w==;
X-CSE-ConnectionGUID: 5WBXdiFyQO+qYcMkvVFK1A==
X-CSE-MsgGUID: Em6FA24HStuu2R3wy5gsXg==
X-IronPort-AV: E=Sophos;i="6.23,238,1770566400"; 
   d="scan'208";a="145562576"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2026 20:07:43 +0800
X-CSE-ConnectionGUID: ZfphAotmRSC8rOI14SSOdg==
X-CSE-MsgGUID: 5y2v2h0zSDKR8hd0lzu/cQ==
IronPort-SDR: 6a085e04_kFgk6cKTFjQwWMA84Frc3nmyeAYaUU6vLn4giWZehuzBQGJ
 awLn9yJXmi+vgqXzgROIVbEslco14X1Xsx5cQKg==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2026 05:07:31 -0700
X-CSE-ConnectionGUID: L1VkjcwFS7GLbZt8u5Bxww==
X-CSE-MsgGUID: w2BBOh++RZOsS4jheLX8xw==
WDCIronportException: Internal
Received: from wdap-zejtyqwo0v.ad.shared (HELO shinmob.wdc.com) ([10.224.105.206])
  by uls-op-esai2-o.wdc.com with ESMTP; 16 May 2026 05:07:31 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 1/3] check: add --cmd-trace option
Date: Sat, 16 May 2026 21:07:27 +0900
Message-ID: <20260516120729.113659-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516120729.113659-1-shinichiro.kawasaki@wdc.com>
References: <20260516120729.113659-1-shinichiro.kawasaki@wdc.com>
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

