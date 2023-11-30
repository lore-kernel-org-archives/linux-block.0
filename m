Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="V5HSyfWx"
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F18A10E0
	for <linux-block@vger.kernel.org>; Thu, 30 Nov 2023 07:37:43 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7b359dad0e7so13081039f.0
        for <linux-block@vger.kernel.org>; Thu, 30 Nov 2023 07:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701358663; x=1701963463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eRo1oknj4mG3obwA0KmAvZPEjccwf277vmOJQMSbu+o=;
        b=V5HSyfWxih5vlN9sEwNh4WyJLxo2rNJRaDQed8gzXIOrjHWi07juEfASs39Vl364vr
         oieI9VpmVVFeMwXkwp6ggdI53xyuUSNHfsu+R4XLpL7E182oLXp1m7K6B3UhRN4TaZ8E
         nQjdDZgGWR7pe4NmRoBW3HIEoj2RK0vdskfSIz2A9CMWTJTJWDg0EpJRbw0RoKtXL05L
         mU9NhSuhajtyoObvym8TLDlsPOxUMOBxDAnncYmSOdQvIeUpxlzmNMammDN63SRSMg23
         vTnF6GpOZpiR7ROey4cnLd3zxwYnrCtDUpJf4fC9ldzgumNEVV0wOJ/xdLtIxLRWbO3u
         xStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701358663; x=1701963463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRo1oknj4mG3obwA0KmAvZPEjccwf277vmOJQMSbu+o=;
        b=vRLAgfeNGEGZYw9nQXRCWj7kR6N3jyl15MAt0HNWLKvTj0s+uFeXokmb35CQd8bdGb
         W2TQb3eE0p5CY0v8pd7T++Z0NB7d5F5tr8oK3yj6zU9SlZPNXRnjjRVnzZvpMPZlGIry
         pGPFeqE91nQ1yAW/ZlEE0EQNJdch/crwl0SeBjGzt5ClJKvHsiqMGh6DBZn6pvUuKEWu
         SPc/D55Cspw+S/Xpar6HLwN0NWdLLN4Ne1hhXxSUSnNfM9VjNoFl/UuYCbpbUURVK+BV
         T9kGUiTxtqYU9kgaiqvDq7JEthMaE2ZF+tbBfnnGhjjoqGiQajlmnwMT1REa3R1a08T4
         WVXA==
X-Gm-Message-State: AOJu0YxiNFGQwlVDJCPwtuxkxxYA/ZCRnxoiLr/xxU6a28MV2Y3Luzpo
	SmxU/Aqa9FakrxIlxkTrVEHfzg==
X-Google-Smtp-Source: AGHT+IGSYO+9xXxMk+Bn7bqLWNX6OK2f41ov3rtjgV/FWA2seq3P2qUsGUYmTrmQqmmsuPk1XL1ywQ==
X-Received: by 2002:a05:6602:155:b0:7b3:6d5c:b8e with SMTP id v21-20020a056602015500b007b36d5c0b8emr2615464iot.0.1701358662939;
        Thu, 30 Nov 2023 07:37:42 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id el4-20020a0566384d8400b00468590162f4sm345409jab.178.2023.11.30.07.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 07:37:42 -0800 (PST)
Message-ID: <feb0a163-c1d3-4087-96dc-f64d0dde235b@kernel.dk>
Date: Thu, 30 Nov 2023 08:37:40 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zram: Using GFP_ATOMIC instead of GFP_KERNEL to allocate
 bitmap memory in backing_dev_store
Content-Language: en-US
To: Dongyun Liu <dongyun.liu3@gmail.com>, minchan@kernel.org,
 senozhatsky@chromium.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 lincheng.yang@transsion.com, jiajun.ling@transsion.com,
 ldys2014@foxmail.com, Dongyun Liu <dongyun.liu@transsion.com>
References: <20231130152047.200169-1-dongyun.liu@transsion.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231130152047.200169-1-dongyun.liu@transsion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/30/23 8:20 AM, Dongyun Liu wrote:
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index d77d3664ca08..ee6c22c50e09 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -514,7 +514,7 @@ static ssize_t backing_dev_store(struct device *dev,
>  
>  	nr_pages = i_size_read(inode) >> PAGE_SHIFT;
>  	bitmap_sz = BITS_TO_LONGS(nr_pages) * sizeof(long);
> -	bitmap = kvzalloc(bitmap_sz, GFP_KERNEL);
> +	bitmap = kmalloc(bitmap_sz, GFP_ATOMIC);
>  	if (!bitmap) {
>  		err = -ENOMEM;
>  		goto out;

Outside of this moving from a zeroed alloc to one that does not, the
change looks woefully incomplete. Why does this allocation need to be
GFP_ATOMIC, and:

1) file_name = kmalloc(PATH_MAX, GFP_KERNEL); does not
2) filp_open() -> getname_kernel() -> __getname() does not
3) filp_open() -> getname_kernel() does not
4) bdev_open_by_dev() does not

IOW, you have a slew of GFP_KERNEL allocations in there, and you
probably just patched the largest one. But the core issue remains.

The whole handling of backing_dev_store() looks pretty broken.

-- 
Jens Axboe

