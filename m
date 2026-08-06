Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04B499F03;
	Thu,  6 Aug 2026 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786054278; cv=none; b=LeiABot8FjHstqlswf82r7ZdzCCBhOLIOXxFFpH5eS6PDlPYmPXogbnabiKbxm/wVW199K96Pb62Px+YyI0v0C0aMDaXVIK89b9RMb5i3HxClNQC8PWSNFwPDqb/V+4LZtxtLz5Gz29Sh2wLX7G3brWQTr5M86jY4OHr1Mznl5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786054278; c=relaxed/simple;
	bh=hNAFkLhkHf+S4mcBt9/aY9A5BzWfXcPmGSRJl7/4BL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r97FTQkwLZUQi3lstFv9+3/o/ABIk2bpEIavrTN/65sNzJOPooIhw2h4Zram99ESp1BBG4VGHbR9/LZswfxIEH7oWjfYR+LK3IEzKjUJhD3P5tsMhE+IXQwbazLAxFtpySEh1Bd+Gax3JtIuX4u7hrMzQBlKaX7DKXUXr9Pm3xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca5Kmi3T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca5Kmi3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2721F000E9;
	Thu,  6 Aug 2026 22:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786054276;
	bh=bkfyYt0nKyeTEUyq1ZBeSX2vfTy+B2vXRuyImjcb0Ys=;
	h=From:To:Cc:Subject:Date;
	b=ca5Kmi3ToCwGiK0ES26yioe2ZZdSHsut3ZzWxubTNg7D1FtnC+GMmd5x7OhzF7KD2
	 2YWdBp6jHFa437dcbPVjZEcuxXMyOrjNp0u6r015ZgvsUevz3v6JxBYP9vbiiKfu6Q
	 WrXb4OHUFoGbCyhoo/kUnbm4NipW/N5vHCmfaI736zjbsVE+6tyG1FgRW3skRd+tsm
	 jDGNjYaa9mnfJxDLHnZNmVJTrJMQIjG//8la98pHYmIee4BWmd73JsFZG8BGnfwZvR
	 9aPhJ4M457RiiNXJrHZXJJVSJ/rOO7vCpfKqbhdijyn2zzaSsdNHbvVwKobJgRVKl6
	 Wvn3cHzZ3qJTg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-block@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 0/3] Fix a deadlock in blk-crypto-fallback
Date: Thu,  6 Aug 2026 15:10:28 -0700
Message-ID: <20260806221031.79050-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a deadlock in blk-crypto-fallback that could occur
when a large WRITE bio was submitted to dm-inlinecrypt.

As a prerequisite, it makes mempool_alloc_bulk() support fallible
allocations in the same way that mempool_alloc() does.

Please consider this series for the block tree for 7.3.

Eric Biggers (3):
  mm: make mempool_alloc_from_pool() return bool
  mm: support fallible mempool_alloc_bulk()
  blk-crypto-fallback: Fix deadlock when encrypting large bio in dm
    layer

 block/blk-crypto-fallback.c | 72 +++++++++++++++++++++++++++++++++----
 include/linux/mempool.h     |  4 +--
 mm/mempool.c                | 50 +++++++++++++++++---------
 3 files changed, 100 insertions(+), 26 deletions(-)


base-commit: 0d839570765118029aa8bf4a95444c6a11aacf85
-- 
2.55.0

