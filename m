Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF239E164
	for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 22:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792362540; cv=none; b=KhBDouZs82ERghw+Q/lugTq8c9HjJEizJpBzlQK6+N6Xnwy5ZFgoVgy0EYkWopLyDeJMKxk8DilIQcl1EyoFKyueq8/yC/C56h/8jm225pSM8XaaZEdT+Jvt7EjPit/wP0SH50QH0/VgKFATcPngUNDMJb15IMvZTh/pToBbj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792362540; c=relaxed/simple;
	bh=DfupwPSZCin6aC6UoR/hMPVmIOg1Ka92Z2blxUP6B8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hR6/w3uYg4iShjOAaNEoen5losRBoqTPzu36RSjFnW4J/tLD0wKa2FcsFlCWH+Y05SBki4KI3O+W1KLcsZRze6SVLLhaP4FOe16Y1UzTT7X9zPX2rqxAqXfL/i5ZUpbMaBQncgBdK1UnlO/GTBCuXKs1DQfK21F4R9JHBDffQkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0cibDtL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0cibDtL"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e011d370dso1235647f8f.0
        for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 15:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792362537; x=1792967337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YuPuYj2KyJGah9hmABQQctga1s9wEhiM9oVruD5npRo=;
        b=j0cibDtLxh/izLswrWPSsQZxFjb5L4EMPQBgcSnjGDit42gu1Pm5oWUsCrfuFTx8nd
         wYdyunGN9El/oKYgG2w3WAYm0sk7eApe6170A44Hd9mgeJuNdh1e/KU4iIOUMEAXzaU3
         VNCxgmRqbBuQMK1tFC8Ss7wwT5CXv6gb+uHeepZrZvqLULJeGZbe416AFBo2XlQDlYK4
         43A+vKFjj7e/2eSEWeetWdnbn+6n4rO33x0NXv3tPPTW37QdsurVr5v5j7d0s55IMXhA
         W9bE69ocS128IIfUjS4jY1tNP2zNYItTsbpAaNtwkQR1T27hfeK4TocFTYZc22mWLe1T
         cdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792362537; x=1792967337;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YuPuYj2KyJGah9hmABQQctga1s9wEhiM9oVruD5npRo=;
        b=zpMIQTiOz4h7DmaXLyHiUPBHFjK+CRFhYnBZudLpB6yZU1DbrmnvBSyYH6HsYEaYkx
         H+hf4DN12vXBG6rfXEsNDxOfhY01Ho1k3Y6hX/1Q48Q6WVGz6B7YXU8mnQJrd7h8ijvG
         dCb/6BqLB+rocPo7jBXSppSjGC+UfotWK/S8Qlt2Vnt/3Zbdr4gGM03a3kKwWLd79sEf
         4r3mHQVEMFz8Km3pHKKppbeZN9rkogcWZ0kihBVkE+ZEtEh2hm7VLD5Ne1GBjAQrveVl
         xLLPaXCa1uOcppDrcGbz5imMepBuS5JER0XglhmO8GrfLnesDl1jZQPf7qnL6nweE+F8
         OgwQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcCsp+5WYkrmzVTMUIU471wJH+wvDBJPHlPTpX2llcC/UrWt5s/TetBOg95ca7Mlz2vXe/SoipA7bDbw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIy1dIxn9jH2OWbWK1jLUW26QIdp9ZUJpKoXHy1Uc7WxDVI6wmW
	ukr/PU3KLvgxcZLpUXMblEADEz2M+XmHKviuUoRzLjqq8aLqQBbZsjZjSGlXDw==
X-Gm-Gg: AYBFou0ZYvRH+IGV0jj5VOdjkDrRkyyz71alwuBbcI8n/76Diu9zEVxcLC8F74G+5cN
	AfbNrQLGO7i468GzB45P/1fLAL9GsKf7xBhqHEsn7ZEOhYwSLi6pfaApgTrSkFxwv4j1A7bofPU
	jY1VgUYl3wNBrz4N8RpB4mztkvRhoCE7q5ot5YVtJgayZ7InDhDk9QU5PRgPy8lidZAKx0RLMT0
	UowF1OZhrAo+tHUDLojEUw2/JZD4IhwEgHvLv/7y72H7tcst+nie1FLLcUBDMZbPspUAtWqIJiI
	p7IOffM/Jn1GIH1bHXucvWJEHh3ufwCkTvcXZEbRoYm+/GLdkInhstJmckR1jGVlGiBwHG4VSVz
	9/GdcgL8w+Jk5JBu9h1j+5WLbDVE32vvf1Qj9SwKoxyh2zRLOYd1I37llCVSc05PcHNY/pLbgqA
	dqu8txxFJ/O9PXo56oqZivFeHH21zzcUFqY0h1uCz0T0DZp0KboNy+IAULpahL/KwL/N2r4Z55A
	Iq7EQJ0FbOn+hN3YTj3vRhywc3j4bk3Vj+VZUTX9KAb7cViKTZV6UkxXa4//HJDFFoe+AuTIRtJ
	Cbx4Mxn3HynVvlOqnuNnYJ1y4wvWh1a3VmJ7FS5jrcJDH+cH
X-Received: by 2002:a05:6000:2f86:b0:48d:fd0e:a117 with SMTP id ffacd0b85a97d-48e079759c0mr14316716f8f.5.1792362537508;
        Sun, 18 Oct 2026 15:28:57 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f5b2dsm20677990f8f.31.2026.10.18.15.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 15:28:56 -0700 (PDT)
Message-ID: <0fe67d0f-54cf-4076-9e4d-ad23d05e7099@gmail.com>
Date: Sun, 18 Oct 2026 23:28:53 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/4] xfs: support dma-buf registered buffers for direct I/O
To: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj1072538@gmail.com>
Cc: djwong@kernel.org, cem@kernel.org, brauner@kernel.org, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joshi.k@samsung.com, anuj20.g@samsung.com,
 nj.shetty@samsung.com
References: <20261016091919.971295-1-anuj1072538@gmail.com>
 <20261016091919.971295-5-anuj1072538@gmail.com>
 <20261016092855.GD23141@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261016092855.GD23141@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/26 10:28, Christoph Hellwig wrote:
> On Fri, Oct 16, 2026 at 02:49:14PM +0530, Anuj Gupta wrote:
>> From: Nitesh Shetty <nj.shetty@samsung.com>
>>
>> Add the init_dma_buf_io_ctx fop for XFS files.
>> XFS picks the device and calls the iomap layer with
>> the relevant device.
>>
>> Refuse the iterator from every CPU-copy path: DAX, buffered
>> fallback from a -ENOTBLK direct write, and read/writes
>> without O_DIRECT.
>>
>> If a file is switched between the data and realtime devices
>> after registration, the block layer cross-device check refuses
>> the I/O.
>>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> ---
>>   fs/xfs/xfs_file.c | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
>> index 426a67b813a7..f97d5acfaf68 100644
>> --- a/fs/xfs/xfs_file.c
>> +++ b/fs/xfs/xfs_file.c
>> @@ -340,6 +340,11 @@ xfs_file_read_iter(
>>   	if (xfs_is_shutdown(mp))
>>   		return -EIO;
>>   
>> +	/* a device mapping can only be read by a direct I/O bio */
>> +	if (iov_iter_is_dmabuf_map(to) &&
>> +	    (IS_DAX(inode) || !(iocb->ki_flags & IOCB_DIRECT)))
>> +		return -EOPNOTSUPP;
> 
> Maybe move this into the actual methods for dax/buffered instead
> to avoid extra conditionals?  Same for the write side.
> 
>>   
>> @@ -1209,6 +1219,9 @@ xfs_file_write_iter(
>>   		ret = xfs_file_dio_write(iocb, from);
>>   		if (ret != -ENOTBLK)
>>   			return ret;
>> +		/* the page cache cannot copy from a device mapping */
>> +		if (iov_iter_is_dmabuf_map(from))
>> +			return -EOPNOTSUPP;
> 
> I suspect these random fallbacks are going to cause trouble, but
> I'm not really sure what to do about it either.

Folks did mention it to me before. For a slow path we can try
do something like amdxdna_cbuf_clear() does:

dma_buf_vmap(dbuf, &vmap);
if (!vmap.vaddr)
	return -EFAULT;
memset(vmap.vaddr, 0, dbuf->size);
dma_buf_vunmap(dbuf, &vmap);

But I can already imagine it triggering some interesting
behaviour like buffer migration, which will be too penalising
for things like clear on a hole. And we'll need to be careful
about deadlocking here.

-- 
Pavel Begunkov

