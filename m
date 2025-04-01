Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF21DB92A
	for <linux-block@vger.kernel.org>; Tue,  1 Apr 2025 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743513515; cv=none; b=ITM6vfr2qdwyO4Km7j/tzR84zJKCY9EIvzCBZn6vgbl834/ttmnf6D1zZmGRaYfUXdy4IMtq+UIHFUE+CKyS4FnY+6OJpeBwmgX/lpKr9m70e6feYSC+i8YQAbdj8S3sLAstPm65/ObPJwJ6cyAr24Zjl58JUHMPmYUg7Evxryc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743513515; c=relaxed/simple;
	bh=kTfiAdRpBr7pOp34IPVjliGIooasg71O6bVNGmB6Zog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCMwfzZhLtN26CGji1NY7xzpaMJBiIOwymNCyEnBTaH3RpxaH/csWuHD4j6Qt9G1xGQuC/rm5NSBWAHep8OK8EIm8lMuwtrPvEDdIpsVeKnDHKqCkZyYIvPlHJvT7newlz1KXpOa1gkoiwCCo3/IOUxVMCmJ4YB5TIIOGLoBBCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U5kjERip; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U5kjERip"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ce868498d3so22120215ab.3
        for <linux-block@vger.kernel.org>; Tue, 01 Apr 2025 06:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743513511; x=1744118311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AHAHZnRaWT2kEHEFw/h+fXhuvxH77Ryny+INUOk6P78=;
        b=U5kjERip5owSoLsuQ38NL+fFd95z7p6so/d66m/fjMnqCUZg1aCv1JDbRux6MhuOm6
         bHA7Fa/OZD2j88BSz8Ucg3aTkzcZR6PLoc1EsJQ7YzGXi4f/5x5DrqWghM3CpQGf+QN2
         ZqmTSY7GmmEXcfGwKw8XMtA5feQ61szca/xmOP4AXkEqOeisJk7z0ItQZeksyLRaHXFj
         +ftdDQbL8k1QhhREWT2jp9I/ggpXIJuTXFH2PtHy4p6ASpM4LOvJYjclQmJT7H4q2GJ/
         15JGB3L7uf2wvJ2IZr/RszFL246S/vknu9bUc1j6LOgDJ7qTosWKUXjevAWltP8/4drA
         +zIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743513511; x=1744118311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHAHZnRaWT2kEHEFw/h+fXhuvxH77Ryny+INUOk6P78=;
        b=HJXxj+3YV41cj5WbPVNEzX60wkpFA4utLCu++oPUyw0koqsau3s0T5zE2cQtUgyWrQ
         wY+6Ok9qTymEQCFLZykp71BmsatU00kbO/YCOoH7ED2ETdkeCzEyNssI1gvbxhtFkRO2
         /+VJRz+EX86QxpAIr5isRZTrusToPiUAQYB7CmQVC7a3MqfOuIm3TSxD/mo6+6p7WFVn
         PTM0ZbHz9AbAEP+Bmvnas696wik+RFjK6UACXS7xjgdA4/UHpQObP71o2sznZii3b4B+
         oaxEiN2xz9MzU5JuYWWb8HjrC1Xwzi0rr2v0A0uxfHKGZn+suRYNQ4Sfmx2n4jS4By6B
         sVig==
X-Forwarded-Encrypted: i=1; AJvYcCVngdIkzTqqWuTSKga7PTT8N39XWh0gwh4l38rbnx+txEy+RctUGwOHvM4vtkHc4ywoBMWkvTwdhXS3ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwM5s/tQ59C+bs9lymGw12bWgECyif8x0oYQz3v9E6nThVwKaf3
	oJAYX1AuVcNCROpLrEaJozhHCKPtOgF3z13inhmr8QGmUf/TewzQZgRMammvUhhTIBwf9oEoxzl
	K
X-Gm-Gg: ASbGncsi28ipiutNxnADek0ETtT5FlxMzsUuXrd1U45Xwlr2mOSzwM79UJcYn9+Hxmb
	vfQIR++2JETFXpKWfehk+z0iTSIj/8vU9jBPQyTofWdqpHWqpCWaKOHncYCiFkhHLanlLcvPWPK
	OO1qn7PEu2d+xlEWmgkGLqYCfb7HOo9ylOKv/Bx6qWYzeK5pP4lJ0jOIGkJqdoJ2b6qW49fv0p9
	Lc6d1gWT34fgywY74YoSbn4HvJ7G3EulooXPrOgxjJpDI8a278liEh0x8efHsPzTJ02egPD2glP
	YY2IzVUmqapMaLaKurJpgQEJHWjBLiHPBedp/02eyA==
X-Google-Smtp-Source: AGHT+IFVnPkYjUDSgEcAEBlaOmmh5aK7tQ1ZzesCShYnYzsQMsgfc7WnH26Fxa32XvQ7Qw4imigY9Q==
X-Received: by 2002:a05:6e02:17ce:b0:3d1:78f1:8a9e with SMTP id e9e14a558f8ab-3d5e0a0d2c2mr126004175ab.20.1743513511570;
        Tue, 01 Apr 2025 06:18:31 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4648cc61csm2379600173.141.2025.04.01.06.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 06:18:30 -0700 (PDT)
Message-ID: <500a6b67-9ce0-4a74-9ae9-59ee0d4990d4@kernel.dk>
Date: Tue, 1 Apr 2025 07:18:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: ps3disk: Use str_read_write() helper
To: shao.mingyin@zte.com.cn, geoff@infradead.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, naveen@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn, xu.xin16@zte.com.cn,
 ye.xingchen@zte.com.cn, feng.wei8@zte.com.cn
References: <20250401192139605xby4g5ak51tei46zArAT8@zte.com.cn>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250401192139605xby4g5ak51tei46zArAT8@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/25 5:21 AM, shao.mingyin@zte.com.cn wrote:
> From: Feng Wei <feng.wei8@zte.com.cn>
> 
> Remove hard-coded strings by using the str_read_write() helper.
> 
> Signed-off-by: Feng Wei <feng.wei8@zte.com.cn>
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
>  drivers/block/ps3disk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
> index dc9e4a14b885..b7fe90b6fdef 100644
> --- a/drivers/block/ps3disk.c
> +++ b/drivers/block/ps3disk.c
> @@ -9,6 +9,7 @@
>  #include <linux/ata.h>
>  #include <linux/blk-mq.h>
>  #include <linux/slab.h>
> +#include <linux/string_choices.h>
>  #include <linux/module.h>
> 
>  #include <asm/lv1call.h>
> @@ -233,7 +234,7 @@ static irqreturn_t ps3disk_interrupt(int irq, void *data)
>  		op = "flush";
>  	} else {
>  		read = !rq_data_dir(req);
> -		op = read ? "read" : "write";
> +		op = str_read_write(read);
>  	}
>  	if (status) {
>  		dev_dbg(&dev->sbd.core, "%s:%u: %s failed 0x%llx\n", __func__,

If you're doing this, why not kill off the useless 'read' variable as
well?

-- 
Jens Axboe
