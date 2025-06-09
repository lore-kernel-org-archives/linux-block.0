Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2A51624DF
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502100; cv=none; b=cNUpQGItx0y25uFNx01DeZ1ytUTcoasY8zu+mUyVlAKAphkdhEpJyHqlAXl1+3WWur/rW3e11LV2OBXDdlFze/dGwf5lGiGoczNOQquOd2jD40YuH4DbgFF2Z6jAjMv+yQJHU9i4yAzL3ZaewQf/+6EjjNX/IECX/LBqN7PiKDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502100; c=relaxed/simple;
	bh=A1wDyxbvHHqicVQTTMSZu6KrWiPSDOzNq8DpWzJQtd8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eXHbsw9FneCKqLBCH3ymeqDECh0p1kOSdp0ldco0JL62/Nmz1G4Gh7rYRuXizaLbCVag9vpOM6fIInJKXjqZKFuF1lLXkhwWhoWeptl3LnG4yrVjurVFIgdC5INwBRO1w/bYlys8h4NEXRFc9m9isg3pT5G2GzoaWS4wcnxXVr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SZbEK6qB; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SZbEK6qB"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bGPC416XfzltPtc;
	Mon,  9 Jun 2025 20:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:subject:subject:from:from
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1749502094; x=1752094095; bh=zpDa7PM8gDIM/x1IAzLXATzr
	dnEUd6JRHz9OFu6P/9A=; b=SZbEK6qBmwdb0eISlD9zm2WLIY8iItK9df8bCMW2
	xaIKcZkDm5rh32xjQMmtcR1ZKBjJtITGb6CCTIoynX8h0qApI1FsRLrz7dANu43Z
	HGK3eBxAAyFGSUI18qapB9RnFGRKVNfeA6CfHajCKDSZjRCKK76wawHJPvU376mH
	7vZkLo4dDLEUuntCkWk5mzYCZk6+zkcGMQOxtBc4jaMiYOgMZZBKXYJam6PH9ILu
	E9maW69HR5CQuyGSMWR+I+XCKJgvYzfXWaC0BCF/5GB5OIZteiLnMCbQ+MIpn39Y
	O/pGlwl4PehktoC3QvVMEnuxZw2WJ9VVWgVyYsAODcdkww==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cqLFy8ATxkwQ; Mon,  9 Jun 2025 20:48:14 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bGPBw5jKqzlgqyd;
	Mon,  9 Jun 2025 20:48:07 +0000 (UTC)
Message-ID: <a0c89df8-4b33-409c-ba43-f9543fb1b091@acm.org>
Date: Mon, 9 Jun 2025 13:48:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250516044754.GA12964@lst.de>
 <47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org> <20250520135624.GA8472@lst.de>
 <d28b6138-7618-4092-8e05-66be2625ecd9@acm.org> <20250521055319.GA3109@lst.de>
 <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org>
 <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org>
 <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org>
 <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
 <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
 <20250526052434.GA11639@lst.de>
 <a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org>
 <d8f5f6eb-42b8-4ce8-ac86-18db6d3d03d0@kernel.org>
Content-Language: en-US
In-Reply-To: <d8f5f6eb-42b8-4ce8-ac86-18db6d3d03d0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/25 3:47 PM, Damien Le Moal wrote:
> So yes, we need a fix. Can you work on one ?

The patch below seems to be sufficient but I'm not sure whether this
approach is acceptable:

Subject: [PATCH] block: Preserve the LBA order when splitting a bio

Preserve the bio order if bio_split() is called on the prefix returned
by an earlier bio_split() call. This can happen with fscrypt and the
inline encryption fallback code if max_sectors is less than the maximum
bio size supported by the inline encryption fallback code (1 MiB for 4 KiB
pages) or when using zoned storage and the distance from the start of the
bio to the next zone boundary is less than 1 MiB.

Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  block/bio.c               |  8 ++++++++
  block/blk-core.c          | 12 ++++++++----
  include/linux/blk_types.h |  5 +++++
  3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3c0a558c90f5..440ed443545c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1689,6 +1689,14 @@ struct bio *bio_split(struct bio *bio, int sectors,

  	bio_advance(bio, split->bi_iter.bi_size);

+	/*
+	 * If bio_split() is called on a prefix from an earlier bio_split()
+	 * call, adding it at the head of current->bio_list[0] preserves the
+	 * LBA order. This is essential when writing data to a zoned block
+	 * device and when using REQ_OP_WRITE instead of REQ_OP_ZONE_APPEND.
+	 */
+	bio_set_flag(bio, BIO_ADD_AT_HEAD);
+
  	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
  		bio_set_flag(split, BIO_TRACE_COMPLETION);

diff --git a/block/blk-core.c b/block/blk-core.c
index b862c66018f2..570a14a7bcd4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -745,12 +745,16 @@ void submit_bio_noacct_nocheck(struct bio *bio)
  	 * to collect a list of requests submited by a ->submit_bio method while
  	 * it is active, and then process them after it returned.
  	 */
-	if (current->bio_list)
-		bio_list_add(&current->bio_list[0], bio);
-	else if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO))
+	if (current->bio_list) {
+		if (bio_flagged(bio, BIO_ADD_AT_HEAD))
+			bio_list_add_head(&current->bio_list[0], bio);
+		else
+			bio_list_add(&current->bio_list[0], bio);
+	} else if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
  		__submit_bio_noacct_mq(bio);
-	else
+	} else {
  		__submit_bio_noacct(bio);
+	}
  }

  static blk_status_t blk_validate_atomic_write_op_size(struct 
request_queue *q,
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3d1577f07c1c..0e2d3fd8d40a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -308,6 +308,11 @@ enum {
  	BIO_REMAPPED,
  	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
  	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
+	/*
+	 * make submit_bio_noacct_nocheck() add this bio at the head of
+	 * current->bio_list[0].
+	 */
+	BIO_ADD_AT_HEAD,
  	BIO_FLAG_LAST
  };


