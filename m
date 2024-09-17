Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D073446
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551183; cv=none; b=Ss104DXUehg9GnCACHgtDVPXoP0H3IPdSuxfXjFE4NHc7vtfAwwowGHed80bmVBzYEl2GU1f09Xn9rs/FweQN6LsCnKDrVLnKjeMzyCMRXX1iRyGam7IocqQ8iN5lX0V/qugHdgELJKbWab2e9Mg7bJaaLaFZiHzOnrQ1xHlAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551183; c=relaxed/simple;
	bh=Byz+FGQQoYuHubRax7vtAJApKyDAGo22b41HPFg6vVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMuEyjlOk2JhdQ7SZEM8QSnlYzfgh3vcODaZr1gT4/f3BCgWWJKXxcWsE4uWnDcqCQgiOgRJ1G7Nx8LnfvMfEB7ksL7bzeOYo/SIPmmQz/xARyl/ptnuW2IDHVsf5l/EL/ZlvGFkM4oxXPhPqQGAT1N+eT1/J9wOy/W6jZeMYL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgQIydEV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgQIydEV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8FEC4CEC6;
	Tue, 17 Sep 2024 05:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726551182;
	bh=Byz+FGQQoYuHubRax7vtAJApKyDAGo22b41HPFg6vVk=;
	h=From:To:Cc:Subject:Date:From;
	b=VgQIydEVlG8ty2sYppsXdqW/WsN8GbbhBQirAdy0dkJtGM5bBRW40VkQKUG7KW3lo
	 qz6PkiFdDeJ4neNdGFO1K1AM11l0Un7732e7C/lwBmiuf3f1Rd3p9JwWj0PDfi7DRz
	 85Wmc79sWd3u6KfXjJdlA6pnKqPjhKiafX78x2YR/TH8Gpq9edARAXV6p4xEMiUtFS
	 Okb5Y4lVV6+eKnczJIsFnWmN63akz2LkNcjWS3EbZzzkbN2tzj36IizbKv12AMF56E
	 uVbfcyfzhyB3FEDVOOMofLMZ2IIuAeWdas5mCTfAePVd0B4wxYKsQoknMbxPSx5Hg3
	 5ce6gnExd7zHw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jeff Moyer <jmoyer@redhat.com>,
	Jiri Jaburek <jjaburek@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] block: Fix elv_iosched_local_module handling of "none" scheduler
Date: Tue, 17 Sep 2024 14:32:58 +0900
Message-ID: <20240917053258.128827-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 734e1a860312 ("block: Prevent deadlocks when switching
elevators") introduced the function elv_iosched_load_module() to allow
loading an elevator module outside of elv_iosched_store() with the
target device queue not frozen, to avoid deadlocks. However, the "none"
scheduler does not have a module and as a result,
elv_iosched_load_module() always returns an error when trying to switch
to this valid scheduler.

Fix this by checking that the requested scheduler is "none" and doing
nothing in that case.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 734e1a860312 ("block: Prevent deadlocks when switching elevators")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/elevator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/elevator.c b/block/elevator.c
index c355b55d0107..d0ee9c0aaed2 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -714,6 +714,8 @@ int elv_iosched_load_module(struct gendisk *disk, const char *buf,
 		return -EOPNOTSUPP;
 
 	strscpy(elevator_name, buf, sizeof(elevator_name));
+	if (!strncmp(elevator_name, "none", 4))
+		return 0;
 
 	return request_module("%s-iosched", strstrip(elevator_name));
 }
-- 
2.46.0

