Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F411B289811
	for <linux-block@vger.kernel.org>; Wed, 14 May 2025 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248747; cv=none; b=MfwuC6CLXmSCD0S7tFbX1asf4NC1TZSkNCM2jtM6tPl4LOtOaeTJYQO6MoYsi5o47d9Pd4J8wEFX/M+ZRmZyQzs6n0pvCmfTKyzSmmSomLxnvHz5d/aFRhAPWSRGkvkGOQ0ZjmVS6kgidTfEOPx+fLLpVM3na8ZL9aajiQoDDHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248747; c=relaxed/simple;
	bh=CQJ/Izdemu9Upqt5gzxnWRlT+ZgctMHmGm8idYAOny8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+5Dz3YQBvr310FtXAe/NhmZCICZgkrEUyOHREZzDxbaEFyN7VkysgUkcKXw/qfN2yVsnyBavs42hQux3G+JHSqckwaK5lhc2RR8GAiVWsjk/8lnf+6MmswjbO2X+ZFPmipQqn9sHiFrEZm7uTfEkyPJEqZaVHC1aJhsKdLgSdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=STw0v52y; arc=none smtp.client-ip=209.85.166.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="STw0v52y"
Received: by mail-il1-f196.google.com with SMTP id e9e14a558f8ab-3d8e9f26b96so878455ab.1
        for <linux-block@vger.kernel.org>; Wed, 14 May 2025 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1747248743; x=1747853543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGMN7yT051U8CF0u0W3zG/2Gp6ABI+Yzeacfvbogg24=;
        b=STw0v52yb5f0mPL9IZXFtif2MvZtEGQ2168zGGYzHCPb6t4M0vFI1jgwVwp1LT9Pn2
         Za9nauB7EZCqRUQTpEvQ2fc5DQm9SbI5ueJz6kx8+ASZEMaH0r5RKD0q77mQfTOU3xpZ
         WRuxwr5X3agOghIhOz2VBvaJVhlUgfFwPjXSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747248743; x=1747853543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGMN7yT051U8CF0u0W3zG/2Gp6ABI+Yzeacfvbogg24=;
        b=fOKYEdGUJ7aXevbVx6hwSOurNOKbPZuWY5G2qRdpOo9O3HUVkujvkK1ZkdbfUuDGGH
         X4XMICorS5HNIx1LcxjQak8ijIbx8PJV+1DQ3EMHtJC6OttPqinQr0tr5lJUtyQZYLdV
         RyP1pvMNRyl/usGzIz3HHliikHaEZn8osWJ0p/+58xhHimuT8GwxZm+5oXxS7YXcDbCF
         KPIKatfel0C5cfbm4ESttjJfPsXGJamLX63a/Ku+rtmhx+I2CgqW5gPjXT4434Xzyx3U
         as0ulPDp7hynWSDHiHG9G1XKhb1cdI6Oja0b8bpmH4wFGwihk3cuSnVobI0vD2uiKolz
         meHA==
X-Forwarded-Encrypted: i=1; AJvYcCV6k39AqfLKnYSUrwyP0r5H42POLWIZNcIbPmWHovwwR9uerWfDqBo53ud3gab0KBmqsZegKY+2psrYNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrmUzI3wiw6w7cRToZd1RHcNX9bYUoMF+lEqHFLwy6wxYh3vH+
	2e1nVVKiv6OsWYX62mEVx69IIDutz6Eoi6GZs4GNbWStHP6AUl1VYLa7thXP/uGs+Q0nIdaA9vn
	dMOGjJ2A=
X-Gm-Gg: ASbGncuozZHPmaVQso+LN5d+Gij53nHoEn+MDwLXF7ZQt97IxFE+gcoF0B74gZFKIh8
	scDLIwWsc9O75l9NxZimC67VznZ6mRMvBIPVE2EgCh6x0O2J1E85yPhx2c8CssSJoSlNR3DT6fT
	vaj5xMYGSxna2buVYGqkv8nM7TXn2JivJqpc1v8kCqK5DqJ9IZu3iUF4LRK/0IhC5nrsvMx/KEd
	GaFz2WlBTFH6TyhKnm8HcTiqr+Q2raxXBiXn6N69JuM+L9faxc6axtM8JYOLdAS7SwSDRLix+5s
	6NqAJh38ZT7hxuTCiTe8oFg594xFmLOL5uZnYKU9bP1YK0HQnS1RxhO4HUb/sZY4W41vtIVcPlV
	GwQ1qW/3Lpw==
X-Google-Smtp-Source: AGHT+IFWNOPlW3Guyw5uFAogWr2c6RBmPpeNia2yV6RQZMbC2QrNjBo4dAxX2hlRCnwwzJwFcrXEhA==
X-Received: by 2002:a05:6e02:4415:10b0:3db:7007:297e with SMTP id e9e14a558f8ab-3db70072a21mr27112305ab.6.1747248742981;
        Wed, 14 May 2025 11:52:22 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4fa226587acsm2718570173.115.2025.05.14.11.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 11:52:22 -0700 (PDT)
Message-ID: <9c69fb88-d4e1-4567-93ec-ed303b9ba01a@ieee.org>
Date: Wed, 14 May 2025 13:52:20 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rbd: replace strcpy() with strscpy()
To: Siddarth Gundu <siddarthsgml@gmail.com>, idryomov@gmail.com
Cc: dongsheng.yang@easystack.cn, axboe@kernel.dk, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250514182015.163117-1-siddarthsgml@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250514182015.163117-1-siddarthsgml@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/25 1:20 PM, Siddarth Gundu wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Both the destination and source buffer are of fixed length
> so strscpy with 2-arguments is used.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Siddarth Gundu <siddarthsgml@gmail.com>
> ---
>   drivers/block/rbd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index faafd7ff43d6..92b38972db1c 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -39,6 +39,7 @@
>   
>   #include <linux/kernel.h>
>   #include <linux/device.h>
> +#include <linux/string.h>
>   #include <linux/module.h>
>   #include <linux/blk-mq.h>
>   #include <linux/fs.h>
> @@ -3654,7 +3655,7 @@ static void __rbd_lock(struct rbd_device *rbd_dev, const char *cookie)

Could the cookie argument possibly be defined with
its size?  I.e.:
   __rbd_lock(struct rbd_device *rbd_dev, const char cookie[32])

I see all the callers pass an array that's 32 characters,
but the function argument doesn't guarantee that.

You could also abstract the cookie with a typedef and
operations on it.

					-Alex

>   	struct rbd_client_id cid = rbd_get_cid(rbd_dev);
>   
>   	rbd_dev->lock_state = RBD_LOCK_STATE_LOCKED;
> -	strcpy(rbd_dev->lock_cookie, cookie);
> +	strscpy(rbd_dev->lock_cookie, cookie);
>   	rbd_set_owner_cid(rbd_dev, &cid);
>   	queue_work(rbd_dev->task_wq, &rbd_dev->acquired_lock_work);
>   }

