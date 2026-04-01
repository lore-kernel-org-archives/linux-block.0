Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567D735836C
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056769; cv=none; b=VCoTuwJ1t+r8jnaRTcecoXR+Bxj5BuwNcClb7M7DVZ5MnfRO94mzmPlv+ECesRP9JumDIU0oc7TKjHLkMSf6L10iWlTQrLnnZa1y5Bl7LFhsRU/1RyUG5fg9WGVKnU2USS2kgqLZNoHD+hKVCHt1/wJ6C662OG8rVtsPHGSLeiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056769; c=relaxed/simple;
	bh=cq3uQKFeKjafBze1o/fWC/jcny3yRlVf//B9QgBCPNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMNRXT/rBrLZyRJhBHr/kuaJUAGNtBJmMU8eTjse+j7OR1Fq5FH5RM4dixzaz7hZul/D780qsrAw7aw1J4isqCpyuZpZ7+4OCRorEcclRVQvmZ9+YS/lMsdxfcC79HBiEWuhZiJDUHuiusSWeR4zjz//+gNjbzPTW/D1BIgdVIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=D0pcgmaM; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="D0pcgmaM"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-66f747175d8so4299960eaf.0
        for <linux-block@vger.kernel.org>; Wed, 01 Apr 2026 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1775056766; x=1775661566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vowzyU0SrHEAHYUrDuyIU9MIx98uSZTg1/2EM+Z8IKY=;
        b=D0pcgmaMUmJ6+v7ae5y1XndVSHJTPhNXABeuqLW7w6kQf6mDqtwouJ/Ww05MqCBggj
         gTWT/TIRZywpU8cg4033xULn7VebSUqR9/1O/lcDdQrcwvDtNztpaD2H9kvELaWnJGke
         LZN09FL6ARwD3GQtF3RrHzizU94X3Id5obzZyelxbBPCn+nbKzxhS1JoWdPMSRjsbyNB
         vaoPgk/YlSikuikTbkFroW5XsFslDclN6ibnf5aXd0xICNaXGNxhOtOi7fejDkIq526O
         M9/a7kcadFZsA7xe0ywuhSDVTWTt/I99j3n9mJgyd0pg3/+Tjop7IgPIyqkyOVLcFvwr
         YlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775056766; x=1775661566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vowzyU0SrHEAHYUrDuyIU9MIx98uSZTg1/2EM+Z8IKY=;
        b=IxXMAm5ClJhq9EIMCJnmQI6FLII0IkiTEQtDwpp2j+JRdWRjqrS6Bt+rkKHHe7PxNS
         5e1KwMErceggue5FPN1tovx/CkpXcAC4KueW5j9LAQ+SAi7pClLK5RJ5Lds96luT5bQ7
         /CFaF2iioTbSOppkBpgUcEMTv8eim0mMLYpimbSKM8Fgxjht5aEMBClDUPp+UVNSCav1
         m3qS4BrJuXCBUJn504LCwxZyiz/XeuBff1PQroXKlkK0QyPT98GcDLfUGD+oGCBVt4b9
         6c6vnEliuw37d3bwMNgPK/3vzGzMerKicpWi3KHM+upm8i2WRJSptqG3YSleYi0TJLEA
         vdLA==
X-Forwarded-Encrypted: i=1; AJvYcCUKekEEvpDIJ8djkTcxKiyt2DYAEzclVkIs84JdZ6popVCz5yPrYlJ64uXaOCOmQa8MViY/1st19Ipbsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBqhUmA1rEa+EKIBcY7TUfNpd67wJXNqqc5K/0JXhyisiNj6f+
	41S5QyBgFznB5koh749R+W9WAeicTpAbVuV23CZxZH2uOQFO8j4ttyiFWRWSdrRHpoc=
X-Gm-Gg: ATEYQzyXMyKQeI9PBcnFNuMRAOzoN3XtRDucu4I53QtTHx+IJYJNjxFfZD8GJrG3TxJ
	wtjH962t7tSGJ1vaJu3nelXqzWHpE8ZzS0sZLHbDg0LAP3po+3J+wJ0KGJasVnkCrHS2GDD1F7m
	zD3pO4hxIEuIw1N+UDJQPvpqyfcBPmSLCO5pPNjnrJ5D/Q1wI1ENC2q9h1pgurXeJrMvIa4LCWh
	AMhGK2dqy6MXwkQAKEcCl/7vwKPe51uhVxKBmJxamJHsqTUmeZBquh4h766v8/wOoUmr3d6A1bj
	UPlq+ZryQL5jGhB+rixI3SGvX7eY0R8pPJK4a9NOOToNNFCFI1ciafZA5zMs33/OonK9tBv1BMb
	RsJyBz8iD40r1quTCvwphLymA5eFuV6BaFfS41CKqINmA76otgeEEiKbzk2/xxkH0IsH0A3y3Se
	nUpaV/vXGLQrNzRY1gmhAsa4FRukm5bH+7h0zXtyEcuw8YiBW4xMSOxKyZZzItuYpkBMLf2nxct
	XTQZJGs
X-Received: by 2002:a05:6820:1519:b0:67b:ab68:b5e2 with SMTP id 006d021491bc7-67fabc059afmr2150025eaf.18.1775056766301;
        Wed, 01 Apr 2026 08:19:26 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68037976cafsm530119eaf.9.2026.04.01.08.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 08:19:25 -0700 (PDT)
Message-ID: <f10b5a3d-33f9-486c-b8e9-6d9286448f69@kernel.dk>
Date: Wed, 1 Apr 2026 09:19:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] ublk: use unchecked copy helpers for bio page data
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>
References: <20260401012401.3653194-1-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260401012401.3653194-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 7:24 PM, Ming Lei wrote:
> Bio pages may originate from slab caches that lack a usercopy region
> (e.g. jbd2 frozen metadata buffers allocated via jbd2_alloc()).
> When CONFIG_HARDENED_USERCOPY is enabled, copy_to_iter() calls
> check_copy_size() which rejects these slab pages, triggering a
> kernel BUG in usercopy_abort().
> 
> This is a false positive: the data is ordinary block I/O content ?
> the same data the loop/nbd driver writes to its backing file via
> vfs_iter_write().  The bvec length is always trusted, so the size
> check in check_copy_size() is not needed either.
> 
> Switch to _copy_to_iter()/_copy_from_iter() which skip the
> check_copy_size() wrapper while the underlying copy_to_user()
> remains unchanged.
> 
> Fixes: 2299ceec364e ("ublk: use copy_{to,from}_iter() for user copy")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- update commit log (Caleb Sander Mateos)
> 
>  drivers/block/ublk_drv.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2e475bdc54dd..3e329906ae19 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1322,10 +1322,18 @@ static bool ublk_copy_user_bvec(const struct bio_vec *bv, unsigned *offset,
>  
>  	len = bv->bv_len - *offset;
>  	bv_buf = kmap_local_page(bv->bv_page) + bv->bv_offset + *offset;
> +	/*
> +	 * Bio pages may originate from slab caches without a usercopy region
> +	 * (e.g. jbd2 frozen metadata buffers).  This is the same data that
> +	 * the loop driver writes to its backing file ? no exposure risk.
> +	 * The bvec length is always trusted, so the size check in
> +	 * check_copy_size() is not needed either.  Use the unchecked
> +	 * helpers to avoid false positives on slab pages.
> +	 */
>  	if (dir == ITER_DEST)
> -		copied = copy_to_iter(bv_buf, len, uiter);
> +		copied = _copy_to_iter(bv_buf, len, uiter);
>  	else
> -		copied = copy_from_iter(bv_buf, len, uiter);
> +		copied = _copy_from_iter(bv_buf, len, uiter);
>  
>  	kunmap_local(bv_buf);

Is this just a jbd2 issue? Because we can just get the slab marked
appropriately to not trigger these warnings.

-- 
Jens Axboe
