Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECDA18FDC8
	for <linux-block@vger.kernel.org>; Mon, 20 Jan 2025 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737386199; cv=none; b=myUAbb8PDryuJnYsDXz2YVTqJ8X3zbNwrWwqRBem/xomkqhMkjkIKzunyXutUCPke9/9F1OPdcNo7xd3mwvSRq7Hnv+elPTkNmZthK6nn8EAFKNC2LiPFi1yK/oRL/yVWawXO+JJhjBM8PoEe6xreuM6VP3SmgHxNLpPeQNwabI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737386199; c=relaxed/simple;
	bh=N/09wP0BL+H92OwKbasER3ehiHFLHhxOkwKi4aXhZqU=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=NGD3JYd8p7eecu9o/7AOvK8hkyAogacOMLgH4oOoxkOoMpOkxGK2AwNUNF5z4Gg1I5I/DW7Q74NvqrGueY/8PzTswis5847CNI//7BqqpvMOVcYr7+fqq6gEUafKjYJbNDf+rEup/UORgAAWHtmPMXYTt6x8cTwUMQH5jGm6tM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ri+lr4E9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ri+lr4E9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737386196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=DtCbR8FTF1GLHpSQcORCkWOKw6JmrqvTdAcRj4GwZpE=;
	b=Ri+lr4E9Cle3H6K1JPGSc7umZLPoARcoeUHdyD1wHzlPausjDQzkiW4YNBspBqQ6v3iEBI
	/jzamiHX+v9LCiDwwQDi5+0fs/8y1BfxfV8RalUVl+Z8viYCBQ/aZECNe/kvMzl4a/JZIh
	OxvinmeGPoutlE7iiXJ9Yh0r49msBZs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-JwY416IONamA_MimYDbvow-1; Mon,
 20 Jan 2025 10:16:35 -0500
X-MC-Unique: JwY416IONamA_MimYDbvow-1
X-Mimecast-MFC-AGG-ID: JwY416IONamA_MimYDbvow
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 977971955DCD;
	Mon, 20 Jan 2025 15:16:33 +0000 (UTC)
Received: from [10.45.224.57] (unknown [10.45.224.57])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C08C53003E7F;
	Mon, 20 Jan 2025 15:16:31 +0000 (UTC)
Date: Mon, 20 Jan 2025 16:16:26 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    Zdenek Kabelac <zkabelac@redhat.com>, linux-block@vger.kernel.org, 
    dm-devel@lists.linux.dev
Subject: [PATCH] blk-settings: round down io_opt to at least 4K
Message-ID: <81b399f6-55f5-4aa2-0f31-8b4f8a44e6a4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Some SATA SSDs and most NVMe SSDs report physical block size 512 bytes,
but they use 4K remapping table internally and they do slow
read-modify-write cycle for requests that are not aligned on 4K boundary.
Therefore, io_opt should be aligned on 4K.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: a23634644afc ("block: take io_opt and io_min into account for max_sectors")
Fixes: 9c0ba14828d6 ("blk-settings: round down io_opt to physical_block_size")
Cc: stable@vger.kernel.org	# v6.11+

---
 block/blk-settings.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6/block/blk-settings.c
===================================================================
--- linux-2.6.orig/block/blk-settings.c	2025-01-03 21:10:56.000000000 +0100
+++ linux-2.6/block/blk-settings.c	2025-01-20 15:59:13.000000000 +0100
@@ -269,8 +269,12 @@ int blk_validate_limits(struct queue_lim
 	 * The optimal I/O size may not be aligned to physical block size
 	 * (because it may be limited by dma engines which have no clue about
 	 * block size of the disks attached to them), so we round it down here.
+	 *
+	 * Note that some SSDs erroneously report physical_block_size 512
+	 * despite the fact that they have remapping table granularity 4K and
+	 * they perform read-modify-write for unaligned requests.
 	 */
-	lim->io_opt = round_down(lim->io_opt, lim->physical_block_size);
+	lim->io_opt = round_down(lim->io_opt, max(4096, lim->physical_block_size));
 
 	/*
 	 * max_hw_sectors has a somewhat weird default for historical reason,

