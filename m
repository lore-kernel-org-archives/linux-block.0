Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777937;
	b=Hl1YMKKe0N1ZaA7AN1MnQ0qVvdYCMlcTXppU46IBzKsTdqoZiMYZDuvjXzH1M6q/pixG
	 L7MmGzz8m5ZOtABLgKvVKK7hyxX4ybGRIX2AzWgJ7SeHeAybWuMvZIqfB/W7vCJwEdK21
	 dA/IN330NXwNrqIBLKs126w/ywY1VX8IBC+aqfkRikeZcmWjs0BwyMpzRON9AlkL8WN6t
	 yY4eLqos9rJIkb2mnSk4GReCXg02UGK3W8eGnKmpyVofy/FaM1bJUWOuxPMsEn9xt+miZ
	 oEOvnTeZ2O04S9XsuBNnHNsmXAEh34uC0TXr0ElouqgH1tY/AWpTsz/yL6uSpXQyt8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=kkvar2o+3Ha6mOonX176i6kW5zfw4JypQo5ROcscIGA=;
	b=3ZOJ0Y6rZqRvzEA6qgfKtiI/Qd6D+Kxzk3V0CPJ1ghfVaEBUQGOAcxfjcDmQ4P6GWqOA
	 R1li2xhK/LxBI9V3ncaKAiQw6nBlPcSr1zWIDyUTDfuj1ERt9ucDzaROKiheT8L+Nb9La
	 IuHZdXAbuBKhbhqHOIkEGARFQaR/M7327cCrFHpm9J1K2igiUWiSKknbFvZJE8uBtKfmD
	 dxYqs6o66p81OShfyOh3dUromELa3B1KSY71fRK3Uz7n6SzcJqXlrhvPLGxj9SEnaEilY
	 RQoqV+ycDNqwAEFWgooSYu4KnRHXaYFt3vEXn3ER/n03Tv6gIAYKl7IG7Ghx9nVs/SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SOT8t9b0;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26508606A31A
	for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 17:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26508606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SOT8t9b0
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4956869750eso7599915e9.2
        for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792777935; x=1793382735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kkvar2o+3Ha6mOonX176i6kW5zfw4JypQo5ROcscIGA=;
        b=SOT8t9b0Kkg7LWtVWTOOWybjUwlnbXORbDPfeX/VMPPFu2GIGj7UhjJTWGQaZJ99he
         jyMV2TZ7na0z1OWCH9Kn0YPhyCvYK3Rh3K0oWj34wPTIogZr+QGtT54BzHlrvAO9E+UU
         1ZgNdQzxHo2HTfJLfuDpFI21+mchEZsb4tFdlQROz2+BjvvBETRfoBS9F3L6JZ4Nt1uO
         vqos0vccP5QUKPzP7HZWCGNix0kqkEXjyVMDAYceoEpqnyZR98GfFXHYycpKSHoI5QxU
         V09VS/MwZ1IuZlO3bull2Ev3Nt8JciztaD+4QAlutnie7W5SJ2uhvq9LU+f2kSQqcRzk
         mMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792777935; x=1793382735;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kkvar2o+3Ha6mOonX176i6kW5zfw4JypQo5ROcscIGA=;
        b=P1Cp8qhWAAwlgHVP9padetLKHLAkkvKbYBE6qd55Ml7i456SQReX8u48lOWqFKyhiQ
         OKKm4OuXfSsXZGn6ydICX94BT6MCy6CclKI1uHnknMoiJ8J3lxgA9xAFVMpIUk+JiRdP
         Avc7YNNt6TRq4pNCI2LaXbeck6U7IpTcPuvZZ3rnEghYv2sv32OD33fkHxKj8u0EZcsM
         I81G/kARsM5MfjeRTB1iAoH8qF5BxJWA2UCYc8fXMEVw7Df2ukynzl5hzQDMCeC3Wufd
         SO+F70RUlok3R8S0k51ch4TciY20rQvkcEJeN6a9xwqG2/vSUjeJf7g8Lo0BnL3RSyc9
         n08A==
X-Forwarded-Encrypted: i=1; AKwUvBzfw5CzWSKTuaddhVsjAIEDA7KlbfK+a67R/aK+AUiyCGUDOjUytQHxxPFwrPYAE7iaYZ9NxnImp9D/zw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIN+6b2lNUjcdrVZjNHKlFulIn5xzvlXVOIGtejS6ETEUxsSg1d
	7utOY0IW1VO5pWWbXFhQGfYncK6sSuvfFqM28S1WvlkNYzpwXHWDVJVU
X-Gm-Gg: AYBFou0CmGTAKtQob/UXOFb2C9UJYsrgeQSkB4yzuPZ3sxBJ2nQuYP84n7/2eGbuFMR
	Wm4H9lJNiupVNwIqB7kOiQqUHmruAANb2nJSkUQs2wEQ2WamfHdyTlJL0bjdbmp7deN2RS2kNYv
	zAOmv7b5offIFjKjAtfmYGx7TvcXEIkteD7cTCffQmCkp2TrKbA7dB2ul0KjZI3YIN6EPFm03Gh
	ZJwqEVdZSbgtWfTB3AuAVjMJntuFPDE+nGNqIZqQwltlTJvNcKUqTATdHeWmD+BvNQ49ShKrk8E
	DXOFkazzM5QAh5Ik6QVswplk//MmQWP1Bu9RhcGxEDkmv+DyOIIjcP+mDYAMUR6/lDd3ZwrGDCZ
	qbP+iPlu8Pblr9e8nHoLVtHrj3r9hHVpH/vOfux2xq2jS014V7yxAYk7wCN8ocBpZ+s0sb6p77v
	t3cbLSI6mZptARJdc4yNRdRbnXn8595HtnhA27YVWm31rpWn6lslCE2eLKF1c7FMlp+KSKXDrIe
	lvACUDHQuOCcs+xW/ZzYuIciXd8ma6QRp8NJXcAOWtsIPjQF541mWA2AYn2/wxKCncKBAb1OjCc
	896uKrA1+5ig/3Or+kNKQR2c9RrFeU1N15NG6HHmmdSt3ebLAoaWxnypZESfPloRND5jTsS5kQk
	SPC/aGF6TgQ9PjIBfwNHpYAQf1D4e7w==
X-Received: by 2002:a05:600c:3e88:b0:4a1:dfaf:f465 with SMTP id 5b1f17b1804b1-4a211c72edcmr46211455e9.4.1792777935335;
        Fri, 23 Oct 2026 10:52:15 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d40459dsm1191081f8f.28.2026.10.23.10.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 10:52:14 -0700 (PDT)
Message-ID: <7c1599a8-31df-4797-a794-bf5ba3d75286@gmail.com>
Date: Fri, 23 Oct 2026 18:52:13 +0100
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
Subject: Re: [PATCH 1/2] block: reject dma-bufs larger than 4GiB
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20261021184658.644645-1-kbusch@meta.com>
 <20261021184658.644645-2-kbusch@meta.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261021184658.644645-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/26 19:46, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The dma-buf offset is set in the 32-bit bvec_iter bi_offset. Reject
> buffers that can carry an offset that would wrap.
> 
> Fixes: 839231d19393 ("block: add dma-buf support for raw bdev")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/fops.c | 3 ++++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 46cb86dd36d23..a974b423869eb 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -19,6 +19,7 @@
>   #include <linux/iomap.h>
>   #include <linux/module.h>
>   #include <linux/io_uring/cmd.h>
> +#include <linux/dma-buf-io.h>
>   #include "blk.h"
>   
>   static inline struct inode *bdev_file_inode(struct file *file)
> @@ -1009,6 +1010,9 @@ static int blkdev_init_dma_buf_io_ctx(struct file *file,
>   
>   	if (!(file->f_flags & O_DIRECT))
>   		return -EINVAL;
> +	if (ctx->dmabuf->size > UINT_MAX)
> +		return -EINVAL;

Sounds good, should be reasonable for now. It'd also be good to
move it to dma-buf-io* as it's not a block problem.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>


>   	if (!disk->fops->init_dma_buf_io_ctx)
>   		return -EOPNOTSUPP;
>   	if (bdev_has_integrity_csum(bdev))

-- 
Pavel Begunkov

