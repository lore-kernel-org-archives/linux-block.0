Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F697465
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713597399; cv=none; b=Z0P0MLT8HZqMVZL5yQQo4BaEJXZRE3crzeMyiPtahsUVZqng8SaJ7e7Sul/amzKhiWq1PGtgYLiSRj8ESN1PAafon66qI0SZuVSJjS/bmD7BfcK6q6FZf8lkKlc1SkMdDqiIHsBolQ6WqrqZydUaIvohfn2bv4VCdODQmG2sGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713597399; c=relaxed/simple;
	bh=HQyF8zZSvXbF/+y1/E8lNDWlMFzqJJe7GGY41HYh3V8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PZQ4U+7DnwjHE+XaZ1ZY6MsVkuGI6hr4/jLEgba9JIPj6u6RgwRO0saY3PIU7ulgLRvX1fd3jrwOVJQ60ZjmrfHXCcYm5iABYHLrSOMI0FFaA5vd9ACDEw9GriVra+k5zkeQXJLxgGbAPsF9tyfkdTXICt8aAdq3jYZCQoIb+tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fqa1r4g1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fqa1r4g1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67844C072AA;
	Sat, 20 Apr 2024 07:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713597398;
	bh=HQyF8zZSvXbF/+y1/E8lNDWlMFzqJJe7GGY41HYh3V8=;
	h=From:To:Subject:Date:From;
	b=Fqa1r4g1l96tr1+TsLey0BMYRwt2GZn36gG4R2PNz+0ptoJWMjEP30f7KtzRq9YYQ
	 4n0pk0Avn8B1J+58gq3wZkiNERo4qJ/2E9LZr/YgtmL14vYEi/EnYKzdr7yCAuHbMu
	 9GBE4zamUie3ds2mplwSHlXhtdrPIgYMrtwsMkDi7xO6pNby384rENs+5voBvunLlC
	 JtlgUXFETONwI6SsRUsOtfjZKIILNDZBZVCAmVLiaZNAPFYoNQ9XkEgRC69PfHzwJG
	 OHEtKo1HvID/8FwRPASYHt3/tpbtFdHFG/OsfxoonJ/zQnP9aup8C5n1/GAffcNMH+
	 gHzlmvhl9JeFA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 0/2] Fixes for zone write plugging
Date: Sat, 20 Apr 2024 16:16:35 +0900
Message-ID: <20240420071637.1270724-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jens,

A couple of fix patches for zone write plugging. The second fix
addresses something that is in fact likely to happen in production with
large servers with lots of SMR drives.

Damien Le Moal (2):
  block: prevent freeing a zone write plug too early
  block: use a per disk workqueue for zone write plugging

 block/blk-zoned.c      | 34 ++++++++++++++++++++++++++--------
 include/linux/blkdev.h |  1 +
 2 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.44.0

