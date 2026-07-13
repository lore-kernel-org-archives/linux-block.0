Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B59C204C3B
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783903173; cv=none; b=AKpXtu31esNrmt8gInjIPXMhEyotcAoMZdcF6vtuttvHdkqczuCNC39kzS/tzLH6vd1sMoS8NwfdJOeNZ18pj04gjdvzyQkzY6qVrsbk7pXB3Qa2Ry1FuR+ERvy5B4VrlQEv5W9Ij9ZT+j6Uy6JlllcOlYBUhumMlOOKpNaJOOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783903173; c=relaxed/simple;
	bh=465hUMJgrZHFvP3qJLCLn0CTMsoJ+Cy8J28PgnG6nG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/smNumnPBPPFWE+xDg0VTTa/9KqoGpt9/U+1pcRAi183GVrOM79E/5Bx8Pjf2HabZpc0RTgAPIQIIpTYbFRdbMt2JpUGDYg40b3Qm+KlnmyW0vVbw5nemTU9ZnjpJKKBUtTQIEksAK+MZsiLThJeM2kGqYfqkldZzj7cF8Su5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=orgn4Xgs; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="orgn4Xgs"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783903172; x=1815439172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=465hUMJgrZHFvP3qJLCLn0CTMsoJ+Cy8J28PgnG6nG0=;
  b=orgn4XgsCFPbF8hKXczG+gH2/f+R60/ZjYLOdRN5MSMdW0Fc/5r17r4F
   GrvvXIgRWJgNq4r+Tr9zzQYkVeSNrnvPW6QmXMGMGh/bO1EGP6qOPm+v6
   QDdzXfk4r6Y4sDW+oXW5UwSBwNYMN4ARbCDlMZeGhX1giRHVsCjm+LgKq
   I1T9ITHIqC0sfnHQE0VJvGhjrJa7O9WRxx3OBVxqgASd3VLkZjDmloZgB
   zRncz+eEGqBTGP/lmsDfBVG8mhBe/w8ry2xjMK4xaWilODR01VSW6yRF4
   XQAriTra4R18LGDpHfEDDNSs+jpvO8811lAf/JI8kIPJKK3mops5p0r6s
   Q==;
X-CSE-ConnectionGUID: IcJ1JKZHSFCDgE+3ljgVWg==
X-CSE-MsgGUID: EgZdrr8LQpagnjCJBA/isg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; 
   d="scan'208";a="150596166"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2026 08:39:29 +0800
X-CSE-ConnectionGUID: biajly5bTiOVbkONzZrtSg==
X-CSE-MsgGUID: vjNEuTI5RNum3LGkk/pw5w==
IronPort-SDR: 6a5433af_MLTVIFCNJUoQvm3qohRCqiX13/9AqK41EeGVG4obrWnLaV/
 P6SbF/uA4s5POCXx7yCX7iIxweY7dGNT7t90IMQ==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jul 2026 17:39:11 -0700
X-CSE-ConnectionGUID: L6fFZhjyT96FOABL8sVn6w==
X-CSE-MsgGUID: K1ACUwcWSTWwi0xCMVDsDQ==
WDCIronportException: Internal
Received: from unknown (HELO shinmob.iptvf.jp) ([10.224.106.2])
  by uls-op-esai1-o.wdc.com with ESMTP; 12 Jul 2026 17:39:10 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/4] CONTRIBUTING: clarify that GPL-2.0 is not applicable
Date: Mon, 13 Jul 2026 09:39:05 +0900
Message-ID: <20260713003906.21153-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
References: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Majority of the blktests code has GPL-3.0+, so the effective main
license is GPL-3.0+ (e.g., check, common/rc). However, GPL-2.0 and
GPL-3.0 are not compatible with each other [1]. Because the majority of
blktests is GPL-3.0+, blktests cannot contain GPL-2.0 files. All files
shall be GPL-3.0+ or GPL-2.0+. Document this requirement for
clarification.

[1] https://www.gnu.org/licenses/gpl-faq.html#v2v3Compatibility

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 CONTRIBUTING.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index 4cfc868..375c4eb 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -16,3 +16,7 @@ as per the [Developer Certificate of Origin](https://developercertificate.org/).
 Please run `make check` before submitting a new test. This runs the
 [shellcheck](https://github.com/koalaman/shellcheck) static analysis tool and
 some other sanity checks.
+
+When you add new files, choose a license from GPL-3.0+ or GPL-2.0+. The main
+license of blktests is GPL-3.0+. GPL-3.0+ is recommended. GPL-2.0+ is allowed
+but GPL-2.0 cannot be applied.
-- 
2.55.0

