Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270468;
	b=ro3COuRPn/0PmXIhOOyz4scEB42d0Fh7BzfYDUGtW8zOxUebnNhVOwYuai5JwAJyljoW
	 KHDTCDH3qpLzuphebFePJtCA579iI+KqzF4grRqXxrzsDjNcXwPl7jKdY8GLWfjVD7VrX
	 gL5z+y+NbkUoy/oTjAty3YCEQ5fsg/uKVZUXY76zd6GiXtiHkTMQFzzszxoBtn5CZ1G1Y
	 U3FlaDBX9IMxXYYuxDZrc81DN2GdO0Eqs5eYgFltqAmA6AO9NK4tjCwbQJIFzV1n2Ux2d
	 09yfCWHN9j9z+96pH3I5IDKvue3dVeobRO2uqp9fOp0uRIlOX39hZAyI81ZVwFVEzBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7YTm9ioo95Vo9gklY6fm7lji+ML3t3fOVUT2mwFWX0Q=;
	b=Toye5iWO8poVavG7nCw3zRdhYspSQE/00B1iRF7Tul+agaidqhkbw8Okxv3HoLe47Qgi
	 3raubb+iy2l6R2pVM+kX/YgdKc7Wg4rpQJb1GO9qvGGQdB1sR/feRTr2QFg0V7lh51NtT
	 v+WlbJlp4TNAfT/xpYFpMkfXRgA2Ks/YdF0yafOw+jzFEgJZc/f2a2SNRL8q3UJJrOjSd
	 skM5jLi0JghBEZxkA48BPoEC45YevBnHVtNfvHQP90pnSy/CyTS950tbwP1irwrJItFy0
	 xGG6LNhSeVOBgsSbvueRMdt2u0V0TDTYk+JTNXBozw9sTNXBVwftWDPU2FwdnEQF8mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UJn5KNjy;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17804606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 10:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17804606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UJn5KNjy
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e47347279so1349615f8f.1
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270465; x=1793875265; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7YTm9ioo95Vo9gklY6fm7lji+ML3t3fOVUT2mwFWX0Q=;
        b=UJn5KNjyiRih8vsvpdukZE44AMO7w6G87LNnlo9RcXudohke/6lP6Vx6FsEuF8CfdX
         ntvOaytd9xjKaBH8BcQtqznorK/8Dj4gofogWRdFY0Y6kqN5wb4sReVwXVRcUtaRaeM4
         v13tb23nuRx7cZMhkkcdnb32kl5+ysAYB3yDC9adOuz/XvvuECl2j2823ZjEaXco4Pqi
         9AwDaNY9MGwgFU3FDmjsnFFyYC2T66OYuhEUJTAUhJNZNwWjD43eFD4iCpKmwS8XSnVk
         uPk4NfOg1eTOY4jERyUEGbBy3dGrpo79fkqIL/LpEQ7wgbp29NoqfoteKdE5I5fLRYkv
         zMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270465; x=1793875265;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7YTm9ioo95Vo9gklY6fm7lji+ML3t3fOVUT2mwFWX0Q=;
        b=H9kWYThTixywDpcgO8pyPjHfW8fxFKI9PFe2F050AnbYYzh34Cucc4VON8FCXPfcZC
         v583t11ZHcQzdl4pvjhBjo33s7FvECIaSaH19AMQxzfHX69gFRwdT5EM4D3OhoY7Pag1
         L/bQQEx3k5kEJD3yJsfXVyxFaBeLkHagTuTEJK9vgNeyKFgBKLRp/ihxYcf5zPqJbs2b
         h2utZ0WND7tQGMoGfDdoDBUY5u1LA2ShdihUJW1dIsJePa4UeQBkM7GmEbceLpbib+eg
         stejlPSGgFLl5F2vLP3DmIGkLO+ZGO7bM3YPrs4tNXLSbC50YzCzDtU7NOvop3XNbQd/
         ipdQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8TF4EIZsDPmj8hcfYQ23qXGPsZWXRQsZNqIm0UeocfI4G3Vrjr9HFM+14oHPfbG8eulR2uhNXyaWeGQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIpdinz7gXXpYnyYKNpeIu6oDQhIZj5mahxK72vNGTUb9Mu66JQ
	IBT1As/QVxltWlwNkaajJvBeJscF/AeLxaflU5/PqUVFXjP/IQZ3vmmr
X-Gm-Gg: AYBFou1l4xlpNxHoDHXcCr3Et6xj8MyTrpvBud5wrkOsrw+qve/4n9WEs3Sb6WpfiQ1
	FMWsJN/17eiiC+AcEv6CXsXfGhI5vJNF8Mdu1cmB7eqQ9/kVquduJzV8ezzylD7uS8C0DAo4xdQ
	H/GU/heiimLpICaJgqIFHlDABCrz81tG/5FaUx1sY7ZrBcvmfMxMIOE6e/Pthr7AFIKEzj9BOZV
	7lXVA6YOqI/mKt1R/y5Gqvd45F8qS3bYLoYXzfcWpvcZ+a+2CtyNeEnQ6J6rQ1uT+dEvFK4/+UQ
	MMkrTOde/QFtNPUiIfVAHn+ae430R+gNFnjuyCYFXwlpN86GuuKMdUfYv34wbnX+LUvEZ+TDaVK
	Mq9ak0xc4nFr0Yn96F1ie4lALLnSZ673m0G353rXqOl9lU9KB2i8s/OQSKO0LdoqXO2uV5uo77s
	JF6/mkqutZAegULG3mBoNba7yGBrOXp+S3s/tstHXX5IL+64TfxcUK268EMjnGrJFc1za3B5gle
	AW9PsuYUfU7v3xymGv64OoJ1S0smzSOLUZbAJecnIpdqvid8ri+Hcz5nGcjB5NDJXY0Kfh3k462
	h5d2TLaC91smoe0NQ+aH6YsgoQV26bD5g4Wq4I6xo6BBa/aBP+cqUhN8SrxfATAoTcjk3D3gAMo
	gCoNNCQgyybMU33glrgxs2CcYO+8BQmndGkxgeGi1YlXlOO4U4luEE9qTY/rsY0iO6Ctw/vN7o8
	22PQ==
X-Received: by 2002:a05:6000:29d6:b0:48c:5304:5e50 with SMTP id ffacd0b85a97d-48e5d331691mr7785077f8f.0.1793270465337;
        Thu, 29 Oct 2026 03:41:05 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd48fasm33467703f8f.31.2026.10.29.03.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 03:41:04 -0700 (PDT)
Message-ID: <a0a9ca65-a28d-4361-9813-99b584b9148f@gmail.com>
Date: Thu, 29 Oct 2026 10:41:06 +0000
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] io_uring/rsrc: pass import flags to
 io_import_reg_buf()
To: Anuj Gupta <anuj1072538@gmail.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 mkp@kernel.org, bernd@bsbernd.com, joannelkoong@gmail.com, miklos@szeredi.hu
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 fuse-devel@lists.linux.dev, joshi.k@samsung.com, anuj20.g@samsung.com
References: <20261022144501.2478417-1-anuj1072538@gmail.com>
 <20261022144501.2478417-2-anuj1072538@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261022144501.2478417-2-anuj1072538@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 15:44, Anuj Gupta wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> Give io_import_reg_buf() the import flags argument and drop the
> __io_import_reg_buf() variant, which only existed to pass them.
> 
> No functional change.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov

