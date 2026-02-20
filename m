Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9B2045AD
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771593842; cv=none; b=YkuS7UvrNnIU/cWbF7kdNVBFmvlyTz46AUMfqntJb3zVQ3Eowa6abCQbNP+q1i5R4tPePWaaKhf61QlXyQacuwkbyEhI/aKlyYIPb2k/bmrABligsDx/DUxB8H3hIOSxsmtUTpNFXWo0qqXhFv1P6FWwpvyp+3xH7YMy++d819Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771593842; c=relaxed/simple;
	bh=bDao1ZUxUrKM+x112UuRVky3nEuininO+DUhrMA161Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nl9qR5npZE9KAKy16/k6CzU/7dPb1/A41pEEfqhUw2f0dKag/m/owbwOifXQHfWOIFZ5WBmnWg9+HNAQ2W6F6KtKcui2g0vEa+aLN/RY+JqHkH927KNimDp7nJFxOgljSSmc5qj7B68JH72jJ78InAAo9H423sRUeYP1rmchPew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EsE/u9rQ; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EsE/u9rQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771593840; x=1803129840;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bDao1ZUxUrKM+x112UuRVky3nEuininO+DUhrMA161Y=;
  b=EsE/u9rQTadERUWXt1kyXNgPHAuIqnlK5OrI5+Ip2xsTWHnosOT6+t1r
   jSEIcH68FSNbwEeQlHKz5xHYpIa2xVDCLkfPzlyJV1M+9Q5WO20MpPZMb
   1s/wyuMLqDFIKbRMFS0ovAdHFt/fGWyVlnZHiI313bEfE901K+5irnHvr
   5cpb4iaoQfz510OZdAbu7FKDOuFiT4WVvJ8G7+HZp70jzVj3QF5LRhjuA
   MClq23K1h+Q+kkYXY4kYaDQ/eEuEWCwQVB2cZgD4YCe+o8aF5w0rTeX8e
   A2DoRuXQzPkWMODqfU5GPT/FQOyJqanzT/nyYK3UaMRM5CRFtzD/30w/V
   w==;
X-CSE-ConnectionGUID: QT+Ov+0KQBKNpUJg87agDQ==
X-CSE-MsgGUID: LFa1lIzLTh6rKMzQ+TNReA==
X-IronPort-AV: E=Sophos;i="6.21,302,1763395200"; 
   d="scan'208";a="141089912"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2026 21:23:53 +0800
IronPort-SDR: 6998606a_WtrGv1U83uO+gv49Ce0Xp3KuJUQ+7ZF6VsJ7PEYpHdWeNft
 Csxt8jCcl4bY4LHkohvmMdqlISAOOxG6PtJ453w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Feb 2026 05:23:54 -0800
WDCIronportException: Internal
Received: from wdap-y8axpm7exs.ad.shared (HELO shinmob.wdc.com) ([10.224.99.2])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Feb 2026 05:23:52 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 0/2] zbd: adjust to recent blkzone change
Date: Fri, 20 Feb 2026 22:23:49 +0900
Message-ID: <20260220132351.273758-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the recent change in util-linux [1], 'blkzone report' command no
longer reports numeric values for write pointers when the write pointers
are invalid. This change caused two failure symptoms in the zbd test
group. The first failure symptom is arithmetic failures by evaluating
the string 'N/A' as a numeric value. The second failure symptom is
write pointer validity check failure for conventional zones. The two
patches in this series address the two failure symptoms respectively.

Link: [1] https://github.com/util-linux/util-linux/commit/b032247f48d8b6a13bf8541eb663c779e448f568

Changes from v1:
- 1st patch: Added the check for read-only and offline conditions
- 1st patch: Added the check for conventional zones
- 1st patch: Use the value -1 when write pointers are invalid
- Added the 2nd patch for zbd/002 failure case
- Link to v1: https://lore.kernel.org/linux-block/20260219121940.174239-1-shinichiro.kawasaki@wdc.com/


Shin'ichiro Kawasaki (2):
  zbd/rc: do not use invalid write pointer values by blkzone report
  zbd/002: do not check write pointers of conventional zones

 tests/zbd/002 |  3 ++-
 tests/zbd/rc  | 19 +++++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.53.0

