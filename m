Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772D41D47B3
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934805; cv=none; b=iZKsZJ6/adujNNIoAeWF/xeFXCbC0fVF9q7On3BWsnjIaVbQDlTQVOELc5itcAsulpsM+C7gWAhxqKZGxNycU4aeo1V0QAznuuk41AnbtzFmYAvF6pxymnBu/gYNvenmBrYftmbOmQKOCWhYfV+nzwXDLTv4cyM/ycKPQWOEM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934805; c=relaxed/simple;
	bh=i4it1yBD8to04S9szdAzsyWiqY1O2byFyfUU6seHpdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPDeh9zr8YJYsK2QEZV7+/OAx/sDs+2Pp96GPZvuNZDELoOjgwF/MJSig0REMFL/wg7VJ0imnU7O5J7qj4umo13SsvgKsR8N3wpneNJvkfyUPN5Zncja2m2otfQbR6Y9hL+c6whApBvCn0OgLERay+KqIj+Z3GDdbAc0hJO8HRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcpG8IiL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcpG8IiL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65BAC4CEC6;
	Wed,  6 Nov 2024 23:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730934805;
	bh=i4it1yBD8to04S9szdAzsyWiqY1O2byFyfUU6seHpdE=;
	h=From:To:Cc:Subject:Date:From;
	b=tcpG8IiLZ1AcrS2cx/vt7EXxJedTQxtPjjKUvjkyDf+xDs0+KO9uWbts2OTskERNk
	 VXGgU2TMyCZbVlFyPN4oKjjGUhIgetJcLdhvZfq1bJ5yDFMMd6nMbjrbcab0++GkpL
	 k0wrX9KXGNSIOpvPKWH/b3Baqf1oOn22So0yaRzgOdGO36U+mwO1r5ExnUKeYa2/6A
	 QiHu2taP8p8L+khuXRouUWYjYq6i1ncBaKVNQVGn4I7Nc8CCbG48/AK4dzR5mgKnr1
	 zdMTrR6zA8HMSPAfLJ10AXV9VxNnswEyp/7qUt1Ptd+Rrd2+1kzdEFGR+QdU8Hqyy9
	 cHZaK4VIAtg7g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/2] Introduce bdev_zone_is_seq()
Date: Thu,  7 Nov 2024 08:13:21 +0900
Message-ID: <20241106231323.8008-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow file systems to safely access a block device gendisk bitmap of
conventional zones to determine a zone type by:
1) Patch 1 - changing the gendisk conv_zones_bitmap to be RCU protected
2) Patch 2 - Introducing the helper function bdev_zone_is_seq()

This is in preparation for use in btrfs to remove the btrfs-managed
bitmap of conventional zones and in zoned support for xfs.

Damien Le Moal (2):
  block: RCU protect disk->conv_zones_bitmap
  block: Add a public bdev_zone_is_seq() helper

 block/blk-zoned.c      | 43 ++++++++++++++++++++++++------------------
 include/linux/blkdev.h | 28 ++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 19 deletions(-)

-- 
2.47.0

