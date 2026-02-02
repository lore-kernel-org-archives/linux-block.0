Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0957D2E266C;
	Mon,  2 Feb 2026 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770019528; cv=none; b=iOAoRVixp5YlanT7YHXjGwHAfLStikIEZBkcE7a/byzKx7BJfWHcPitzpF8m8EOcOYPOm5E/bbI9eb7Sncg/RwmuIvp/ga3qZNvHmQocZAr6JH5l4zsjOrKyK+rYaHznUeIocZ5ecmRpymwFV3jioTcjZc6rIYdaEA+OhySFDL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770019528; c=relaxed/simple;
	bh=GD/dPYEdljGY+Rko69wynHAcdro2Fro/nn3uCyJuYOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbL0+HyI1PN145srGIFomHyT6Q9mf7OlMJRdZBTW4a+8/lMXSMqx6BO04cy8qYVgP3TjKZ29KBegfF710TYAgP6lurYiNIytk4m6bn45IF1oCrdZs4wKm9r879LeXxYDQAxes7dPSAHZXPGHt2S1oI3IVpEzRTTV6gMj8kSUSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A5FC116C6;
	Mon,  2 Feb 2026 08:05:25 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>,
	yukuai@fnnas.com
Subject: [PATCH v9 0/8] blk-mq: fix possible deadlocks
Date: Mon,  2 Feb 2026 16:05:15 +0800
Message-ID: <20260202080523.3947504-1-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix deadlocks:
 - patch 1-2, pcpu_alloc_mutex under q_usage_counter in blk-wbt;
 - patch 3-8, debugfs_mutex under q_usage_counter;

Yu Kuai (8):
  blk-wbt: factor out a helper wbt_set_lat()
  blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under
    q_usage_counter
  blk-mq-debugfs: factor out a helper to register debugfs for all rq_qos
  blk-rq-qos: fix possible debugfs_mutex deadlock
  blk-mq-debugfs: make blk_mq_debugfs_register_rqos() static
  blk-mq-debugfs: remove blk_mq_debugfs_unregister_rqos()
  blk-mq-debugfs: add missing debugfs_mutex in
    blk_mq_debugfs_register_hctxs()
  blk-mq-debugfs: warn about possible deadlock

 block/blk-mq-debugfs.c |  68 ++++++++++++-------
 block/blk-mq-debugfs.h |   8 +--
 block/blk-rq-qos.c     |  11 ---
 block/blk-sysfs.c      |  39 +----------
 block/blk-wbt.c        | 149 ++++++++++++++++++++++++++++++-----------
 block/blk-wbt.h        |   7 +-
 6 files changed, 159 insertions(+), 123 deletions(-)

-- 
2.51.0

