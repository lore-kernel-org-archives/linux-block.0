Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61B525F98A
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 05:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791695963; cv=none; b=JYCQb5ryEfFGVNt7pgStxAMlNkBueXWZOcAcpnmaMR0ZenQEboW2dTfpu4LPmCvMs6X135VVUJS5nN2krCbD4uucIqt/M3v3521oDukmN/RQSZqIS3LnfFtqGPAJ6dfCc/XflF7Z8PPGxfCydzzNvkwVf1Hq8Sf85wslVfmB0Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791695963; c=relaxed/simple;
	bh=yQ6gVx+3TRvMg1JXh7l5Z1oTc+eL5ZApypmtUHwCvz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bE8n9ExIVGHlmiJONmYfM9lDTrMp8BkIjV+TVM4rHNgzRTrZw4yOvc27BXh8/tR7DZF6En0KP3lKif8pX9Pm8potkwzA6SOqSTNK77zaPCws7+2I4uEIyu8fk/IfwHA3VFZG2MnFgoHQx+xXhCte7PY+PR1Zkw+83t6C4b9o/cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrA0sXSZ; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrA0sXSZ"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35115b52125so1241188eec.1
        for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 22:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791695962; x=1792300762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Z9JHfHb81pE0sUZcdvVbHvhF9QmiecEDL7VzMryt5w=;
        b=MrA0sXSZuyNsSyz0COzhjW6lCTCKEXSepypI4t/4YcW4i/WUYxHSSWreguqHnb07oh
         8lk5NH88quOglVK7tw1jpIPSKuvbHjgf8+heuDr+/wXc3kMQGR+0iniRgWgm/ILPJZgW
         h2iRp1w6tJNz6uO4XoYVRCRidt2X5EN7q8tyerGy+CYZ+w7w6L8cKD3EHIRo7odzWQFm
         +o0LH3xbE/du6WOdPppdq3ZXD1BTTDQelozdvylnm+QlNrXIrNgbRPoGWpfcPXqA0ajj
         uqGIdh2+xGT3CKYdyRhfnwStyVKQ4f5PAqN72gaLT799w1OujE8KdMUhkdUUMD37iRAq
         NSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791695962; x=1792300762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Z9JHfHb81pE0sUZcdvVbHvhF9QmiecEDL7VzMryt5w=;
        b=1NDmmMkTJD3K5G3RpnMphYI3yfv3TfMQGs6sOgWnoXiUDjCLUnpmcSJ0w2inqiR7de
         vnW8AdSicDXcdNxhNy8U6UyRA2PwsJCQy0EbpTkroQL17k1P4PJO/2ezNv/RlQxdZK+Q
         QOOv+GOI8oOd/HPyQZUQDhCLHhHX++Ug2/lr0UKHhMG/l/iBDhDKFOV5wm38foBVqEQ+
         7wPEg+LY4b+npboDJZszTmZVf/fB/QG3QWb0FCJvirHABB5cpTSw/ZFaHpdNtNBKYVYW
         eZgOltVOWHHMpfc/0SrxWUbtEbV0ljr938o+Dy57saWDMbDI2gmbHSqtW/J5IRJAr72V
         5vxg==
X-Forwarded-Encrypted: i=1; AKwUvBw7SBrMvHXLks0BZUrasRTcq3N/6n4ami99ywx8lYvNxr+G+VcE/eLKELyINXNS8+z7EZTbsFPBcLBrvg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJlTa7ywyNNLfQmKIHkK1Efc2wGve186noAerKmQMkcieMic4dR
	jZXMJbK1qoArU0LUYMRxBrJoYxsl8JB8bLfujIRn5aBOuIkOFTH97ott
X-Gm-Gg: AYBFou3KseVoiZhVlrazJQNO0fVbylzQl6CjSuMFRIgCoScs7rmjqs9d6tb2xoFmxho
	l5JXvvY10oJQzLDNgBY23Te/RSqjGnmI5J1P/kt1ZcCZDPTA18D/58n/L6hhREPqGeZjqXs73+3
	pjtgZNg0vkveAEr/Mrh22bnnzJb3OtyuIRJ4bqkMHcybickgrgyemGpOS7XgOZT2NQ8qL9sQ1uX
	wlAnuvpWskWG1lGFKEuPv/O1WGK3hnVImYLRJm1tvE6AiGGIn9SOjLShS0r4wfwwyIj5Z//Ay8X
	5sh/rgGHt8ReEQKxDuJTg7TSWQD3eBYRdjrn3ulJfxarEYkdMbbUjmfxxmmMMRALqzfgmKj+uqn
	ZkgQnA9go9R+ecOkXAUj7F4uHp2MQ3/uwc3HzbQcAcQgeWFXZvOqLVPVHHIgPW8vYaUHS7+qLBk
	1f2ZXTimh3l5PjAR72E4EPAB0YPF4AZgLDeL4dgLHmMgIYjqEfMFGZc81GFiLaTVDt04GIyOpvx
	EqA6JSNCuu6QMpWs2JQ6Goa/YfsCS6OjE3rcveb9g8QsD1QpgUiiuKQ27q6ZJIxQFBmDCIBqgTf
	gZajOe4lBFNVtPMYNnT6H1OFeYMT2XcCUcJyVdnTxJckMrD9CmvO5rh49P0dTLuVcJANxjOhpaQ
	LNKW7KyJBKSKROV3fffKEX2V9245szDB4miM4kMgI8FU1qEl5RLHX9IfoDBUkbc70rw==
X-Received: by 2002:a05:693c:6218:b0:350:1d30:6c0f with SMTP id 5a478bee46e88-3537dfc7defmr9387129eec.9.1791695961379;
        Sat, 10 Oct 2026 22:19:21 -0700 (PDT)
Received: from FT6N242TWK ([223.181.119.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35978efac1asm4979129eec.19.2026.10.10.22.19.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 22:19:20 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] block: fix the length of a smaller last zone in blkdev_get_zone_info()
Date: Sun, 11 Oct 2026 10:49:06 +0530
Message-ID: <20261011051906.60397-3-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261011051906.60397-1-jain.sm@gmail.com>
References: <20261011051906.60397-1-jain.sm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blkdev_get_zone_info() sets the length of every zone to the zone size
of the device. The last zone of a zoned block device may be smaller
than the others: blk_revalidate_zone_cb() accepts that and remembers
the capacity of that zone in disk->last_zone_capacity. For such a zone
the length reported from the cached information is too large, and
start + len is beyond the end of the device. A conventional last zone
is also given the capacity of a full zone.

Example with a zoned null_blk device of 10 MiB (20480 sectors) with
4 MiB zones, last zone:

  BLKREPORTZONE:       start 16384 len 4096 capacity 4096
  BLKREPORTZONEV2 with
  BLK_ZONE_REP_CACHED: start 16384 len 8192 capacity 4096

Limit the length to what is left of the device. disk_zone_is_last()
still recognises the last zone, as start + len is then equal to the
capacity of the device. The capacity of a conventional zone is equal
to its length, which blk_revalidate_conv_zone() checks, so use the
length there.

Tested with zoned null_blk devices in qemu (all zones sequential, and
two conventional zones followed by sequential ones, both with a smaller
last zone): the start, length and capacity of all zones in the cached
report are the same as in the report from the device with this change.
null_blk cannot create a device with a conventional last zone, so that
case is not tested.

Fixes: f2284eec5053 ("block: introduce blkdev_get_zone_info()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
---
Prepared with Claude Code (Anthropic), model Claude Opus 5.5
(claude-opus-5-5).

 block/blk-zoned.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 9555eae91a..ca0950be3e 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -971,7 +971,7 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 	rcu_read_unlock();
 
 	zone->start = sector;
-	zone->len = zone_sectors;
+	zone->len = min(zone_sectors, get_capacity(disk) - sector);
 
 	/*
 	 * If this is a conventional zone, we do not have a zone write plug and
@@ -979,7 +979,7 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 	 */
 	if (zone->cond == BLK_ZONE_COND_NOT_WP) {
 		zone->type = BLK_ZONE_TYPE_CONVENTIONAL;
-		zone->capacity = zone_sectors;
+		zone->capacity = zone->len;
 		zone->wp = ULLONG_MAX;
 		return 0;
 	}
-- 
2.43.0

