Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9D23A5E75
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 05:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774331424; cv=none; b=U3KwfTeQMRL4tvxlgsrAoUAjS8VZFXkakbjKnQ7lW0A9Nu2d4wCdcaaOrM0CZJBSgBUgrBTzfUWswkX6ghccoBOuRZ9urIJkjYZTyGK4IiAUg9KIRz5vXdYnVOnEvcwhUudlTezKjQIoNF5BmdN7LvPxBPTOwufL+54N1ROH6+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774331424; c=relaxed/simple;
	bh=9zsTq3JkQTmr+vDmo9NRlJ8WM+iWNWUrc1xSnNWfWXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0hL1JJzfi0dB39zA9Ljy34mYdhpzT5EvaK1lO0KSGZmfZ5LFWZaxfJvqg2u3TTjjbj3DUwAmckvA4JhBTgYpXUbkCswtaNa9EDZmV3Ij+JC7PneEmEPdLRJ34MI3OuMQu/3NBWR0HTJ8zEBPfo2lQ/Dg3r8gZeHZNJ/rtSwFeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Js1yqf4m; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Js1yqf4m"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1774331421; x=1805867421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9zsTq3JkQTmr+vDmo9NRlJ8WM+iWNWUrc1xSnNWfWXo=;
  b=Js1yqf4m7oeKdST5BCKer6fS44Teng8uljU70QIozgyXwrBgWFNKeW0K
   eU79srZSxEWQNCdtzkCqyRqDb4JFC+Ub5VOkTDUYM3VbfANxN+ZeJlGSO
   ZwDmxR+pRZ+C6qho11ZBnpF5GtTFlpJUBhzxfvSKQLZgAP3xjPTWIc3w7
   f+EVz5QFwRpdRTe7hwEqcLSlcgh+Fc5O93EtUTLH+b7nMwYU+bQwCGa+c
   NBU5u7MvDwABo7ZNIBU9KWS7DIayhjNYsZz4QtnxTggQd4sUyHvFdJK3O
   YFqK13Ojup9zlBBR0c5GSgBvcbLpvUX5AtZcoHdKNwFws9dVuKJxF4tDa
   g==;
X-CSE-ConnectionGUID: /fsDcNKIQSmXrFIVkPyOdg==
X-CSE-MsgGUID: XIAAHCnmSk+KtohC/gFc9A==
X-IronPort-AV: E=Sophos;i="6.23,138,1770566400"; 
   d="scan'208";a="143614102"
Received: from unknown (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2026 13:50:07 +0800
IronPort-SDR: 69c22603_1v+MGB50r8GbxffcTeO8N3tXtdjgrG0+1+MzcCvqbEyL8Xx
 CBOV2BrSSak7+EWDzTqAcPcum9vU8qiaJhPA3Jw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2026 22:49:56 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Mar 2026 22:49:56 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 7/7] zbd/012: add missing scsi_debug check
Date: Tue, 24 Mar 2026 14:49:49 +0900
Message-ID: <20260324054949.3821569-8-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260324054949.3821569-1-shinichiro.kawasaki@wdc.com>
References: <20260324054949.3821569-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case uses loadable scsi_debug, but it misses the check for it.
Add the missing check.

Fixes: 3ca2657f94b8 ("zbd/012: Test requeuing of zoned writes and queue freezing")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/012 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/zbd/012 b/tests/zbd/012
index b2bda5c..c2e47f3 100755
--- a/tests/zbd/012
+++ b/tests/zbd/012
@@ -13,6 +13,7 @@ TIMED=1
 
 requires() {
 	_have_fio_zbd_zonemode
+	_have_loadable_scsi_debug
 }
 
 toggle_iosched() {
-- 
2.49.0

