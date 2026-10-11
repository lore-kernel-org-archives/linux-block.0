Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909713C4168
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 05:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791695959; cv=none; b=SoJ4M/IH4JXF3ojIV7HQYVOcJRbF9gl5ntkztSLknAPkgYZ8TirZC63BCPXadpuauO182UNMy5a6iqXoYiLbnLRg+72JTHoLiigxrFwpcrIbIK5lYIDvZMOdW4lF7A3UrRCDOhs7OldIo1FePcAWWk6OfjkZOz50+sfi2qmgJxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791695959; c=relaxed/simple;
	bh=U8rEmVEm6NJOvBo5ns78eKUPkHx3I/RxebN283wiah8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjvKyHLxagdGJZbhgvachXizA0MKIa1HANQEcVxScVwh0GHrQH+ytrOu6Gy//ctNnNwukJArcWcsG8EINGwdZxRbzKAoo5aPH4Kr1ojDGwO7CoWrBTWW8GIsmi654bWAV/RLvsBOmDddoXIaUZzacpiu5/A6bZrgwKCa7p1/gSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qWphle3U; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWphle3U"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3115c4451c8so965076eec.1
        for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 22:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791695958; x=1792300758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P3HkQjCQhDTO0NbzrRMmz2iW5BJKPRHxdB9PJFrYJVg=;
        b=qWphle3UPHNeCaWHGQqxaCGFd8m8/6hPTYNeRw/FANlMuLjpM6ZpX0rv7E0RZnKQEl
         C/oHjv+qPuxPm9C2T6Lx2GSyIyT5ann8ZXLRH0+6QSxrRucFEB7S2Nyq+4bE2souckXD
         bTUnDaoWsXAAEu5cY7g7+bFgVKd8GsZAEIyCkR/FfgvEO7gJtM8QoIb7En6Esq5dIBON
         hTqC70ltETfkJdBG1JDQcEraFQxB7iciqQgktEopyHMnhjBAXiMHxFjjtxE7f6thavyX
         8uC3jY2MLldkOr1VNvfr7bjoHLG9SElhqMHK0hobySzb0COLyHGub6IhXAnIhB2lvUJs
         cGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791695958; x=1792300758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P3HkQjCQhDTO0NbzrRMmz2iW5BJKPRHxdB9PJFrYJVg=;
        b=Np6gwTfsR/mn1drnr7rL+V4hRjqPqXdc3DdfXBiMMm+S8wxJhKL/I4LU8z/TORvTs7
         QNLYlbrI/x7g2fvToUv22lvB4mq4BxNO3Wfpt6mOXPr8fMYipekWOG0uhFItjMcbJ1CF
         a/kkYgHWR85hLIgOg3mz+YEpaz2Gt/oHm9BdmXSQ5ZI7h79T/UKBzle21PlKPKmk/oqt
         FM60HIu8HV/K7ReVawW/YOQC7z3NcB6MU0h7WrAuvQzhKIedF+3sbUA7Faa6NHFBptla
         WXWa0F09R66TBxsflAUNBxcjisEuTje8EdUJnTOoOj4+A+/kIG3A71OAJ63X8k+vqdLJ
         rT6A==
X-Forwarded-Encrypted: i=1; AKwUvBwAHuN3k5FoI9/7ADzJLgg+eAA22dWDVrtTpeaJ4i66eNmfSLok0RQjGhYMMeDEYKRnNC7fC5osjSVBRQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIM7LauYEovUNdRLaDyB42dpSuOqAevxtxgklEVbQAYzcnOMr4O
	cwE6VR6zGqWhxLIGOxidi22itiTLyLMUCqgcx2t2gzqkY7EhpQXJRyx4
X-Gm-Gg: AYBFou3aVjn1EujdCe3TkWd+0nqQWlyPgYFhYIogXgdy4ibl1Hh8q4rqItIGlZRtuCJ
	lfwaEv5AgKJo97Z3W0mpLix03SbmunrwfgX8vE79neD7pJ+pG2l/yaD7Nd334oHH6u305Iq84iE
	o1SD4mVU0M77iMKZG2II84/H24NLwdx/6Mh6kQt7VwVASY1aP6h0MXR7FG40XWzxNJnHYFgfu0+
	a6dpb5FGzHP9j41O7FEHixR25MWlhs9l8u7XwQbq3uZUYmTqp+0oCLQFHTJ219ooYl6hBCm/Yrr
	7nAX4k1rLXGOvZZwaAyhGk79ymvzjudoLVUkVru+V+aYPtujPRgSQCYF7VAo+xV9k+PPOBIyIuO
	AuInIfzlRBJujICxMkMj1RduG3HXWgTqFUnTT50b4Dl11hYCRn8Zp0pLx2e34vdVXjvrmPo0l+H
	zDgFNcgGmkZ5GzpUDNakODFsELhuhsM9deTJwhuJp0sj4k4oQ83bs5tz4pieDZizUxgfGvWJZ2Q
	fmTwTl78KxwKCTamTbt2hknyuXyD4/S9bB/oD/xB+BxaVvQ/YmRGPswL8bnmf3C1PXr9pe4AiEG
	tWr75Sy0ul8fl1Y792iZOpjXERB8qQRUdIfID0JtgAgRiqGLc+9FsiuFs4zXhfKz1QzhX/bK/XZ
	1jqahu84aILa4JQnnRQzyk/HnEGsXNSS7+ZSi4czPAlI8N+B5vsD0S6yFkiQMjW5ExQ==
X-Received: by 2002:a05:7300:fb8a:b0:353:82a3:eb86 with SMTP id 5a478bee46e88-35382a3ef76mr11428098eec.0.1791695957378;
        Sat, 10 Oct 2026 22:19:17 -0700 (PDT)
Received: from FT6N242TWK ([223.181.119.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35978efac1asm4979129eec.19.2026.10.10.22.19.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 22:19:16 -0700 (PDT)
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
Subject: [PATCH 1/2] block: only use the cached zone report if BLK_ZONE_REP_CACHED is set
Date: Sun, 11 Oct 2026 10:49:05 +0530
Message-ID: <20261011051906.60397-2-jain.sm@gmail.com>
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

BLKREPORTZONEV2 takes the flags field of struct blk_zone_report as an
input. With BLK_ZONE_REP_CACHED the report is built from the zone
information cached by the block layer. Without it, BLKREPORTZONEV2 is
documented to behave like BLKREPORTZONE and to get the report from the
device: this is what the changelog of the commit that added the ioctl
and the comments in include/uapi/linux/blkzoned.h say.

blkdev_report_zones_ioctl() only uses the flag to validate the input
and calls blkdev_report_zones_cached() for every BLKREPORTZONEV2
request. A caller that passes flags == 0 gets the cached report, in
which implicitly open, explicitly open and closed zones all have the
condition BLK_ZONE_COND_ACTIVE, and an explicitly opened empty zone is
reported as empty.

Example with a zoned null_blk device (10 MiB, 4 MiB zones) after
BLKOPENZONE on zone 0, and a write of 8 sectors to zone 1 followed by
BLKCLOSEZONE:

  BLKREPORTZONE:             zone 0 cond 0x3 (EXP_OPEN)
                             zone 1 cond 0x4 (CLOSED)
  BLKREPORTZONEV2, flags 0:  zone 0 cond 0x1 (EMPTY)
                             zone 1 cond 0xff (ACTIVE)

The uapi header marks BLKREPORTZONE as deprecated in favour of
BLKREPORTZONEV2. A program that follows this and does not ask for
cached information can no longer tell open zones from closed ones, and
is handed BLK_ZONE_COND_ACTIVE, which is only defined for the cached
report.

Call blkdev_report_zones_cached() only if BLK_ZONE_REP_CACHED is set,
and blkdev_report_zones() otherwise.

Tested with zoned null_blk devices in qemu: a program that compares
the reports of BLKREPORTZONE and BLKREPORTZONEV2 with flags 0 after
the sequence above finds the differences before this change and none
with it. The report with BLK_ZONE_REP_CACHED is unchanged.

Fixes: b30ffcdc0c15 ("block: introduce BLKREPORTZONESV2 ioctl")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
---
Prepared with Claude Code (Anthropic), model Claude Opus 5.5
(claude-opus-5-5).

 block/blk-zoned.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 475aa16bc4..9555eae91a 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -400,6 +400,13 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, unsigned int cmd,
 	case BLKREPORTZONEV2:
 		if (rep.flags & ~BLK_ZONE_REPV2_INPUT_FLAGS)
 			return -EINVAL;
+		if (!(rep.flags & BLK_ZONE_REP_CACHED)) {
+			ret = blkdev_report_zones(bdev, rep.sector,
+						  rep.nr_zones,
+						  blkdev_copy_zone_to_user,
+						  &args);
+			break;
+		}
 		ret = blkdev_report_zones_cached(bdev, rep.sector, rep.nr_zones,
 					 blkdev_copy_zone_to_user, &args);
 		break;
-- 
2.43.0

