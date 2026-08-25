Received: from mta1.migadu.com (out-15.mta1.migadu.com [95.215.58.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCB43DE44B
	for <linux-block@vger.kernel.org>; Tue, 25 Aug 2026 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662663; cv=none; b=TAm4otdh6Xrm/rno2LXCS+mg+vGunbC5+qo19U1ScZABe4asWsWWtzUVDtfOrieTpCUePVsvh5Z2bBdL12lOxQRFQiHYYpSRav5Mn6pko9mg4+GqpxPTgc2dwckEo7qIrohgOBcBDvk7tvi8lLiMbPfI3RJ65bynGJMg/nuHL4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662663; c=relaxed/simple;
	bh=9M5TpW7OSL4RIGdODhBHEplejl9FHnW7owVvWRUicCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UY05+stGksTGPs9p2M16EnpWGfWSzqx1L+jzSdxl4muPIw/MahNK8ODchZwyhPGOxKFIclu2ZTJEp6GhhZPozc8Ga4JkfNGYGWFt86qi+x6K0DCoSedA/1T84zmdclOZirFABB4UdyGK3TaPZ9Tu5yRKbpgWSf3HsiPishFevm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z3EXsfLk; arc=none smtp.client-ip=95.215.58.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z3EXsfLk"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9M5TpW7OSL4RIGdODhBHEplejl9FHnW7owVvWRUicCo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787662659; v=1; x=1788267459;
 b=Z3EXsfLkWj1ejzFkd6YXhWUOZSVoTdMqIcKfguiucivnnqIJp6Kie+RN9k+loxiZWWvENxDL
 NdzYX1dP6Kn3KSl6xUGcckwbiN9Pox+S30fUM0fV+Y8rMfQvUJRRhFkEReX5XP3Cad7VDLJ+Fv+
 P6ihOBCs4q1J+3z12hHeR7LY=
X-Envelope-To: linux-block@vger.kernel.org
Received: from ctao-book.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 75461cd3aa7331ef;
	Tue, 25 Aug 2026 12:57:39 +0000
X-Mizu-Trace-ID: 75461cd3aa7331ef
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: axboe@kernel.dk
Cc: hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 0/3] loop: three small cleanups
Date: Tue, 25 Aug 2026 20:57:17 +0800
Message-ID: <20260825125720.181793-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

A stale kerneldoc reference, a simple_strtol() left in the max_loop
setup code, and an unused function argument.

Tao Cui (3):
  loop: drop a stale reference to loop_validate_size()
  loop: replace simple_strtol() with kstrtoint()
  loop: drop the unused argument of lo_req_flush()

 drivers/block/loop.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.43.0

