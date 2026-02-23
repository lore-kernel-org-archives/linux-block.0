Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B64725393B
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832480; cv=none; b=K+12xxZCQ5Zuk9p+umUxPPT6nMIrd7hsSYRp2m/2ZWQOXDwDtMoe+HgklVDDJ6B+PY2GojTlyxcIj6Khlhqq5hr55crHVhcq4VQ8wEbgf+/6PCxMuL+EWr3E9MiMkGyiheQJgHim+rNPD59TigZClrPlY87ghiHh0sBit5d6jZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832480; c=relaxed/simple;
	bh=wHEyzeUjCtjHyHbnsYoszk/C1HYDn6Hf89D2hkGqffM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r2+86FapeEqOJqOaZDdBAw7ICs9TJEy265LmNycuEk1J+oYtbcOkbQIy8xSsJR5rwU1sDWRYTDhQHk67Lr6ejnnVzzj2LihDQEOoxu6yIsjbwPlDLYNxtqtCZAyUcnDYjsDHa+owU+TvflHPE7i+/SxtAccsfqx/+igtxQKVJQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lhBYmw6N; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lhBYmw6N"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771832479; x=1803368479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wHEyzeUjCtjHyHbnsYoszk/C1HYDn6Hf89D2hkGqffM=;
  b=lhBYmw6N4Acj3ApsCHMX/yzzxzu5VhfastUEOKcG+6vKAS8Ho+AfqHYa
   F6m4gTKMYvmRdoPkUGHRMnDiovGleeoIXiXxRu+Gk/NMpr2THYxRajYEk
   52R0R4IYSWi85lnplabUT7aw0bVOqDbea+TF+rAqYwEvzIWY6jKvM6Br4
   ASHLXM1lYLC6mtIm5YmRJF6/rWcB0vASiroXBfxc0b2KtIMF4CM0ANKL5
   FbnSapkzk7MwBvYoQlt2RFGs5aft3COGNsxzFB+p0KFwTRDnyE4nXMGEu
   FlHgm9j4Y0AkJ/Pqr8RRQ8o8VxfpDA5cRBTo9ilPDeYY80Wk5H3FW1qB3
   g==;
X-CSE-ConnectionGUID: +6TpyrC/SV67s6NnVibb7A==
X-CSE-MsgGUID: XszCM5oSRhqZF70pQfIziw==
X-IronPort-AV: E=Sophos;i="6.21,306,1763395200"; 
   d="scan'208";a="140846175"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2026 15:41:12 +0800
IronPort-SDR: 699c0498_ntmkUsKWGo9ZV/OjeEw79btH6l5YL/G/1dKQM3YNErWyP0y
 9Md1mQj4Uu8gYigyNy1Z5tI7VD5bbVMN5WZ3dbQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2026 23:41:13 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2026 23:41:11 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/3] misc fixes
Date: Mon, 23 Feb 2026 16:41:07 +0900
Message-ID: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are miscellaneous fixes. They are not critical but worth fixing.

Shin'ichiro Kawasaki (3):
  common/nvme: do not call 'nvme id-ns' to non-nvme devices
  check: increment bash requirement version from 4.2 to 4.3
  src: add nvme-passthru-admin-uring to .gitignore

 README.md      |  2 +-
 check          |  6 +++---
 common/nvme    | 10 +++++++---
 src/.gitignore |  1 +
 4 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.53.0

