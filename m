Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795505324;
	b=dOF5nlHnpLv4pp2tKOv50tHnfRUI0nVIxZeQ9a6hwhufnkYc38Ceh1sMbcOvuwODdXTp
	 0BbMXUgQ3ZPsh0/mHsqMa4lXMlPQ8/gZuTVMLzDafEqTJ4s/nSRqh1p0BFR8HV9kj8wR6
	 rsZWE6pgFoF/78Nm1KNy+2heUELd37zZx/j1deTjFGmYaOkgtrOr1W45FZniMLqb6eMKw
	 MycpM4HvHoiSL52m7U2bWXG2Tz0Gj0hgV+s72qnsl4uh2a7m9jq2Ule61F8SzavitTNM3
	 NpG2BSq577/myUA70Krwiv3i4MoHdCy1Twj1Y7iujnaYiXTxHcCjgcCrbL2cdXC1dNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=WtLZKv4PnV43ule2KMeNIz98TT04uu2TzULijbQvMnI=;
	b=bj4JJ0APc6lV0Cuss53z/CmRmB25yT6HFTxdkZiekoWWo03AvUOmWurUNaFD9tj7Si0h
	 X8MFdYf327u6oJPzMNZL43zYX94iJ0NqvRNjG4T+7S0GlguoVDKJvPoawUmvj3ESWTVxM
	 aJVW/XyAok19L30TfHCNTI1TsKLZdozpOblwGT117arfw8DY2hDQveQBg55om6a4NYwVC
	 OJZsQDyfW/6vyhc6BmQwfUW52SufBEn38JLxUHPTt8kGvDR6u3LQvs+3qA1yKG6oo9D/4
	 Q5t6e8uFLA0+MvWFKVxu2m7z1elq/bOiP34OoGFT/i58gbFQ37DSCyuXCcAUg9+Xq6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QuSDH9g0;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351B7606A321
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 07:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 351B7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QuSDH9g0
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso9050959eec.0
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 23:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795505323; x=1796110123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WtLZKv4PnV43ule2KMeNIz98TT04uu2TzULijbQvMnI=;
        b=QuSDH9g0Yf1FWzuIb52bLRWBfPmSOfshu7ZDI9PbEK461SZrYtGMFyFm5hVWhm7E89
         UdhFa9srtOTK43Nzl1sJG4bkO5u6bEgjqvpbmV1GjahzECGTMrJDfU9zrxJNtOjrVzuj
         X3wMQHhQJBg/YbyZVdFuLz18WgrhRrqez6gBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795505323; x=1796110123;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WtLZKv4PnV43ule2KMeNIz98TT04uu2TzULijbQvMnI=;
        b=yWILtdmxEYOtHZFLNE+HOlS5ya7eTEfQ5vJBcxI5qq0lppRwijtwcncd+9KCLetsgp
         15tY9r8KER/gOvG+Dx9U4F1ox7OyNjztJRc3B4VFDGLlGEC+CAz6gnBK6iXwYxhD6I3r
         dI/aT0tBvwcFi0O1WQDxO6GfdfKxls1IdKxwhtlUTYwaj14LxPeL+tuXmvVIwYh+z2c0
         9iSA9OEdbRYOybSDLqK47HbDVoU/qeI2Oy6a5FVlnQaeUCQKpMly3kJDSOOgxFnN4kAN
         +Pri9sxvG6fdug78sypPVlAWdhpl3Mps/+KCpXvQqj1/Ji3fV5vekg4FnmmTt/zeCH+T
         r8xg==
X-Forwarded-Encrypted: i=1; AL+hErHnpHrwFCPGQbyKDGNkmiTwuJ3BoSEh3DPMEq3dX+to8l8Xgzp1sJ3Od8G8j9P0cjp0MXJfRiPWAqvS1A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9XPPz2r3aAVn8u5K2lT4wyvvXe5bDSjY545h1q5emNL4kyiL2l
	NvJKQtPa/6DCoOX+pl/iYi9SEgPN04nykDMReWh8ixV8dCorzawgx3J02TTWAva98g==
X-Gm-Gg: AZFdTZcbLXke9M2HhezbhnB538uorq44DOzeAqExReVhAekq2r+Knu3HWXKxLFhNLIi
	7ruA2HbNK+Bjo0sNXaeHiEPHy0k+h4mVguEPuRbpvoW7w6O9Bq595yowYL6431tLaPPjQQrDOvN
	49FmP9CVmJAE0rq+eGnAmuHcO5VlDrMbU5wngvLTJERysGQQmydub3Ge6uS6FyYFAM64AmR1N1v
	GkhVVo02X+cmMvRayTpLed1j2qybn3++m3tSWIga0PrqJSPCp2LiYEJDBy00+dfRNAiUyNDou0B
	1pt1HbNr6LNCcQoQXOiw93YTyWta82nmUWNavRcdyppbHOSM1G6tkh8Tmun+wmhF4rQaE2r5pTB
	6blzUGnEpy5zm04huYYn65DkTrr2+oqIyZl4rORQ51SRPmz5lpfglcpJ6G4q0+FM7hHpuI2iXdV
	Fat2kcjwCkB1HgOoI1xPXP2MI0Ak7h0a7lrE0M+NENQ7y3xtaJSKgERtIkMKXKMxildwYtX2xIH
	dD5Yj8iejl6Jd/qgD3VS8en8xL3BY/7YJNDK2uWpiagmO8Wa/ZnKP+jSR6P7e0ZBcWPgDP2CnXt
	N1bkCY4TosHe2wfDkpZ1VjpZJJ2p8frL2EA3pULrnaBILLeN107qS5UceebwGNaaY1Sg/jcdvLf
	6yC1X8tEHmskU+ac=
X-Received: by 2002:a05:693c:8083:b0:376:6530:248f with SMTP id 5a478bee46e88-38570a3717dmr16522843eec.24.1795505323304;
        Mon, 23 Nov 2026 23:28:43 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:d159:d585:9ced:38ba])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm44118149eec.28.2026.11.23.23.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:28:42 -0800 (PST)
Date: Tue, 24 Nov 2026 16:28:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Xueyuan Chen <xueyuan.chen21@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] lib/lz4: add safe decompression from two input
 buffers
Message-ID: <awU7nwcEVC20uGMi@google.com>
References: <20261122-zram-split-decomp-mm-rfc-v1-0-4e69b08c0fed@gmail.com>
 <20261122-zram-split-decomp-mm-rfc-v1-2-4e69b08c0fed@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122-zram-split-decomp-mm-rfc-v1-2-4e69b08c0fed@gmail.com>

Let me Cc Herbert and zswap folks on this.  Herbert mentioned previously
(back in the days when we landed SG-list based zsmalloc object read API)
that lz4 can be extended to support spanning zsmalloc objects and, if this
lands, then zswap may also be interested in adopting it (along with zram).

On (26/11/22 01:09), Xueyuan Chen wrote:
> LZ4_decompress_generic() assumes contiguous input. Its wide literal
> loads can cross the boundary between independently mapped fragments.
> 
> Add a dictionary-free block decoder that reads from two buffers and
> handles literals, lengths and offsets that cross the split.
> 
> Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> ---
>  include/linux/lz4.h      |  18 ++++++
>  lib/lz4/lz4_decompress.c | 163 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 181 insertions(+)
> 
> diff --git a/include/linux/lz4.h b/include/linux/lz4.h
> index ad6042a718b5..3b6217bd9a9b 100644
> --- a/include/linux/lz4.h
> +++ b/include/linux/lz4.h
> @@ -292,6 +292,24 @@ int LZ4_decompress_fast(const char *source, char *dest, int originalSize);
>  int LZ4_decompress_safe(const char *source, char *dest, int compressedSize,
>  	int maxDecompressedSize);
>  
> +/**
> + * LZ4_decompress_safe_split() - Decode a single block from two buffers
> + * @first: address of the first input fragment
> + * @first_len: bytes in the first input fragment
> + * @second: address of the second input fragment
> + * @second_len: bytes in the second input fragment
> + * @dst: output buffer, disjoint from the input buffers
> + * @capacity: bytes available in the output buffer
> + *
> + * The fragments, in order, contain one dictionary-free LZ4 block.
> + * Their addresses need not be adjacent. An empty fragment may be NULL.
> + *
> + * Return: the decoded size, or -EINVAL on error.
> + */
> +int LZ4_decompress_safe_split(const u8 *first, size_t first_len,
> +			      const u8 *second, size_t second_len,
> +			      u8 *dst, int capacity);
> +
>  /**
>   * LZ4_decompress_safe_partial() - Decompress a block of size 'compressedSize'
>   *	at position 'source' into buffer 'dest'
> diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
> index 3a2cd9acada4..548197faa3e3 100644
> --- a/lib/lz4/lz4_decompress.c
> +++ b/lib/lz4/lz4_decompress.c
> @@ -39,6 +39,11 @@
>  #include <linux/kernel.h>
>  #include <linux/unaligned.h>
>  
> +#ifndef STATIC
> +#include <linux/errno.h>
> +#include <linux/limits.h>
> +#endif
> +
>  /*-*****************************
>   *	Decompression functions
>   *******************************/
> @@ -705,6 +710,164 @@ int LZ4_decompress_fast_usingDict(const char *source, char *dest,
>  }
>  
>  #ifndef STATIC
> +struct lz4_split_input {
> +	const u8 *first;
> +	const u8 *second;
> +	size_t split;
> +	size_t size;
> +	size_t pos;
> +};
> +
> +static __always_inline size_t
> +lz4_split_input_left(const struct lz4_split_input *in)
> +{
> +	return in->size - in->pos;
> +}
> +
> +static __always_inline int lz4_split_get_byte(struct lz4_split_input *in)
> +{
> +	size_t pos = in->pos;
> +
> +	if (unlikely(pos == in->size))
> +		return -1;
> +	in->pos++;
> +	if (pos < in->split)
> +		return in->first[pos];
> +	return in->second[pos - in->split];
> +}
> +
> +/* The caller has checked that two bytes remain in the block. */
> +static __always_inline int lz4_split_get_offset(struct lz4_split_input *in)
> +{
> +	size_t pos = in->pos;
> +
> +	in->pos += 2;
> +	if (pos >= in->split)
> +		return get_unaligned_le16(in->second + (pos - in->split));
> +	if (in->split - pos >= 2)
> +		return get_unaligned_le16(in->first + pos);
> +	return in->first[pos] | (in->second[0] << 8);
> +}
> +
> +static __always_inline bool
> +lz4_split_copy_literals(struct lz4_split_input *in, u8 *dst, size_t len)
> +{
> +	size_t pos = in->pos;
> +
> +	if (unlikely(len > lz4_split_input_left(in)))
> +		return false;
> +	if (!len)
> +		return true;
> +	if (pos < in->split) {
> +		size_t n = min(len, in->split - pos);
> +
> +		memcpy(dst, in->first + pos, n);
> +		pos += n;
> +		dst += n;
> +		len -= n;
> +	}
> +	if (len)
> +		memcpy(dst, in->second + (pos - in->split), len);
> +	in->pos = pos + len;
> +	return true;
> +}
> +
> +/* The decoder has checked the lookbehind distance and output capacity. */
> +static __always_inline void
> +lz4_split_copy_match(u8 *dst, size_t distance, size_t len)
> +{
> +	size_t copied = min(distance, len);
> +
> +	if (distance == 1) {
> +		memset(dst, dst[-1], len);
> +		return;
> +	}
> +
> +	memcpy(dst, dst - distance, copied);
> +	/* Reuse the period already written, keeping each copy disjoint. */
> +	while (len - copied > copied) {
> +		memcpy(dst + copied, dst, copied);
> +		copied *= 2;
> +	}
> +	if (copied < len)
> +		memcpy(dst + copied, dst, len - copied);
> +}
> +
> +static __always_inline int
> +lz4_split_read_length(struct lz4_split_input *in, int length, int limit)
> +{
> +	int byte;
> +
> +	if (length > limit)
> +		return -EINVAL;
> +	if (length < RUN_MASK)
> +		return length;
> +
> +	do {
> +		byte = lz4_split_get_byte(in);
> +		if (byte < 0 || byte > limit - length)
> +			return -EINVAL;
> +		length += byte;
> +	} while (byte == 255);
> +	return length;
> +}
> +
> +int LZ4_decompress_safe_split(const u8 *first, size_t first_len,
> +			      const u8 *second, size_t second_len,
> +			      u8 *dst, int capacity)
> +{
> +	struct lz4_split_input in = {
> +		.first = first,
> +		.second = second,
> +		.split = first_len,
> +	};
> +	int written = 0, min_last_literals = 0;
> +
> +	if (capacity < 0 || !dst || (!first && first_len) ||
> +	    (!second && second_len) || first_len > SIZE_MAX - second_len)
> +		return -EINVAL;
> +	in.size = first_len + second_len;
> +
> +	for (;;) {
> +		int token, literal, distance, match;
> +
> +		token = lz4_split_get_byte(&in);
> +		if (token < 0)
> +			return -EINVAL;
> +		literal = lz4_split_read_length(&in, token >> ML_BITS,
> +						capacity - written);
> +		if (literal < 0 ||
> +		    !lz4_split_copy_literals(&in, dst + written, literal))
> +			return -EINVAL;
> +		written += literal;
> +		if (!lz4_split_input_left(&in))
> +			return literal >= min_last_literals ? written : -EINVAL;
> +
> +		/* A match must leave room for the final literal sequence. */
> +		if (lz4_split_input_left(&in) < 2 + 1 + LASTLITERALS ||
> +		    capacity - written < MFLIMIT)
> +			return -EINVAL;
> +
> +		distance = lz4_split_get_offset(&in);
> +		if (!distance || distance > written)
> +			return -EINVAL;
> +		match = lz4_split_read_length(&in, token & ML_MASK,
> +					      capacity - written - MINMATCH -
> +					      LASTLITERALS);
> +		if (match < 0)
> +			return -EINVAL;
> +		match += MINMATCH;
> +		lz4_split_copy_match(dst + written, distance, match);
> +		written += match;
> +		/*
> +		 * Leave at least LASTLITERALS bytes and end at least MFLIMIT
> +		 * bytes past the start of the last match.
> +		 */
> +		min_last_literals = max(LASTLITERALS, MFLIMIT - match);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(LZ4_decompress_safe_split);
> +
>  EXPORT_SYMBOL(LZ4_decompress_safe);
>  EXPORT_SYMBOL(LZ4_decompress_safe_partial);
>  EXPORT_SYMBOL(LZ4_decompress_fast);
> 
> -- 
> 2.47.3
> 
