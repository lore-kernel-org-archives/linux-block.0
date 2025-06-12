Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FDD20C485
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730114; cv=none; b=jeIMeS1FYfQkwQCcaZ4NhyVa5ONzSTaWWAc6y0qG603t8SWmbLVF+T8qkDaJb759aI+UIBf/s7zsyOhoIKHhnkuh7s4ZJ56xw+Sfd81AG5B/KdZvR2JOLRUOIAzRxagpV9ApmXVtKHeXOdBIT7lhkIgvLrxPOOitjZXy7iork9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730114; c=relaxed/simple;
	bh=/5hkVOPMuKNYyP5pXqAuGWYICPyX3micXgythDTEnfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juDYXEbWcykwN3ZuJVcOaUJudulfusr+Mg9Z/NDKacotnyY+Pt1OcRawHY3AAdXQbOKmu4l3MaCAReQ3kpu15565H4lAYVyp1/kuL9xzObkO/MbhvXu71jISrygXlVJDzae476GRJccumZgDoOql9mIEH2z3sUqrwjKAmnmof8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=b/+EWrU0; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="b/+EWrU0"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-874a68f6516so75799739f.2
        for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 05:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1749730111; x=1750334911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oiQC+W0yjIGVwcsiN86fhi+gjf0lk8z+cPeuP0rwwk8=;
        b=b/+EWrU00bjwqoqDBfgmYPWOhkSYPf9t6JvmX8kXLzj1ZrUUYHgzKK7TZc6ZTCIm+u
         kPgS+I65OIuGFHJxyqvt7BuJ47EADr8r/3NM6rNo0FaA4y1G8LzTtpQ6EGxttSF5B24P
         /hTX0C/8paMgK9MgwJ57jgm3Pm5KPjA0ypCzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749730111; x=1750334911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiQC+W0yjIGVwcsiN86fhi+gjf0lk8z+cPeuP0rwwk8=;
        b=ZpGF8XUgUpbc0Vt0+z+IRwVDzFVX2gurHtr5I8QB63b/gMsIQ5LYRcyRDG5FYZvZz2
         LEDcxUpBae+kmqWcn6dZO4851Ey0gsmVD5DvoO33q6YoAJkl3CNYN7Ui6G0vUJSsfE03
         8uQGcDkbabuCw15icfyVi9Ai/QVCQQ8ySHY/zmIaWpIn/RvF/cDXroTia+hR+s5xk29h
         q+zUDiROwu3mUl+gjR4Wg3OKKtNXJMd1HwA1uoL0xmRASmON7MUPCy//gB46vkRihUZL
         48ZYKJrELksXIXtUjjJnD1aC5EBJTqIe5Zbskz7Ra8gaBfU0ZjPfTFijo4FdWlrdBUHp
         e6Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXRv35BgJZB8oGrvzKjm8yynSlNiCqK0tOezxznM+/uDib9pYCYu/QAanyFYgGPahg3uaQGXRklgZ5MFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyX2yvzM5Mu5oCKjiKF/L8gEGF8asqlucuIVoRf7FbGYnKgaUwQ
	COBC/xL2TcFGv3cJR2m4OeBvvrtF3X7R9p1PFDYrNlTQFS2L4bk4qigAmZjIkVjU/A==
X-Gm-Gg: ASbGncvGdY58eQ1M89HtfRJNAJRQbowrFARowMVZ51qIRcj840RJ5HgT0W4UqpDbEAe
	H0Qwi3y6PnutoeRibE+Ty4wy88IOfwajrWW7xbT2bpNXrkiRbyyeJet/tgUdqa1fWaZODyyF70t
	TfCz4uz//xqVngHb+161POh1kPU7oRS8uDbEF5P/8Sn3cQLx6jV93GP1nk+PsrqQDIqx+DMAWbE
	MfPkSc1dNARSGed1LYVES3fA0nhw0tTzmAaKrAx4tFDkUNJReGtnGbKi9flpovHU4tOXAy9MVno
	O59tx/3MYpSVDB+1rYA8cL93XpLnww2DNG120D8iy1XL7+3PjDty0/EqhFP+ZPQAKj8QI671CmK
	tL4KhNDa7X/XrCY0cJ/ID
X-Google-Smtp-Source: AGHT+IFE6LoaIDSTbR2+Z49WPjvrD6HagrivYIZlBUHlPLtFW8Kl3MBn0+M7fl7SQRHeC/DZIkrMcg==
X-Received: by 2002:a05:6602:3719:b0:864:a3d0:ddef with SMTP id ca18e2360f4ac-875bc410f92mr880203339f.6.1749730111300;
        Thu, 12 Jun 2025 05:08:31 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-5013b75604esm260578173.8.2025.06.12.05.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 05:08:30 -0700 (PDT)
Message-ID: <28c3f551-c1a2-4bc0-a263-a27576335317@ieee.org>
Date: Thu, 12 Jun 2025 07:08:28 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] rbd: convert to use secs_to_jiffies
To: Yuesong Li <liyuesong@vivo.com>, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20250612110705.91353-1-liyuesong@vivo.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250612110705.91353-1-liyuesong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/25 6:07 AM, Yuesong Li wrote:
> Since secs_to_jiffies()(commit:b35108a51cf7) has been introduced, we can
> use it to avoid scaling the time to msec.
> 
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>

Looks good.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/block/rbd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index faafd7ff43d6..92d04a60718f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4162,7 +4162,7 @@ static void rbd_acquire_lock(struct work_struct *work)
>   		dout("%s rbd_dev %p requeuing lock_dwork\n", __func__,
>   		     rbd_dev);
>   		mod_delayed_work(rbd_dev->task_wq, &rbd_dev->lock_dwork,
> -		    msecs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT * MSEC_PER_SEC));
> +		    secs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT));
>   	}
>   }
>   
> @@ -6285,7 +6285,7 @@ static int rbd_parse_param(struct fs_parameter *param,
>   		/* 0 is "wait forever" (i.e. infinite timeout) */
>   		if (result.uint_32 > INT_MAX / 1000)
>   			goto out_of_range;
> -		opt->lock_timeout = msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->lock_timeout = secs_to_jiffies(result.uint_32);
>   		break;
>   	case Opt_pool_ns:
>   		kfree(pctx->spec->pool_ns);

