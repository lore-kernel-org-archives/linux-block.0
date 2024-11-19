Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A952E1D0178
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032596; cv=none; b=OOF9L0r0PypUbpI8r8BsdT2gbhGHlFt77gfuKgGm67haHOTOD7coPduQr4NFZHuft74buxuIardejcx9zvOMzC8sbKHBS3Bl4seQoMa3ixwIca4l25fVU4Pd+iQP46hpaU6cjvdehiQv1eyrIMYO+yXAtOOHC4m7T9ye5nJDo/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032596; c=relaxed/simple;
	bh=0f6S0RB/AiU5GiFN38vADG3jqi+SBgwUjcGvL8yG4M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqVR0TCLeGOPRppgX2JWhFtaRg0FKh2E7xTXtbLTO1WplugNJze/762oGFvsMg8h8InJh7M4EP3QSywik7S7u7jeVbeG9udXYo8uJfOmMrs9rO/8/mJwDXVJQH5S4zIiH63EIqRQ6iRF6Y9M8FXwXOaCotLOtGByGOTvBSqFJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=baFKwbeK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="baFKwbeK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fxTizBwkU/S+vMp14/1RVvZVh9j3GPyxNt8KwLd+5RU=; b=baFKwbeK2uMsn52PHkCm3flcJZ
	EPEsYhYOKOy0t2LCa17lTu7JXkmV3WddJXgjUG07xVJ8Fli/Zue9+p7n8e+6NR2zGms7MIIPbIyFg
	qssM3X+dO83DTBPkyArVMl5xorrs2kDNYgQe3n6OoLCdeTADOaRqcN8AdDUZiUfYJJ0MsYkjOshV4
	zUl9FZB9/7OFxoUO76P62TpEfTUwS3fUrGtcDq/uC3rhnE8mS6MG55kundAJL3QLW3SOaLw4CVCkq
	6I6ION4yEevEySwRFpaNymeSuIi2j3u74rEYJ66Gn5gE+Fej61eaMNl5HBOEZ+7cgD5Xu2K0xX+U8
	yGHB3KJg==;
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDQna-0000000CynZ-2o5E;
	Tue, 19 Nov 2024 16:09:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 6/6] block: return bool from get_disk_ro and bdev_read_only
Date: Tue, 19 Nov 2024 17:09:23 +0100
Message-ID: <20241119160932.1327864-7-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119160932.1327864-1-hch@lst.de>
References: <20241119160932.1327864-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

get_disk_ro and bdev_read_only return boolean conditions,
don't masquerade them as int.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 957767c0cafd..f2c0868544a3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -775,13 +775,13 @@ static inline void bdev_clear_flag(struct block_device *bdev, unsigned flag)
 	atomic_andnot(flag, &bdev->__bd_flags);
 }
 
-static inline int get_disk_ro(struct gendisk *disk)
+static inline bool get_disk_ro(struct gendisk *disk)
 {
 	return bdev_test_flag(disk->part0, BD_READ_ONLY) ||
 		test_bit(GD_READ_ONLY, &disk->state);
 }
 
-static inline int bdev_read_only(struct block_device *bdev)
+static inline bool bdev_read_only(struct block_device *bdev)
 {
 	return bdev_test_flag(bdev, BD_READ_ONLY) || get_disk_ro(bdev->bd_disk);
 }
-- 
2.45.2

