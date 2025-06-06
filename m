Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174031C5F14
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749182194; cv=none; b=o5pufd27gd4HplvhrU33xYr/0NVcdfuZOqVX2ane6aXxA9yfrf1FEYmY6akFRP3pQB5z1jo2S7CidXJ5X3G8K/wNaZQo2e4vzUXDZ0t+C3M6S5sDxgdwIyakZioLsSD2rYjb0bCRmZaDHyyN6ACwqe22yXUS8xnOKXEce2jZckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749182194; c=relaxed/simple;
	bh=Py6fRzLbBKySV/KLnexn83qDYl3HmjWs97rn8SBudBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V0u6K1/gDffdtSRkkQ8hpw6DWC8zJYOIcJDLILbBJPZhw5k1jrHepR42WncG5vAT4GVlHgO5X6ngtNvrifPoT0YLWq5PDH20PviKoiovxWcrg2xAu1R7axAF0CxsChm0sgx3/vb7rMSYTBfOgWv9lbtpn+dUDj71XpzqG7Kt770=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cOBXCAve; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cOBXCAve"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749182193; x=1780718193;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Py6fRzLbBKySV/KLnexn83qDYl3HmjWs97rn8SBudBg=;
  b=cOBXCAvefXDoKPVvEaDWhRnh/wMi5fDQ4gs9+3kJC6kgxJFXtbDLG7ye
   fAhKsbFVE5EoX0bCo0q7Y5a+WZ43Vrk4D+SfeyusclSSvycsyxIHW6EZX
   yr4x5UHubNzx7TEB8dLPG40V+oOh+Ahxjg6oZrmF35qOCNF0CXTRCVqR7
   vuYqwVG8RSj6JN4gGuHIHWpN5lzIud7F8kFYRzNKcc5dliC7ShaFLpFcH
   I8ILTLXUwB5FxRmX6p/m5sOu11FE2Si/WAlhpca1LTkamLGrpWO9y9coD
   XlHbX1AvqcQglnNaRvnGhaa3Nmuj3SVsgQdioYL5rSed7zhFdBEtf3Jbc
   w==;
X-CSE-ConnectionGUID: CCZ8PVVHR6awuBQw5pK2cA==
X-CSE-MsgGUID: GqvaoDflRfu1emCPFEDe3g==
X-IronPort-AV: E=Sophos;i="6.16,214,1744041600"; 
   d="scan'208";a="86114878"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2025 11:56:32 +0800
IronPort-SDR: 6842588f_zzkaRoBzbKxyXLQnpxTWKzNAFGGfB7bsGUlKWRHQnVqmHos
 2kfm6pon6DtuJuUQoHG8pOnOAFMMS5NcQVYx3lA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jun 2025 19:55:11 -0700
WDCIronportException: Internal
Received: from 5cg21505sl.ad.shared (HELO shinmob.flets-east.jp) ([10.224.163.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Jun 2025 20:56:31 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/2] check: support "set -e" strict error-checking
Date: Fri,  6 Jun 2025 12:56:28 +0900
Message-ID: <20250606035630.423035-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
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

This series supports the "set -e" strict error-checking based on the
discussion. The first patch modifies the check script to allow "set -e"
in test cases. The second patch introduces the new flag ERR_EXIT to
enable the error-checking for test cases selectively.

[1] https://github.com/linux-blktests/blktests/issues/89
[2] https://lore.kernel.org/linux-block/ckctv7ioomqpxe2iwcg6eh6fvtzamoihnmwxvavd7lanr4y2y6@fbznem3nvw3w/

Changes from RFC:
* 1st patch: added comments to explain why 'if' and '!' are avoided
* 2nd patch: introduced ERR_EXIT flag instead for grepping "set -e"

Shin'ichiro Kawasaki (2):
  check: allow strict error-checking by "set -e" in test cases
  check: introduce ERR_EXIT flag

 check             | 48 ++++++++++++++++++++++++++++++++++-------------
 common/shellcheck |  4 +++-
 new               |  6 ++++++
 3 files changed, 44 insertions(+), 14 deletions(-)

-- 
2.49.0

