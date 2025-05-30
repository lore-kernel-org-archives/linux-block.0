Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763422AE6F
	for <linux-block@vger.kernel.org>; Fri, 30 May 2025 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748591669; cv=none; b=j1zZPyjEAX64rNONYcAzj3j7M1ojRZ+t0KCktb8tIWYqkCnWrwC7UjVvb/6mZEfw/oAdXW7hPDZuJzGxtUmbqBXtJomhw6ienuxI322C9dG5PelLV8dJzZQCriaskHTDG7oIiVMbBR35Md7k1SWZDfxtFLJlF/SjtbmxS63K/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748591669; c=relaxed/simple;
	bh=iS9rV3cfaraSNd/jx3NQ/y7N15Zi0iMH+UVMNsULmt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nZfSPafkBsAIWYvfBjbJ9zhqSAC/YpHo10zSFZIpLgjMILF/V4x31B26txc9OZ4MLzvvp9Tnm/h5A07e/tubmgC8k+Haf4yLAfyfHJJ8gkws1CXDYgRpcQgEik9TORRhnom+BxKMX6nTZ/+bsW3Q9wmYEiZMmMAOG03P2o5LHG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Y+hodVDV; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y+hodVDV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748591667; x=1780127667;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iS9rV3cfaraSNd/jx3NQ/y7N15Zi0iMH+UVMNsULmt4=;
  b=Y+hodVDVtXATQ2gSvFbDRMXYZjVPLTmWO5SAGtl2wKdH5n6fM7bBKRbm
   xyJOHD/gsmu7NlliFlqavezYWAdhzlYdShQMZ9nKGlOkmAUvMy1tCnnU9
   l4vR+qTFiLoz83TE9kqZErQVdxDr25YUnVFpi9ykPojE03LEoLG60yCNh
   OYxnrS/64UBzpVGB6ohqGTqCEBnPxpDAaCtm4Kw/geXaHPWXHmB7SQTgE
   1II1YDIvxw/RtnOool/QNhDZtw7YvBnSLVLXbKXroeqOBlDDjR4OGr0r3
   1tXSMpsee6+z1+zhumXP3bKC0AHBas7fzLfoRANb42R0FDLekVNznKUk4
   A==;
X-CSE-ConnectionGUID: eLH0aoZWSxaRHNBYyzj7yg==
X-CSE-MsgGUID: SOmgKOaPTKKeifZC5PQEkA==
X-IronPort-AV: E=Sophos;i="6.16,195,1744041600"; 
   d="scan'208";a="88625259"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2025 15:54:26 +0800
IronPort-SDR: 683955de_nt9QtD8y4d6eploR3R93t+R6xFpmKQvQ0ML0lIm3FKCz4aK
 0881ztvgLxSfzmEO2JVFtN/3v0EmkTBe4FqFFag==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 May 2025 23:53:18 -0700
WDCIronportException: Internal
Received: from 4r6vzh3.ad.shared (HELO shinmob.flets-east.jp) ([10.224.163.85])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2025 00:54:26 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests RFC 0/2] check: support "set -e" strict error-checking
Date: Fri, 30 May 2025 16:54:23 +0900
Message-ID: <20250530075425.2045768-1-shinichiro.kawasaki@wdc.com>
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
in each test case. The second patch adds the feature to detect the
test case exit by the error-checking and abort the test script run.

[1] https://github.com/linux-blktests/blktests/issues/89
[2] https://lore.kernel.org/linux-block/ckctv7ioomqpxe2iwcg6eh6fvtzamoihnmwxvavd7lanr4y2y6@fbznem3nvw3w/

Shin'ichiro Kawasaki (2):
  check: allow strict error-checking by "set -e" in each test case
  check: abort test run when a test case exits by "set -e"
    error-checking

 check | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

-- 
2.49.0

