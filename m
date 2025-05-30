Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2EA211A27
	for <linux-block@vger.kernel.org>; Fri, 30 May 2025 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748591672; cv=none; b=HvDI7PqFX+ta4vLZyETnVHA4ZsK86/fW2L1WuL2C0IyK8zyCJyIWtxYhBDG7S927HpD/f1CcfAYuflbCmBt2WirIEHZavEuai/COYPGmdZbQudjg+qAdBJy8IyCxWQYI410K/G3Oo1Rg0sB4YD1ddBOkC7rvn2P9xr3RQ+SERVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748591672; c=relaxed/simple;
	bh=KY2nrXI/+7Ei3w06A60gKkVCOh0MhWpAplxQd7TH/aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6qVaDQiY5R8gCnu8Bvqxmk1OEmLj8HtyRE3z/6Ddm0NUOk08XzkgA1ipZPDm0y8kuDthkAq4MWOelKDpw0J00krUwSVTorzqJ58fQ1q5hkihSfrkA+L03Ko2ZxUmnHx1yx9yjTJZCyGd3xGXVuuC7Ix+HTCiiVJcdY08j5CfRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UKOxmifl; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UKOxmifl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748591669; x=1780127669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KY2nrXI/+7Ei3w06A60gKkVCOh0MhWpAplxQd7TH/aw=;
  b=UKOxmifljDpKBLvfVQNbuMBZPuZnjNSDQwhzELzf+hJIfpzcZwas3Tpg
   poi9Or3oKBQopDgnyxx+wnuw/qmXFPN87WV+1GJi9aeKsLHsMKIRMmk/H
   YEZVi+7fkWj1yw7QTMUmRF0yHQurlV5GAnVsOhJsLZOnseXR1if55onwR
   RtxZ5EXmsZG+jlM99Bjd77st6piiQZHbhSX5DfHl8kd5+MafkUxq3JukE
   R73UiXZfVcR0C32UgYI1q1Isy3aTSKx2Hmx8tGJO8oxrkdQYcx3njAoxU
   E6XxsCQDv9UrCmzIZYBIWhH6/HBnKLwqoabhYFuksSbdGk2Ja0tWKeLR9
   g==;
X-CSE-ConnectionGUID: 9JWl8WFRQDi0unjPca9Rjg==
X-CSE-MsgGUID: 6EZY3iYkT1W88pTsDmT5yQ==
X-IronPort-AV: E=Sophos;i="6.16,195,1744041600"; 
   d="scan'208";a="88625260"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2025 15:54:27 +0800
IronPort-SDR: 683955de_Cz9237c3WRwrX+ZUtMU9iUGI7V4cbMKk3+gB8zpF9ECwF7L
 IJ8Bk9512H9iMB+mFR1njhJfRiO3p5wIxxXfSdQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 May 2025 23:53:19 -0700
WDCIronportException: Internal
Received: from 4r6vzh3.ad.shared (HELO shinmob.flets-east.jp) ([10.224.163.85])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2025 00:54:27 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests RFC 1/2] check: allow strict error-checking by "set -e" in each test case
Date: Fri, 30 May 2025 16:54:24 +0900
Message-ID: <20250530075425.2045768-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530075425.2045768-1-shinichiro.kawasaki@wdc.com>
References: <20250530075425.2045768-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bash script development, it is a good practices to handle errors
strictly using "set -e" or "set -o errexit". When this option is
enabled, bash exits immediately upon encountering an error. There have
been discussions about implementing this strict error-checking mechanism
in blktests test cases [1]. Recently, these discussions were revisited,
and it has been proposed to enable this strict error-checking for a
limited subset of test cases [2].

However, the error-checking does not work as expected, even when each
test case does "set -e", because the error-checking has certain
exceptions relevant to execution contexts. According to the bash man
page, "The shell doe not exit ... part of the test following the if or
elif reserved words, ... or if the command's return value is being
inverted with !". The blktests test case execution context applies to
these exceptions.

To ensure that "set -e" behaves as intended in test cases, avoid the
if statements and the return value inversions (!) in the test case
execution context.

Link: [1] https://github.com/linux-blktests/blktests/issues/89
Link: [2] https://lore.kernel.org/linux-block/ckctv7ioomqpxe2iwcg6eh6fvtzamoihnmwxvavd7lanr4y2y6@fbznem3nvw3w/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/check b/check
index dad5e70..3cf741a 100755
--- a/check
+++ b/check
@@ -502,9 +502,9 @@ _check_and_call_test_device() {
 			fi
 		fi
 		RESULTS_DIR="$OUTPUT/$(basename "$TEST_DEV")""$postfix"
-		if ! _call_test test_device; then
-			ret=1
-		fi
+		_call_test test_device
+		# shellcheck disable=SC2181
+		(($? != 0)) && ret=1
 		if (( unset_skip_reason )); then
 			unset SKIP_REASONS
 		fi
@@ -637,9 +637,9 @@ _run_group() {
 	local ret=0
 	local test_name
 	for test_name in "${tests[@]}"; do
-		if ! ( _run_test "$test_name" ); then
-			ret=1
-		fi
+		( _run_test "$test_name" )
+		# shellcheck disable=SC2181
+		(($? != 0)) && ret=1
 	done
 	return $ret
 }
@@ -695,9 +695,9 @@ _check() {
 		if [[ $group != "$prev_group" ]]; then
 			prev_group="$group"
 			if [[ ${#tests[@]} -gt 0 ]]; then
-				if ! ( _run_group "${tests[@]}" ); then
-					ret=1
-				fi
+				( _run_group "${tests[@]}" )
+				# shellcheck disable=SC2181
+				(($? != 0)) && ret=1
 				tests=()
 			fi
 		fi
@@ -705,9 +705,9 @@ _check() {
 	done < <(_find_tests "$@" | sort -zu)
 
 	if [[ ${#tests[@]} -gt 0 ]]; then
-		if ! ( _run_group "${tests[@]}" ); then
-			ret=1
-		fi
+		( _run_group "${tests[@]}" )
+		# shellcheck disable=SC2181
+		(($? != 0)) && ret=1
 	fi
 
 	return $ret
-- 
2.49.0

