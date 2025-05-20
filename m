Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3866722DA16;
	Tue, 20 May 2025 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747764567; cv=none; b=AISVpTOtp1SWerzhZ28stlYE2EKRjmUrNei+5yG3q2coRDKycEOCBV8toClyOXhylJrBufv4QJBzwBhAX+Ff8LFguvqASAoSFilLNw2xn8i9J9WdOcOD5F1lk0tEb9V9Xj7a+/TmegTn62o4BzycFxpTu8OwAASGaJwPPUdxOOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747764567; c=relaxed/simple;
	bh=XPzARLkBvcJFmLTFMZW4+wt5UBWrFQ9ZwCb7j8lQ/30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxKGc+i206pSsRyV4NCsege7t5x6x6IuBcjd+FR5f/L50kCHq5aVfLSRtBHcIeqts6k1NpZXqnDJ1t2yWSEVNFiNFqHCcZzgchbadlX1AfMYSH3xe27d1KpAH8Cvp6TnfdZkbVyg6+p/mqQhBLudom7fhWBHLJYl3gOJEnbrjfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=hDT6pRch; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="hDT6pRch"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4b22cz6JJ6zlgqyG;
	Tue, 20 May 2025 18:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1747764562; x=1750356563; bh=Byijd5r5XP31BtZ8ZR7CrdnO
	sTA+YR7G3UabzhUTU0Q=; b=hDT6pRchf/JB1iMQV3oh4oUr4Fh4OVA/5Ne37f42
	gIJugzX0BAvBxdgYASCE/tdWwhKp6f9BGXDtP6yQdFdMS47qfhxv0DCwG1ldV/Ne
	Xe/fdDXJUEXaOtt2rY+MBdnNFckxqx20NpzTVGdZ2PbeyMO59+nDa4AtzZpvxyqF
	XD7oIF1xUg+9jxVdOiSRI+in1Aso0iMjn5SX/UCb9IHvsfYi4BgLrJV56D9mbESb
	rtDlR1ejP3CsjIWGc7fsZTfrtPSwlJDnza9RjL0tEXJHE4t6KrnUiLxgE7o/BjKQ
	uLehHQU4YO7weIBhNTvSzv6Tktxjww2VQVEll2/BxC979g==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EK_TemovTSWB; Tue, 20 May 2025 18:09:22 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4b22cs5v81zltKl7;
	Tue, 20 May 2025 18:09:16 +0000 (UTC)
Message-ID: <d28b6138-7618-4092-8e05-66be2625ecd9@acm.org>
Date: Tue, 20 May 2025 11:09:15 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org
References: <20250514202937.2058598-1-bvanassche@acm.org>
 <20250514202937.2058598-2-bvanassche@acm.org> <20250516044754.GA12964@lst.de>
 <47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org> <20250520135624.GA8472@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250520135624.GA8472@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/25 6:56 AM, Christoph Hellwig wrote:
> On Mon, May 19, 2025 at 03:12:11PM -0700, Bart Van Assche wrote:
>> This new patch should address the concerns brought up in your latest
>> email:
> 
> No, we should never need to do a sort, as mentioned we need to fix
> how stackable drivers split the I/O.  Or maybe even get them out of
> all the splits that aren't required.

If the sequential write bios are split by the device mapper, sorting
bios in the block layer is not necessary. Christoph and Damien, do you
agree to replace the bio sorting code in my previous email with the
patch below?

Thanks,

Bart.

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3d419fd2be57..c41ab294987e 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1792,9 +1792,12 @@ static inline bool dm_zone_bio_needs_split(struct 
mapped_device *md,
  {
  	/*
  	 * For mapped device that need zone append emulation, we must
-	 * split any large BIO that straddles zone boundaries.
+	 * split any large BIO that straddles zone boundaries. Additionally,
+	 * split sequential writes to prevent that splitting lower in the stack
+	 * causes reordering.
  	 */
-	return dm_emulate_zone_append(md) && bio_straddles_zones(bio) &&
+	return ((dm_emulate_zone_append(md) && bio_straddles_zones(bio)) ||
+		bio_op(bio) == REQ_OP_WRITE) &&
  		!bio_flagged(bio, BIO_ZONE_WRITE_PLUGGING);
  }
  static inline bool dm_zone_plug_bio(struct mapped_device *md, struct 
bio *bio)

