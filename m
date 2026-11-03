Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793682588;
	b=HCmZPSDmt76761x+spBtWVd2+PBdxIzMJZpygDTR5wifpyzdwH7YxXJD5QwKFDYF7Ypo
	 g4JbBpZlHiFU8s+98xOD/GTtqRj4Rfbl5cxM921CAFFu/QDejr//jWB5+QJtG8UZobzOr
	 Zm4q37tEHeP0iOPOd22OfyW68XaQkB4CwpqaqEWARJUAPIf4gsNy0nS3/5eGPoKS+V3Hq
	 +ZXJDc0RoUI0TbfIR674D1jgaPLIRPlFzYLG1o4y6aDp8YENlV7J4jjRqEg69PMl72MbT
	 ILJR2Lh7ONN3lgcvOCtofT3dDrurVCr7cw97D3gHh08BhwjFmQI+jj7XLPAEDhfSYhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793682588;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=x19BTesQnJxPeZKo9N9Hiry2qG8zcnro7nMubU1G4qw=;
	b=tQ5TL0wyFmC27xV/JhG3LYwgh6zM19hw8DMf9mfoMlUA3LuUHnotlWRmM3ZVjx+Xw2CW
	 hNaIoQgdNN3qqxJIStQOJFrR8NvGb5Cdnf/jHTtAi7dDVV8jTpJoC7bji5sPXQT7jleY3
	 oQbknLmpa+j2Kn6/NOzQdW2g/yiR+Jw8ljKVxh84bSa4gcM7qMvVDbEiUtyE8iXaTDPyW
	 a045gaIickicb4kKgnSMGBSypHMtj0FNB31xY6Y3ljPB3E4pj2pDfA/FJSqE/Jr5T9LWY
	 njL688TcQXAvw+XmdUxtAHcOxyGVHtlPdm+fj0ohL6T7sa3yvvhUznrZXgPDxeqzgsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSNR9CVQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9D606A324;
	Tue,  3 Nov 2026 05:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSNR9CVQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176C41F000C1;
	Tue,  3 Nov 2026 05:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793682588;
	bh=x19BTesQnJxPeZKo9N9Hiry2qG8zcnro7nMubU1G4qw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bSNR9CVQ7FFju701jEka8AEGbZWPTn6u8D2rXYSFhxFPyp3989ausuCEglnh99GDY
	 6UzbNHMQ99rdRVtwk5rWsVW8cHbNAhxSbaWBapMSn97u55JeBpmUMEXNvGc0QgECTC
	 tLK0brd4LIYw6miF0r78pcdgePHFtJvDe80VeY0kViZf82ZX38FbARpbXc8kZHD02d
	 HiX4HNEaDqBl+/iu/VVAvkzO7zzxkA5vaiepsCeovK6BTPehA6vm2PCpN/cbBTMh5l
	 WcyrQnMGE5aXL6Hw6/+NFIeU9j5TCqcvQHaZdlkjx6176lsOJLGwx/3GoZKdfEPIW4
	 9a97D+688359w==
Message-ID: <c65e0bd5-2168-4733-81b8-1cefa806c03c@kernel.org>
Date: Tue, 3 Nov 2026 14:09:45 +0900
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zloop: reject mismatched conventional zone files on
 restore
To: shao.mingyin@zte.com.cn, hch@lst.de, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org
References: <20261031221610676B5VoVcwMgkoDNVZH2bVDO@zte.com.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261031221610676B5VoVcwMgkoDNVZH2bVDO@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/26 23:16, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> When restoring a zloop device, zloop_init_zone() checks that the size of
> each conventional zone file matches the configured zone size.  The check
> prints an error and then jumps to out_fput, which releases the zone file
> and returns the value left in "ret" by the preceding vfs_getattr() call,
> that is, zero.  zloop_ctl_add() therefore treats the zone as initialized
> and continues with a zone->file pointer that was already released; any
> I/O to that zone then dereferences it.
> 
> Return -EINVAL, like the sequential zone path does for the same kind of
> inconsistency.
> 
> While at it, print the zone size that is actually compared instead of the
> zone capacity, which may be smaller and only made the message confusing.
> 
> Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
