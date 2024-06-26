Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855041922FC
	for <linux-block@vger.kernel.org>; Wed, 26 Jun 2024 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431215; cv=none; b=GtnFsy/fapfGbPrM5zxGbDGbpstkX4ZUzVuIQ0W6K0iR8+1y/Wpv3D45jUl8MGLZqOqleyscDdr1FXpYHiNWD0TiOe46w+9f9lIfm7nYa0ooNAWYSg70vJ0Cf1VZn8h4+2hSMHqn3mybB1SCxtKmzvtiY7GhSqBYBdyqFv4UYzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431215; c=relaxed/simple;
	bh=90IFLVAimWlxflMq5YOSkklPtSnG+d0tK9j19/4wy+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ss3LnU6YjeI+waHdH0V4RV5MByxTGWR3zIyu0RO2Kce+tglxrNCatTccqDUZriHRwyQnVaqCajxxVxeUqNENlRWyp07fvajmXWE9+NnxYjGiaUdjZ4xVLJPRNWicn/LMUHzgqr66pmtiYAszc7W40QWApE4aowEi1SOmThz6Xf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=J/HoTc6D; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="J/HoTc6D"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7180e6ed01cso108590a12.1
        for <linux-block@vger.kernel.org>; Wed, 26 Jun 2024 12:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719431214; x=1720036014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tFQCYxkTWkVTkeG4pmT0NAA774VOsw4t919VmGwibAQ=;
        b=J/HoTc6DvBbXkVC/M33JaTxGUpNOKP352At2Mv2yNXqE1bHJ7j79D2yD7IF40yBI1y
         7uFIbLOy1nNaAFBITORNneL3Qcn46H40YdqbvyCPbc3C59N9rY4a42IvQfXbS9k5YjJU
         lP0Aaz8sdqL9hBVBsakxI/xgNG9sYQO0q+t0iNDhXqIjDD3Wpk+WpVjB2/3VeI823FjC
         NiGE30Krk7uVFTPgOXM96z9jsCNYrPOYA6Dq3CAt+2mcvIVU/CPg4g7VhtCyOd1domlx
         OOXy0g/HeGHgeXnlNfKXK1l9atv/xIfkEoDmlmjtcArnZYlPSjfI1CWs1I2t7Et8mqA2
         HnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431214; x=1720036014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFQCYxkTWkVTkeG4pmT0NAA774VOsw4t919VmGwibAQ=;
        b=M8UHZt0HNGpOvT7TKhju9Grg2bCNXe2Q7m3u8AUUIHYUMe43lc6Gg9Cf6rNMXv73cP
         zTu9s0KAJH8HuZr0q+QTv1cphmJHeUHV1uJDqELi0R3sk4acCxUKbvC8/d+VJOksuY+Q
         CJSRhgbaMulNcxhBOlMHQ/U0KBdhhDUwM9sl0OWbmkmfETfuJE2YIWyZog+8jdQjH4uu
         ApmNrerULHn7+Z+PdjyWYbRwfnS4nlxM9g5MKRJozl7jHxjP7kPW5eMRw4tSNAbaJKgW
         T1l1iK04t7c/kEPD6x08bXbb6nBpNnU+ag5LeRITuQTzdrr5OIxq4OOgOAQu9iX35Cxf
         1ETw==
X-Forwarded-Encrypted: i=1; AJvYcCWhKjCdXVcPM3dx9tBauMbDvfOvnre6O+Qu6uBDdue4TEFeB4u7jwtTi3dTWYoh30F6SEJM5KUezNErYVlY3o6Q/nj8w1W4ieCFoeA=
X-Gm-Message-State: AOJu0YxHFWp8Ir/ywcqHKFSoDP/WsM9SImCxShWM3PRRLMdLfwcUOPvj
	FpgtkSkXtTMtYFYaBkNg/bydtx9EIXmfTtV4cwp1w3Fx4t4jSsWKlmgf9b8KFNs=
X-Google-Smtp-Source: AGHT+IEsqyry2dKkQyVU+KqpfX7PK/KlBwJ1aJo473T1bK1fv3LN794lmHlDZiHq/jj1q1c90ArWNA==
X-Received: by 2002:a05:6a00:3e24:b0:706:7d86:487f with SMTP id d2e1a72fcca58-7067d864f28mr10467895b3a.1.1719431213873;
        Wed, 26 Jun 2024 12:46:53 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7069d65dfc7sm3287078b3a.133.2024.06.26.12.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 12:46:53 -0700 (PDT)
Message-ID: <58cc9e3a-bb69-4205-9f11-d262f811ea9a@kernel.dk>
Date: Wed, 26 Jun 2024 13:46:50 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] block: add support for notifications
To: Daniel Golle <daniel@makrotopia.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Hauke Mehrtens <hauke@hauke-m.de>, Felix Fietkau <nbd@nbd.name>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Al Viro <viro@zeniv.linux.org.uk>, Li Lingfeng <lilingfeng3@huawei.com>,
 Christian Heusel <christian@heusel.eu>, Min Li <min15.li@samsung.com>,
 Avri Altman <avri.altman@wdc.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Hannes Reinecke <hare@suse.de>, Mikko Rapeli <mikko.rapeli@linaro.org>,
 Yeqi Fu <asuk4.q@gmail.com>, Victor Shih <victor.shih@genesyslogic.com.tw>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Li Zhijian <lizhijian@fujitsu.com>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-block@vger.kernel.org
References: <cover.1719368448.git.daniel@makrotopia.org>
 <609f654800583feb016d96d9c3fc2f029f0f460a.1719368448.git.daniel@makrotopia.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <609f654800583feb016d96d9c3fc2f029f0f460a.1719368448.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/24 8:51 PM, Daniel Golle wrote:
> +static int blk_call_notifier_add(struct device *dev)
> +{
> +	struct blk_device_list *new_blkdev;
> +
> +	new_blkdev = kmalloc(sizeof(*new_blkdev), GFP_KERNEL);
> +	if (!new_blkdev)
> +		return -ENOMEM;
> +
> +	new_blkdev->dev = dev;
> +	mutex_lock(&blk_notifier_lock);
> +	list_add_tail(&new_blkdev->list, &blk_devices);
> +	raw_notifier_call_chain(&blk_notifier_list, BLK_DEVICE_ADD, dev);
> +	mutex_unlock(&blk_notifier_lock);
> +
> +	return 0;
> +}

Nit: redundant newline.

> +device_initcall(blk_notifications_init);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index b2f1362c4681..8d22ba03e3e1 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1687,4 +1687,12 @@ static inline bool bdev_can_atomic_write(struct block_device *bdev)
>  
>  #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
>  
> +
> +#ifdef CONFIG_BLOCK_NOTIFIERS

#if defined(CONFIG_BLOCK_NOTIFIERS)

> +#define BLK_DEVICE_ADD		1
> +#define BLK_DEVICE_REMOVE	2
> +void blk_register_notify(struct notifier_block *nb);
> +void blk_unregister_notify(struct notifier_block *nb);
> +#endif

Surely these helpers should have a !CONFIG_BLOCK_NOTIFIERS failure case
definition? Either that, or dummies. As it stands, any caller would need
to check if it's enabled or not.

-- 
Jens Axboe

