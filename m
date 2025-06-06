Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5A1C5496
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 03:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749182195; cv=none; b=MbANG9RVEKRjEl3Dr6czs7aA4ZX0yBWnU4AER/Xm8gM7QNiVH3DM5rUFfOklKR1F8TyXfph++bTDTt4yVC9lag9n/eGVz/4cdGi2eYXtiXfSHUhmAyYl0rhFFS6k+7lRJme8oEeSUojRpj7QaMr9L3bicGXnucZQ3JWiSazRZvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749182195; c=relaxed/simple;
	bh=Sx7RYy18a3TE88qkDYTNWJ/VuHNlO2PcJvvQjHCRZ4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/ePf8XUb9sKQ5XElXvA/PRBND2S+FttGGMW0OfUAWbN4khg4Khc0zCz22b6pyW57OPeXNJ8ga4XMAq7ah4kaFasc25guBhayx6P7BkgTqIE7PFxDGhkC5zEvzks0Mi7eyj9Pdd2oe7GZEo6bCcsj1gZKslAgKHlV/CHLvjVsYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NxJqbU20; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NxJqbU20"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749182194; x=1780718194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sx7RYy18a3TE88qkDYTNWJ/VuHNlO2PcJvvQjHCRZ4c=;
  b=NxJqbU20R5bVGEboyKIHWT/w1WzDEMkz4TNp5XJk1QxTtOmriHJ5T2+g
   fQmjxuYx1r6TylZK81oSsv4LOkeVyjvresw0BvGU6TQ4lLSj4k23zsszx
   6Fpdfq7RX8lDPybzOgZVjtAHDazvRibrfEAgDaw+XQfwLW0LaT5M+V5sB
   GxMLdbf0sZvkx+j1Msi9yf9AyriPSryCw5yKdU2BQUh04p/rDg/odgk0T
   FRXn8fyxym3pIhGim2bWZW9SeRtK1Ucmkk5FTfbwBA1REGcEpxptQmAeT
   ucz1P2UTCp7MEVAcqrA0bfOY/o7D1e24twFxveB/p1Jg15HKQ7+mGREW1
   w==;
X-CSE-ConnectionGUID: eij5vwQEQnOiJv8fZLWlXQ==
X-CSE-MsgGUID: 4MdyWx2WR4+3pJpub10fHw==
X-IronPort-AV: E=Sophos;i="6.16,214,1744041600"; 
   d="scan'208";a="86114880"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2025 11:56:33 +0800
IronPort-SDR: 68425890_XFPNP/4CzgqC9h655TaRLopwISZgNejNFq7Pu/d8btSKaJ1
 AN1rTieksUwg7+ftxGkD8/2ijeRU9HNFBFVahng==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jun 2025 19:55:12 -0700
WDCIronportException: Internal
Received: from 5cg21505sl.ad.shared (HELO shinmob.flets-east.jp) ([10.224.163.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Jun 2025 20:56:32 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/2] check: allow strict error-checking by "set -e" in test cases
Date: Fri,  6 Jun 2025 12:56:29 +0900
Message-ID: <20250606035630.423035-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606035630.423035-1-shinichiro.kawasaki@wdc.com>
References: <20250606035630.423035-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bash script development, it is a good practice to handle errors
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

Link: https://github.com/linux-blktests/blktests/issues/89 [1]
Link: https://lore.kernel.org/linux-block/ckctv7ioomqpxe2iwcg6eh6fvtzamoihnmwxvavd7lanr4y2y6@fbznem3nvw3w/ [2]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/check b/check
index dad5e70..f11ce74 100755
--- a/check
+++ b/check
@@ -502,9 +502,10 @@ _check_and_call_test_device() {
 			fi
 		fi
 		RESULTS_DIR="$OUTPUT/$(basename "$TEST_DEV")""$postfix"
-		if ! _call_test test_device; then
-			ret=1
-		fi
+		# Avoid "if" and "!" for errexit in test cases
+		_call_test test_device
+		# shellcheck disable=SC2181
+		(($? != 0)) && ret=1
 		if (( unset_skip_reason )); then
 			unset SKIP_REASONS
 		fi
@@ -637,9 +638,10 @@ _run_group() {
 	local ret=0
 	local test_name
 	for test_name in "${tests[@]}"; do
-		if ! ( _run_test "$test_name" ); then
-			ret=1
-		fi
+		# Avoid "if" and "!" for errexit in test cases
+		( _run_test "$test_name" )
+		# shellcheck disable=SC2181
+		(($? != 0)) && ret=1
 	done
 	return $ret
 }
@@ -695,9 +697,10 @@ _check() {
 		if [[ $group != "$prev_group" ]]; then
 			prev_group="$group"
 			if [[ ${#tests[@]} -gt 0 ]]; then
-				if ! ( _run_group "${tests[@]}" ); then
-					ret=1
-				fi
+				# Avoid "if" and "!" for errexit in test cases
+				( _run_group "${tests[@]}" )
+				# shellcheck disable=SC2181
+				(($? != 0)) && ret=1
 				tests=()
 			fi
 		fi
@@ -705,9 +708,10 @@ _check() {
 	done < <(_find_tests "$@" | sort -zu)
 
 	if [[ ${#tests[@]} -gt 0 ]]; then
-		if ! ( _run_group "${tests[@]}" ); then
-			ret=1
-		fi
+		# Avoid "if" and "!" for errexit in test cases
+		( _run_group "${tests[@]}" )
+		# shellcheck disable=SC2181
+		(($? != 0)) && ret=1
 	fi
 
 	return $ret
-- 
2.49.0

