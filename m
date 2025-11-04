Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A91E1E1C02
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259801; cv=none; b=InhCOibP9WHLWeaRlNT/NpiHWt7mFkCL71GzdnCtPUSdtghtDIRlEVzX1wWQe5freGzDzXjG6auEpI7MI0NFyDvqqdyaotV1NgSCcZnZRhpwQF/Xiv5yeKfJ8G0wkt/JVaorzURZK+ok5/a7c6XC7eT50tQzq3j4kXicjYdLvJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259801; c=relaxed/simple;
	bh=OY6wmS2cjaoU74ByE55r3CESyyslJw59xMwwDbCQcNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ubs4FThnRfn3D4wn3/Jxb2cddKxZabC6LUJGzIMGEcERXzL2fJ0CFCsJrjwVDuqGUKpDWONOOSbIfnmY2a/zTYduoAd9i6o6siRu1ixuxzGfZHudcODzqi02+PL6cH++ntYOZkh4/pTWFxWqJ4WAZcCZAIDYf+TtxMo3sdT9GE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0D1kAcx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0D1kAcx"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-340cccf6956so1949128a91.0
        for <linux-block@vger.kernel.org>; Tue, 04 Nov 2025 04:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762259799; x=1762864599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuYa8Vyc5g36zBbzEp6ohHNgPOjM03c64dcRTIxk/XA=;
        b=e0D1kAcxX/U2JrPsU6OZoYyaStafkLiLKMsT4xfwfjtykF5wtNbe3WZJTO3BsLzqY3
         k1FpVVc4jeUoX6wQabLcMaozAJud6YY0SDId2ZIxAi4mxaSlR/7yzYza737NALtoamdM
         AvsVKHu6SxYAS5LDjDB9lCBLmLHVLWCK+83xQ8Sdbv74fdW0vYl96JadzvHRxklYsw7q
         SqcJ7+FcZ+u55vuyZQh0VkmkLqk1wPbyYMUv9kwKOHMSIn8uv5eu/0x4iiSQveQ4W6Nj
         H9aT0tsu8HNI1FL4+12ggVwrzv1N/lEUwb0IAFhtpFyvEIG5ZXDM3zv+3v2lzxA7NgMN
         CF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762259799; x=1762864599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YuYa8Vyc5g36zBbzEp6ohHNgPOjM03c64dcRTIxk/XA=;
        b=lFC2dp5/UcfAnkN3AXelnA/ZpIaiBOtY7CPXnnw953YIieiog9KxqJhd5YNl/JLkPt
         p/xK+iZsxZ2RXdCx8AomjfacMK9StfeTSzdQ9dpxQerfGMlq4BO5EQWrF+qwltFy+Lgl
         tE/olWkHNTtNLs/Hq13P4cCs/0TJuLCDeAMt3rkdRav9sfXTeMoHmKhAEpUlTQBSRJWe
         /I0HO3wJRZzDJ4DU3iwcx39cP3Sawy4dSYUn9VVwqo06UQdEYDpNaA0P+BF/p5lKUEGC
         zrCmnPnkQsiszZH3WMWI3sXs8wCUeV7d9bHCKoas4YCgKgWneeBYfCqnhOOvXR5e97I1
         +4ww==
X-Forwarded-Encrypted: i=1; AJvYcCVLSg7pyMR58USlwRED4RjcKh2ZJtRUMcvUM8A3QyTyxXN+MCdxL1RX5FUmqO6pvdMk9+8Fq/ehR+k1zg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz56HXDi7yGSMYtWmRAkVV386zfSzcvufxOym7Lm97c+1RAif4
	QCudDsOwQYB3aUzrWtWsx9f+BcJ3TdA6f2W4F2xmWW6UJ4ANB+Y6OJDk
X-Gm-Gg: ASbGncuP5gcoZg6jd8ZZEtmnsVSKc3Do1mavsuf7Xk71irLhzWnEBV+oh59I9qtd0tk
	oaeAt83nCWiW2JXPwc51Rb/rl+0fSgal8ZGh9EpGloxm609graEE6CE+gUbXXLNY9FClOrPrC0q
	Okcj+E6Ty8r+Wlvta/q7mgJXLQQmwinMyYXDjgPjOmHqdQ3A5rh6ric1AZ8+aYvONWPP7byGa3y
	t5EAhWTiRi990aXSRB85UpH5AzbQglkBOUY8BoMBt46cSzpsOQWYnrYq3Ddw74g8cGmyDgSv8ny
	mfuFzd4PU/L5SzS7QhI8lQgb4w+8r6GqHzwyohy9p0WpT9OsWb08w6+nTvGBLlTtSldtrituvwV
	UFFtIIf4VjJRadHfXjzvnnHqGiXzOfaXs/Qxvzy9lXGPKM6qoti5EIADrTl0T11zto19dpRpl2q
	2Hqa8LsEXI3rPYHGqu09A=
X-Google-Smtp-Source: AGHT+IEqu3D4nCBfCW/PW2rcdwd+c+X0hF9STm+2SPgeMcdKeUwLd7lODO/G7LNmaVev7hTJtyCaaQ==
X-Received: by 2002:a17:90b:3c89:b0:32e:9f1e:4ee4 with SMTP id 98e67ed59e1d1-3408305863fmr23514216a91.17.1762259799323;
        Tue, 04 Nov 2025 04:36:39 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341599f14bbsm4565467a91.13.2025.11.04.04.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:36:39 -0800 (PST)
Message-ID: <ffc08b98-403c-4d29-abbd-b599c7c5e3d7@gmail.com>
Date: Tue, 4 Nov 2025 20:36:33 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] block: add __must_check attribute to
 sb_min_blocksize()
To: Christoph Hellwig <hch@infradead.org>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
 <20251103164722.151563-6-yangyongpeng.storage@gmail.com>
 <aQnd4-RRe4K_b4CA@infradead.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <aQnd4-RRe4K_b4CA@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 19:05, Christoph Hellwig wrote:
>> -extern int sb_min_blocksize(struct super_block *, int);
>> +extern int __must_check sb_min_blocksize(struct super_block *, int);
> 
> Please drop the pointless extern here, and spell out the parameter
> names.
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Thanks for the review. I'll send v6 and fix it.

Yongpeng,
