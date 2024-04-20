Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912AEEEDE
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713599893; cv=none; b=nWNkn9iuaxxaqFqlBobvsB+EKYU4sPf/YxYjBTwRcQOyj7UkhFpBtWMt0AuIOcup4LhLRiT59n6NPhkFeWaJLjeB78gauzDvJTve+Ty9WJlYbiXfbMnlxPBOF/RaoyfFJYdsS/YT7WWAzX0S/itEv2BbG0HZ+Ivr5LPi6kvmGhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713599893; c=relaxed/simple;
	bh=s+ipoMq7xoVTCk+fo9iXvZSipgP/zIK+m/fhRRm9ZfA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MYsIc8AkQCVPI5ZMoIKTtyC7aNl/Fq7Uap2DMI5SwPZhyyXLRlZ9Pb6NYhdJCNXXTIEoHXRkCH+7MqE4E2JvD53NlyJyBcGisv1wPUr/0oU+aysVj1Fx9WnpdkuqXlIWgm0Jhhj6lb6w0bneyDgvgjGPriDTbUbbgeJ4Ro+ObfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vH1lNBSl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vH1lNBSl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B625EC072AA;
	Sat, 20 Apr 2024 07:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713599893;
	bh=s+ipoMq7xoVTCk+fo9iXvZSipgP/zIK+m/fhRRm9ZfA=;
	h=From:To:Subject:Date:From;
	b=vH1lNBSlJhbqSQpky02/JaNb7d5xmfpJ1kqoAC01kpdOhnCGxb3q6pcKz5TnzyEN+
	 K9nFnL+LfCY8vWm0a1YpYqhlHh2vwOuhDzXYpImtR5e99DwR8z9UyY7P6HjOiyYk9i
	 4wHdolBoYGsLi5irYbGPt8mK0NncVXIiP4jx0ybMWgz6PDAMwloa6lf9kTlccx8Mps
	 B4+Sz0nVhnpUWdrEgFpRkNOxK47KBnCNjnQMiQg9QnNdrGYHXWMTDJCBvBfTaZxAhO
	 JHMaIlWA9YltOiJp8DrX6dPKUW11+Ch073BNnhyJzLOCbZRgQ75Wuu45phMj4RMtsD
	 VysGZnfcAsXMA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 0/2] Fixes for zone write plugging
Date: Sat, 20 Apr 2024 16:58:09 +0900
Message-ID: <20240420075811.1276893-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Apologies for the churn. I sent the wrong patch 2...)

Jens,

A couple of fix patches for zone write plugging. The second fix
addresses something that is in fact likely to happen in production with
large servers with lots of SMR drives.

Changes from v1:
 - Fix patch 2 to create the workqueue with max active set to zone plug
   pool size.

Damien Le Moal (2):
  block: prevent freeing a zone write plug too early
  block: use a per disk workqueue for zone write plugging

 block/blk-zoned.c      | 34 ++++++++++++++++++++++++++--------
 include/linux/blkdev.h |  1 +
 2 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.44.0

