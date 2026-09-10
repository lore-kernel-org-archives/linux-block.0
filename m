Received: from mta0.migadu.com (out-102.mta0.migadu.com [91.218.175.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5CD48EC83
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051437; cv=none; b=NhTGC4acPpr43vDF6UssVkmsBVOBKmce2teckerNr1eA6JtBuw/GeHRaUQu74ET9vrH/IWONR10PxqKRf642BdIP/0sEIoHo003TzDnoMZfjdR/ddlYDebc0ifHWTbUYiEYNhB4tbUuC3YA8+G3IdUX8wLypnXUWZdDZwgyIbJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051437; c=relaxed/simple;
	bh=0phTsAjdn7TqGFxMlALLAWSoJ5zzPQQtHCGxDn4Kysk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ekhUgnNVK+xJAS0lGcbhwLNg79rXQtg/2HB8AGpIPRLK7atA+3BqXtUfWmB5HQQwX9/ptzHWQHpJK5R8O+9PzOnVDTND72HXLPa2yhjzk5sW7yI8qY9p0zPdglZgPJerGUHSfnlnNHLkMTQNHoEwKojdnktkdM9g1QOLUVPn7i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a0m0QZhh; arc=none smtp.client-ip=91.218.175.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a0m0QZhh"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0phTsAjdn7TqGFxMlALLAWSoJ5zzPQQtHCGxDn4Kysk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789051430; v=1; x=1789656230;
 b=a0m0QZhhXdh5KN4TIP+3VGCZQsIA3NeNr3sfOzXpjUQq3AlRw7JUssrQhQdMtaRcupKYR1iV
 VB9P5eS3mHzxUuJscf4yoAl4Phdv5gMDaSxDn5dWnhRu6JLi9cg2F8/EBypvq2jROxqshTyigzq
 eD1uBbgDlDbYVi3ikvIlRZdM=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id e3740c36f3401afa;
	Thu, 10 Sep 2026 14:43:49 +0000
X-Mizu-Trace-ID: e3740c36f3401afa
X-Migadu-Flow: FLOW_OUT
Message-ID: <c80bc923-d4ec-44d0-9c20-3594b8b10182@linux.dev>
Date: Thu, 10 Sep 2026 15:43:45 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: cap atomic write size by PI buffer size
 constraints
From: John Garry <john.garry@linux.dev>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org
References: <20260907074111.721054-1-hch@lst.de>
 <20260907074111.721054-3-hch@lst.de>
 <a17ccccc-a91c-4e45-a97e-d899c739e159@linux.dev>
 <20260910053636.GA27408@lst.de>
 <b800ecf7-1e78-4605-9db0-7bf891d8ca51@linux.dev>
 <75f54355-8c69-4d02-9531-4ca85fac46a8@linux.dev>
Content-Language: en-US
In-Reply-To: <75f54355-8c69-4d02-9531-4ca85fac46a8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/26 13:52, John Garry wrote:
> ...
> 
> Now I'll fix that patch as suggested and retest.

Below is the updated change. I suggest that you integrate into this 
series - but I don't mind how it's posted.

--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -240,14 +240,20 @@ static unsigned int 
blk_queue_max_guaranteed_bio(struct queue_limits *lim)

  static void blk_atomic_writes_update_limits(struct queue_limits *lim)
  {
+	unsigned int integrity_max = lim->integrity.metadata_size ?
+					max_integrity_io_size(lim) : 0;
  	unsigned int unit_limit = min(lim->max_hw_sectors << SECTOR_SHIFT,
  					blk_queue_max_guaranteed_bio(lim));

+	unit_limit = min_not_zero(unit_limit, integrity_max);
  	unit_limit = rounddown_pow_of_two(unit_limit);

  	lim->atomic_write_max_sectors =
  		min(lim->atomic_write_hw_max >> SECTOR_SHIFT,
  			lim->max_hw_sectors);
+	lim->atomic_write_max_sectors =
+		min_not_zero(lim->atomic_write_max_sectors,
+				integrity_max >> SECTOR_SHIFT);
  	lim->atomic_write_unit_min =
  		min(lim->atomic_write_hw_unit_min, unit_limit);
  	lim->atomic_write_unit_max =
@@ -515,11 +521,13 @@ int blk_validate_limits(struct queue_limits *lim)
  	if (!(lim->features & BLK_FEAT_WRITE_CACHE))
  		lim->features &= ~BLK_FEAT_FUA;

-	blk_validate_atomic_write_limits(lim);
-
  	err = blk_validate_integrity_limits(lim);
  	if (err)
  		return err;
+
+	/* atomics limits depend on integrity limits */
+	blk_validate_atomic_write_limits(lim);
+
  	return blk_validate_zoned_limits(lim);
  }
  EXPORT_SYMBOL_GPL(blk_validate_limits);
