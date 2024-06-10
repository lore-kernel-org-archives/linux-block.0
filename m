Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B421B5A4;
	Mon, 10 Jun 2024 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718046305; cv=none; b=sTV5QnvsuW/It3EzX2ttk5FnN5XkCtzkergYH0syAB7u8uCxhal2yODriqOxuy3Ftm4EtyXqKtDdCjJVrUiwLH6B8poOUdHFlXnS8/qtMJaNtoZ5Zx32+8YyKHzwmv4hgjK7rWQNeuva3PCq24RimIZYIRrvyxAt0N7yQcBHOKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718046305; c=relaxed/simple;
	bh=DYw5X4U5HLsZyrnq7FpFUJMkaKGQJYDLUdfj4fuMRHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmUa+Ikq0UMKs8X6FAGcl08wTJn+VRkykEZ53rLnBuuyB9egzc+maUbbd3jndk5dxFv9XDPpm7U6nJS7W/zEt9K/KqAUevu2VDn86YeWUkCUPAah6y22EHCzy7S7QADdY7wqQ8rnX98uEiAXUhLPBHTAeU1GO12DgN3jQIQQ3+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f223c99a3so194840f8f.2;
        Mon, 10 Jun 2024 12:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718046302; x=1718651102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RzcwVjd3wuF7qA5HimwlYDFzQ23qzUuT3/7uHPghCl4=;
        b=N/ubT16tvDEjiT7yngOASYbvLe/IWGMQzox2Ir16q98InmbvHvJll2CCPpq35sjNAo
         eL9a7E1/8uhl2ZPybJ0z7qjO4BJYJs34oBCNP07FAF5J3UtoXYHf8bKzCYGMCKPB/r4Y
         p7BFTlPI5ihf1ugmSIuA+Fag36iTq/hCLGgU8wBIoMSQxPbgDbK/tgQE2xKux36/0R6c
         UxzTXhspx6bjxIfZB/u/k1yd1WaiPir9LxgrqOVy9abK0yGVtcIQbvDX81WBOqsbZcid
         Y7+7jlRzqHEovXJO0jXw7S3c6DMIUUJOZVjDghu47SdrNOCUaM2+sZLTohipHtrdXa9L
         cv/A==
X-Forwarded-Encrypted: i=1; AJvYcCVqSU0klp6g5Y9HIKrwcP07z4gEN19KcojrvT4xgvekXPbG0E0hM9B+QoXZoJyW4ZGYkMR0zkMQx/suTjscgnfti0uh1jhma2ahTEzs
X-Gm-Message-State: AOJu0YzTmM36sDKPngMpf7pzmvGU4PFw5dxdUckYzedGSjeGbWlOpx+2
	faVG1Cjm7BfHRSOGSkuARZjrUdTPHBlagFOzV5mKMYG9wKfOHWTy
X-Google-Smtp-Source: AGHT+IEvwv08TmpZPro//md103k727X8OXUPGA54WdjDUCV07StJHAMkwZJmFcCstU1jB4eMBih7gA==
X-Received: by 2002:a5d:526a:0:b0:35f:1412:fa8a with SMTP id ffacd0b85a97d-35f1412fcddmr4011456f8f.1.1718046302401;
        Mon, 10 Jun 2024 12:05:02 -0700 (PDT)
Received: from [10.100.102.74] (85.65.205.146.dynamic.barak-online.net. [85.65.205.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0f2b0d85sm7800267f8f.42.2024.06.10.12.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 12:05:02 -0700 (PDT)
Message-ID: <e8fa4c36-49e5-40b8-9cea-6b3b61aa3240@grimberg.me>
Date: Mon, 10 Jun 2024 22:05:00 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel OOPS while creating a NVMe Namespace
To: Keith Busch <kbusch@kernel.org>,
 Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, sachinp@linux.vnet.com
References: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
 <ZmdLlaVO-QUug5aj@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZmdLlaVO-QUug5aj@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/06/2024 21:53, Keith Busch wrote:
> On Mon, Jun 10, 2024 at 01:21:00PM +0530, Venkat Rao Bagalkote wrote:
>> Issue is introduced by the patch: be647e2c76b27f409cdd520f66c95be888b553a3.
> My mistake. The namespace remove list appears to be getting corrupted
> because I'm using the wrong APIs to replace a "list_move_tail". This is
> fixing the issue on my end:
>
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7c9f91314d366..c667290de5133 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3959,9 +3959,10 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>   
>   	mutex_lock(&ctrl->namespaces_lock);
>   	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> -		if (ns->head->ns_id > nsid)
> -			list_splice_init_rcu(&ns->list, &rm_list,
> -					     synchronize_rcu);
> +		if (ns->head->ns_id > nsid) {
> +			list_del_rcu(&ns->list);
> +			list_add_tail_rcu(&ns->list, &rm_list);
> +		}
>   	}
>   	mutex_unlock(&ctrl->namespaces_lock);
>   	synchronize_srcu(&ctrl->srcu);
> --

Can we add a reproducer for this in blktests? I'm assuming that we can 
easily trigger this
with adding/removing nvmet namespaces?
