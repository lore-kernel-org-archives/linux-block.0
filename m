Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0946830DD3A
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 00:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761525075; cv=none; b=HcOQbASVQ3Vc1aIfBDk9BtL5wdMnDZvBfZHBmsP2ytH0qyZHHuDIr0FWaraoOeByEndF1U9ALx76/lLYKaL5yBFXSPgUKdZpfXT/rR5oFbJHJPzouQebeR2KWi3tj/m5vvuNNp76/2FG0CUNGMUp6Rvzt/IbZ3XlQRgiN7pf5w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761525075; c=relaxed/simple;
	bh=qHRDNmezj/sglcBwpH78ih5IjCp/ZhnTjo06XGN5i7o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nmr0nOu/yPp5it0rXX4AzdK9OZDs/Bv+ArFVYdVWlapDGNx/b/xlpswm9WrFXMVMb8+eM+n2syA6ClNO2a/DoMK7Ktj7uder7f/UML3QKjMAp3mNEBn3MkCusmwaqevlH+U/EdrmTIRw80EiF7Gh6kRZO3EqJ2p14yCIrnNt+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5VGWVga; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5VGWVga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DE8C4CEE7;
	Mon, 27 Oct 2025 00:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761525074;
	bh=qHRDNmezj/sglcBwpH78ih5IjCp/ZhnTjo06XGN5i7o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f5VGWVgabD5W4a8oW+Pwp7fS4H/n6kFL0idzZl537aIBd0YdzZe7XarP8s3PuPTvs
	 xcJDJ76e9f3AbCJDtMCF5tzDTebPXi1i6/7EBDPqpUnkdWLADDk9e/xbzW6v6Js/kL
	 WoMTv6zxMYHEny8AcxsxueMGIxP2GLZpolYZC52M1Az31WK5ijLky2NYtgtC0byUQg
	 lrwKgPv90BnGO8lELXavTe/3l9Kbaq+IO7Dl/YfVkcFWELvpQJZf0ZByy4tyF6Q0vK
	 8QLfAjJse5Y7TfI4tZflNL3DMI/OCU8cLypOwDduyFtvKZK5EDgT8bJTPxvwyKfI8l
	 d54p4ENUb01sg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: make REQ_OP_ZONE_OPEN a write operation
Date: Mon, 27 Oct 2025 09:27:33 +0900
Message-ID: <20251027002733.567121-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027002733.567121-1-dlemoal@kernel.org>
References: <20251027002733.567121-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A REQ_OP_OPEN_ZONE request changes the condition of a sequential zone of
a zoned block device to the explicitly open condition
(BLK_ZONE_COND_EXP_OPEN). As such, it should be considered a write
operation.

Change this operation code to be an odd number to reflect this. The
following operation numbers are changed to keep the numbering compact.

No problems were reported without this change as this operation has no
data. However, this unifies the zone operation to reflect that they
modify the device state and also allows strengthening checks in the
block layer, e.g. checking if this operation is not issued against a
read-only device.

Fixes: 6c1b1da58f8c ("block: add zone open, close and finish operations")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 include/linux/blk_types.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d8ba743a89b7..44c30183ecc3 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -341,15 +341,15 @@ enum req_op {
 	/* write the zero filled sector many times */
 	REQ_OP_WRITE_ZEROES	= (__force blk_opf_t)9,
 	/* Open a zone */
-	REQ_OP_ZONE_OPEN	= (__force blk_opf_t)10,
+	REQ_OP_ZONE_OPEN	= (__force blk_opf_t)11,
 	/* Close a zone */
-	REQ_OP_ZONE_CLOSE	= (__force blk_opf_t)11,
+	REQ_OP_ZONE_CLOSE	= (__force blk_opf_t)13,
 	/* Transition a zone to full */
-	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)13,
+	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)15,
 	/* reset a zone write pointer */
-	REQ_OP_ZONE_RESET	= (__force blk_opf_t)15,
+	REQ_OP_ZONE_RESET	= (__force blk_opf_t)17,
 	/* reset all the zone present on the device */
-	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)17,
+	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)19,
 
 	/* Driver private requests */
 	REQ_OP_DRV_IN		= (__force blk_opf_t)34,
-- 
2.51.0

