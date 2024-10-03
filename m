Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E3238C
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 01:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727919012; cv=none; b=gERjL8+tC9XSLUrcV5wEdp35JLi/B+j9PTnFsnnfH9DkLgXws1ueaQECcAk+Zo+BKKxLR1cD3Quuzay7fHwzS12eCNaw7PMkwlgEAmJLxjYjyhOnEfzVpWb7rEqIBC9r2kzSPr44SRV0pIo+6i6Rsgu0h+LFo4obFtVKg7XA/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727919012; c=relaxed/simple;
	bh=SfcgjggtAaylP8Sd/cCQqkth6PFQ8CTQBIK16jGcmtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+vqOj7tD3vZqYABRvGIKijQSXMUzlXyi+fygyWel/cuH4V3UCsM/ieRfrxV20JCwahl5LcxPiS7/88+F50ZnIxTRtS8HdROWeUzHZudCw8raXlCyi7z3dBUuibHctY+UnlxjW+Bhj0wKEUOUjXdvweOCfgEg7OQOkhqdof6DJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jPqrRek1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jPqrRek1"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7e6bb2aa758so151117a12.2
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 18:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727919008; x=1728523808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2jK1LKgHNGrOsT9T25ivUT6cmVd/BgRHk791AuwXxE=;
        b=jPqrRek1U8HseDhgq7WVsQVI/EmHTw2JivUMQeExFl5zb5JuV4T4/LXHJtSlIpxkSu
         XN08RATMsJF1dD0yW555AIXOZMM6nONUIoiRxKyh4YMPSuj+yMCmw9eX5lMLv3b6RHdc
         uy6qUhZuzD8UYPca7Jw61XZeKFNlamx//0ke6leLYVabBzMqsb8/uTBKCFPJp8qa6qoD
         fBGmBvREZyoYMcYflkn3EfyMXn4LCsiBR1pCuTcTT8plyzXbaBe+ps9Uj9VqXlzNPR9h
         8XTLC0n+XLaiYP+kik4hFN78SiwtB+gJ8bbQOmKGW36IddhuT4nNygbMit0AndbS6InW
         U0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727919008; x=1728523808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2jK1LKgHNGrOsT9T25ivUT6cmVd/BgRHk791AuwXxE=;
        b=KECk7ayys57PfqsPflbltgHtOMmznu5F7LBPFGCRJeW7tuiMlKM1JkZHoqtjHTZ40T
         vO2K3yDgB04sqUMMwKvgNekUUgaHXl9+wI3clzmCKn19R3MOTsImt0IwrPq73Gv1MIhj
         ShRlUmr6N2gOtzIOaKV1cUIOUds1p77H8pTd+y3dJDgFJvjgzEqFJQxGNQnPNielc3k2
         NJDYmCWQwcneYYNs3AxWAjnSkZpv0nvjaI0IPu0iq+aZBs8pL7tfkdC90yqQp25fO6cT
         4J/SAjM6BKS6oTHEzlRjdz4KB4C+2BXvR73dT2zgcs0rChr7K2Jko0dg2wURFiSFK0bt
         HMAg==
X-Forwarded-Encrypted: i=1; AJvYcCUnJhE1tnK9qNsDyTLyDW5ZByOnRqqpYDP30myl+bD55y1JazgD5usUBIJ4kCo3xYD7LBPmgKPADmUzfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrQdVLsVKSBFE64w430yBVuq9AvmM9nJuJNlUxztmpeYHXxSZ8
	O2FkrXeIFjNH+p4TZfOtIwQ8svqK01yZQPsnDZ3ET8ZI7t3lI4nnU7mVxBiFHxEIJ1ifPnZsMgI
	H8lQPvg==
X-Google-Smtp-Source: AGHT+IFo77QGE3tiMpqLW5wpPALAwDn2zErn1iJ0lRBzJMN5mkgA/9QJ2AKOq/zTWLnD/39SSmFyTA==
X-Received: by 2002:a05:6a20:9f45:b0:1cf:ff65:3c30 with SMTP id adf61e73a8af0-1d5db1b708amr6951797637.29.1727919008304;
        Wed, 02 Oct 2024 18:30:08 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f76f072sm2370745a91.18.2024.10.02.18.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 18:30:07 -0700 (PDT)
Message-ID: <11ac4a76-0a54-4d30-abd7-0b97f5c8bedd@kernel.dk>
Date: Wed, 2 Oct 2024 19:30:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: enable passthrough command statistics
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20241002210744.72321-1-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241002210744.72321-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/24 3:07 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Applications using the passthrough interfaces for advance protocol IO
> want to continue seeing the disk stats. These requests had been fenced
> off from this block layer feature. While the block layer doesn't
> necessarily know what a passthrough command does, we do know the data
> size and direction, which is enough to account for the command's stats.
> 
> Since tracking these has the potential to produce unexpected results,
> the passthrough stats are locked behind a new queue feature flag that
> needs to be enabled using the /sys/block/<dev>/queue/iostats attribute.

Looks good go me in terms of allowing passthrough stats, and adding the
0/1/2 for iostats (like we do for nomerge too, for example). Minor nit
below.

> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index e85941bec857b..99f438beb6c67 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -246,7 +246,6 @@ static ssize_t queue_##_name##_store(struct gendisk *disk,		\
>  
>  QUEUE_SYSFS_FEATURE(rotational, BLK_FEAT_ROTATIONAL)
>  QUEUE_SYSFS_FEATURE(add_random, BLK_FEAT_ADD_RANDOM)
> -QUEUE_SYSFS_FEATURE(iostats, BLK_FEAT_IO_STAT)
>  QUEUE_SYSFS_FEATURE(stable_writes, BLK_FEAT_STABLE_WRITES);
>  
>  #define QUEUE_SYSFS_FEATURE_SHOW(_name, _feature)			\
> @@ -272,6 +271,40 @@ static ssize_t queue_nr_zones_show(struct gendisk *disk, char *page)
>  	return queue_var_show(disk_nr_zones(disk), page);
>  }
>  
> +static ssize_t queue_iostats_show(struct gendisk *disk, char *page)
> +{
> +	return queue_var_show((bool)blk_queue_passthrough_stat(disk->queue) +
> +			      (bool)blk_queue_io_stat(disk->queue), page);
> +}
> +
> +static ssize_t queue_iostats_store(struct gendisk *disk, const char *page,
> +				   size_t count)
> +{
> +	struct queue_limits lim;
> +	unsigned long ios;
> +	ssize_t ret;
> +
> +	ret = queue_var_store(&ios, page, count);
> +	if (ret < 0)
> +		return ret;
> +
> +	lim = queue_limits_start_update(disk->queue);
> +	if (!ios)
> +		lim.features &= ~(BLK_FEAT_IO_STAT | BLK_FEAT_PASSTHROUGH_STAT);
> +	else if (ios == 2)
> +		lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_PASSTHROUGH_STAT;
> +	else if (ios == 1) {
> +		lim.features |= BLK_FEAT_IO_STAT;
> +		lim.features &= ~BLK_FEAT_PASSTHROUGH_STAT;
> +	}

Nit: use braces for all of them, if one requires it. And might be
cleaner to simply do:

	lim = queue_limits_start_update(disk->queue);
	lim.features &= ~(BLK_FEAT_IO_STAT | BLK_FEAT_PASSTHROUGH_STAT);
	if (ios == 2)
		lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_PASSTHROUGH_STAT;
	else if (ios == 1)
		lim.features |= BLK_FEAT_IO_STAT;

and then I guess the braces comment no longer applies.

-- 
Jens Axboe
