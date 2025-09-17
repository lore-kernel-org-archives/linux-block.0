Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACD53451BF
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109765; cv=none; b=V5r5A+2d7UgJCE1r7BnDEgUNX44+dtnpU/y1rwUbq6pQISZ5X0kl5x6hrvFa0CUNTEUBVm+MNhOoR1pCO7piZ0TuKXsAghW01g+F7nTWdNQXTSD900WRhnRqsv3JVJ8N+7hs/lpXUoXRqoPHlvv5hKNP25OizG2nxhVAmtja/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109765; c=relaxed/simple;
	bh=P31ZPPFI8RHZLaZUYOMQoer9rNdoRvpJOCWhchNMg9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2x0Hr1A3p4mgxzMD+6HuAf9iLLacj+iZUE/SeWoDQkzs50FZgqtNJyXH43nw+N4B8+bEYCIz6NbioObZT0BgzGEUSx7cSN8ZiVaILICvwQwnmChet3K9OvM/GHs4PAiAiC8zDWEUec6R9Qd6nI1DQGU8L3jVLt0pCeRZX/v9U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fH8WPrQL; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fH8WPrQL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758109763; x=1789645763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P31ZPPFI8RHZLaZUYOMQoer9rNdoRvpJOCWhchNMg9Q=;
  b=fH8WPrQLe/ToYbwdhED1MTHFADa+cSWN5P+vkuYkeDq72ZD3+UXVtsfE
   L5HZPMAx799BorJE53uf+6kgO5CpzGh5eqqcUbD9vOEN5h67HFyA3vl3t
   M+dcHeJpHp2JGMw3NM6Cu82mojecb0WcmpmAQxR7fKpNjhpr1azup6lqA
   nKQdjJw/lZu3HnCai9LZUD8JxuGX+QUaqmlDSxK6x5oBUaFOu77eeADCB
   ULPNcFC6/8DwXqxPaRy90kExaM519nWBWH1I4JT1A4OvQdd6VayE8xBj8
   Qb5KjaHQAbhwHwO0vi8vjuk+XundrLvlyEQBAajexCpomTejvrxH66osW
   Q==;
X-CSE-ConnectionGUID: jx4rqkWhRiqO7TeXzOlGZQ==
X-CSE-MsgGUID: SwpUb9hGSnWgFraGTEsxDw==
X-IronPort-AV: E=Sophos;i="6.18,271,1751212800"; 
   d="scan'208";a="122448534"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2025 19:49:23 +0800
IronPort-SDR: 68caa043_ha/XPp9/sv4hXEkDhHJKEm2RLI32lnagf8flM7Rq7WQhyv3
 SsHuN64TqCP9uDMyLlumqohNj8viXSHmXHXSFug==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 04:49:23 -0700
WDCIronportException: Internal
Received: from dr34yd3.ad.shared (HELO shinmob.wdc.com) ([10.224.163.71])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Sep 2025 04:49:23 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	John Garry <john.g.garry@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/5] check: factor out _check_exclusive_functions()
Date: Wed, 17 Sep 2025 20:49:13 +0900
Message-ID: <20250917114920.142996-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917114920.142996-1-shinichiro.kawasaki@wdc.com>
References: <20250917114920.142996-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for the following change, introduce the helper function
_check_exclusive_functions().

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/check b/check
index f11ce74..cd6f927 100755
--- a/check
+++ b/check
@@ -13,6 +13,13 @@ _error() {
 	exit 1
 }
 
+_check_exclusive_functions() {
+	if declare -fF "${1}" >/dev/null && declare -fF "${2}" >/dev/null; then
+		_warning "${test_name} defines both ${1} and ${2}"
+		return 1
+	fi
+}
+
 _found_test() {
 	local test_name="$1"
 	local explicit="$2"
@@ -31,10 +38,7 @@ _found_test() {
 		return 1
 	fi
 
-	if declare -fF test >/dev/null && declare -fF test_device >/dev/null; then
-		_warning "${test_name} defines both test() and test_device()"
-		return 1
-	fi
+	_check_exclusive_functions test test_device || return 1
 
 	if ! declare -fF test >/dev/null && ! declare -fF test_device >/dev/null; then
 		_warning "${test_name} does not define test() or test_device()"
-- 
2.51.0

