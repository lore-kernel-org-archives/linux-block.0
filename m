Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0844A2F85B
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 00:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761525074; cv=none; b=ayEQiezUg7Rdc8bjG8KfzbuNm5XkIIwhQldoiQ38BssFhIjI28Z+9x8HnxDRAc9X6h97UwUk23TMema1fCJumXQI3PnQwtoT7HKnbcLD452WTGOKRXLQgC+RD2U8DVfbcDQQPWmj1Elg5N/qYU93cI2WbCf7PDIWXaeskv2c1Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761525074; c=relaxed/simple;
	bh=p2+DR9XF9OW7U9qbkurjEcIyanfqTDO5zwMTwQXw9s0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=A4tLCMA2YCOxKbzwL6CqAJJCq1ByzcMJV4yAT+u4RphAVvQGydAiel9l6jJEIFwUcpEaQerfMMIMTgY96i9/tDXd3qI+LXOlqlvxX6agFRj8OGwyamJ9zilXtvHng7hi83yILGIqslm38d7htIVHnjp+xtkmTfcZahdFfEgcZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEG5SlLW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEG5SlLW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3672BC4CEE7;
	Mon, 27 Oct 2025 00:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761525073;
	bh=p2+DR9XF9OW7U9qbkurjEcIyanfqTDO5zwMTwQXw9s0=;
	h=From:To:Subject:Date:From;
	b=XEG5SlLWhzkht/bm6K51y5UgCkHimYxsXcFs+FiLKrZFoCSPNvBJFXunXmSgKvDe9
	 +h92rB0H94XXKzEPM2l2ULeIgjgQcL2e32b6Kzea8rsTSVcoADy6Y7M651rzJ58HZx
	 jix1gGs2KAlom68r1knSI68ktwhzC6lueSzWcJFa8bpCjZMxKrYndFC9ZpL7YLb3l6
	 9LiaOhjAhxwr+1jOCdJUpmX2ZiCqXBZl0m1kGE6Dys5t1C2hObonc+jaI5TAXwp1ik
	 K/uKX+0YyG6ECccMeGJVvnXBbR8YF5JOT/cfnq71ywgfwjHshYQNwhC48HiFQbH7Oi
	 JJ5xqAfphlN0A==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 0/2] Zone operation fixes
Date: Mon, 27 Oct 2025 09:27:31 +0900
Message-ID: <20251027002733.567121-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jens,

A couple of patches to fix zone operations definition and handling.
These are not in response to bug reports, but they certainly fix things
that are incorrect.

Damien Le Moal (2):
  block: fix op_is_zone_mgmt() to handle REQ_OP_ZONE_RESET_ALL
  block: make REQ_OP_ZONE_OPEN a write operation

 include/linux/blk_types.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.51.0

