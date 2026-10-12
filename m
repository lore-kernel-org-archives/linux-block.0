Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E498D305E3B
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 04:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791781099; cv=none; b=SVYIAwD3cP1cCk6xrwnM4+MantWXsTkdbQwyyP2smcUTKGRsqW52ayC68no3czHfuaao5XXlSlSRWuKb7HK1K9PRsPHKJac3PrmdRe3FvF+mHLcxHEOQB/eUKtZvR3nuPxUvMj24ocfv8WJRTrdwn7SX71fcTrwKXHwrGsXpZhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791781099; c=relaxed/simple;
	bh=AFWunX/fdfKk7oo3KH9cElHwI/KXDnx8CXky7Ppjwqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGtvWxyQYxoixVQgu6aHH/eyNJtedrVl1G05uUth3UIzQcC9fmvU4yNR4dEVPgby+z7x5oh5Mwpwqr3cdBBQpqF9HWHB3JCWFA9oBe8LLWwn9q2M0gU7gMKNqIbeaTqiBv68aWTpJCsEoiTZQ3RU0q2Nq9Z7gihV1JWfIRib7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1MIrhqx; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1MIrhqx"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35829219da8so1368469eec.0
        for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 21:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791781098; x=1792385898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jt34mxURyUDiAONEdJWn26r9FYppX8tRuTeRjKHWRy8=;
        b=d1MIrhqxVVanPxGAVqLkafFIyW7/UkSGqZ19PXy7xTKwWxRcw/A+4Doxhub0zXiIYA
         0VlP7qhxFA1e+3tuPS3CHqnODxbNcH/GXSDM/cF0dEvs8thsGoq80IT3V6q9RATxWUl5
         +zThmWzU2zLofX2EiOnOIm9EhhZUun5euIZonE7sYNEvypJw1l3Nk8fScSl5fKbkOu5z
         9L3WLzR/7Muu0cpXXLzrkgPz7tarwgOtdVfdeN5kyhG5oGqdDdkCHHTgVnf4UHUIFtkZ
         3xFxgFhGr63aqH+mp+VAqmLAo5s+Swk4Ek9hYUNyzuUB22jlXat3M5eQ2rkZyLjaYcIc
         fQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791781098; x=1792385898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jt34mxURyUDiAONEdJWn26r9FYppX8tRuTeRjKHWRy8=;
        b=sa1IkbmMf3n0oIaNfgITJC0B6oaIwR8GNIi930nfduTN8/LSGx75AJoGn2KN+agvNA
         v02EpYPPZFNmPhwdEbnm8+u+BLAov68qHAQw8shzI10elNcRRF8ZzLp3z1cvqZCh1tAn
         eE965z3Fl5wGp2xU9BxjAs8lA5vU8KaZFBBHY/3z5N0myuRB8d7uSp7rsessPCvw9bqs
         vF83BFEvS3wQtL/2PJMioFubA5QsaFqmzTyJ7DEkRCRFK7FgjyIrR/OzyZehUfaL6/dk
         DbH9SiT9ZAqLnvsRrhr6QO65a1qJoQZxIBCfIWvvIy5J9f4V8iBfO9C2DjD2Hz63dMbv
         Pl1w==
X-Forwarded-Encrypted: i=1; AKwUvBxvfDAxXWdr8N1l7Xyl1/f6Nze7wyoQ6phDHpL96Ze5RCryYQyHe9xpV7TFN+ZKZUqXsTudXV1OTyyzIA==@vger.kernel.org
X-Gm-Message-State: AFq9FYK7SB0AAgDgpJuB7G7fBnA66eoXySgieCYrew5x7on2ZyB7s7tp
	0Z9/4CDOD8xU9J6zDTQUWgKwkp/c29S8av9gpo07OOCr3PlSpzHZ9eBV
X-Gm-Gg: AYBFou0weaXcgJ7JWpHpStGwdECGWRk2YNj96VjuDM5XQOwj7ZEnLF/E2unMvB5zwQ2
	dhumqEEZVyLdvl3ycZbaqgi/xgwn2fjIJ7aP2X1hlf1/ZgVhqLi9OLhGDjx+TCI9l50yDYaeIu1
	ii5IbI50vbQQ5wsYRa3d+yfOfjoEJF+67jWqA+g5jNhsv35ipmdZ18DUtXT66drOQWqQMSYDvED
	AD7aBa0yjIIsd/g7YU2XBjs3YWz9wF7mC+AsReeqDxSkl8DFFvHXQa6DbR7n65NdBYclraL1fm1
	FRa0H3Q7W1pbhrt4ZcxGelygmJrpBpvzapTiQijaSpvh7GTAI1UO4eBHNZFivGSKGpcKB6yb6wn
	4tmk/Eda90wAWo5bykL3Zk6m2etHmJWiEIsLrhyZdvyGobLK63iUv7onz+ztuThkWjNL2IzH+S6
	SDxAabFBSi/6y0L2VErcOqzpQdgfHgjRboZzLQU1ILr6d2XvDdA/HhVFR3hDKRe0H03Nud+d/sO
	SbgH5HmhD2Wbw7BvIo9WyhLMT10imEOghKJHjD7751a2dmXLzikh5mRpWEgYqAvufhAg7qXLrDx
	Sqkm6ST9Qoly0na3wTckOcrMZkWOrAyfydPaV07yFcAUgbtG2w/iaSVyLK6AbyQ3BFeWzkumde5
	kvDLEerVZCKdQP79QNsjvLH6sLbDpF0kRJnJpSHaYm6n0W1kRjy0vxWU=
X-Received: by 2002:a05:7301:4208:b0:351:2f0a:cb2a with SMTP id 5a478bee46e88-3535f480bd0mr10661101eec.2.1791781097875;
        Sun, 11 Oct 2026 21:58:17 -0700 (PDT)
Received: from FT6N242TWK ([223.181.119.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca79536sm29359039eec.16.2026.10.11.21.58.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Oct 2026 21:58:17 -0700 (PDT)
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
Subject: Re: [PATCH 1/2] block: only use the cached zone report if BLK_ZONE_REP_CACHED is set
Date: Mon, 12 Oct 2026 10:28:11 +0530
Message-ID: <20261012045811.47473-1-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <e146448b-5210-4215-821f-181c91625141@kernel.org>
References: <e146448b-5210-4215-821f-181c91625141@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 11, 2026, Damien Le Moal wrote:
> Can you reverse this if to be "if (rep.flags & BLK_ZONE_REP_CACHED) {" ...
> Also, the condition should probably be:
>         if ((rep.flags & BLK_ZONE_REP_CACHED) &&
>             blkdev_has_cached_report_zones(bdev))

Reworked exactly as suggested and reposted as v2:
  https://lore.kernel.org/all/20261011154018.48913-1-jain.sm@gmail.com/

blkdev_has_cached_report_zones() is now used from the ioctl, so I moved
it (with its comment) above blkdev_report_zones_ioctl(). Patch 2 is
unchanged and carries your Reviewed-by. Retested on zoned null_blk.

Thanks,
Shashank
