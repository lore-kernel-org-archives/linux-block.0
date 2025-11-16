Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C043119F12D;
	Sun, 16 Nov 2025 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763266229; cv=none; b=CWQOoGVKfpb1af3y7+D2KoaslCPgdg7XAz2G6V3hdDt9g1kXJhZ6IIObGFTjZIE3Y6PYm2R4ixyGZ2Fi7d16w191VgI1u6nWcl5S4u3TL0ZniYJDmJ7UrgGQ9/VTTOjEw/PQa3gCTrk3ScPal+8HcWXRfMoGpNDNvvBtf/71Pak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763266229; c=relaxed/simple;
	bh=ZOj8gZZ3iniFRDrko2GdVfvU1ILuabA1ZswNDe1Gn34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T3rgCBa3qid50rDJB8hxQjtcU+BE6yVTUqNFkvoSPdqW3lKFh5vBkorO5YPxaU+/RorJ20URp8Yc/P5E9yu7lCUqFSu4s2SoE0jDYreB5B/6GTqNwQFGoYr9yNOE2DfEQE/SWsUCwwKhllNL4SrJiHxty0x2bA5lCofcVJIjmdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C1EC4CEFB;
	Sun, 16 Nov 2025 04:10:27 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH RESEND 0/5] block/blk-rq-qos: fix incorrect lock order for rq_qos_mutex and freeze queue
Date: Sun, 16 Nov 2025 12:10:19 +0800
Message-ID: <20251116041024.120500-1-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - Resend with kernel.org email server.

Currently rq_qos_add() will be called with rq_qos_mutex held, and freeze
queue, this is not expected. This set make sure queu is always freezed
before holding rq_qos_mutex.

Yu Kuai (5):
  block/blk-rq-qos: add a new helper rq_qos_add_freezed()
  blk-wbt: fix incorrect lock order for rq_qos_mutex and freeze queue
  blk-iocost: fix incorrect lock order for rq_qos_mutex and freeze queue
  blk-iolatency: fix incorrect lock order for rq_qos_mutex and freeze
    queue
  block/blk-rq-qos: cleanup rq_qos_add()

 block/blk-iocost.c    | 15 +++++++--------
 block/blk-iolatency.c | 11 +++++++----
 block/blk-rq-qos.c    | 23 ++++++-----------------
 block/blk-rq-qos.h    |  4 ++--
 block/blk-wbt.c       |  6 +++++-
 5 files changed, 27 insertions(+), 32 deletions(-)

-- 
2.51.0

