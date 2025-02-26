Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9999919DF52
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598575; cv=none; b=Rmm1GHFDAn3ImctN9R1BwoLv9EaxYW0XJV6WakJtrtihtARFGF/GL2SIyxGdKprO3rCZ2g/ZkMo4fE42sSlDtoeWgcrB3DT6epdN3XJDk66hXjuPSRiblqOfVNBd9NulhM8PJISjS90a3uz17ksUz//Gr05XsUO06bwBHCLSsgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598575; c=relaxed/simple;
	bh=7bcO+2fNVcIn6QQh8s6i3Sv8pSilFCdjl4g43H0pfVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lybwLg1CAr2pnhedQC3DCiPb7EGbS1aPnZHXVNxtqesISsKoHjXplfnTgqG9T96nsctnnYXaRH8CrLITx3wqThXoCAwtChLzGkv4aWm60myiYkGGTYwn+RWhob0oRh5Q7MDiiEBZ8N93C4oWIl8FLFV2dr1+xC2NDhUZx6Z9klQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3U8oErE5; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3U8oErE5"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d03ac846a7so771475ab.2
        for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 11:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740598573; x=1741203373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZO9STZ95sF/hThjh2V4XP8IUCqoQU8S45+6Tzt1P4U=;
        b=3U8oErE5utlheiIpRIHDijiwKxsHx2JYJ7YG0AXd9sxbcd2BcWlQFHRzT2H4PcRkR2
         0DQqvST3zuJSNo+YJmHFkrMmYLt6BhOCHd/kyOh6cltwLiJ5c84+5uPslirO9FFSOJQ5
         RsoJB1FoXxPv28//1k8JLoMKKkzXUHWX58RmRBmdJD/2WKlO9m9YHPbMRlCFbWWX8E0G
         dObGwqoGe3DUgvDG4Q7VVHpWgTcIVjCbKuBXunMdA1ymsOPhqEfS30IzP5+RewPOUtex
         33qLN2RPooKv439Z8uCP9qX8Defaor2+yI5MxJuQoE0cMcgWT6vmOB/T+FV6lVm9+kzx
         meKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740598573; x=1741203373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZO9STZ95sF/hThjh2V4XP8IUCqoQU8S45+6Tzt1P4U=;
        b=nP2t7ujcGiVaw+SE/iIWTPX1BFgOS5ra9usOVnrvnraS3njX4384iO75WswE3+YPdT
         sU1zCrQ7lzk6j9Ug0woHALetpNWEeL6V95n7Bf5eTrr9sW4osrzoJCFgwqt6DMAX3X/A
         Zcw5MnlTAbgYp8dM3zlW8UYT/mbSiSrxMWJYqd8qLyUOPpuF99FJmYHwcpjEFQ1iEwbS
         P4W2O78MLjMxnu+YPSTf+FtZNqGMrlmMY4li8Q8ck7KfM5ZLvcp9NdyfM9t2YrC/jVhr
         1iDUHi5mk/T3ZJyaZaIb9e9JoX/dbdEoXYoWegP616ZEUKW7g6QWBoNT1bUL6U+QIzi5
         tB6A==
X-Forwarded-Encrypted: i=1; AJvYcCXcF94JD9zibv43KOjd+SA5Nw21raDiGyg8oJMH6GxrDI8PuWvFcFSuwCCBKV8E0EpztD92lerwxgVLkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh4gAGFrzbd+pYLx2paM8Dcrf6ciqpQ4lwBdt3cTlcA7WaBZ+0
	gKFQ99N1YNIGcJWuSGH3cAxQXiAalJJIlu64BRo16zmwp18PUD7FEmY70C+pDcU=
X-Gm-Gg: ASbGncua/38Z/mUpBrxKyl1QJfYZtjeudjQIDoktxPJh6RK+eVG15o3yTUNHJMMpeBA
	KUCbLX8xm8ZEdhw2MOswqd1wjyKojBX9pVogZHNXQYh1tQc/2qdRpF9hflHA1+GDUhMiTagykyd
	j99P/xTTJSjlh6A8iTELHi2/wcwTG2K8TaOXbA7w6vZtwGckuuqrmtaSg2C3oz+dyquvuSYOaJW
	t2vHy+Ca4WgD+ZzRtcF9o1thuq99oEQAj2Amn9XvRExX1/T1vd0gkjgTrAwT8A/kfm3xS6etlpx
	Qfck9zw2sEB/c3Emu+djkQ==
X-Google-Smtp-Source: AGHT+IEbyL3881tCFlSZe9P+BIU2SFkXwfwwPxd72T/h1DgwPnDSWSN6qbGSXbtQaoY0apPWHhil4A==
X-Received: by 2002:a05:6e02:2148:b0:3d2:1206:cabe with SMTP id e9e14a558f8ab-3d2cb52f7cbmr218812255ab.22.1740598572682;
        Wed, 26 Feb 2025 11:36:12 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f04752dd55sm1043887173.113.2025.02.26.11.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 11:36:12 -0800 (PST)
Message-ID: <83b85824-ddef-475e-ba83-b311f1a7b98f@kernel.dk>
Date: Wed, 26 Feb 2025 12:36:11 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 6/6] io_uring: cache nodes and mapped buffers
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
 asml.silence@gmail.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-7-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250226182102.2631321-7-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 11:21 AM, Keith Busch wrote:
> +	return 0;
> +free_cache:
> +	io_alloc_cache_free(&table->node_cache, kfree);

kvfree?

> @@ -548,11 +607,19 @@ int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
>  	return ret;
>  }
>  
> +static void io_rsrc_buffer_free(struct io_ring_ctx *ctx,
> +				struct io_buf_table *table)
> +{
> +	io_rsrc_data_free(ctx, &table->data);
> +	io_alloc_cache_free(&table->node_cache, kfree);
> +	io_alloc_cache_free(&table->imu_cache, kfree);
> +}

Ditto

-- 
Jens Axboe
