Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC84E22576C
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744832857; cv=none; b=gmQqvVMaXU/do0tKqPCQhjzWbIaCNAQT3b/jujS/HHCBCQ27PlY1KC4qm+NJxRClnmSgyHboXA60NK3AgpuGB7mlOsLfzB88XMr/t//ZyiRCMW4ehQlCxLzJcQUy+6PxqA31QbY1QwG9xPiGRTlPNGgBg2awu/HCOIY/4ZFtmdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744832857; c=relaxed/simple;
	bh=nmFbN8Jvti+aMcvdpLVr3RTBQY+w/ZlzYQcItC+kw5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzxAeW6Af/5U+jSEGEb8wheUTN8Zxf2Oi9ZqUvc2xcBcI318/wwdgFaPaoT+4AE8vc+F23ZRcGHRWTxOZ7mjARXs4e4FHtTncs1d4OUOlc4uCTzo4ICunkjZwFyGaWf4sSutKNL/oWOR8b4EjyC1FhpE7nsSAiM0/pmjXS7oLBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cIzBWt5j; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cIzBWt5j"
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-2c6ed7efb1dso4598349fac.2
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 12:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744832855; x=1745437655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Z9Eo3ldxsL6anf4/4F6dhkx8sn/QEC09Uie3Va9hcw=;
        b=cIzBWt5jiOkVqPN2LIGrRmsqTwQHY5694RMUusL6EkSO/egpxGcOzV9m0cf9u9Xul6
         xkz/e/+D4wPX3Cs9uCuFw6JQO24sFmywP/Qm+pe/uRSGfDkTODOKj3Vvx+X3Jxa42z9v
         6gFNogCt7pgg0WN/Q46GZ/XDfqus1ZN6vE0YB0tx8qujyAEu55vZOqeqI06j3ScxOh+3
         jSuV+/a0G3LPK8uErcacOPsGOGiqOhY7wMkZkMk3Uc7FSytB7VY+lMGhD4BfwJUxfhaZ
         cOBfM7CH4OEXmEAPAYLU9HSBWA4X9WAyy+tJ8pzZm1RkRVarGco1Zef2sD916BVrLUlH
         FV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744832855; x=1745437655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Z9Eo3ldxsL6anf4/4F6dhkx8sn/QEC09Uie3Va9hcw=;
        b=DULj1gnVpKPqmKWu6JB4L0UDstIOzrrRlrA9nGyfdhPFBwlC0/uVw5/3nTg1EZCBdd
         4PmvVSP4uO/hrE/klTTLy75ymqyzYmBPvEhdTcgfzdIoeEsdu1iGyHAeKJI4jcxME6Q7
         90VTzFvRZoachXqFA30ylzb5LzF7Od/oJsNee34KveUOzGpDazFS1y15jSE/LYPi9IFo
         tqjy+sJLSsEyMozCpOZVtESERwcsqSfucLEHm6kqNjNQkKIyAzBdQyz1GiljIqiYhdR7
         KpvQPH86DPdBBmQHZ30koweurK4RgMH6i97hVJEX0CsEIUTy9vqKey6b2f46x51oI4bC
         stHg==
X-Forwarded-Encrypted: i=1; AJvYcCX+a/KX5feAVI1K8oF4u4GNTDDZiZZkMm/yTNr49KsX3fkWWK2u2ZXdZMfoEBgsfd5atwzztmVGM80pfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBjiIoekLXS7o0vCW68IdjB+joWQ3FQBogjT03BSF/CMuwZbep
	7807ELl1h2/acS0dO05m6yrGaDenecfnuY83qnntDXhEk4AnVhtWorRNfhbidOBa9QisEl928Rq
	V3R2lCBnmRywm+SOLl/k9w0IQA7L7IgqP
X-Gm-Gg: ASbGnctg4F5r6GwAixDCzKUwP9H76dS/axuQdTPQRm2Sv9onuHI58Y2NvRDkz1bthYO
	ZDXzPKAGZoCVUCudKgYQB0HRVCqkXc1QaV5m38p6KuHuLzuzXqwk5KSqNVafDQmht3WJeHlElxW
	3E6tOYsGMNWiQ+ZMZa6h03G4t1WbUXhHqHi2aVMQSqFMnJ0CG5w7p+5ERrNJbGSr52MZpJY4yme
	Q9q7JegfXwp5NPOTLFv4x8ar8rBsEOj1Q8tTHVz0WVzU1CgWxg+xr+IwQj+29iWmmOt5IcK+I0N
	1VoltR7N6slNnSqccoRi2ztuU6XJq/7YM7sH8pHd6hX+yA==
X-Google-Smtp-Source: AGHT+IHlwyfJxVMiDiN9x6Wgi13vU3cyT5vEzRavgbyocC7QMrrwBfs+HSwVE22KOOJbvZEl5GHu8B2jnJJ9
X-Received: by 2002:a05:6871:6282:b0:2c1:b4ce:e43c with SMTP id 586e51a60fabf-2d4d2b9d85bmr1888654fac.21.1744832854718;
        Wed, 16 Apr 2025 12:47:34 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2d0969cc5ddsm800307fac.23.2025.04.16.12.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 12:47:34 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C637D34035E;
	Wed, 16 Apr 2025 13:47:33 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id C55E2E418F0; Wed, 16 Apr 2025 13:47:33 -0600 (MDT)
Date: Wed, 16 Apr 2025 13:47:33 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: remove unnecessary ubq checks
Message-ID: <aAAJVZ8Bob8rosaa@dev-ushankar.dev.purestorage.com>
References: <20250416170154.3621609-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416170154.3621609-1-csander@purestorage.com>

On Wed, Apr 16, 2025 at 11:01:53AM -0600, Caleb Sander Mateos wrote:
> ublk_init_queues() ensures that all nr_hw_queues queues are initialized,
> with each ublk_queue's q_id set to its index. And ublk_init_queues() is
> called before ublk_add_chdev(), which creates the cdev. Is is therefore
> impossible for the !ubq || ub_cmd->q_id != ubq->q_id condition to hit in
> __ublk_ch_uring_cmd(). Remove it to avoids some branches in the I/O path.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Uday Shankar <ushankar@purestorage.com>

> ---
>  drivers/block/ublk_drv.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index cdb1543fa4a9..bc86231f5e27 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1947,13 +1947,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  
>  	if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
>  		goto out;
>  
>  	ubq = ublk_get_queue(ub, ub_cmd->q_id);
> -	if (!ubq || ub_cmd->q_id != ubq->q_id)
> -		goto out;
> -
>  	if (ubq->ubq_daemon && ubq->ubq_daemon != current)
>  		goto out;
>  
>  	if (tag >= ubq->q_depth)
>  		goto out;
> -- 
> 2.45.2
> 
