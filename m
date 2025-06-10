Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098125CC61
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576219; cv=none; b=pIhY+mwvJbHYeNrWe+n+i4c3f2lO8YcJpcSNtrP3HDuTHS6HN7L4sE9TDSyw6VNG3kho3mJcc6+Qqj0uELmXIysY8bRoZ51eVwUHdiolOPHmM8DPA1K8GbvqahCxEJyGt8eODsva0wYfOGlhvqf8uqHd31K1hDASuc2QQiL+IbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576219; c=relaxed/simple;
	bh=PD0pNNUsK1SAxaDm1AcB6jphM9XUoA+T5uNkMyaqifQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kw8stXWIW5RV1lZ+1unzEzmAurbv3YYysYHKJxpGF3U15BJZcpw/vWbhQmgzJWEULDzgnz8UXGo6aFNIhDsI8zDPXNR4KRbz91e6YP7IVYnE5nhHIPCAU5FfhD18hKjaAcxZXr1lIKo5ym1HwBHG4WomujPFMEF4TxQmZd3sXf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NNu0dRND; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NNu0dRND"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bGwcR0NJmzm0gbW;
	Tue, 10 Jun 2025 17:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1749576213; x=1752168214; bh=iYIilzFcsCU8kpeeHe+PCB5I
	PlLamgkXNG58jf4wELI=; b=NNu0dRNDXnL8pOMmiBMlYITZdGKD9YB/4T7dFJW8
	9451HJ3GXKR9rAnh9mY9wy1UE4qrbgiOGhYyQu6pOLIeyaflN+2uOGMdL6yYCszT
	6OR0TvaYKLUnkVkXLnoOaNkiwV8zYN/mTXrodwkz7D/rjlGfo/l4NRnKACKkEdqF
	zASILX0Q539C4LmqiZFOBnZkyUs52QrGCIHy6PYwKtjMg8PZWY9eFDs+DUibbWTj
	ZPHt5R6rhh/31r7iTu0RweBa5yOd1Dw9/0TGelPerA5uSog8oFwRTj5zI/SDOk5y
	Uo0con3asBPqEAXGevniA8w+3R+bU9akeu59uKRChpwBOg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id O2fEvx7eQ9Vo; Tue, 10 Jun 2025 17:23:33 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bGwcJ2dyZzm0yt2;
	Tue, 10 Jun 2025 17:23:27 +0000 (UTC)
Message-ID: <83e74dd7-55bb-4e39-b7c6-e2fb952db90b@acm.org>
Date: Tue, 10 Jun 2025 10:23:26 -0700
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
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Eric Biggers <ebiggers@google.com>
References: <20250520135624.GA8472@lst.de>
 <d28b6138-7618-4092-8e05-66be2625ecd9@acm.org> <20250521055319.GA3109@lst.de>
 <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org>
 <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org>
 <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org>
 <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
 <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
 <20250526052434.GA11639@lst.de>
 <a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org>
 <20250609035515.GA26025@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250609035515.GA26025@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/25 8:55 PM, Christoph Hellwig wrote:
> The problem here is that blk_crypto_fallback_split_bio_if_needed does
> sneaky splits behind the back of the main splitting code.
> 
> The fix is to include the limit imposed by it in __bio_split_to_limits
> as well if the crypto fallback is used.

(+Eric)

Hmm ... my understanding is that when the inline encryption fallback
code is used that the bio must be split before
blk_crypto_fallback_encrypt_bio() encrypts the bio. Making
__bio_split_to_limits() take the inline encryption limit into account
would require to encrypt the data much later. How to perform encryption
later for bio-based drivers? Would moving the blk_crypto_bio_prep() call
from submit_bio() to just before __bio_split_to_limits() perhaps require
modifying all bio-based drivers that do not call
__bio_split_to_limits()?

> If you have time to fix this that would be great.  Otherwise I can
> give it a spin, but it's public holiday and travel season here, so
> my availability is a bit limited.

This is not the solution that you are looking for but this seems to
work:

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 7c33e9573e5e..f4fefecdcc5e 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -213,6 +213,7 @@ blk_crypto_fallback_alloc_cipher_req(struct 
blk_crypto_keyslot *slot,
  static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
  {
  	struct bio *bio = *bio_ptr;
+	const struct queue_limits *lim = bdev_limits(bio->bi_bdev);
  	unsigned int i = 0;
  	unsigned int num_sectors = 0;
  	struct bio_vec bv;
@@ -223,6 +224,7 @@ static bool 
blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
  		if (++i == BIO_MAX_VECS)
  			break;
  	}
+	num_sectors = min(num_sectors, get_max_io_size(bio, lim));
  	if (num_sectors < bio_sectors(bio)) {
  		struct bio *split_bio;

diff --git a/block/blk-merge.c b/block/blk-merge.c
index fb6253c07387..e308325a333c 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -192,8 +192,7 @@ static inline unsigned int 
blk_boundary_sectors(const struct queue_limits *lim,
   * requests that are submitted to a block device if the start of a bio 
is not
   * aligned to a physical block boundary.
   */
-static inline unsigned get_max_io_size(struct bio *bio,
-				       const struct queue_limits *lim)
+unsigned get_max_io_size(struct bio *bio, const struct queue_limits *lim)
  {
  	unsigned pbs = lim->physical_block_size >> SECTOR_SHIFT;
  	unsigned lbs = lim->logical_block_size >> SECTOR_SHIFT;
diff --git a/block/blk.h b/block/blk.h
index 37ec459fe656..5f97db919cdf 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -425,6 +425,8 @@ static inline unsigned get_max_segment_size(const 
struct queue_limits *lim,
  		    (unsigned long)lim->max_segment_size - 1) + 1);
  }

+unsigned get_max_io_size(struct bio *bio, const struct queue_limits *lim);
+
  int ll_back_merge_fn(struct request *req, struct bio *bio,
  		unsigned int nr_segs);
  bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,


Thanks,

Bart.
