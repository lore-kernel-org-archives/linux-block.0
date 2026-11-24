Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506988;
	b=VFAihuw/pBoJNlz2kn+WKJNhjspqYZ8BNQr6sNBvpkbpp5G/yIB2SHcVNFmpBkQSrjJ3
	 f6u6BYcNbO39NFX/WwI2iTUu2WdNMSch1W9Rihv1HFb09mO14PbfmcJYsYd08YhgHpdPb
	 6KADK5eLS7400oRPf0PNS7v4we6hKUmZu1esoh/0uS1KlAykQTIp2SdP3M7t60HM+SMLK
	 YMXdr+F9S/TNvuVB1/b+I4CayNWKGCUOBf/l66/Nsk7NwQz4xjl/AS1xZztOD4AsMEQE2
	 Yzy6PcjxRnSqPDtKp8xPnD44ud8uD6YGxhpYTmbu0zwu5XX1TKbO/picaBSaut2pXlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=vYhZnVqOZw+nz+bSvWI9hUrAjtNqzIx5KTyz4HXKnEc=;
	b=L+T0PeAdyndBSWFCILEt2lTIz8q7zjdZDWZG2o2C8ci5eV5aEoUIealHOf81uEe0gXqN
	 meW19/px6qpXboWGv08FyMaE5S/aOb6Izj9j+HO8+GWciNioLojTKazpMPI0hGCOCoapa
	 JRjkvrS9govEw4RZ7bWIkhpnv5BIROKUhdc4WNlLa6QHzR1+43617wbfgpGCm4LeSJsKf
	 g298kgOCSAn73heKRRV+1FRQK0JGPzzgYeHNkkiBqCue27qAnHAhJIfjxe6GbEmalXAkY
	 1kwv+VJAdaTPAEsHONSRN4VxmHd6bc+ykJM80wBv1NApWQuhqI2mAJ8lx06FCg7DQNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cN9h1p1V;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF7D606A31E
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 07:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBF7D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cN9h1p1V
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3861d608cdcso464773eec.3
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 23:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795506987; x=1796111787; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vYhZnVqOZw+nz+bSvWI9hUrAjtNqzIx5KTyz4HXKnEc=;
        b=cN9h1p1VoSXcPxB3Fj5OZVM0BsYWslYa7ACsFpqDPFTZIQWQ5e5j7XPqNeI+ViFAqD
         wXUlKlA0oka3N72ZB2U8ftjBv7rhKElWOmRGyQ0qk2AUaJhRA5TlVkvISCzLYB9H7V79
         4MnUaw2bfyijcXTAjZQozrv3OHx7fV7naGPH+rv7RZ+xRoIFbpWvSAvpNNGrtNcAMFAz
         vR5z/pFRokCQBYsJaaThWUs1hY6tJj4YnoRd4fpsH/fjTjSR+dn6v3NQlESJxOGvbshG
         UmLBo8w78lxcEwNYRemOtvLIae7OlArtnpQ7ymdKDMxuY38tQJmG2/tP/QHZBgQAWme1
         6sUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795506987; x=1796111787;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vYhZnVqOZw+nz+bSvWI9hUrAjtNqzIx5KTyz4HXKnEc=;
        b=eB8vBXw3HTEtxdPdOFobzJ8P+SPw8PXa8ZJfuCLPY0RYy3C9PjfRDUrnW1lCke+V6a
         C84FoHYrKTLuj50esSyf/ooCUbQ5AwmDSLj+ROeH0d17WjiGPsCpCP9CdHehSpASzk+5
         0dW+QHCARsQXc5PKBFlXGNdZTXuJ7fxdf1nxMlrZTAgOM2UrHDlVD/KovHkRWYZIepvz
         zK8bgoOiGijNYr8pBkG/YAPmxfJwjZZqykFKZaR+C+1hE2aTspENxuKZUIGda6a3A36V
         olQTHpXmyeAfiGjCpetDBDQW+BzJaaJsLMLN5lIVV5MXCtnPN+qKLIgh5mT6LyHxsLQX
         SKtw==
X-Forwarded-Encrypted: i=1; AL+hErFWw378/XecXRy8TucYLx8sBtlFuZM4DZTAGlz4TXlTIKhQLGutFbqy6MKeJVpQVvGjNrXpNnRwXdQqXg==@vger.kernel.org
X-Gm-Message-State: APuU4Z823aOymjLd/ASdHd1ZJSiop6KkhnWJD/PVmbDK9sAJsBP05cTD
	TwwU7SN6AxmM8cknWGYSHE5KudZBLdDbHJyU7O5f+hD4QqF2ReiuEN5e
X-Gm-Gg: AZFdTZdCaXdYURYswd8Fv7COm0xAsnqO0coOGU6Q7y6blr9BnO5mGf90Y6RsxnIqDGd
	K0kZ0qLuEIuQFs2rrlzvSujWKekd06mVf0OARVNfylJwSIlQMXr3T35ap3jYdooqaabzpd/ZG0d
	yRb915VFiMvnxsIbCrLNtwFTqsz7a3DGuiL72LVaSII2mepdLPu51cuWD+K9RdOsI3mVy4HO6Ma
	GjrFcDduknDTWJS5CZ+ywQvEghUB+XW9SlxY11xGI6VbhTmIEHqC2xg2btZ330ogpDt9erlZsUS
	1OHHI96YRzPYkN/F4pPwgWggpoLNOsIxJ9v4r+kKq82YDlNWMlVbyTmKIDpW+7UNX3BY4RpNPWJ
	VL/T1p8JrzzF0+R9Ug5uYsDSgD+LD8JkEq48fPVnau0QCkZmo1PetSrHnFqNPUnQJYOCrj5u1ye
	ffby3i/4caT9/ucL++A34p6+9+nQO42JXlesjTj6PyG6Gkl2vT1MmbLgyL3f6iPi9nBTKGaY2vT
	XmHVyyfHTEabjEsqC3LlB+a3RUBrLwa0F4H8LM9solRq1oZ6lrqw9bBPFQxTcG7tX1LkngJ+TS4
	hfhCt8dgECS12WmEVO78KSGDArl+8EWhJzHoYRYUTtle0sdkgk3eKh0LGy+lFBbMoHU=
X-Received: by 2002:a05:7300:1c24:b0:384:a0cb:a6d0 with SMTP id 5a478bee46e88-3856de58f7fmr23387653eec.1.1795506986646;
        Mon, 23 Nov 2026 23:56:26 -0800 (PST)
Received: from o6.lan ([2602:fce1:44f:115e::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm51631829eec.11.2026.11.23.23.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:56:26 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RFC 2/3] lib/lz4: add safe decompression from two input
 buffers
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Xueyuan Chen <xueyuan.chen21@gmail.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Nhat Pham <nphamcs@gmail.com>, 
 Yosry Ahmed <yosry@kernel.org>, Minchan Kim <minchan@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org
In-Reply-To: <awU7nwcEVC20uGMi@google.com>
References: <20261122-zram-split-decomp-mm-rfc-v1-0-4e69b08c0fed@gmail.com>
 <20261122-zram-split-decomp-mm-rfc-v1-2-4e69b08c0fed@gmail.com>
 <awU7nwcEVC20uGMi@google.com>
Date: Tue, 24 Nov 2026 15:56:21 +0800
Message-Id: <179550698133.2385422.1938353460437500441.b4-reply@b4>
X-Mailer: b4 0.16.0

On 2026-11-24 16:28 +0900, Sergey Senozhatsky wrote:
> Let me Cc Herbert and zswap folks on this.  Herbert mentioned previously
> (back in the days when we landed SG-list based zsmalloc object read API)
> that lz4 can be extended to support spanning zsmalloc objects and, if this
> lands, then zswap may also be interested in adopting it (along with zram).

I tested this approach using real zram data from an Android phone, but didn't
see any performance gains. :(

I'd be interested to hear if anyone has a better approach.

> 
> On (26/11/22 01:09), Xueyuan Chen wrote:
> > LZ4_decompress_generic() assumes contiguous input. Its wide literal
> > loads can cross the boundary between independently mapped fragments.
> > 
> > Add a dictionary-free block decoder that reads from two buffers and
> > handles literals, lengths and offsets that cross the split.
> > 
> > Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> > ---
> >  include/linux/lz4.h      |  18 ++++++
> >  lib/lz4/lz4_decompress.c | 163 +++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 181 insertions(+)
> > 
> > diff --git a/include/linux/lz4.h b/include/linux/lz4.h
> > index ad6042a718b5..3b6217bd9a9b 100644
> > --- a/include/linux/lz4.h
> > +++ b/include/linux/lz4.h
> > @@ -292,6 +292,24 @@ int LZ4_decompress_fast(const char *source, char *dest, int originalSize);
> >  int LZ4_decompress_safe(const char *source, char *dest, int compressedSize,
> >  	int maxDecompressedSize);
> >  
> > +/**
> > + * LZ4_decompress_safe_split() - Decode a single block from two buffers
> > + * @first: address of the first input fragment
> > + * @first_len: bytes in the first input fragment
> > + * @second: address of the second input fragment
> > + * @second_len: bytes in the second input fragment
> > + * @dst: output buffer, disjoint from the input buffers
> > + * @capacity: bytes available in the output buffer
> > + *
> > + * The fragments, in order, contain one dictionary-free LZ4 block.
> > + * Their addresses need not be adjacent. An empty fragment may be NULL.
> > + *
> > + * Return: the decoded size, or -EINVAL on error.
> > + */
> > +int LZ4_decompress_safe_split(const u8 *first, size_t first_len,
> > +			      const u8 *second, size_t second_len,
> > +			      u8 *dst, int capacity);
> > +
> >  /**
> >   * LZ4_decompress_safe_partial() - Decompress a block of size 'compressedSize'
> >   *	at position 'source' into buffer 'dest'
> > diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
> > index 3a2cd9acada4..548197faa3e3 100644
> > --- a/lib/lz4/lz4_decompress.c
> > +++ b/lib/lz4/lz4_decompress.c
> > @@ -39,6 +39,11 @@
> >  #include <linux/kernel.h>
> >  #include <linux/unaligned.h>
> >  
> > +#ifndef STATIC
> > +#include <linux/errno.h>
> > +#include <linux/limits.h>
> > +#endif
> > +
> >  /*-*****************************
> >   *	Decompression functions
> >   *******************************/
> > @@ -705,6 +710,164 @@ int LZ4_decompress_fast_usingDict(const char *source, char *dest,
> >  }
> >  
> >  #ifndef STATIC
> > +struct lz4_split_input {
> > +	const u8 *first;
> > +	const u8 *second;
> > +	size_t split;
> > +	size_t size;
> > +	size_t pos;
> > +};
> > +
> > +static __always_inline size_t
> > +lz4_split_input_left(const struct lz4_split_input *in)
> > +{
> > +	return in->size - in->pos;
> > +}
> > +
> > +static __always_inline int lz4_split_get_byte(struct lz4_split_input *in)
> > +{
> > +	size_t pos = in->pos;
> > +
> > +	if (unlikely(pos == in->size))
> > +		return -1;
> > +	in->pos++;
> > +	if (pos < in->split)
> > +		return in->first[pos];
> > +	return in->second[pos - in->split];
> > +}
> > +
> > +/* The caller has checked that two bytes remain in the block. */
> > +static __always_inline int lz4_split_get_offset(struct lz4_split_input *in)
> > +{
> > +	size_t pos = in->pos;
> > +
> > +	in->pos += 2;
> > +	if (pos >= in->split)
> > +		return get_unaligned_le16(in->second + (pos - in->split));
> > +	if (in->split - pos >= 2)
> > +		return get_unaligned_le16(in->first + pos);
> > +	return in->first[pos] | (in->second[0] << 8);
> > +}
> > +
> > +static __always_inline bool
> > +lz4_split_copy_literals(struct lz4_split_input *in, u8 *dst, size_t len)
> > +{
> > +	size_t pos = in->pos;
> > +
> > +	if (unlikely(len > lz4_split_input_left(in)))
> > +		return false;
> > +	if (!len)
> > +		return true;
> > +	if (pos < in->split) {
> > +		size_t n = min(len, in->split - pos);
> > +
> > +		memcpy(dst, in->first + pos, n);
> > +		pos += n;
> > +		dst += n;
> > +		len -= n;
> > +	}
> > +	if (len)
> > +		memcpy(dst, in->second + (pos - in->split), len);
> > +	in->pos = pos + len;
> > +	return true;
> > +}
> > +
> > +/* The decoder has checked the lookbehind distance and output capacity. */
> > +static __always_inline void
> > +lz4_split_copy_match(u8 *dst, size_t distance, size_t len)
> > +{
> > +	size_t copied = min(distance, len);
> > +
> > +	if (distance == 1) {
> > +		memset(dst, dst[-1], len);
> > +		return;
> > +	}
> > +
> > +	memcpy(dst, dst - distance, copied);
> > +	/* Reuse the period already written, keeping each copy disjoint. */
> > +	while (len - copied > copied) {
> > +		memcpy(dst + copied, dst, copied);
> > +		copied *= 2;
> > +	}
> > +	if (copied < len)
> > +		memcpy(dst + copied, dst, len - copied);
> > +}
> > +
> > +static __always_inline int
> > +lz4_split_read_length(struct lz4_split_input *in, int length, int limit)
> > +{
> > +	int byte;
> > +
> > +	if (length > limit)
> > +		return -EINVAL;
> > +	if (length < RUN_MASK)
> > +		return length;
> > +
> > +	do {
> > +		byte = lz4_split_get_byte(in);
> > +		if (byte < 0 || byte > limit - length)
> > +			return -EINVAL;
> > +		length += byte;
> > +	} while (byte == 255);
> > +	return length;
> > +}
> > +
> > +int LZ4_decompress_safe_split(const u8 *first, size_t first_len,
> > +			      const u8 *second, size_t second_len,
> > +			      u8 *dst, int capacity)
> > +{
> > +	struct lz4_split_input in = {
> > +		.first = first,
> > +		.second = second,
> > +		.split = first_len,
> > +	};
> > +	int written = 0, min_last_literals = 0;
> > +
> > +	if (capacity < 0 || !dst || (!first && first_len) ||
> > +	    (!second && second_len) || first_len > SIZE_MAX - second_len)
> > +		return -EINVAL;
> > +	in.size = first_len + second_len;
> > +
> > +	for (;;) {
> > +		int token, literal, distance, match;
> > +
> > +		token = lz4_split_get_byte(&in);
> > +		if (token < 0)
> > +			return -EINVAL;
> > +		literal = lz4_split_read_length(&in, token >> ML_BITS,
> > +						capacity - written);
> > +		if (literal < 0 ||
> > +		    !lz4_split_copy_literals(&in, dst + written, literal))
> > +			return -EINVAL;
> > +		written += literal;
> > +		if (!lz4_split_input_left(&in))
> > +			return literal >= min_last_literals ? written : -EINVAL;
> > +
> > +		/* A match must leave room for the final literal sequence. */
> > +		if (lz4_split_input_left(&in) < 2 + 1 + LASTLITERALS ||
> > +		    capacity - written < MFLIMIT)
> > +			return -EINVAL;
> > +
> > +		distance = lz4_split_get_offset(&in);
> > +		if (!distance || distance > written)
> > +			return -EINVAL;
> > +		match = lz4_split_read_length(&in, token & ML_MASK,
> > +					      capacity - written - MINMATCH -
> > +					      LASTLITERALS);
> > +		if (match < 0)
> > +			return -EINVAL;
> > +		match += MINMATCH;
> > +		lz4_split_copy_match(dst + written, distance, match);
> > +		written += match;
> > +		/*
> > +		 * Leave at least LASTLITERALS bytes and end at least MFLIMIT
> > +		 * bytes past the start of the last match.
> > +		 */
> > +		min_last_literals = max(LASTLITERALS, MFLIMIT - match);
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(LZ4_decompress_safe_split);
> > +
> >  EXPORT_SYMBOL(LZ4_decompress_safe);
> >  EXPORT_SYMBOL(LZ4_decompress_safe_partial);
> >  EXPORT_SYMBOL(LZ4_decompress_fast);
> > 
> > -- 
> > 2.47.3
> > 
> 


