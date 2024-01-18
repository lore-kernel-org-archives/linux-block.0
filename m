Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9D11E520
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591234; cv=none; b=qw054uRXM+m9aIRbEwfJbYUWs90Y0j/cJrFwIIcn6TGyjrnNSb0TOiTCNiVAzObl66brtI2+gy0ir2SIjtXE9WUKsZLvYE0POG3154OUNNGtaz+NFgZ/CDgIoQ892McbbORu4NpG3sTTL+37OGz6EGo5SthroyH2VlGGvNn0Elk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591234; c=relaxed/simple;
	bh=ipuXZIpkqvyoFi72VtI54EQu47YsHMypO7nBKibnIA4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=LBdNALRfqmw3761/BbEGI+HwB8RbGVTGbzpkg8tzWmYNw1nujcebtdK9gWjLjijvlGHWxBabsweIq7qT3LBrOH1kLmDfIHP4WAgJKNpeciI4Tx+qGg3A3AJINnfIXRrnD3FVHJbteQi9BiHuABkITD4rifRbTYeKJqR8XeM+PcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cIB2KqO4; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cIB2KqO4"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-35d374bebe3so9805985ab.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 07:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705591232; x=1706196032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQJTwYjBW+C1ky0uIeVi+0jPt7nyJT8dC8zxjuOj6ec=;
        b=cIB2KqO4vffUtyplPlw1n4LQXrkl5aCbQ7V/95f5HPi5yAtFbPvUWYmIx2LqkjdMaA
         3Yf7WhgzZZk4JP/1Jf0lTMpBNrNEw10Gqpv/xxc6hqW1xiv4y7bJ158o8l/zViv5beGn
         gcOHa0p+BeAaP6qtgf96XZ0chlKZCOyqox8kIIVCxpSjzTFuCntXpNMx4Nb3bl4alXxY
         Ub3dkVXXDsYKH5C4zZXtUbjTgtY/54wSE0VQzZAg+bt5wUmvPAnJEzgoLHc74onplprv
         +/CXOaoB+X7H4cBj1eObmSyb8lIRkXD8OJyDYGGkSGtuDW/68MUUsSdOW4OCavMabrqh
         t1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705591232; x=1706196032;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQJTwYjBW+C1ky0uIeVi+0jPt7nyJT8dC8zxjuOj6ec=;
        b=UHyopr1Ux8B3TWlVgC/5cC+7sK8pAbEvnixQPSSBRuVHiGsgJ/iYqQ0kBW8LKUODJT
         fe76pYHD3roFa15ZHnhQJsnl59MKWgzv+0BTtqVEZMduNlL2eh9NW7EDFe+VCt19mQlq
         f9SiQG7ZrNH1JWqW64MTEtcLJE1/q+jRvSXDEVmqTFVRxjsxjwP1nwcvzJH4szs3egLk
         P7JX4btT/Ukt7YQyyqxiXJ+2c1h7dfhT8MFE4zXHxZZpNrenqgOzVazVyaobOsNawekB
         9rOawlXf4GLaLf7wi6BwRd/VbGy3ZQBxC9Bz5a3OXVquGoUIuPHzvD+TDQr5RK3oAcih
         hIoQ==
X-Gm-Message-State: AOJu0YytzY0+iHYJSJtBEwdItdGJl60CIHBCE2lUq0jl3FzHl1pCIYcz
	eZYn3s6Zl6jYeOqfq8+SiWMnLYGRGSse9ZFWE4fd6cvNMtHzvlVuNnWJnMHCr4w=
X-Google-Smtp-Source: AGHT+IHvndeo7LZc4yj9jDyfvF1A5dB4m6oeKGrshKMFpAI7qE3NxRlMQpEHbdCVg05kBxRQBmIU9w==
X-Received: by 2002:a6b:e305:0:b0:7bf:7374:edd2 with SMTP id u5-20020a6be305000000b007bf7374edd2mr2137744ioc.0.1705591232346;
        Thu, 18 Jan 2024 07:20:32 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y30-20020a029521000000b0046eb228a0e7sm655932jah.26.2024.01.18.07.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 07:20:31 -0800 (PST)
Message-ID: <f6e687cc-debd-4864-901a-fb35be9f2adc@kernel.dk>
Date: Thu, 18 Jan 2024 08:20:31 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Move checking GENHD_FL_NO_PART to
 bdev_add_partition()
Content-Language: en-US
To: Li Lingfeng <lilingfeng@huaweicloud.com>, allison.karlitskaya@redhat.com,
 hch@infradead.org, yukuai1@huaweicloud.com
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 Yu Kuai <yukuai1@huaweicloud.com>
References: <20240118130401.792757-1-lilingfeng@huaweicloud.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240118130401.792757-1-lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/24 6:04 AM, Li Lingfeng wrote:
> From: Li Lingfeng <lilingfeng3@huawei.com>
> 
> Commit 1a721de8489f ("block: don't add or resize partition on the disk
> with GENHD_FL_NO_PART") prevented all operations about partitions on disks
> with GENHD_FL_NO_PART in blkpg_do_ioctl() since they are meaningless.
> However, it changed error code in some scenarios. So move checking
> GENHD_FL_NO_PART to bdev_add_partition() to eliminate impact.

This looks fine, but it's identical to the one sent out by Yu two days
ago. Hmm? Who's the proper author?

Adding Yu.

-- 
Jens Axboe


