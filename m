Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA4D22A7F6
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 05:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791695955; cv=none; b=GEJ6x4WNJRKNtivdxzy11/xj8rfLHlgrA5+M+hKCQkYa95HNdovGGb9p3ud0zXnGd11Z0JoShPtDcu7EI9EYPo+UTQrW/LrN1KTTHaPBF0YfbseXjSTGIhhrgBK6iLuGrlR1ozF7NcbR3qCEtHtdCtGLqJYKcA0F+3wErFOld7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791695955; c=relaxed/simple;
	bh=HvNmhkVDvrgbn7qUxofRW7SwFcOvKCzi3f5X/xRClVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipHcwWmU0adAszjYaKbvdse5cNJvFAulWn4ZC0FQrYg3TtxZdd2jfviESmHmEfaxJ0j4sC7gWAiGOB2z2XF/lQ+L1kkb6K5gyNsXCa4tESmcwUd9d/aK1zYdzMalPm/oFcltFi70bKoA4bbTNxe9t5bBAlxcym3tlz8CQjgbGD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvXqJd85; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvXqJd85"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3515f9a5d25so2665767eec.0
        for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 22:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791695954; x=1792300754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z3f/o3Gj46IoB/K1eXbjM9yD+rl1ZhRg4Q8Vl0iFlb0=;
        b=CvXqJd85rGAym+I79mdQD2GVyuMWRuS2e6mWQrcALLfKA5RMseuca8dP+Is/24Q3ns
         MDtUhIvzA9KmPn7jg+0Vad0++uMD++rgZIUA/p3YojeatSRrVDxHU3OPqn8pooY1k5Vr
         DZHEDNmNNM0jN+sf4rBecmKSGgMYni7+46etua7u9SO8WSZEeTmK0bp2yBmxCe67+u8z
         hIzYem7/EzJleg2DXMXUpSK0bS/qgPMQXm0mSd20effWHwvHKUjP7U7MBrT3oRah7l3d
         PXMytGGi1QXP0mUvmzcrwxNsMd7wjqPWTKuKV2L6FMUR5RPvXVNswokq2YRgx+WvJu94
         185g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791695954; x=1792300754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z3f/o3Gj46IoB/K1eXbjM9yD+rl1ZhRg4Q8Vl0iFlb0=;
        b=0kLrJeZktDyj/z6E9netVsUqzj2ufnHi8zjjZbqfpqlSLyJ2Uc1ZUlaKinakItIZkN
         K8z8Kcd8zAK4pydNx/2YXSmuEddZ2AVNjT+2xcXMzsBpZUUiRUhSxO1fkIW6fBlRMJCh
         /gb3FkOyAlO9U+OS8JajXjhWYhFlvnNfnjMlX4xIO1VhNcanWxYhA8lqq1s4xvCPeadE
         bPDbX9TVorL1X12waZbt5E3OrT/n2Jt4l6+BcNZ8RO/beOelLd++UGH/9trpWRkyVIAq
         vTnUMqhd/OxE4VzzhQ2Y92NPVIx/MdHUOxrbf4CCSk2nbFk1NNUnMwTcW+nEbWVQL2a+
         GMPA==
X-Forwarded-Encrypted: i=1; AKwUvBxu0tSgVIrQK0rdJXedAd0BsBGuTGBO83Wx9/KX051IK9IZuPtegPA2cefrQphX4/nlEhdtKDUHi/MOeg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKsxZK7ja41G37kSN7PZ/OUMj2KnrZ3UeCOdEiSlNCMubz7w3EE
	0XlX5CEW/PD1rzUKS9CvzNQmhNk4GEayV0I4xtBNTxqirjDloW+Whu4+
X-Gm-Gg: AYBFou3dmOESu2X13SyRQwqOV+YMvASqUSImhfZ/a0ZEaQF6SwB8OCLB9CXBEK1CcbE
	3yVtv1Vx/oF2Mjgl6pNKPBiIUAHU5ZKRcG96BAThxqOgbEWfNlShBNqWRx2Amipdufyaa//Fuin
	XdAs7R+wDlyJl2Uior6+ioDZeFwlRykPFYThv811zAWNsl0DTIA7CeHTJ6QDzSVxRPjSjop9wEa
	AWazT1vH+4Nq5FzvpcDXRotyng7UecR12HCfIiPBc3mmnCVZVYPkDKPPq4WAlVnASArFCqUPeHo
	/Q7uoOVQZUOoALlN6dRUfbEtla5kTc4bLaenXh5sL2DiCOHQ/ifdb1Yd/Ry9QzTQKysU8R/HnMW
	rRGRVhta2R58Z7V8g2t6WBo71fiB9BCzfncTxVlJ0bslgNzn5Wq1niluobeoOufp9R16HpQdYjT
	aplclh9640LqXgv/lFRHeQZGUremWPeRUPvNDUEkOKWzvPAoGItawlja2SP2YnAE66nOZ0vF6tC
	IFwQbSXIPyYbO2VnG2jgvcMxrnhISnPemEsFIR/IeEedQEBz632l1Izo2vgQCKOd0ZWc/YiI6Rz
	AihbiSBCpQ8MiwQjthgu8QYBikRa3hoH5Ur3cILsehxI7vCvAWy6ZhB+R25oi6JINm13eTIAnI6
	qKMrF3zBLoFq6qs/3BUX9zKBSMj2BYCrUD3DtCKSZ0+jDDJtyxVR925E=
X-Received: by 2002:a05:7300:2216:b0:351:28d9:4908 with SMTP id 5a478bee46e88-3537db99e8amr11984121eec.0.1791695953335;
        Sat, 10 Oct 2026 22:19:13 -0700 (PDT)
Received: from FT6N242TWK ([223.181.119.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35978efac1asm4979129eec.19.2026.10.10.22.19.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 22:19:12 -0700 (PDT)
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
Subject: [PATCH 0/2] block: two fixes for the zone report ioctls
Date: Sun, 11 Oct 2026 10:49:04 +0530
Message-ID: <20261011051906.60397-1-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two problems in the zone report code added in v6.19:

 - BLKREPORTZONEV2 does not look at BLK_ZONE_REP_CACHED and returns the
   cached report also when the flag is not set (patch 1).

 - blkdev_get_zone_info() gives a smaller last zone the length of a
   full zone, so the cached report describes a zone that ends behind
   the end of the device (patch 2).

Both were found by reading the code and then confirmed with zoned
null_blk devices in qemu (x86_64). The test program opens one zone
explicitly, writes to a second zone and closes it, and compares the
reports of BLKREPORTZONE, BLKREPORTZONEV2 with flags 0 and
BLKREPORTZONEV2 with BLK_ZONE_REP_CACHED. On mainline it finds both
problems. With patch 1 only the length of the last zone in the cached
report is left, and with both patches there is no difference apart
from the zone conditions and the write pointer of conventional zones
in the cached report, which are as documented.

For patch 1 there is a choice between the code and the documentation.
The changelog of b30ffcdc0c15 and the comments in the uapi header both
say that without BLK_ZONE_REP_CACHED the report comes from the device,
and BLKREPORTZONE is marked as deprecated in favour of the new ioctl,
so I changed the code. If the cached report is meant to be the only
mode of BLKREPORTZONEV2, the header needs to say so instead.

The series is based on mainline (a5ebb76233b7, v7.3-rc6+). Patch 1
applies to next-20261009 as is. Patch 2 needs its context adjusted
there, because blkdev_get_zone_info() tests the zone type instead of
the zone condition in for-7.4/block.

Shashank Mohan Jain (2):
  block: only use the cached zone report if BLK_ZONE_REP_CACHED is set
  block: fix the length of a smaller last zone in blkdev_get_zone_info()

 block/blk-zoned.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)


base-commit: a5ebb76233b79db01e82e061173cb73c6d2b5c6b
-- 
2.43.0

