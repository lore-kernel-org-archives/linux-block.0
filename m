Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BA716C448
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336979; cv=none; b=bAZcQSpFmhGk5O3mh6seVvxIw6JuxiLkpcgHCwJlrfXfe5YPj/VxdLBIl+fwVK1EhhwXB3oX5PllCfWxc7TAIb4eRmfJ+gWEH0l+gl68hOljnCFi+t+/5cR1nBPEjrx0i8STv4WhpF6sWjXbryNW+jJdVna+Ld6KpQxPQhKs8Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336979; c=relaxed/simple;
	bh=2+i7bTWNtKNOAzGlbkmTO8GKENs6BV1RJJ0bZA8PkaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I1n3kepZh7xZ0CwA5nvUhYDANirDNbdHljvcFFY8ZXxRBkBq8err9lNtou/sXy3Ltcau6OfXRbN0xpcSsbi2C/B5KeukDjtupyJmay+nMCGYBaEykLu3jIHJLHhz8YS74p0UsCJNeb1e1K+G2cktcRg3AA0usqOhBEoy+0FCSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNs4MY8q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNs4MY8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BEFC32781;
	Fri, 10 May 2024 10:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715336979;
	bh=2+i7bTWNtKNOAzGlbkmTO8GKENs6BV1RJJ0bZA8PkaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNs4MY8q3abQM8SbLYgXMeYaDzHCmij5v91uqVWOtyH6UAAoHEYtwfRmmkjMZW7b9
	 pHvpHFlmPx2pLHvHSnlcQp1tzMauPCkbwiNixewSYtZljYf1VNKc+GOGbzHHnqF/pR
	 YaOFURjHFbTRc/GG7FcKehQSjnKz/rReuQYOTmbqmeWMNzvGyZ+f1/iMK2zLNu/Fa7
	 uOI+PaSFKdSi/Keou7y/s70aVKizAX2JEHwjGUf9J4B198WrbJ5dK8QA//kEYvAI8o
	 lyGA87Zxx1COTgDIBWfGBj0FKhXFItokyhnEGz3/cR9QZ+HF4fCtzzVodCcpiPCiXQ
	 zBC2fzlYnZg5w==
From: hare@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/5] block/bdev: enable large folio support for large logical block sizes
Date: Fri, 10 May 2024 12:29:05 +0200
Message-Id: <20240510102906.51844-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240510102906.51844-1-hare@kernel.org>
References: <20240510102906.51844-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@suse.de>

Call mapping_set_folio_min_order() when modifying the logical block
size to ensure folios are allocated with the correct size.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/bdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index d37aa51b99ed..a0c0ecc886e8 100644
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

