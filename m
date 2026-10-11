Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B600D30C160
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791733235; cv=none; b=qi1cdZ0MiQzXIjosB2f3REzb71dHmK/pqhIY/Vf2GLhlj9Q1CVUCK7R+kV1inuqaNecMW55xcVTKIyZ23errQp1MwzT3KmptuBLxteF7Fn3t3JeheoaZm/ffV1WmNm3dXAqdZyuNGrdMcp8gc5XtbyQheYCEB2h4rgTzUEFrm8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791733235; c=relaxed/simple;
	bh=+QYIHXFyvNbrFVG0qD+MuEWSYUcqmjbDjCNet5E0HIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTlHX5XiYgHadCZQ363TBijYGIcctMwE3q6ZUzINz5lPHE/ZTo/tnwhcBBQd5NGWA5nRkoqBzkm6etRD1kWzgYAmds8BzXHbXZbzP5nyThJ8KQwjZsQpD6PNW1+7YpWtbgNjGzdP3h4QSsdkRjz+4OFZitHWUf7uVhBBXMRJmjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYxdjo/x; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYxdjo/x"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-141395927feso2047658c88.0
        for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 08:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791733234; x=1792338034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oOpfbyLfnY+pmbLGNuG2FatM2jcN5qtcmQGfobqrIc4=;
        b=VYxdjo/xjbAaGBrIezMpvuPUR0k6xQcY3SJVwJlYhci7rdm8OO35pytT/dnQu+R3zQ
         LiDh7RA0FC/pf79Sj96Mue67Zdg8xMhHZ8vrQtr/DR67r/P77tWpkLFHJoJtk11k8PAB
         IGeWwgWa4dXuiulpfp87p5Ky6zslvh8EaPmoSH2I0qQmHzqblx0TTje6nr2gUlwZY1LI
         naEq/JmjdQqLl8O6lpupEltFK0yUn7rbcHjPKV3bgs2X96R2ivcg8grWQCuJOB9eA7PT
         yGekfD82THIK6A5Mb+S3/kLX+/m7nvMtGMoS5pHigLZN0xDop+pb9LwihESYMwnEvsQ/
         ymMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791733234; x=1792338034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oOpfbyLfnY+pmbLGNuG2FatM2jcN5qtcmQGfobqrIc4=;
        b=r665fUXSnp9paYOR7lqxQrngwyZqs1H6w+owh7tLXhV8CWTnYSDF1gSKCUc7VDmJ7z
         pw/XAqtwBVMlAaAvXggHtR//eBN4ok4jIAas4EIFJDNueOjzVbQYR1My7d47lTWyXfdw
         vMFxFM3LsjSccOPXSZb/lTuQGzO2DYo2zwzG4T120+0/iuMH4abXVuz6yim7lbhOSIfz
         2IYR31SqqS5Tihk/jLDeJu/Dt+mylchcN1Q4Yulq834bywmY6WQ8X8GDu40FIJV9rWYF
         uDIRafXFdeL51wJRDzSp62mut615S+ofLTxVQvWXxMUCeMkf0F3I+MC94oe9QtCANIti
         sN2w==
X-Forwarded-Encrypted: i=1; AKwUvBybJJp6uadwnVH/N4/S2l2uG2Cwh9M64bZb8o7KYbbyrC0fOFMQr7EkPg6K+M2DQ//iiBWFk9BPWhan0Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYIX8xnUbvsQ7o0RB4lWFmOIegdG1VTJlFC4t3TbcRQCp6pA5R2t
	HpNu8C0LcyTnHI1DvecA2wF45ZDSPb8FBGjwRsVmomUeIfTQA++K7WDy
X-Gm-Gg: AYBFou32EXQ4fU5rrx65Sp9iwgfTF7/YF6aObx7Iz9JzVSt7lixQUm6JCYXzwCzslF/
	Lxl4XlUwP2IeiReCofhLv5sKSJraLlGKEvB+IeWgwsyML/o6jG9dargJO3pd1gpkqdGF1sUODXB
	xev6kKmgZnCs7nZwmHNN2w0yiQnShJQJ5iSH1xy/aLNmYFMalRKT2r+4OlOHlzzmiTU3dMXJS8q
	MWNWpYWH0/1WIsRAne85hiR+jae/ZuC9x9xEAysecl/OcB5ROf4eTOA7G49DdxG+LsGcxNeNqk4
	i0HxQNpgRmBdhq9fMJkiyBNDr5mpqfykNs4G50tLsUUeZTpIaJ9ANWF+dlnYmMHe8oeAxPOAafg
	z2F0jppliCRw2x1TO1eap3bbwDJN380a0A6soxG0ZBwhqpWpoYKOchasYEDwtdhFSocNSkO/1Wp
	dVQIhbSRy6hYXUPsN2A2Hvln0rqAxU/EMulMlt9VqqIz4fkMj2cZXWhw0ndO0o6WG/wIivYSck0
	kT9BkngzP7XbVEu/CLmxW6HEr5ICzcrEK2tYjH5qwm1dQZQb12tr4uaTkbfKt3bc8mrPYnaAUfv
	mSszFhDEBnxV5dynwIbjejHE2p552Ln/6CafEpu7+vSsapG+DcQ3iNh+/DwPtfkRKttnWTJWrqJ
	GSniwgwze7DCTgRHBYjU9maX180S58IXyRP57uZasygx5Tea6CZM34nP4CgVdak1R+Q==
X-Received: by 2002:a05:7022:3b87:b0:14c:e31e:5dd4 with SMTP id a92af1059eb24-16a60ce6e71mr12195246c88.36.1791733233708;
        Sun, 11 Oct 2026 08:40:33 -0700 (PDT)
Received: from FT6N242TWK ([223.181.119.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a32eb7ebsm26252154c88.12.2026.10.11.08.40.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Oct 2026 08:40:33 -0700 (PDT)
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
Subject: [PATCH v2 2/2] block: fix the length of a smaller last zone in blkdev_get_zone_info()
Date: Sun, 11 Oct 2026 21:10:18 +0530
Message-ID: <20261011154018.48913-3-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261011154018.48913-1-jain.sm@gmail.com>
References: <20261011154018.48913-1-jain.sm@gmail.com>
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
Prepared with Claude Code (Anthropic), model Claude Opus 4.8
(claude-opus-4-8).

 block/blk-zoned.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c9b66b8a7..4ebaba9aa 100644
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

