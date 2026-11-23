Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.71.154.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795419745;
	b=tne9gxjqv+a4SHUSARH3s5q34Vdubr8M/0ZPJTddKLQrfYmjilm1DxNVgS3JAYFQZN9u
	 VkSX7MlGDgFLwGuoEipXJkH1L59hscP6X3UMfzML7lOLKZlUphbnOxNS+pGTb/jro/Qrj
	 3dEhFCP6mPyTwenbYVu0zt0YneG9gR0np6MXYAX6w19XoTIHWFNkU7wNeHrtOFWG+Njou
	 6W3wXeOOTTIbWOhqiQfgp+82U7YRziSqw/KQe+DsSlWSbU2fV4oeqhuLDQaBYm7uvSfD3
	 fu5C1X3zhMzoqo4MoCypNlPFQeSPVlrFj2Q7XWW7fFyCTjtE2Fzj+JFijy5rIu9TMhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795419745;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 IronPort-SDR:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 WDCIronportException:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=XX/UPCKp/YOud/Nk2FEAAiZRkVqumzqqTFMCQ2ihimQ=;
	b=B9Id7SzYe9n0AgSNvPztSBMH/ESPNAi9eSooiMx4Q+EWKGUO1gri295MWEFVxoK84NmI
	 +Bb3XdAvqecXm13oTWVzWB7x8/BOCxvyLyx5DQA/3pOU+/7XlIcdCytg0QW/48B22WQOj
	 cI4Cx2UgMQPSbw6ytsyrdyaUM3rQBnSuQJrIDlKZCkLrqKkHrlTWejQKapTDh4vRQbzZG
	 7fFaH7U9wXu4cZw4lYENI5siVJboC33VI7ttLPOgMMSSjHF7qSM1I8kcXnQTkoc17PXG/
	 Wn28WkEfpe/npqjxeF9CyxvrAsukvv3GeGI2TbzJiWcgNBcM5BxCkFza/aWBng4RoKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=cKp9petU;
	arc=none smtp.remote-ip=216.71.154.45
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F30606A31A
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 07:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89F30606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=cKp9petU
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795419744; x=1826955744;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f2w98vmrsQ5YTEWsGzRFWWG8lUit3s008i9OPf4FgTo=;
  b=cKp9petUJJmGiNWTTCcA+ehkWMWaPGVRKYQyQwMp1LCwOqZP0AkfaYJ4
   jFTVyHUxzHnuwuuFKpVuSgKcn8wBnOhwBcNW+AjhwuP0CcWmZZ8uCj5cf
   h8JhRab5tsRt+qJ0WnvVxfzZAyxWerffBhuU/dwEVuVbTmyqUijXG3mpW
   9Dd4FdxYWwzwioykyaWc4OaqBNWFI13y/KsOCNYaL9/xED+GZftyaitSD
   JL6jJTuXxYmVRev1Z2eQ7Yx4Erus3wzauP4/Dp5bwTsQi6S5pCcK2BY+C
   8iMmC/6g3D/OgLu/nEz2M0gpZbgtaadPRXuo8muyJrRPBSwFongdIQ/Yn
   A==;
X-CSE-ConnectionGUID: wBdzRm77RiqJvIlWayFJfQ==
X-CSE-MsgGUID: kSivLPsOQLqvylIU3WF1Gw==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; 
   d="scan'208";a="159923146"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Nov 2026 15:42:18 +0800
X-CSE-ConnectionGUID: osq12VOSQVWl6CiEItCjsA==
X-CSE-MsgGUID: UU+Rcbb8QL2iE5jANEGVjw==
IronPort-SDR: 6b03ee5a_qQOuPOGUV7T4xeA/vrQZmd3inizpeG51aXpSAelF8nepzMz
 r9TVhsXbSVzUMU0y0viFpV3kKmZfTA9/38GC/8g==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Nov 2026 23:42:18 -0800
X-CSE-ConnectionGUID: Q48hYuvZSoiUPMpwTGvI2g==
X-CSE-MsgGUID: osZscT+pRtqrtYj8KrtmnQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 22 Nov 2026 23:42:18 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Daan De Meyer <daan@amutable.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] check: avoid double calls of the cleanup function
Date: Mon, 23 Nov 2026 16:42:17 +0900
Message-ID: <20261123074217.1446119-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the commit e25f27939668, the registered cleanup function is called
twice: once from the explicit _cleanup() call in _call_test(), and once
more from the EXIT trap when the test subshell exits. At the second
call, TMPDIR has already been removed and unset, and the output is no
longer redirected to the test output file.

This was unnoticed because existing cleanup functions work fine at the
second call. However, the cleanup function of the new test case added by
GitHub PR 260 does not work well. It refers to TMPDIR to stop the nbd
server, and the second call prints the error messages below:

     cat: /nbd.pid: No such file or directory
     tests/nbd/rc: line 87: kill: `': not a pid or valid job spec

Avoid the second call by unsetting TEST_CLEANUP after calling it.

Link: https://github.com/linux-blktests/blktests/pull/260
Fixes: e25f27939668 ("check: Add the ability to call a cleanup function after a test ends")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 1 +
 1 file changed, 1 insertion(+)

diff --git a/check b/check
index 3ef36b4..58eae3c 100755
--- a/check
+++ b/check
@@ -417,6 +417,7 @@ _register_test_cleanup() {
 _cleanup() {
 	if [[ -v TEST_CLEANUP ]]; then
 		${TEST_CLEANUP}
+		unset TEST_CLEANUP
 	fi
 
 	if [[ "${TMPDIR:-}" ]]; then
-- 
2.56.0

