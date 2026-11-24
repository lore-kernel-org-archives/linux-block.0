Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795494528;
	b=qTLORV8kwrSVQRnP8H86l8Hs4jByAuOy0+czkajyCuEp2ih2hVTQnhdtA6++Kmiy2f5A
	 5ryr25/vWShfbh2aJClKLG/a464/DW+xFjgHrNxZUL1nbZzgwepAmh+i5GJdLIslPC3+g
	 Riydl9v3u00EHGMHd+haH+EFRjyYwrtz9KNl4O+Ep6h6NLsrvueasOTqBT519pZ21TUxT
	 FlE4YF9KGjYfZweckBdQS3+cMc8N3/O47tg3r1pRA7bPR6L8i0sPbgcyTfzXf2214oe3s
	 YWMMgfJDz9hIcc3TbOg+FFAdw+TxgVIQ6ZqwDnJINZ0/ac6Z6ZysgcRn/vuVFLNSFOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494528;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=o0uCJt2nGOH/3ssHkKbsShLtTHhMXA9MYNZxQAUCQ0I=;
	b=nyNB3TeS8nsFbulaEiVm9IsdE4MgqrJWzyFu5Lr349499phFPyUmQqINNe7issb0jZ9w
	 9HGUSlsWky8EwQ4icEd3QXcrJEG2t0nMPbAt8mSK5bbcwLu4r8Qlj74UI9NYkz/ct27kG
	 LoB29y1QHZ5Jnf+JxztQ30WwTPWCVbZQzTOTZcExESzq9yg47kBWUI653UDXAogiIA7FQ
	 cY+YEMrOeO+5JuRNTtmaWSv/6SLCGA4uZIedQeNDNevAagOHoz69Wrj+Ai/D9hmGY/kVw
	 AfP2uMOnFlRkAJOrnlVqLJYTiuaDyq5Wi5kwDERsO2BENK2W8SoMVn9UmOPSHRmS+UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNDs5mc7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1838C606A321
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 04:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNDs5mc7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F3F1F000C4;
	Tue, 24 Nov 2026 04:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795494527;
	bh=o0uCJt2nGOH/3ssHkKbsShLtTHhMXA9MYNZxQAUCQ0I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZNDs5mc7msYm6FfWkan6zfuGobt9cFRYNAHn9ClZfAjwyC9gm3hZ3oYeLcOEjwKUf
	 2tjxxzabJlw2eW71UhFxBVGD4TseasX3Opn05BhZITy94EW5gqRH1ICgaAhDA58aFZ
	 Ii4XwCZwBPlX6BI5kthN+rheWCELrrdGPMDNU3spL68sLBf6YMgSI1cW5wj0IfYluE
	 bKlMtvuG+YpureSx4g68jpTPo8c8hje1JeemPFw0qr4sRWJoAIeLSxq7tWBEOEqgUw
	 X9gc7pWJ7CLphCAf+BZS5BTPTYKwB2evAGC1UoR18XRYo9yOBVSZYl4T+kzTNV33OJ
	 F4u8tR1w1IfKg==
Message-ID: <7c2c47bf-3bfc-4c69-acca-65aafb007397@kernel.org>
Date: Tue, 24 Nov 2026 13:28:45 +0900
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
Subject: Re: [PATCH] block: don't wait for all RCU callbacks when freeing zone
 write plugs
To: Qiliang Yuan <qiliang.yuan@linux.dev>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20261121-feat-blk-zoned-rcu-barrier-v1-1-766875b525be@linux.dev>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261121-feat-blk-zoned-rcu-barrier-v1-1-766875b525be@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/26 09:57, Qiliang Yuan wrote:
> Zone write plugs are allocated from a per-disk mempool and freed with
> call_rcu(). Before destroying the mempool, which happens every time a
> zoned disk is released, disk_destroy_zone_wplugs_hash_table() calls
> rcu_barrier() so that no zone write plug is still waiting to be returned
> to it.
> 
> rcu_barrier() waits for the RCU callbacks queued on every CPU by anyone,
> which usually takes a grace period or more, even when the disk had no
> zone write plug left to free. Removing many zoned disks, such as the SMR
> drives of a storage node taken offline, pays this once per disk.
> 
> Count the zone write plugs of the disk that wait for their RCU callback,
> and wait only for that count to drop to zero.
> 
> Removing 32 zoned null_blk or scsi_debug devices, base and patched
> kernels alternating over 2 rounds of 3 runs, median of the 6 runs and
> range in parentheses; "with plugs" leaves four partially written zones,
> and so four zone write plugs, on each null_blk device:
> 
>   devices                      before (ms)      after (ms)   change
>   null_blk                   820 (805-885)   438 (424-454)     -47%
>   null_blk, with plugs       876 (852-883)   844 (805-877)      -4%
>   scsi_debug, host-managed   958 (945-991)   642 (630-652)     -33%
> 
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>

Looks OK, modulo one nit below.

With that,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> @@ -2146,10 +2151,11 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
>  	disk->zone_wplugs_hash_bits = 0;
>  
>  	/*
> -	 * Wait for the zone write plugs to be RCU-freed before destroying the
> -	 * mempool.
> +	 * Wait only for the RCU callbacks freeing the zone write plugs of this
> +	 * disk before destroying the mempool.

The "only" in this sentence makes sense when considering rcu_barrier() vs your
change. So I think that the comment can stay as it is since that also describes
your change.

-- 
Damien Le Moal
Western Digital Research
