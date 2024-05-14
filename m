Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B76A181319
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715708364; cv=none; b=HW8wbUtmHGVOTBPA+MA6bxWLWnPaFbI9Y7p3nmn8Ie2/qYI3uabIZxRu9PUOTmauWPN86ekj1j8TLU5tAVWHpKmkVn3zqgCfsRCltWujvHb9NQqoosgprPie7VYtQxgGDvtIlGaaoaffvgTaJU7HRal+V5FdNWNWOuaqbNtVPB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715708364; c=relaxed/simple;
	bh=7s3ygm1qdmW1SDxuIuRIwVke+9uiYVb8lCs0ybKAYMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r6BVW7h9Lo4BcM8qIMKrLP9e6kgELFTyZ5G3JY6qEWnREBiWOfoCg8CLPgYrPab4onBvLRUXpQPWmlFEMUXZqL3/lZX8Mv6LtAz7p/D8WqaOtTGNRxI5PSkMcHWw37QKutas65c4utVp9pt9Q4J/GYNQSs1jO+ToRFtI9pU1YaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDL3a79W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDL3a79W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61091C32786;
	Tue, 14 May 2024 17:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715708363;
	bh=7s3ygm1qdmW1SDxuIuRIwVke+9uiYVb8lCs0ybKAYMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dDL3a79WQhHZh0uAZSQ5XbZo3r9X875ZxUn51Ayr32ZkSQJfGRuuaMYytRzPbVyFX
	 ASHrJK/sOIm58CniJPZxEmh8Nq+LGnwhmcajZLR0j52NDltUdRjFU/zB05e7ZlEgGa
	 A8l0Xj5BydMygYn8klsgyXWFi4q871hNdiyramenxkETcg2tm0+zBrS9REqfnNLeBE
	 Sw5G5Gj7g1BCMORYpDeE6/XnWOdapbF6q4O7E6yygsfwzmJf+Ui/xq2vuAt9VIQtjV
	 hVetRfz31805bcjckOxuUtPCrTHhuckcnPbtp2AmSsj8c7KQQOW0zg4FdvKXWjLbkG
	 MPPfzXipA+sww==
From: Hannes Reinecke <hare@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/6] block/bdev: enable large folio support for large logical block sizes
Date: Tue, 14 May 2024 19:38:58 +0200
Message-Id: <20240514173900.62207-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240514173900.62207-1-hare@kernel.org>
References: <20240514173900.62207-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call mapping_set_folio_min_order() when modifying the logical block
size to ensure folios are allocated with the correct size.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 block/bdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index b8e32d933a63..bd2efcad4f32 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -142,6 +142,8 @@ static void set_init_blocksize(struct block_device *bdev)
 		bsize <<= 1;
 	}
 	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
+	mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
+				    get_order(bsize));
 }
 
 int set_blocksize(struct block_device *bdev, int size)
@@ -158,6 +160,8 @@ int set_blocksize(struct block_device *bdev, int size)
 	if (bdev->bd_inode->i_blkbits != blksize_bits(size)) {
 		sync_blockdev(bdev);
 		bdev->bd_inode->i_blkbits = blksize_bits(size);
+		mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
+					    get_order(size));
 		kill_bdev(bdev);
 	}
 	return 0;
-- 
2.35.3

