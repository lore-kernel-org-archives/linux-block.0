Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2EF209F43
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114537; cv=none; b=MPM4xMP/kQozUA2s/eMdx01iFHFav3PJUsy297EYj+q3GoO0b4VQ98JRYcxhv5Hy/1XROOi/wn2Bs7I9oKigStq1n82gkm3Fd4tEJuCwGF66ntf/8bL+uEWhubUNAYT53+oxvGMW3eBnsn9HOMqnNaKhcpEy8wNeKmJlQgmQrYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114537; c=relaxed/simple;
	bh=8qTv+tHe42jQWyaEAKtVpg/0o9eunktfQyGpzc3QlZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGcFpI0NlwT0nmzfQIdwQuOGnHveOGlZcr7K8B6Cuv9Guu2ZmeaOv2nZasAcPRwp4PQ0mIE7PM17PetU0OhzZAss64RHm/O3IekpJSP2N7A7tePBjXG5oP2l7MpqG6VK290meRa8qOmg+cz+EnXTnCIZcijcTBZIUSS7Z9CmuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sewS+8He; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sewS+8He"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gbDBb3x7bz1XLyhV;
	Wed, 10 Jun 2026 18:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781114524; x=1783706525; bh=vhuqtvq8H0gyQEP/h14fXa9s
	BHHLOHxAy243S2kyU38=; b=sewS+8HeHbqAhNm/Wint+3azgK+fn6mp3LQWmUdT
	PJ8pD5gvSTCmri6eSDb1BrSuyvGtuMO0pPm52TEG4hdJ5cHkSy2z/0ItTCUAxNS4
	eOpvTYij3UtQbYN4UEc8mM7atpQx7oxLRIGeqLGqwRkjW3NQyXHKWEBE+8IrrEaE
	rz+UzXxmJikJA4SYVnSJ/rh1Q6ninl+uP57WYYTnmH6St6QQKe8KOTjChELhdu4m
	OuohMMm9fduzJD3YIBVB0kDKL59Gh2zNAEsCisaSGkYv+Nt+wVLpJF6Izbn7zMuk
	DNlX+9qhyw6/i61UxC5ZMzQKN+wShKQG0QmlrfC65LLHrw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sKl6Xm3KpP9R; Wed, 10 Jun 2026 18:02:04 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gbDBJ4SVkz1XLyhT;
	Wed, 10 Jun 2026 18:02:00 +0000 (UTC)
Message-ID: <5795e025-2613-40f7-9fa9-109c2e56d858@acm.org>
Date: Wed, 10 Jun 2026 11:01:59 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/27] null_blk: Enable lock context analysis
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Marco Elver <elver@google.com>, Keith Busch <kbusch@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Nilay Shroff <nilay@linux.ibm.com>, Genjian Zhang <zhanggenjian@kylinos.cn>,
 Kees Cook <kees@kernel.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <b70422c6f243b9275e336430071b52eb92dd40c4.1781042470.git.bvanassche@acm.org>
 <aij2yP1Y1Dven4Bz@infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aij2yP1Y1Dven4Bz@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/26 10:31 PM, Christoph Hellwig wrote:
> On Tue, Jun 09, 2026 at 03:05:08PM -0700, Bart Van Assche wrote:
>> Add __must_hold() annotations where these are missing. Annotate two
>> functions that use conditional locking with __context_unsafe().
> 
> Please explain why that is needed and there is no better way to have
> proper annotations.  Both here and in a comment in the code.

Hi Christoph,

Is the change shown below considered acceptable? It converts the
null_lock_zone() and null_unlock_zone() calls into scoped_guard()
and thereby eliminates the risk that any null_lock_zone() call
would not be paired properly with a null_unlock_zone() call. The
DEFINE_CLASS() macro below does the following:
* Before any code block that is protected by scoped_guard(null_zone)
   or guard(null_zone), call null_lock_zone() and create a local variable
   with type struct nullb_dev_and_zone. That local variable is declared
   with the __cleanup__ attribute.
* The __cleanup__ attribute causes null_unlock_zone() to be called with
   the same arguments as null_lock_zone().

Thanks,

Bart.


diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 12a3534ecb85..3bf3b6057e8a 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -50,6 +50,23 @@ static inline void null_unlock_zone(struct 
nullb_device *dev,
  		mutex_unlock(&zone->mutex);
  }

+struct nullb_dev_and_zone {
+	struct nullb_device *dev;
+	struct nullb_zone *zone;
+};
+
+DEFINE_CLASS(null_zone, struct nullb_dev_and_zone,
+	     null_unlock_zone(_T.dev, _T.zone),
+	     ({
+		     null_lock_zone(dev, zone);
+		     (struct nullb_dev_and_zone){dev, zone};
+	     }),
+	     struct nullb_device *dev, struct nullb_zone *zone)
+
+DEFINE_CLASS_IS_UNCONDITIONAL(null_zone)
+
  int null_init_zoned_dev(struct nullb_device *dev,
  			struct queue_limits *lim)
  {
@@ -218,14 +235,14 @@ int null_report_zones(struct gendisk *disk, 
sector_t sector,
  		 * So use a local copy to avoid corruption of the device zone
  		 * array.
  		 */
-		null_lock_zone(dev, zone);
+		scoped_guard(null_zone, dev, zone) {
  		blkz.start = zone->start;
  		blkz.len = zone->len;
  		blkz.wp = zone->wp;
  		blkz.type = zone->type;
  		blkz.cond = zone->cond;
  		blkz.capacity = zone->capacity;
-		null_unlock_zone(dev, zone);
+		}

  		error = disk_report_zone(disk, &blkz, i, args);
  		if (error)
@@ -366,7 +383,7 @@ static blk_status_t null_zone_write(struct nullb_cmd 
*cmd, sector_t sector,
  		return null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
  	}

-	null_lock_zone(dev, zone);
+	scoped_guard(null_zone, dev, zone) {

  	/*
  	 * Regular writes must be at the write pointer position. Zone append
@@ -446,7 +463,8 @@ static blk_status_t null_zone_write(struct nullb_cmd 
*cmd, sector_t sector,
  	ret = badblocks_ret;

  unlock_zone:
-	null_unlock_zone(dev, zone);
+	;
+	}

  	return ret;
  }
@@ -657,14 +675,14 @@ static blk_status_t null_zone_mgmt(struct 
nullb_cmd *cmd, enum req_op op,
  	if (op == REQ_OP_ZONE_RESET_ALL) {
  		for (i = dev->zone_nr_conv; i < dev->nr_zones; i++) {
  			zone = &dev->zones[i];
-			null_lock_zone(dev, zone);
+			scoped_guard(null_zone, dev, zone) {
  			if (zone->cond != BLK_ZONE_COND_EMPTY &&
  			    zone->cond != BLK_ZONE_COND_READONLY &&
  			    zone->cond != BLK_ZONE_COND_OFFLINE) {
  				null_reset_zone(dev, zone);
  				trace_nullb_zone_op(cmd, i, zone->cond);
  			}
-			null_unlock_zone(dev, zone);
+			}
  		}
  		return BLK_STS_OK;
  	}
@@ -672,7 +690,7 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd 
*cmd, enum req_op op,
  	zone_no = null_zone_no(dev, sector);
  	zone = &dev->zones[zone_no];

-	null_lock_zone(dev, zone);
+	scoped_guard(null_zone, dev, zone) {

  	if (zone->cond == BLK_ZONE_COND_READONLY ||
  	    zone->cond == BLK_ZONE_COND_OFFLINE) {
@@ -702,7 +720,8 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd 
*cmd, enum req_op op,
  		trace_nullb_zone_op(cmd, zone_no, zone->cond);

  unlock:
-	null_unlock_zone(dev, zone);
+	;
+	}

  	return ret;
  }
@@ -712,7 +731,6 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd 
*cmd, enum req_op op,
  {
  	struct nullb_device *dev;
  	struct nullb_zone *zone;
-	blk_status_t sts;

  	switch (op) {
  	case REQ_OP_WRITE:
@@ -731,10 +749,8 @@ blk_status_t null_process_zoned_cmd(struct 
nullb_cmd *cmd, enum req_op op,
  		if (zone->cond == BLK_ZONE_COND_OFFLINE)
  			return BLK_STS_IOERR;

-		null_lock_zone(dev, zone);
-		sts = null_process_cmd(cmd, op, sector, nr_sectors);
-		null_unlock_zone(dev, zone);
-		return sts;
+		scoped_guard(null_zone, dev, zone)
+			return null_process_cmd(cmd, op, sector, nr_sectors);
  	}
  }

@@ -748,7 +764,7 @@ static void null_set_zone_cond(struct nullb_device *dev,
  			 cond != BLK_ZONE_COND_OFFLINE))
  		return;

-	null_lock_zone(dev, zone);
+	guard(null_zone)(dev, zone);

  	/*
  	 * If the read-only condition is requested again to zones already in
@@ -769,8 +785,6 @@ static void null_set_zone_cond(struct nullb_device *dev,
  		zone->cond = cond;
  		zone->wp = NULL_ZONE_INVALID_WP;
  	}
-
-	null_unlock_zone(dev, zone);
  }

  /*

