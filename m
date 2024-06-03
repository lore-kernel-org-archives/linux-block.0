Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C6D1272BA
	for <linux-block@vger.kernel.org>; Mon,  3 Jun 2024 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717416454; cv=none; b=XtV+w3u/LWzISzOLQCKfwfkUec/6/ihSNxzARk8qIEqV4YOxwm05w0ECLEi/7JlObg7bE1CRbGwfN1tLDou9Od4ebo5KbWD9VFqI1jAxRqy6WrNr+wKoO4n8qI4o9OybpBZ20cQK6WTCThgQmkxBPl9GP6bu6Mr0ePNwY0uO970=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717416454; c=relaxed/simple;
	bh=Y3gF7BbKcqa4JwB0PvnAnvWiJxHmYd92raETWsFFdRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WCwFWqjtIZv5TAc3VDwEKnbWmSJS9+rPtTw2kmP5uwKmjnhf5iNtdG++p4RivmY6Rl9fX4eoFHu2pguKAGuLu1omE2eiysIlSf/Xu90nOqclycaf8vvVpejH9DwknYULXJ9vd51UMKRxukIOdLX7ESZA0zOfXx9P03KIhNGa3xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=tZPl3dxq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="tZPl3dxq"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4213b94b7e7so5944825e9.0
        for <linux-block@vger.kernel.org>; Mon, 03 Jun 2024 05:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717416451; x=1718021251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N43+9H6E0yFDxtyEp5leqtS2IT5bU0sKoqZhcVUnDjg=;
        b=tZPl3dxqYf9d3vwn+V7fPEZEbncNj6gj9Z+Su3MetWZlqYyp/kN//gENoi5IkVapeo
         6LsBVU7+0mgOLKMEc2vnXNr4C5T6eXTxiGCP4v1ZWOyoNDoAZtG+3fv4y4qmgJxtWubH
         +tCAuB2MnzRyffwwlO4ERu2XgWhQoUAg5Y7bF01qHsp+Xl0VPCRhJTtqO8S7MD7nXRw0
         NyxMNJPiBOe6ij25a7+UXsmjEjhB763e2YdLrzqSM7Ye5l6SDhyeVVo8ZwMiGgZqFKau
         AmaNv1jkO7g0OSUt2RmWtz1boULWDZMeF8TQuWN0BlPuhXhuDx7BLK4PcPwvgfSME4X6
         p2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717416451; x=1718021251;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N43+9H6E0yFDxtyEp5leqtS2IT5bU0sKoqZhcVUnDjg=;
        b=IoiO6Q7jPJKRqxmkysBjtavLwn2/hObq095GRPgoryCgBWgdtpLYiRmkxyg4hubRS0
         c9o88VmQe7JL+lSucpsJzKRDajsf9Di7p5eh6oPh3zoJ3EVnpanAzfCwnCTbTrBChtLP
         ffX6P2xethrz4e0/kPedj28zAXkF1BDQKXiPhg7GDhWDkILDwY/jsH/MaWMIwAXVBQ5n
         qzBh7veNQFy4rOUA9IbzwkVi7EDADySMJrv3xhunmhwp0mdOjGfhRj868+k4b2FFE1Bi
         iZrDJoFReYagaZDa2Q6eYOy49opAx5hotzgbwSsU3bttrpEjUjVzW+x6IlUB/u+N1mqD
         04CA==
X-Forwarded-Encrypted: i=1; AJvYcCWaFZF0s4qyc7lqs1fujqRGz6vFuUgulAGxVVoXE2IvUM5gg6U/5EpRNN+6ox4VoNP3MjAcr/xi7FEH+FsHkaanaAWdE/yoIPda6Hk=
X-Gm-Message-State: AOJu0YxyPQ+cYrTpKdR/S0Bz4yNLNMmOx/pSatAq6df+VVZ/pprolFiR
	ATlfK4DjWxalRWzSIWqneubhy45dfBmaw6Obj7KteCvwXXLlKwSIcnlzrrAPkdY=
X-Google-Smtp-Source: AGHT+IEtb1E9CA27ySEC8+JzZdUXyME6wqrjg4eprqNL3aHZhI5qpOxKKzkltHbM4Nklg291mS+POA==
X-Received: by 2002:a05:600c:1e27:b0:41b:8041:53c2 with SMTP id 5b1f17b1804b1-4212ddb68d0mr81757385e9.15.1717416450440;
        Mon, 03 Jun 2024 05:07:30 -0700 (PDT)
Received: from localhost ([165.225.194.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213837673csm70127375e9.31.2024.06.03.05.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:07:30 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: John Garry <john.g.garry@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>,  Andreas Hindborg
 <a.hindborg@samsung.com>,  Keith Busch <kbusch@kernel.org>,
  linux-block@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] null_blk: fix validation of block size
In-Reply-To: <d6999fef-aadf-494e-ad58-f27dfd975535@oracle.com> (John Garry's
	message of "Sun, 2 Jun 2024 11:57:03 +0100")
References: <20240601202351.691952-1-nmi@metaspace.dk>
	<d6999fef-aadf-494e-ad58-f27dfd975535@oracle.com>
Date: Mon, 03 Jun 2024 14:03:34 +0200
Message-ID: <87frtumdwp.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Garry <john.g.garry@oracle.com> writes:

> On 01/06/2024 21:23, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>> Block size should be between 512
>
>
>>and 4096
>
> Or PAGE_SIZE?

Right =F0=9F=91=8D

>
>  and be a power of 2. The current
>> check does not validate this, so update the check.
>> Without this patch, null_blk would Oops due to a null pointer deref when
>> loaded with bs=3D1536 [1].
>> Link:
>> https://urldefense.com/v3/__https://lore.kernel.org/all/87wmn8mocd.fsf@m=
etaspace.dk/__;!!ACWV5N9M2RV99hQ!OWXI3DGxeIAWvKfM5oVSiA5fTWmiRvUctIdVrcBcKn=
O_HF-vgkarVfd27jkvQ1-JjNgX5IFIvBWcsUttvg$
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> ---
>>   drivers/block/null_blk/main.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main=
.c
>> index eb023d267369..6a26888c52bb 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -1823,8 +1823,10 @@ static int null_validate_conf(struct nullb_device=
 *dev)
>>   		dev->queue_mode =3D NULL_Q_MQ;
>>   	}
>>   -	dev->blocksize =3D round_down(dev->blocksize, 512);
>> -	dev->blocksize =3D clamp_t(unsigned int, dev->blocksize, 512, 4096);
>> +	if ((dev->blocksize < 512 || dev->blocksize > 4096) ||
>> +	    ((dev->blocksize & (dev->blocksize - 1)) !=3D 0)) {
>> +		return -EINVAL;
>> +	}
>
> Looks like blk_validate_block_size(), modulo PAGE_SIZE check

Cool, I will use that instead.


BR Andreas
