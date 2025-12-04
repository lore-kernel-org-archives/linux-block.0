Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA80133ADB9
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764846252; cv=none; b=huA+83ApeumZVqMrk1i5iBRL3g+qRipEFPuRc8B9FqCG0rHvWqAGI3QytohjCNNltgQb2Kl9zv565uxKsso5CSla6EIxdyBSRh3dc9yJuRm3T9jBlq+hcchDT7CK8qeICeVH2QPREuzi1NalGgRTeSlboCN9yLb1qFTPP4yK57o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764846252; c=relaxed/simple;
	bh=AwQg7zKWtZ3I3Vkv9FvnT0yAYY49svdZgq5yh6NptFs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uYDaf0p6GtuzdhL/6rUj6LfLhUj6l7nrpLCAOhb5Mgd30t5lNy736X2996T2uQqgVIx7xPGK0s0kquauOf+2sufQiLOTfYXEDTGtAZp3XrAPZnPdl+8nEx5OjEze3ZLDzr4vQaSoNqkRQcDTVXA2IGE74jNiAMDgUvMxVhkfokE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULzrNjSi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULzrNjSi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89E8C16AAE;
	Thu,  4 Dec 2025 11:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764846251;
	bh=AwQg7zKWtZ3I3Vkv9FvnT0yAYY49svdZgq5yh6NptFs=;
	h=From:To:Subject:Date:From;
	b=ULzrNjSikxwbuHVwlk+IzXEL2kshV7KAHSUHxHBxeS4WrgwIh0WjDXLg6eN5d9CHo
	 gZPGiU5YxMTS0h6yJAuIJpock9hmEqL9hScBuSjJQd+UA03QVVYvBGmcsLVmzptEhC
	 qgjOMbbNJ4DZoT30LOeXdDWk0uk7VqISGf8UwDZMpCCBAJuR3UnkmcaCyYMwKcVz4z
	 BADf0oPhuOVHXXzdAdpXODhj+j+/TMJsyTmi4xBZy87qPrH0ZYKNSKGrPImlTxRjEZ
	 plw2C9aY8e6+XHWGjWoDvyopw3Th4P6FsLxtgfBdR3BZsi+VAHvnjtvP5C3HiDTbxV
	 BYbs1L7s3ETKw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH] block: Clear BLK_ZONE_WPLUG_PLUGGED when aborting plugged BIOs
Date: Thu,  4 Dec 2025 19:59:52 +0900
Message-ID: <20251204105952.178201-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit fe0418eb9bd6 ("block: Prevent potential deadlocks in zone write
plug error recovery") added a WARN check in disk_put_zone_wplug() to
verify that when the last reference to a zone write plug is dropped,
this zone write plug does not have the BLK_ZONE_WPLUG_PLUGGED flag set,
that is, that it is not plugged.

However, the function disk_zone_wplug_abort(), which is called for zone
reset and zone finish operations, does not clear this flag after
emptying a zone write plug BIO list. This can result in the
disk_put_zone_wplug() warning to trigger if the user (erroneously as
that is bad pratcice) issues zone reset or zone finish operations while
the target zone still has plugged BIOs.

Modify disk_put_zone_wplug() to clear the BLK_ZONE_WPLUG_PLUGGED flag.
And while at it, also add a lockdep annotation to ensure that this
function is called with the zone write plug spinlock held.

Fixes: fe0418eb9bd6 ("block: Prevent potential deadlocks in zone write plug error recovery")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index dcc295721c2c..394d8d74bba9 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -741,6 +741,8 @@ static void disk_zone_wplug_abort(struct blk_zone_wplug *zwplug)
 {
 	struct bio *bio;
 
+	lockdep_assert_held(&zwplug->lock);
+
 	if (bio_list_empty(&zwplug->bio_list))
 		return;
 
@@ -748,6 +750,8 @@ static void disk_zone_wplug_abort(struct blk_zone_wplug *zwplug)
 			    zwplug->disk->disk_name, zwplug->zone_no);
 	while ((bio = bio_list_pop(&zwplug->bio_list)))
 		blk_zone_wplug_bio_io_error(zwplug, bio);
+
+	zwplug->flags &= ~BLK_ZONE_WPLUG_PLUGGED;
 }
 
 /*
-- 
2.52.0

