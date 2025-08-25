Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C1B2F1FC1
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130166; cv=none; b=MNUdRXUFfELMqLX1/PZ7QIa0nUmkl1+elZTEXxx3tIJfuP+TFyqU6z+f79jQ5D5Up9u3ytlO5gmBYdGmooXkblvOyPIGKXEilwUr6N9tCaV6sv3MCtdOtL431FXxNc+Nua/hQIh4ZpZJ3mByfyRqQRI/lTpT6cFAtockoQber6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130166; c=relaxed/simple;
	bh=uTCLex4r+CcOhhp0Jw1xbazf6aFLqhbTTS7XiB9UMvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qc1H84RnOVDNN7bOzB7VvHCtInnlptYmodJ4nG9GbRK1tGIGKGHcXtLTh+ufS95qqmabh8hNvJxYDgiSx15VVovpEZ8PQhtS7x5FoNpKM7ilQcR+xuC+TbZKM8H0OAnA19h0iV+A3SpE1lStTtvL8JRgHrWQr84Y0HYkwSaeaBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Z0ejFYse; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Z0ejFYse"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e66c013e4dso23156845ab.0
        for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 06:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756130163; x=1756734963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+bj16z3bAVbIZz7VeQgjGNlWSy6Fqh6GjG5p/aTnAY0=;
        b=Z0ejFYsePerMbR0np2UCURp6B5gR2IU8MemNn/750ldCjktwcIj+TQ+eOpFyxNZX+I
         EFJ7/MK0LigcIp0tmXqqmeAsSlrZKn/O2XrU6prlpzdTbDr66jYI83uMYNb3l1OlE5hb
         mOZJfnYYQSG5PsOlpQP1AldLBhGqxmDYp6n1KKRWq6e+JOhryXM9rPyk9tsnT6ydx1oS
         4bmE2rJcDR8CMTX3Cr703ifBMy8jYtBsr1mhgKnyO56g9WP3qfQhi23qZH+KCKpew9Kg
         rXTbzKD91M4Cvyl7lsK9gwoSCLyfRM2ifi5PfZu+N0T3358Q94Qk1AFBJIaBw76Ahas1
         Xqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130163; x=1756734963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bj16z3bAVbIZz7VeQgjGNlWSy6Fqh6GjG5p/aTnAY0=;
        b=LyFLv0AVq9vapJDiljoZZonUUdJ0Rez+TfKfRywvFTh0b/S8vVCGqeP1R1J2o3Y57U
         2A57kRnKgGje/fQh6t0/dk/sfFpESGuWBDVM6uLAemu13vPMTPTD0oFnmJe/FM0oKvge
         nbwvKkKh+AvxGVkv1zQoSjquclEb1ZOxbTx+cKkHsye6+prZpuQgwPTksZCahIR8znnc
         gt8MNFDwJbeyjfeIp0jyleLtB2O2e0lGn1/QxWAfasLrHE2K47BktJWL57hyqYheHE5a
         Y53tsilaim/fC2J6YRXf6U/h71uCaOCnogOt0gUuAGVke0C3kHk6cTc+CZh4CTSFE9xa
         W1cw==
X-Gm-Message-State: AOJu0YxofsAnOjIePn70iQGOscMJv4oKR9/7DMAMLRksUOQ6Udl7miqf
	AkadJA7jlJY4PgzKpduxPbvle/veJh8sMuVOEd2sDdoiJ/08u7oHhSu1LgyHl+UCC68=
X-Gm-Gg: ASbGnct/zNWQY/Lc9NFOmOoRfs1aSrE4zRxYo1hGL4WcV7m7JvwEZmsEfh0uhUhP+No
	1vvZrr4XdI4108lJ+oevJqAexLpNI0LQ53oxQMxClGlLluK65RjsVMgGVTylRHKBM5K+t1sxivy
	ZhjgoqbNLsBD1+WzCJHDZl0HDuFtPbYTjl/gMdPt1RQSfAmNdh+wUfvPVL+3/Ez3t8kFcw49WPF
	eAmMpfDhtZL8TUXGf6bY8GHOD8+t3hUlX5C0SScWTof6a0MI8+++aaqGfWHJYc1eNw86QsjbbM1
	WSO6B7H9mTpnCjK6dd6y7OKMsRofI2J2JjEVcP9gN9Fk3ku772RF4LfLdfNjyaugSIeVCvHW6Zo
	k2v9LLaIrb73DQBOq6QeW99eJNAFzpA==
X-Google-Smtp-Source: AGHT+IEiq20Lr6w+nHnroyq/OSDP6bjRqBGwYdseaIsmpNKgrJv38nh2DaKDNtgxmvXhu4eboRHU1Q==
X-Received: by 2002:a05:6e02:170d:b0:3ec:4b19:1cff with SMTP id e9e14a558f8ab-3ec4b1927b2mr76913505ab.7.1756130163389;
        Mon, 25 Aug 2025 06:56:03 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4e45a717sm50317145ab.31.2025.08.25.06.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 06:56:02 -0700 (PDT)
Message-ID: <36f30d8d-02fb-4579-b527-16da24cdc856@kernel.dk>
Date: Mon, 25 Aug 2025 07:56:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] loop: fix zero sized loop for block special file
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com,
 hch@infradead.org, yukuai3@huawei.com, rajeevm@hpe.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250825093205.3684121-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250825093205.3684121-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/25 3:32 AM, Yu Kuai wrote:
>  static loff_t lo_calculate_size(struct loop_device *lo, struct file *file)
>  {
> -	struct kstat stat;
>  	loff_t loopsize;
>  	int ret;
>  
> -	/*
> -	 * Get the accurate file size. This provides better results than
> -	 * cached inode data, particularly for network filesystems where
> -	 * metadata may be stale.
> -	 */
> -	ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
> -	if (ret)
> -		return 0;
> +	if (S_ISBLK(file_inode(file)->i_mode)) {
> +		loopsize = i_size_read(file->f_mapping->host);
> +	} else {
> +		struct kstat stat;
> +
> +		/*
> +		 * Get the accurate file size. This provides better results than
> +		 * cached inode data, particularly for network filesystems where
> +		 * metadata may be stale.
> +		 */
> +		ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
> +		if (ret)
> +			return 0;
> +
> +		loopsize = stat.size;
> +	}

Gah, that was pretty silly...

-- 
Jens Axboe
