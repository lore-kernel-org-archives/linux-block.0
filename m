Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550461A2574
	for <linux-block@vger.kernel.org>; Tue, 10 Sep 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994096; cv=none; b=OMQj73Usj26+iex6W/IncwCB0hF0sdcZoaEsyfm6yJDm1V2nrcSoUP+Ch4Wt3sqc62gUD7QCzD39TnuJH0ZMD+rZD+GCHk4BQ7sLApkufkyFLxhTtMw1+VAmJETCX7Lf1fOmxKWn1tM8sGG1rcdDidowwGZCGh4GxRVaP557d44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994096; c=relaxed/simple;
	bh=exfRCSbeGc10MpECC/7e0V7yMgHOMWsZWQLKlDrqrcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spbAoReDCLHVkvNYjeHMWRHw2tBWcEa3vJEIoBt/PWND0906Zs4GIo5B2TGH5zAETFvNjHlWePrZ7O/7lTTJxyTdycAFte+ohRbZC7Sx49EolFJPN+CB0O1vGiaJ9tcS20cdS5gjKgs0Bmeqag6x7NVZYMEqriNgRlUgibTunwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kUDQAkkP; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kUDQAkkP"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a043496fdeso18798275ab.3
        for <linux-block@vger.kernel.org>; Tue, 10 Sep 2024 11:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725994094; x=1726598894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4y68weuYe8VzZteJIbmlHGx6ZRCIwg+66SDRaOQ0Pk=;
        b=kUDQAkkP9s45KUpgoGEAQfA3JED/wygrDeLXG765VwPj/PmD8mVn5kq+8hxFJo1Dmi
         CbNKYNt87K3HhhRzDO3pTSMMGRb6+1pQxi/sLPkfABYefVaT3kHpR0SpnGEuk6/GzK0x
         oNQ4pPlaEbLj5senKZ8qPsne0dQBqWvun9nkBzBSWnpvPHzu0u/ptXhE+VxfOI+lH7qh
         VX1yMOdpgYP8TBEVk4XmBq99STKwDQ5a+JT21NcFMqmpg3CsDbh6KdcbaXJpAIQi0C1y
         VyZ1cNYCLpUjM5uNhk2y9CYQv+saNLrKoGinYUEzp/wfH8zqp/cTQApAMTn9VFQv+4Uo
         Dv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994094; x=1726598894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4y68weuYe8VzZteJIbmlHGx6ZRCIwg+66SDRaOQ0Pk=;
        b=a0e6/pJpb24hnrUIbryM25/oFsWq2xdMZO5SQfujscDoGX2RODwcy/kOweo1gOXYXj
         bZi8bvbpLMVNmr0EkPavH5ynfpTYrzPPFWIWsH//LEnFmBbVq2GLae1Mu6efGEFsoK9w
         2mWdSdt2k6KaoYfbqHhkVyKmBYcNeDt9miDQ0+W/J9PBN3gWaGTk078o0m6yNXsdhL56
         s5WPBSL8HXDl03xwytciR+Vqil4V66GG6jT2chv9uQkHawyzu1roR4aj9MhFYxi0JHmP
         Z/odONMShChMWRMGui+iUszynYxrnJm02dozt9HyQJUU7EYLEyP/eSl1yh+DN2UOVuCm
         +UiA==
X-Forwarded-Encrypted: i=1; AJvYcCV9s3B0v7uD5BCVtgRqAHsnGtzIGbkxPu+fIv+j2nYcWGfFINn1PAkFQvskr5QO2HFqoBhRm4nPHNFS3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyV3O4JOYhEwG6kYOSo7n77KrwzLONXGY1cfE6vXllzZPTuDrSj
	fnQDgDRp3xcMj+JFh3iRvCbSNb8s1v/NllRAg4vS+prQjcy1H45YcB8g/fTJjOU=
X-Google-Smtp-Source: AGHT+IEbci4bFKk4qyfG7I+1DUOrdPWBQtYa+ssZc5w3NRdfD9WSHDse9oCgXPz7cY+ZMf7HVvKJ8w==
X-Received: by 2002:a05:6e02:16cf:b0:39f:5d13:9491 with SMTP id e9e14a558f8ab-3a05745eb8fmr106220205ab.7.1725994094344;
        Tue, 10 Sep 2024 11:48:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a058fd5c85sm21473895ab.23.2024.09.10.11.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:48:13 -0700 (PDT)
Message-ID: <e6792bd5-1bd0-4a28-b0c9-7e49f74505f2@kernel.dk>
Date: Tue, 10 Sep 2024 12:48:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] fcntl: add F_{SET/GET}_RW_HINT_EX
To: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com,
 James.Bottomley@HansenPartnership.com, brauner@kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
 jlayton@kernel.org, chuck.lever@oracle.com, bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
 javier.gonz@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>
References: <20240910150200.6589-1-joshi.k@samsung.com>
 <CGME20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af@epcas5p4.samsung.com>
 <20240910150200.6589-4-joshi.k@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240910150200.6589-4-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/24 9:01 AM, Kanchan Joshi wrote:
> +static inline bool rw_placement_hint_valid(u64 val)
> +{
> +	if (val <= MAX_PLACEMENT_HINT_VAL)
> +		return true;
> +
> +	return false;
> +}

Nit, why not just:

static inline bool rw_placement_hint_valid(u64 val)
{
	return val <= MAX_PLACEMENT_HINT_VAL;
}

> +static long fcntl_set_rw_hint_ex(struct file *file, unsigned int cmd,
> +			      unsigned long arg)
> +{
> +	struct rw_hint_ex __user *rw_hint_ex_p = (void __user *)arg;
> +	struct rw_hint_ex rwh;
> +	struct inode *inode = file_inode(file);
> +	u64 hint;
> +	int i;
> +
> +	if (copy_from_user(&rwh, rw_hint_ex_p, sizeof(rwh)))
> +		return -EFAULT;
> +	for (i = 0; i < ARRAY_SIZE(rwh.pad); i++)
> +		if (rwh.pad[i])
> +			return -EINVAL;

	if (memchr_inv(rwh.pad, 0, sizeof(rwh.pad)))
		return -EINVAL;

-- 
Jens Axboe
