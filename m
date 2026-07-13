Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DA41A9F8C
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 00:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783903171; cv=none; b=VCv5hF2mzVkfX+17Iqdf1pKEgVZu97mDUZQmF8K2Dn7oxPA3pjTx6izb2OaI2LwpeOz0q1OEfbMbAhg2y6GqOZVN3UUHHYfjlgc8TTgSakGXxDfuUF/O6bWqQsumzh9EQQqMsqP64bOfst0tPq5cHe7ueCVfrtrJB+LrajChypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783903171; c=relaxed/simple;
	bh=adqQhugJHK47JgeINkEIkwojF3rjhzF7YFCYUgsD4eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dWiS17Z9QrUtMCTFUBDJDKMHQN6TWqn6h2IUGhEDpspmnrwhUqfTDDxSLr/TceU46zc+uyx3rCokKcAmIZiJVbZhYjQ1yR2wtMgec1cMsBTZA9jPutSklz9PLgMS2UyVOuM5WzK7VZaqT6uRo/M6N6cn0bjgZjFB3kOcXi+dn40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Zq93x4R9; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zq93x4R9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783903169; x=1815439169;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=adqQhugJHK47JgeINkEIkwojF3rjhzF7YFCYUgsD4eo=;
  b=Zq93x4R9A7mElt+8JXdBeG9qipdwECdfFHUpDBebG8nwmVzNCw2DCcQ4
   9SYidNrDf4B81+Magj6J1wcKXkeH/C9sYUczaFhtCfD7l/uKhG7R7+6dP
   FQx+xxyYMwrY7go6nCW5xwzurptedp8h7ThBk0k9HUuyGjs6rGzsxgZXY
   J5/aqrq5XfYJsKx5rx1T/iAYMsn3OsdUDI3ZnA9wZ+miMye5ynW75l3lL
   T+YZuOsAo1qgFFhZ3wJav9AYB9QQ/1YCYMNBtNdcnfqtPMIBzIl97V8oZ
   fXNtnBAqYLn+RiLGwMlq1jt3mMaEsV0c9qupOuz0jpRS5gTTtftagfMju
   A==;
X-CSE-ConnectionGUID: IBZlnw1aR+idFLu2HaPc4Q==
X-CSE-MsgGUID: r2oDZkPbSKqiMwpziuvFJQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; 
   d="scan'208";a="150596163"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2026 08:39:29 +0800
X-CSE-ConnectionGUID: fT13FTi6QI+358RawydbCw==
X-CSE-MsgGUID: IAWIZhsyTPyOXUS2peQ5pQ==
IronPort-SDR: 6a5433ab_I/dnUZAikp5UTJ5+EwcW+yoG0YYO0T+DXvTj7DT/gpdEbTa
 pKhwuJgjgSMtNPSjKoj0rVypBez52F51PesSfvw==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jul 2026 17:39:07 -0700
X-CSE-ConnectionGUID: JKikaooRTNKRyiEIfg7vWw==
X-CSE-MsgGUID: BGbR+eC4TDiFrZaUUs7yqw==
WDCIronportException: Internal
Received: from unknown (HELO shinmob.iptvf.jp) ([10.224.106.2])
  by uls-op-esai1-o.wdc.com with ESMTP; 12 Jul 2026 17:39:07 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/4] misc fixes
Date: Mon, 13 Jul 2026 09:39:02 +0900
Message-ID: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are miscellaneous fixes. They do not affect test results, but worth
fixing.

Shin'ichiro Kawasaki (4):
  check: fix exit status code handling
  nvme/rc: use _set_attr() in _create_nvmet_passthru()
  CONTRIBUTING: clarify that GPL-2.0 is not applicable
  new: guide long command options

 CONTRIBUTING.md | 4 ++++
 check           | 4 +++-
 new             | 3 +++
 tests/nvme/rc   | 2 +-
 4 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.55.0

