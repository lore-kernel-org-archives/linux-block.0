Received: from mta0.migadu.com (out-146.mta0.migadu.com [91.218.175.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68673F39EE
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170603; cv=none; b=QYJ3GxI+pGQONrTe35zQ1CfW16O1InYXxAMVNrVvRcXuf4lyHQy7Vm9zk14caD9DzaHftdlSRRjsV9phY+yCorgup1YRu2X/7cdJqnNP/fuKEZ6pJofihkyqEwuPwTyUN0QjvTYfRkSYPXe2ncUKxqBbleo/RoTcU4x/2LrHbxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170603; c=relaxed/simple;
	bh=9M5TpW7OSL4RIGdODhBHEplejl9FHnW7owVvWRUicCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V7T2MnhasRzPgiKe5E6tBXBBjW2MwlO1HC/hMF2kQnThjg0TttiTSxeZvnmqJGSsLLjYCfNvyxxlO5Nw96s6GfqEoGHgd0Bwav1gmnPCrn7ykrss6aS9Z77e1DHuSIVzlZu30i4yFO2dVpDGojc3eDjYVzWSH3Tc/gXs1AsIBv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gT63E3Wg; arc=none smtp.client-ip=91.218.175.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gT63E3Wg"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9M5TpW7OSL4RIGdODhBHEplejl9FHnW7owVvWRUicCo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788170598; v=1; x=1788775398;
 b=gT63E3WgP8bd/pe6v+DiKLx+XpJbcHW8/E5FnH2coHNBq226qX7Vs99FCbnBeIVnb/BIulDw
 h0Oq/oPXYLgc9fP/ikEuISiDoapPvEylq1PLfnszNr+UBss5NQOcIPjAEjM1scG9bV66/9PVlwc
 HaCBPGs16Tgp7tAbBaMixtFY=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 50bdd341791021ec;
	Mon, 31 Aug 2026 10:03:18 +0000
X-Mizu-Trace-ID: 50bdd341791021ec
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: bvanassche@acm.org,
	axboe@kernel.dk
Cc: hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 0/3] loop: three small cleanups
Date: Mon, 31 Aug 2026 18:03:02 +0800
Message-ID: <20260831100305.695116-1-cui.tao@linux.dev>
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

