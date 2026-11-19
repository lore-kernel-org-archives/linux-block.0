Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795089430;
	b=Q9IsivzkCuZR9cl8t3KZx3/wsnLdORw//MOVEmLA+t23e1oCSwj3AZagAdyBONPcedwE
	 nXe2izLnZZF00LAY9IWN9djY4FNPa2/oVXtCW6wtOsa0YVs7XBSIko9R/FHk6O3IgXtpJ
	 XJBgjo0nhjk8t32xc05QheLSY3isOoOculpmweL0yzEs4pAt8D5bLuq7H5RaoythJPJ+S
	 USWiyhzHFi5UiwRP2PjIfsicecA3K7XE4HmEUajq9f4j2f4G6hCEZWFHqyaZ7prcFS376
	 uftnWZUNXhAkdBtrYZ9Dd6AJMOZSnGnC6kaULH9LUUnm5ULLEs9l+0/CX9Fl0WIS0DQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=zlJH4+t0mXQ/RY9w29YgUuQUml1Z0NJ3e214jG9j+bE=;
	b=y2ljkEzqET7Q060NB7mr0KsM+QoqBoDtzdv+312fMpia+9glzjYR0sa3oJxo6x5JfG82
	 HA09NJ3MxW3i3JLR1jGNi7XFHVlYhJWK/vYFzYBvsRrUBGC/JLxXK1EaV0ftdWED1g+Hu
	 +IzFBMSTReBCKzFvlx0wjte6RlOXBWmJWobi0bsTNzS1Uyv637prVgIYoZ8FlNbYNFV0u
	 CdwEJbVGi+8ZvD+G2/hGf3vTOdCTwFLIMDP6uZVKhmYjR9phGzod8DTm3VOqT22FfqYIT
	 vZCHbPiOGtc8PxRo4tZtmOFUKQUwcTV6jnob6wWFZPzimxTelwTtUU2zMwyXWg0vZFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K3dI6WCM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6F2606A320
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 11:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B6F2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K3dI6WCM
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b88d143160so2674867a12.1
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 03:57:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795089429; cv=none;
        d=google.com; s=arc-20260327;
        b=UTXvXyhZeYlUNX7N3/Rz/qBQioe0pQGPVPK6cZnF50HV+e8eEk9C6kT2syIB0C7bd+
         wEJVP8xOoqVvnuX6NRNcobnEZHbkQp0/L5fCEpIG3QbUF4/YhQsZJozeNYq5v7J0g4i6
         +sYKm4Lu9DTy/fuCmB3/WbuzshaLz7G2r0UuEI29ArjlSbrHrHbAGysY+u9xW43wupW1
         n8pNp7DXM+B5wsaEmHUS54hdp/O1wQZt2LTHHXpLZufV4RxYXk58U/dukxdNeC1KlcAq
         RrnlEoqW1acKWN0Koc7xU1DtAioIC4fRq1GSym8VMV5hgUZJM/ZCSGPsqcQhny4cIZau
         g8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zlJH4+t0mXQ/RY9w29YgUuQUml1Z0NJ3e214jG9j+bE=;
        fh=zQ+TM7T+35yKJOJF2ovLmZVGX32szpdZ30ts5enVv1o=;
        b=OJ2HcmTpdiS9MRFQZ9f7EUb9eRTCWKLuIdymhx/i/uLWHmSm7ZUAeIeimIdaiZgZQy
         jnRNQnE+2HxJIE6DPY+wnfJiVGbvZHAkJnGaTqxVg0le0zNmuVRaKNQ+oIncanc2sSl1
         jj/0ru5Fhoelu1I4zYQ/hRw5TIyJOzWGfBRvV+yGW+dZdZ18wZO0Qn7Wk1IYNcnYzsQ3
         SK7eOegtb1k2CLzGfA56ipc9+Bkb9Ef1ScKd3gOsFIy2bdCBKjJCO1nPvSUsskE9zrnc
         iwkTDO4F18FMKJW6eacpSY85HVzPeLv63gSSzbwQbZe5RhoBYRHbz9NJosL/CAujKI9d
         04oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795089429; x=1795694229; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zlJH4+t0mXQ/RY9w29YgUuQUml1Z0NJ3e214jG9j+bE=;
        b=K3dI6WCMFECyf1dQvj6+tjaYhjJfKrNWoVtixGzRQjg9hBHKLgJUV9jS2ejMt8mV70
         FUaP+VD0fcCJw8DuPW228fHRIs6UC5YTRaFCorGpUjggIzvfceeT9VDXSeeAsIM4K/Y0
         dI4yB8/W/9IAkbZvuNywYM1ulat3Tvp3Njr+CBFpEqydko3cMlGXfm79vX29MEwCUULD
         4PXKV0848aTIpdf/FMtlUEqvpn85CPFioJ+cx/TIbaDofkrnexNAEQtyqz4Z5zhLOoRK
         MPjWIUb1cuC0LQ8yBW88FLiqjvp3WQoK8vkiqGXnwluJMY8FROgTztlluOynaxTORKBO
         XNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795089429; x=1795694229;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zlJH4+t0mXQ/RY9w29YgUuQUml1Z0NJ3e214jG9j+bE=;
        b=pl80VB07RhMsoqbaD812c8/MUQXtaQx7WFEvK5XbuPyOxkbqsWrLGih9X1JAmXnixj
         EtIZJQU+nR/6ZVWFldaerjWbrnbPRpgK8GBXDggdVj3nWmTDrMjfz5P0r06Jd6hSIDn+
         a89csmGAuoPasqp61UGL8nhjhOK7vkoWfYi5gabypZuLVIAkfpFni4z62SjBJUPmB1Xm
         3dmH7q/fzSWZ+3Fvgtdi14pBXgTLZGuvqmlNcSCzo7DK259b3EZS8GVt7cbBXslrVXB8
         ND+ejXG/PLBBbmequAX4Z4p9KapnHXlWVPMCt8csJiFC0H26wotg41GE5jdjWUjEvm0O
         qyOQ==
X-Forwarded-Encrypted: i=1; AL+hErGxIwaZ6q91nGfIhd4EbLMwxREly2ZY69MnmiWxSycPwz9VsDXWqegM2nEcryYYYulBOEGrZHbTsUPiWw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/cYXItxAmuH7yae+p5WSO73AIwPSx92soibhMCHcv7HA++iVnb
	zb0DR5WiDPHEAnlRJnz5dZGDQ6IkkaSKZLJ1C6VlVPgO200Rz5cpozuVJIQrMMqbJ75VLoJmf5f
	5MjUUjdAI0aav8vXWWLpDsiel4EqTnQ==
X-Gm-Gg: AYBFou2vezANZ47pe1tSFeOLjBjlM86Lg+7EbUEeYGofflvZ766sTu81ktj1rOfuNBF
	RBc3vFrBhGVVQ5m5AX8YisIuu3uk2AqL3hhlJ+HSKNTUgHnb58ASf9Jqa/Ap2Z/f4CKM8UpMcil
	UeYucbo282u5yLIgZHBgFoQ8fRWo/6Y5bgVgy66dBXiAMSw+B86F4lVxSxSokuH5EkJ5EGi6Pws
	QFrd8YmHDjrJ35CGR3ffC5yEaknwM7jaYA9jUfG6atlBXC1PgaVMaNLDyba1xfcOZQ73NE9Sa51
	f/P2hTat2uzH4VBlQ0Htfi0ZLI3b+E9o2xH7p/Fi0wO8WjC1K+l1zfB+ucnVWlEe+UgNuguBwFp
	M/pk2ydXvmXuBVjeUas6QWixHNC7xYgIGb/IRjFhVXjNAUdu6LEHpL2+hVROyz5MUJur/tvlrtM
	3TBsiGk1fotTdCyuGXCPlmpr+iqn5Ecdq+dVstKksup1AsaNC3e7wdgBtp0N8Mjie+bVA=
X-Received: by 2002:a05:6402:2341:b0:6b8:50e:3bb0 with SMTP id
 4fb4d7f45d1cf-6b887f051b5mr5100854a12.43.1795089428496; Thu, 19 Nov 2026
 03:57:08 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030014540.3065403-1-anuj1072538@gmail.com>
In-Reply-To: <20261030014540.3065403-1-anuj1072538@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 19 Nov 2026 17:26:31 +0530
X-Gm-Features: AclHuK_SZqZJTPjuQjOc7cIWYhN7F4D2sFh9VtkHTF5WSy6wsq_qeWgrWRBsOwc
Message-ID: <CACzX3At2GfpQB7eE1S2njJONChr8DmDC5poBw4pX+pAg21cscg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] dma-buf backed NVMe passthrough I/O
To: axboe@kernel.dk, asml.silence@gmail.com, kbusch@kernel.org, hch@lst.de, 
	sagi@grimberg.me, James.Bottomley@hansenpartnership.com, mkp@kernel.org, 
	bernd@bsbernd.com, joannelkoong@gmail.com, miklos@szeredi.hu
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	fuse-devel@lists.linux.dev, joshi.k@samsung.com, anuj20.g@samsung.com
Content-Type: text/plain; charset="UTF-8"

Hi Jens,
All patches in this series carry Reviewed-by tags from Pavel or
Christoph. The series no longer cleanly applies to current for-next, so
I have rebased it and posted a v4:
https://lore.kernel.org/linux-block/20261119095615.1840522-1-anuj20.g@samsung.com/
Please LMK if you have any other comments?
