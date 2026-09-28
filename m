Received: from mta0.migadu.com (out-19.mta0.migadu.com [91.218.175.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAA54915A0
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633811; cv=none; b=u65zAqHJO/Q3XQF8WV1jP7JLws+y+XAODCcP+0xkGmuaTNV0sLweOyp4aci9hnAe9pzTFAihO90FQtZWk3Fh8vUYOKP3iaD7j7USfG4jkODJvBQV4LQ00dQlzGrEe7/scma6wWhw2d+0QHYetWoYSLMk7BLqFQJ79pAVV4PQgck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633811; c=relaxed/simple;
	bh=wrSQvdUGW5Jkt4r5YgB+gmI1KNzrp9xbeWzGNC1IUdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A1JvKSb3pmo3rQ/9J2ERwlQnf95onF8bhQiXzOiLUNnKKxz7bfqyEhI9GMnLnY0YLzNNY6tso124JBcRRmN1EnWkWYhwpu35K7jFRN0348KX+B1qPyQGUXRTLJN26sJxzyJuLuCPUgSU7sl8kDp1KKTY/etSlaY7sR/SG4fTtBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=abMjA9SW; arc=none smtp.client-ip=91.218.175.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="abMjA9SW"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wrSQvdUGW5Jkt4r5YgB+gmI1KNzrp9xbeWzGNC1IUdM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790633807; v=1; x=1791238607;
 b=abMjA9SWmRwyYsVnyaJWu13nwPJczGgK+fjy/W2hDPngnUuvhI9lT0/T/hc3NKPn+cRmf7U6
 N3dgcJRP9t/80Mw7e6CuJblgGDCMzMcuakoZRbvyv8AUquoVlS9dj/kP2lJwIOI3oCAXNlHPUeW
 WLczK6zFBjS6gfXwA/Mzsc0M=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e91c9c1cacdb44e5;
	Mon, 28 Sep 2026 22:16:47 +0000
X-Mizu-Trace-ID: e91c9c1cacdb44e5
X-Migadu-Flow: FLOW_OUT
From: Md Haris Iqbal <haris.iqbal@linux.dev>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Md Haris Iqbal <haris.iqbal@linux.dev>
Subject: [v3 for-next 0/3] block: delay support for error injection
Date: Tue, 29 Sep 2026 00:16:31 +0200
Message-ID: <20260928221634.43239-1-haris.iqbal@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error injection can only fail a bio today.  This adds a delay_us option so
that a rule can hold a bio back first, to model a slow device.  The delay
happens above the driver, so it tests the code waiting above the block
layer, not the blk-mq timeout handler.

A delayed bio is marked with a new BIO_ERROR_INJECTED flag so the rules
are not applied to it again, even after a split.  Christoph asked on v2
to avoid the flag by allowing a delay only together with an error.  I kept
delay-only rules, as a slow device that succeeds is the more useful case,
so the flag question is still open.

Holding a bio back reorders it against bios submitted later, which breaks
sequential write ordering on zoned devices.

Patch 1 is a prep cleanup.  It moves the rejection of an unknown status
tag into the parser, because patch 2 makes a rule without a status valid.

Tested in a VM.

v1: https://lore.kernel.org/linux-block/20260827000115.128093-1-haris.iqbal@linux.dev/
v2: https://lore.kernel.org/linux-block/20260830012002.80275-1-haris.iqbal@linux.dev/

Changes since v2:

 - Patch 1: return bool, rewrite the commit message.

 - Patch 2: drop __submit_bio_noacct_nocheck(); the flag alone stops the
   rules being applied again.  Log the error when a delayed bio is failed.

 - Patch 3: trim the documentation.

Changes since v1:

 - Add the BIO_ERROR_INJECTED bio flag.  v1 only resubmitted a delayed bio
   below the injection hook, which left the remainder of a split going
   through the hook and matching the same rule again, so a bio was held
   once per split instead of once.

 - Patch 1: tag_to_blk_status() returns an error and passes the status back
   through a pointer, instead of returning BLK_STS_OK for both the "OK" tag
   and an unknown one.  A delay-only rule has no status, so the two have to
   be told apart.

 - Documentation: a delayed bio is held once rather than once per split.

Md Haris Iqbal (3):
  block: Reject unknown status tags in error injection rules
  block: allow error injection rules to delay bios
  Documentation: block: document error injection delay feature

 Documentation/block/error-injection.rst |  39 +++++-
 block/blk-core.c                        |  14 +-
 block/blk.h                             |   2 +-
 block/error-injection.c                 | 167 +++++++++++++++++++++---
 block/error-injection.h                 |   1 +
 include/linux/blk_types.h               |   1 +
 6 files changed, 192 insertions(+), 32 deletions(-)

-- 
2.53.0

