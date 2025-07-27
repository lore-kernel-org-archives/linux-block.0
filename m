Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2862E3715;
	Sun, 27 Jul 2025 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753642852; cv=none; b=Z0EwO6K2heP7gHmkpt2w70sqlGX/NDDo29pKkq16AQiSDoZpklGkerULY9LaLogFVlRrMprr19AhZ524Ad+4XWXS+3AOrDuYJK460Wdge4woFajwfVvTIZAc8NzmhEA70zJwVi53XbHG1aYKsf4uBpmXU6tjlfgPPU/O+YEA5c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753642852; c=relaxed/simple;
	bh=zuHkeBBeTvaCCrKhzwUDs3B3njSVMudixBacrGepIro=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnTHEd4VwBuhDzdfND7nwGhwjAO/Ry1XoJUTBNoRTO/Lj/LPK7T+es9rBdF8M9VlmLnXtyJ5c5QfRU0cDozY7hMGMsH1qhnRM8qmgEypene4HCk3j+u2G38ZSH5KvpQ+pvJJVap3efk906Ru2Cr4kFRSIu1/mJ26yS+AB5jFmgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPYfSBCN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPYfSBCN"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4561514c7f0so37063105e9.0;
        Sun, 27 Jul 2025 12:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753642849; x=1754247649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQ8eZFEj7X1YQOuUROSpfYO1/lMHcm0JAgIfCTXQCIg=;
        b=mPYfSBCNTEH63EKDHM3IXzHQ97LfY0CP9aEpeTILJODOhCYb89FhkRuuLO+Rj9va5z
         CbDzaJbITAn3xVVSivmYo7AOB4lCQ40syqSn8AMcp7ClQZ2SpFDxvJNWNA0+nLw30W3B
         WBSOXjfUeFTZNeUENH40TlNpdDKMNzzzcJScfSmYZHG3lURblntM6hPMfT4eY4DKrKrs
         tAJSrHP3GI6TIPRyhvdUWvzarhz1IAvwwrv8L5Go2Kpjrmv1t6wqjYztOxzzfUDDV9fJ
         tj+dvqGosJdW9RckxX5UYbuW/Jk1hHkg9zJLeUON322r56IaqxeHRrVQQlXMcGt1taXk
         9Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753642849; x=1754247649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQ8eZFEj7X1YQOuUROSpfYO1/lMHcm0JAgIfCTXQCIg=;
        b=StIK4N9nIFPwxs7NeW/t7us+De4fndwx5VNjcTxJNkoapbWMJsvY5x5GqCpslWCKXl
         CNu+sCwTW6g76DgmP0odkyw6QsfVsROutVrYq+8X1LgcvaOO/uu4sH9FL8aldRvZNc5l
         YeoGU5Z8EaMNtTGsNikZB6b9WYY9VOehBKs9S+ChiXH+u48uRBF1+cAIvN2i10WlGyxc
         9jk7Z9ROombvDpBOA666gdCkG7ogyXR754i9xF5u+odGUjLdUEBARtVfuokKZslHq+Kt
         SzpgO6T7/qas4CaCBCs4BbNxjgObBAziwqRrklQAXvSIeV2k61IHsWCVzbQqacWnbrai
         ZXDg==
X-Forwarded-Encrypted: i=1; AJvYcCU6GiCKg8q2oX9g/5nsrm0/lRwdejhhMzUhct1uANBlbX8bu+aT0A+iUSsck8Em+8LIGToqX1leI3uXPrvN@vger.kernel.org, AJvYcCW02chSMzfm8IhRT6AMa+gjlkwoVX6W1Q1OUlCV2/GJ3pHQJA5OnRv0sw0fjPpvpixjWzhh183WxzipgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGfAruvJ8mMz2RsDdIU2iqC2ZV0GM2A/PP1S0XKmvlYEGNABFu
	OizqUIlP3V/CiOnWj6wKcwAFIpvNtfoj+26+JPDMtQXy1vn2RTa1U/IT7UKF1tP3KNnI8Q==
X-Gm-Gg: ASbGncs7SPpuUa7WvfNHcttGBnGCjihCMsOAlvzQx/+7Ab+pOfzcrb1B9at2jdUd752
	fXR1x06UW4loRAyjaArJse4h81SgJutp9wlzBGCxr6SMHt92xdAXq0P+ISAH3tn3BOzxp94hObh
	vVQ6wrNzdzBL5Sbz3D8cb7WnXkOeN6To7gTd5n6o/vdyZU9+dNIppg0ujAMAq7T3Fvlcf7zFQt1
	NpXj7JnLeLYtU8K6+s6Q0zyn6bSAaZ/01/2wa/HuqYfAP+NlN1dJ33eMw2+vFDpqwIx0SsvMFCO
	csCcfpAEyosG+ZGmYfh44oKwdRD7rJERXqd6sgD72PoAs2GcEJ6CoVGNjDj3VG1c27JOQSP5D31
	ZpNJDa88CnisDyjlI3UhimF5NhIZ9nu2o
X-Google-Smtp-Source: AGHT+IHzKrz8ba+Kxaj5dRaIxXmCTwpCXqZajNY+RL3fN+yysFED5tpP5DZWeE6HT1v9R153ZvvQLw==
X-Received: by 2002:a05:600c:4590:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-4587643ec92mr78758265e9.18.1753642849143;
        Sun, 27 Jul 2025 12:00:49 -0700 (PDT)
Received: from [192.168.1.3] ([102.46.170.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f045f3sm6369939f8f.46.2025.07.27.12.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 12:00:48 -0700 (PDT)
Message-ID: <6e1b72fa-900b-45b8-8b89-37cd84cad779@gmail.com>
Date: Sun, 27 Jul 2025 22:00:46 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] DRBD: replace strcpy with strscpy
Cc: skhan@linuxfoundation.com, Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250704175018.333165-1-eslam.medhat1993@gmail.com>
 <20250705173248.59003-1-eslam.medhat1993@gmail.com>
Content-Language: en-US
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
In-Reply-To: <20250705173248.59003-1-eslam.medhat1993@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

kind reminder about this patch change.
I appreciate your time reviewing this.

Regards,
Eslam Khafagy



On 7/5/25 20:32, Eslam Khafagy wrote:
> strcpy is deprecated due to lack of bounds checking. This patch replaces
> strcpy with strscpy, the recommended alternative for null terminated
> strings, to follow best practices.
>
> I had to do a small refactor for __drbd_send_protocol since it uses
> strlen anyways. so why not use that for strscpy.
>
> V2:
>   - I forgot about null termination so i fixed it.
>
> Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
> ---
>   drivers/block/drbd/drbd_main.c     | 17 +++++++++--------
>   drivers/block/drbd/drbd_receiver.c |  4 ++--
>   2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 52724b79be30..028a5cf41d7f 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -742,9 +742,9 @@ int drbd_send_sync_param(struct drbd_peer_device *peer_device)
>   	}
>   
>   	if (apv >= 88)
> -		strcpy(p->verify_alg, nc->verify_alg);
> +		strscpy(p->verify_alg, nc->verify_alg);
>   	if (apv >= 89)
> -		strcpy(p->csums_alg, nc->csums_alg);
> +		strscpy(p->csums_alg, nc->csums_alg);
>   	rcu_read_unlock();
>   
>   	return drbd_send_command(peer_device, sock, cmd, size, NULL, 0);
> @@ -771,10 +771,6 @@ int __drbd_send_protocol(struct drbd_connection *connection, enum drbd_packet cm
>   		return -EOPNOTSUPP;
>   	}
>   
> -	size = sizeof(*p);
> -	if (connection->agreed_pro_version >= 87)
> -		size += strlen(nc->integrity_alg) + 1;
> -
>   	p->protocol      = cpu_to_be32(nc->wire_protocol);
>   	p->after_sb_0p   = cpu_to_be32(nc->after_sb_0p);
>   	p->after_sb_1p   = cpu_to_be32(nc->after_sb_1p);
> @@ -787,8 +783,13 @@ int __drbd_send_protocol(struct drbd_connection *connection, enum drbd_packet cm
>   		cf |= CF_DRY_RUN;
>   	p->conn_flags    = cpu_to_be32(cf);
>   
> -	if (connection->agreed_pro_version >= 87)
> -		strcpy(p->integrity_alg, nc->integrity_alg);
> +	size = sizeof(*p);
> +	if (connection->agreed_pro_version >= 87) {
> +		int integrity_len = strlen(nc->integrity_alg) + 1;
> +		size += integrity_len;
> +		strscpy(p->integrity_alg, nc->integrity_alg, integrity_len);
> +	}
> +
>   	rcu_read_unlock();
>   
>   	return __conn_send_command(connection, sock, cmd, size, NULL, 0);
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index e5a2e5f7887b..9c2d439f26e8 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -3985,14 +3985,14 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
>   			*new_net_conf = *old_net_conf;
>   
>   			if (verify_tfm) {
> -				strcpy(new_net_conf->verify_alg, p->verify_alg);
> +				strscpy(new_net_conf->verify_alg, p->verify_alg);
>   				new_net_conf->verify_alg_len = strlen(p->verify_alg) + 1;
>   				crypto_free_shash(peer_device->connection->verify_tfm);
>   				peer_device->connection->verify_tfm = verify_tfm;
>   				drbd_info(device, "using verify-alg: \"%s\"\n", p->verify_alg);
>   			}
>   			if (csums_tfm) {
> -				strcpy(new_net_conf->csums_alg, p->csums_alg);
> +				strscpy(new_net_conf->csums_alg, p->csums_alg);
>   				new_net_conf->csums_alg_len = strlen(p->csums_alg) + 1;
>   				crypto_free_shash(peer_device->connection->csums_tfm);
>   				peer_device->connection->csums_tfm = csums_tfm;
