Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com [209.85.128.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D2E24E4B4
	for <linux-block@vger.kernel.org>; Sat,  8 Nov 2025 23:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762642873; cv=none; b=FdSwrVCu6v+dOknQw+HhsOnd6ASj/5eonteoOmie3cTnzx1TYw6Lltbrd4F67vcdL7XVsIAvLqIdeU5GwEfX4xhcw6CpkloC9ypl2mkbUMxep5JAzdd37VhaUSMdLlCc7zeoZD+HZpbRQbaIPQEruUVA0szOpudbpIxlDc+cu68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762642873; c=relaxed/simple;
	bh=v7TGA+6QCVK8DbEC2CDrbNmhkXqca0cIDEJRGw+jHVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpxDxaOhzDvgJZ9OP4wYuVwxRqPXl2rlFt/Rw8S4kYDTcWl/66znDgUeWQWRyQShMxrHK4qZGczs0VEENjmd5EyxsLrA92X4uKWmOwyl8x29Nn6sk6bdIn74s+A4SxAVbuq49QpIy7I+FzSAUGRk6Bolu0+x1EvwWrGdaTzgEP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Tq34V5OE; arc=none smtp.client-ip=209.85.128.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Tq34V5OE"
Received: by mail-wm1-f100.google.com with SMTP id 5b1f17b1804b1-47776bf5900so132815e9.0
        for <linux-block@vger.kernel.org>; Sat, 08 Nov 2025 15:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762642870; x=1763247670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RI1kzI7IRCwyOcrqW1kzUHyAYWD73+nYiTUVhp+Ekk=;
        b=Tq34V5OEihPpA3EhqlP62A3kvf7uv+mZveXShKfR8QcYwxCEKDVYSA9jgO1YCPLFRg
         oK6XejcXJf2t0Lj2q+FhMEDrGMW+5Mgw+C3xQW3x9O80qStlEGvZP2i8jMPMFHUtV6ev
         KWeOwBF/tUX/X5jfRWGBOmnd7cqr3QNRgIvEKbUKf0zBIOou5i5b49ZFABj6hsFLesTt
         LBD5c/4FRUZz1EGeEoV+WAUnvrZQcTdwOhoC8WIkZNR58sTRWQ2VaNDrYu3YgvpIUs0k
         yHn5x/f8fCDQKjU+VyvBZr1xc/UJQnyfg2yRloHXHve+kPunjg0q7TUo4odUs5wZl4fQ
         OJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762642870; x=1763247670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5RI1kzI7IRCwyOcrqW1kzUHyAYWD73+nYiTUVhp+Ekk=;
        b=NqeOjHvSwYU9TdoOpbfWs21L+79acOfV5eeMLAicnwLIIAFDEdEsjj21EvFCyNzkSq
         PsWrNo2NiCxXX+Ewpeso9v1CzEvvTxOooJg6hUCwk7ZmU5yBrky3kl73B/lbJqI0b4mD
         WanXwbbu9IvdJ+HYv3iyPkkHgWMh1y9EzSuRSxxLp6PW+oV4Tr5cP/944SOIqV0p2Gd9
         ZsW02kJl6HHZhx6uNHUGyl4xnSZunUDnSXoGQKMuJ+pU4weJGdiBtC/MBNKpjY0OxsOR
         p0dTRfwmYUd3WEoyQk8vb7wJX4HUuiZpCzpba7AOuUgyfAo4N+z5hUgISkClial4jm0P
         vuBQ==
X-Gm-Message-State: AOJu0Yw+BeDDs1BY4NDp86w+NnDae0jj3LQUP1IP017qv8kkYx+fQo5P
	Jeiu9ziiO02Y0bJ1FVg/jr0F6z8idQu37PjLlVzFHUteCNgrPVOGLb5ZZz5ZBgy2ODIu0Nm2eZf
	gjeo4+hq2yn5Hc9nLY/v30j6rU3CZedwDuZdx
X-Gm-Gg: ASbGnctAkP0VHlNjIt/1AWrVoIC49ZzvQvUAA+/ahU0EmYS8EgqZ6ex0wmhlgxlathi
	mFwPCVYMwSp5/gUa5+MSO1z6/zVDk0PA50EPjjxXvPEh+2bIwbggZwjp4SjIFpdhAgELWPHITSW
	J0bGGhI2KkiaUahc+VvoN3PwqN76A8rshzph7JQs9srfm0m8hpnFxmvJVoPKbfzNhbWUzCXs2Bw
	14y6lhOzGGuN5moXXkZvlpUHp4k516Zkdjx8eIPegw5aO5B30M9iLDNvMTNjJ1/z35LUJE/l6WE
	12H9N/qLayXXVw+RtjDaek9MepjgMA4omORRBSoHhw3FWyyJQRHotF35EvytSu8DWmhib6+iBjn
	2VdKRDBbAbqCwpnLdwx3nAnNPynA6qa8=
X-Google-Smtp-Source: AGHT+IHcxgVfwpzXfrUh/1XC3GR9TFTNVVnuZXFXWIUDCpd/RKokGzpROkYIeTRhbDAxmyKUUOVuVsE8we1S
X-Received: by 2002:a05:600c:46cc:b0:475:d7fe:87a5 with SMTP id 5b1f17b1804b1-4777329d164mr16143665e9.6.1762642870143;
        Sat, 08 Nov 2025 15:01:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-4775cdf251esm8824525e9.12.2025.11.08.15.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:01:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D5E7F3401C3;
	Sat,  8 Nov 2025 16:01:07 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D403AE41BD7; Sat,  8 Nov 2025 16:01:07 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/2] zloop: use blk_rq_nr_phys_segments() instead of iterating bvecs
Date: Sat,  8 Nov 2025 16:01:01 -0700
Message-ID: <20251108230101.4187106-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251108230101.4187106-1-csander@purestorage.com>
References: <20251108230101.4187106-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The number of bvecs can be obtained directly from struct request's
nr_phys_segments field via blk_rq_nr_phys_segments(), so use that
instead of iterating over the bvecs an extra time.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/zloop.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 92be9f0af00a..7883e56ed12a 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -368,11 +368,11 @@ static void zloop_rw(struct zloop_cmd *cmd)
 	struct req_iterator rq_iter;
 	struct zloop_zone *zone;
 	struct iov_iter iter;
 	struct bio_vec tmp;
 	sector_t zone_end;
-	int nr_bvec = 0;
+	unsigned short nr_bvec = blk_rq_nr_phys_segments(rq);
 	int ret;
 
 	atomic_set(&cmd->ref, 2);
 	cmd->sector = sector;
 	cmd->nr_sectors = nr_sectors;
@@ -435,13 +435,10 @@ static void zloop_rw(struct zloop_cmd *cmd)
 		zone->wp += nr_sectors;
 		if (zone->wp == zone_end)
 			zone->cond = BLK_ZONE_COND_FULL;
 	}
 
-	rq_for_each_bvec(tmp, rq, rq_iter)
-		nr_bvec++;
-
 	if (rq->bio != rq->biotail) {
 		struct bio_vec *bvec;
 
 		cmd->bvec = kmalloc_array(nr_bvec, sizeof(*cmd->bvec), GFP_NOIO);
 		if (!cmd->bvec) {
-- 
2.45.2

