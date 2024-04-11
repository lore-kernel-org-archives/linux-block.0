Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D600347A6A
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853884; cv=none; b=qx9ThSYBhocM/y7dgFLRGGGsShSaWCP2mrK3baNy7szMeXzpy3jMyi7DXrFjbWW1d7spFtWAgHg8//JYyNCjCmmWzlvO6gZI36DFeYBnKNJXhL6xy74PFPEJA3sv8mOi4h9WoSNw5XEedlubKi8h8o1q34dcZP5IldCshltMJ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853884; c=relaxed/simple;
	bh=UnBJFcPPvwWzi0FfiqnRkFfUQdXHP/a35MX/pq5LyAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpScRiKzJN83gm0fyrO/NaxxkiecoXz/GtGWoOtwYq9f+lYoMP9QqVa+jin2liZcDRsxmKUxtQe+hWkRiqobh9BZB7JjAWLFAPIKdYc7IwTZStTLV75Sx3i+UDQfShSnDmw/r8rTFhMrgL/UAKV10WW66EpHQ9GIK4NSRnnBEyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Fm6vMQyb; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Fm6vMQyb"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so65539f.0
        for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 09:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712853881; x=1713458681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tbctDn2ebNI1qx8fESTV2MUnI/LKkzIT0RDCKmLmiV4=;
        b=Fm6vMQybnvgWX4Zj1birgEwefGXabexCFNFeu3nDiW+dKJaQ6x1adpEq/l8hsFAY4X
         SdCLS4nYpxVIrk7CeO7ZxsigL3KvAYhEPuskgc/XTwCvP+kCLnG4VMvvxnzjA3vICJrR
         T1ikmXVTfcmTdhUX/q85ZjE/gE8uEWv7DJOtjGKmYRtkvUZoKkqoLhC2i9TOkA+q+6ty
         ksm497BdKaNudTDbp0VEzSGCz33S1a/XNSmL3+YB7RNLJfO7vepp7KrdolnJGvgaiFXI
         J3pegBmm+LTN21Tu0KKtTgmQj+9sAyRTzx17eo+0w/NL8VrMtiYKDsF3TLXLyXSk/UT8
         2FSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712853881; x=1713458681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbctDn2ebNI1qx8fESTV2MUnI/LKkzIT0RDCKmLmiV4=;
        b=d1nnx/pze7FYnY1ok3BJ7QWL1ldMULmXWaOofLKE6Z+7HCUmnpEM41mX4H+hOCPJr2
         5cAthQN0AMRBTFOMoavbFaBv4oxMioQAtirI/W7h77UpG91rT1UVuczuFM5i86eQOy+B
         HLQiCa5nOW2AGtPqcrnQd3h4INR3TNL48bWb7mOacMBkl2OHpECYMChS87nLAG+kzSsE
         RbmDzy6DzYr69MOhrU4/UGMtm/UDnQO5OddA0lZKg3zs3F4/M4zN3BqN96x8Xk+d694b
         C7f6h5XJ74h/XdR+f5Oa/7WXg/sCtF40fKNaJgwjz9CVH9flPBq1XBCsroAbWYwyOR1y
         XWnQ==
X-Gm-Message-State: AOJu0YwgndRa6WgK/FecMR+rkvz/AU0ZZ63WsIuOepjyFooXT1eu+myH
	LMT0WUZE7oUffIUKKFzhO0TCvGN2hK97MhJfc9tbTQ2KXtPXLStfsXXLuiSvhO0=
X-Google-Smtp-Source: AGHT+IEUTrM6OumzLR/N7eIq3bgozrwf1Oz1pYJe82O+IuxY0yootlN+7gFIk0CkUsJh86R4wYtIKA==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr395259ioj.2.1712853880943;
        Thu, 11 Apr 2024 09:44:40 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ii8-20020a0566026b8800b007cc7612f093sm492800iob.43.2024.04.11.09.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 09:44:40 -0700 (PDT)
Message-ID: <9a4f8738-6ad5-407e-a938-83395aa1df4f@kernel.dk>
Date: Thu, 11 Apr 2024 10:44:39 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/2] block: fix that blk_time_get_ns() doesn't
 update time after schedule
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, johannes.thumshirn@wdc.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20240411032349.3051233-1-yukuai1@huaweicloud.com>
 <20240411032349.3051233-2-yukuai1@huaweicloud.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240411032349.3051233-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/24 9:23 PM, Yu Kuai wrote:
> diff --git a/block/blk-core.c b/block/blk-core.c
> index a16b5abdbbf5..e317d7bc0696 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1195,6 +1195,7 @@ void __blk_flush_plug(struct blk_plug *plug, bool from_schedule)
>  	if (unlikely(!rq_list_empty(plug->cached_rq)))
>  		blk_mq_free_plug_rqs(plug);
>  
> +	plug->cur_ktime = 0;
>  	current->flags &= ~PF_BLOCK_TS;
>  }

We can just use blk_plug_invalidate_ts() here, but not really important.
I think this one should go into 6.9, and patch 2 should go into 6.10,
however.

-- 
Jens Axboe

