Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444C72512FC
	for <linux-block@vger.kernel.org>; Wed, 19 Feb 2025 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998450; cv=none; b=R1/jMTQo/DmJza+TV9kogU130eHXkEZVRdkMC69Ni7FhpWU+J46GNZPB6cr3bDZePAW9u3EicJd+2iL2yUTdlD2MwzUvYdb7mwy0ChThMLtqmShZY1Txyw7/eIFq4tnr2Y8xb/wDFSEPp9aCqaGR3v3oRsS7Pre+i4vgdC0nh68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998450; c=relaxed/simple;
	bh=VlWpUP25ytyhmuZ2b+Kq96rvbvFsG5DjAVJOh6X/fus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+9SezcPZUgnDD/MkVdx5Cj6C0nHclAj7daQuLZlJSYTzVbhOgM8me7/mRsr4N0YLJuV7Bk1FIHnX2SIy6llEUE1LlC/g98DbUe1MwV7HYZLNQZ4z08jI+4xqufiy6vEXOENRmLbpXcVQJAI/MOUzYE9nsp4DiZq0hw7hPJrXV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wY0M9MOh; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wY0M9MOh"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739998446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HklAJU7eZ7xzNPO17m2/iVhJMtDFPagrfwUu9D2iBqk=;
	b=wY0M9MOhD0AQDDKNB/x6Efe8ZJrdaFzSMyMr/FZt8iknYZFv1r3naAJnlXJfQSsj5oqovJ
	OH8IRzocERd2AtIwZUR57s+6IcTjTFQCrzLsBmZTstitTfs6tG1OiL4r+3AZ1+yi3OaB5a
	D5uF1tdz6pYNBqkvOZF6/KwLTovSfFo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: Remove commented out code
Date: Wed, 19 Feb 2025 21:53:25 +0100
Message-ID: <20250219205328.28462-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove commented out code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 block/partitions/sgi.c | 2 --
 block/partitions/sun.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/block/partitions/sgi.c b/block/partitions/sgi.c
index 9cc6b8c1eea4..b5ecddd5181a 100644
--- a/block/partitions/sgi.c
+++ b/block/partitions/sgi.c
@@ -50,8 +50,6 @@ int sgi_partition(struct parsed_partitions *state)
 	p = &label->partitions[0];
 	magic = label->magic_mushroom;
 	if(be32_to_cpu(magic) != SGI_LABEL_MAGIC) {
-		/*printk("Dev %s SGI disklabel: bad magic %08x\n",
-		       state->disk->disk_name, be32_to_cpu(magic));*/
 		put_dev_sector(sect);
 		return 0;
 	}
diff --git a/block/partitions/sun.c b/block/partitions/sun.c
index ddf9e6def4b2..2419af76120f 100644
--- a/block/partitions/sun.c
+++ b/block/partitions/sun.c
@@ -74,8 +74,6 @@ int sun_partition(struct parsed_partitions *state)
 
 	p = label->partitions;
 	if (be16_to_cpu(label->magic) != SUN_LABEL_MAGIC) {
-/*		printk(KERN_INFO "Dev %s Sun disklabel: bad magic %04x\n",
-		       state->disk->disk_name, be16_to_cpu(label->magic)); */
 		put_dev_sector(sect);
 		return 0;
 	}
-- 
2.48.1

