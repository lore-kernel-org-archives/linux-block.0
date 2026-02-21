Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED7A9476
	for <linux-block@vger.kernel.org>; Sat, 21 Feb 2026 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771634969; cv=none; b=CFghx1zT8Wu0Mi/WHgRHCuP6+1aBW9kA5t+tKZLeazh5tPu8rlsPRT57W4C0lJvuQJxwKoa1eeixFLEZvH+CeV8Ai0sz+xBSu7Ib5nXddnBn7UrJXyAiq2XmN8O7pGtGeJV0BkBn8dkYnBATlAoUFVf6Zgg8REJgTsTlY3FxNCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771634969; c=relaxed/simple;
	bh=MLRAT2diIDRs8xTDNcuPfHJkjSNwaV/cFnVEhK1cg0E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IqKDhCLT4STZYB4bbPpisOd5A83ETFfJ1xHsu+kdMm1hSPbAwtqlXV5iQSDYYFzZgwRyTFJFPHQznZYSn4VW96vr44OujFhRJvxpvWhFWE0i7ki58nPwd7lHD51hqszd6Vhrya6Chv/hdK5wU78UOK07Df+RBKC+6JFwyhG8k7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnGg0f1W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnGg0f1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CD0C116D0;
	Sat, 21 Feb 2026 00:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771634968;
	bh=MLRAT2diIDRs8xTDNcuPfHJkjSNwaV/cFnVEhK1cg0E=;
	h=From:To:Subject:Date:From;
	b=FnGg0f1WVnh3Lz9m/ZYp+j7QY3hxZ2v9CwqlvTW3LSRylltTCIPuGTbB8bItY2Blr
	 OEbLQsheMSFYPxGT+EH19WpEwF2rl2IbJpCCoHeBjx7qBaifMy4L77VJKyQwcRlQOh
	 xnzPoh2megN69ag2edIdDVEuR4jqWp8CJXE+SCv99J3CucnbMGYVlCOkzWfhLNPdz9
	 j4LL716YVVYd7aV0LQxlzg2YksYAPFGzgFL/E4uYJG5ayM8wZXz/Jab8GQh2UEgY2I
	 lZT54YTcZebwdbDihKriKfdxkRP6T31k5km1/U7cjbhnBsV1ufDZiyH8Iy6eYbrTCs
	 wllTnu4yp4hLg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 0/8] Improve zoned (SMR) HDD write throughput
Date: Sat, 21 Feb 2026 09:44:03 +0900
Message-ID: <20260221004411.548482-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jens,

This patch series cleans up the zone write plugging code and introduces
the ability to issue all write BIOs from a single context (a kthread)
instead of allowing multiple zones to be written at the same time using
a per zone work. As shown in patch 6, raw block device tests and XFS
tests with an SMR HDD show that this can significantly increase write
throughput (up to 40% over the current zone write plugging).

Damien Le Moal (8):
  block: fix zone write plug removal
  block: remove BLK_ZONE_WPLUG_UNHASHED
  block: remove disk_zone_is_full()
  block: improve disk_zone_wplug_schedule_bio_work()
  block: rename struct gendisk zone_wplugs_lock field
  block: allow submitting all zone writes from a single context
  block: default to QD=1 writes for blk-mq rotational zoned devices
  Documentation: ABI: stable: document the zoned_qd1_writes attribute

 Documentation/ABI/stable/sysfs-block |  15 ++
 block/blk-mq-debugfs.c               |   1 +
 block/blk-sysfs.c                    |  43 ++++
 block/blk-zoned.c                    | 312 ++++++++++++++++++++-------
 include/linux/blkdev.h               |  10 +-
 5 files changed, 298 insertions(+), 83 deletions(-)

-- 
2.53.0

