Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878EA2E06EF
	for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508439; cv=none; b=ilCziazFWqLoHYPkh+bhmCFPs6xD4hzXikDYzaLCl/yFA3uymjsx1CHTDg9VxNogU9aw+H2FwpYSb9VOXFVsQvi/JWE9CGNMv7Qc77+0FGsYB0T3Zcg9y1p8q7mCG84dD+QCRIc+vEH9qYewhfZy6KmPeoIMWbe98zvAYaV1Z+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508439; c=relaxed/simple;
	bh=lqdw+k88tm2fEdDryyBemEiiLch5x1qX2nXiNN9SMWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OolB/xHYOIKh2FKRUqkqWYR4Bc3ZiFlZujHvEZbUS7LXUgA57LEgMwGTNm15erxBW5PXPAHzYRqS7hgyN/9aVAR4xJcPMdWN+kVUFRp5I78eVZ+zdSVOkd5C5W4w4+vHfoGyJov02UiXKfSTH/X0RpDlpJHSYx7FVzgUMarxFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bletJGNL; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bletJGNL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769508438; x=1801044438;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lqdw+k88tm2fEdDryyBemEiiLch5x1qX2nXiNN9SMWs=;
  b=bletJGNL15ZD7uOpv7rSYOfhSBItRY3TQTuQZGcgV1eGf5hZUd7UamTP
   SzphlqF38kqP9wvFyV5+MaMEGsTx6YJ0m7gKS1nBILSGXn8ONA/+b/tza
   vtqQ1sW6wTGQmDGk3sIyf63v2CcaOQKvegN9jchyiZncEJAnPDE1xk6qy
   T8/+2TCNCCtU6d0hDoLp/ihTZabdH81gR2fhlWI3U56Yg6aqY1XejCUri
   f8W8gk4XxBIa7a2Mo6fJWrkIcapEL0hHiaachNiiQDr9JDmwwNHn8B9GY
   EuEduIIYsAsXcFv+Luu70TTAUmpmDlcLSGKQZMQbLe+d0DzMaR906mAmc
   A==;
X-CSE-ConnectionGUID: OqW/VffTQyu6Wc9DeX41xg==
X-CSE-MsgGUID: JMUWoIgMRMqMNhgofdbZUA==
X-IronPort-AV: E=Sophos;i="6.21,256,1763395200"; 
   d="scan'208";a="140209796"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2026 18:07:12 +0800
IronPort-SDR: 69788e4f_2HOZcrTTzJAaioK/xOYF3zbsR3JvlEPFh8UDdav1m3a2lhh
 uWuSTo0K5RqvlK+iKZHN/XuG/yJhOvcyM1C2tUQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2026 02:07:12 -0800
WDCIronportException: Internal
Received: from wdap-avhia5abdg.ad.shared (HELO shinmob.wdc.com) ([10.224.105.241])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2026 02:07:12 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] common/fio: ignore fio messages about random generator selection
Date: Tue, 27 Jan 2026 19:07:10 +0900
Message-ID: <20260127100710.383851-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The latest fio after the commit 1d282baecd68 ("fio: make sure that child
process output is comitted") often prints the warning messages about
random generator selection:

    fio: file test.0.0 exceeds 32-bit tausworthe random generator.
    fio: Switching to tausworthe64. Use the random_generator= option to get rid of this warning.

This causes fio output parse failure at the test case block/004. To
avoid the failure, ignore the messages.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/fio | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/common/fio b/common/fio
index 91f4b23..8d95e5a 100644
--- a/common/fio
+++ b/common/fio
@@ -229,7 +229,9 @@ _fio_perf_report() {
 			echo "_fio_perf: too many terse lines" >&2
 			return
 		fi
-	} <"$TMPDIR/fio_perf"
+		# Fio often spits out message about random generator switch from
+		# tausworthe to tausworthe64. Ignore the message.
+	} < <(grep --invert-match tausworthe "$TMPDIR/fio_perf")
 
 	for name in "${FIO_PERF_FIELDS[@]}"; do
 		field="${FIO_TERSE_FIELDS["$name"]}"
-- 
2.52.0

