Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288044;
	b=FwrZWQBQbrRWoihhCElUaf4Dj2g67+pLLvmFLAqUDaFpgqg7SIZNih/sMr9SyVI0n1hy
	 GGeKXadBrqfAkC7h+SZeveQgDXEUH2jON5HuTYYP++BJPqQ9u0SQ11/8zcQp5tn9j146+
	 Wvgu/G1DaaTy+ZbEJasfpUH6hA3civK9jDmKVxHL1EtXqcKH8DRcTfJZl7fSMs1iVsYvT
	 mnD0EKGSF7p4Cl39RX7CLDUXvkUp19Pjb4VfG9vUQLWN7ygjSGstRIAbSpkAG78g/1AI3
	 Y3blqk++GLjZnH0dGgBg6hWUutTO66krsQM1j/Eo6eAr1qh4WSY0xmyw6QOkYtbGvOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=fhu0B52Mpip0rn90WpHiJKooVARD6Eibs2UZ3OAYVsU=;
	b=CqjgwaWy2NWouGEYl4fAwVQTIj7X/8jTSb12aogFMpg0/WTk+RL/eAE9uQdybS+GDiYM
	 Q/EWG74u6A+kGkpDAoWwYz7dUkFLcAtm++90JmnGgEQG3t6SKCB+jmdDC98xHU3gARdqt
	 25HCpq+WdgMUeL+bckbyNmycqGq5XvUB5KPN0elHcfOIdT7blwlVstE2KF6k4sRnYyJIa
	 I2wkVO4BQTE35WMLi4/ZlDqNubmSdbUruHJcEMSlWyMGeJmuC6TlbjhQ2qhhkf5hGgvKZ
	 sFVU3ncgTLtKi3Ge64eirgvERXkwPuRV+7qlqR7jePDpsKxhL9leAbl8tynuwOytGXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="Ya+M/y/X";
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31225606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 15:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31225606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Ya+M/y/X
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-84a2bea315dso1622260a34.1
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 08:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793288042; x=1793892842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fhu0B52Mpip0rn90WpHiJKooVARD6Eibs2UZ3OAYVsU=;
        b=Ya+M/y/XhOFXus1JhrvEP3GvQEtkumhh8IDTiHQG4oV1GhEfnVIGfRHqla2TNRVfIa
         wJ+iZjpwRf4H6MRQDDN/uBkfeX5W2AQlOoC756VcDCGblzqmah52iurpw0Hzemo8zmuR
         IExfQpQTuqkx3W4HV/dWHMGWGLyGQcZi4swBG+XSVz7i3ylgaLCcLw/joEBBbiuQuAiv
         WIH82XASFJhzQ6r2brns5N0xjlnB9MUpNJ7hceU+phSDa+HFFIfvVNZaa7BgStpN9LhF
         rHMI/gDgWfa1Og9Zw6gYURTX5wUv3aqzoMAwllO5O4m89jO24Fz7Qc8eoezlPhdD8DXJ
         B/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793288042; x=1793892842;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fhu0B52Mpip0rn90WpHiJKooVARD6Eibs2UZ3OAYVsU=;
        b=Ge35aIoyVkstqQXlv6B3Deylm6ANspiYcu9zWpHXlyatrmnwp0XMyV2xmbIMyn48fQ
         M9zTjMx4mac09bYnqWsHYFb38cX3UlaUqQ8rkUWEn7DjrpcetTlqBt16bDbz15pVij4m
         F57KX8X2HhuBb9ALRbMUC/6KnhZWF0zGfYlk9Jm1HC9JHaKM7tPjFZ/zKOXlckfueF21
         8h0bEqe1dqC5e2NJQGTq3Pfklo+r9PCH7SexPFTSLMx+BkBTRlf0NiIQDLaGVWCu7tYY
         VQ091+VOG6u7PzniLdBBJ6lc/Y304yWInAHnsJ0EhPySYXVO2kQGZSPywOdE0xoTcOa7
         aAzQ==
X-Forwarded-Encrypted: i=1; AKwUvByPO9W1I/P//g9wbvM1qb0y2f1yQzO6WeYe1ApD/MCcTkv/glRagnxmJ28s7h5fAeHcDTErlI21mA/2hw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJSjWN74Zt3n5+7gfPtJTXq330pM6KkyJX9B4tjvLHd5gVxnTgA
	li47RS0ORdGcfObjoPd1TrI2lqNH8LRavsl4L7W9NmkoYAYZqcAixSCFwvcoadr5TjB/m2X+Gkx
	ON8zRltw=
X-Gm-Gg: AYBFou09p3grpVh0y3zW3FrNmVvBk62TbqkjZJa+AIoQ6BJq5saOIZqMmNLXb8M1LSK
	iN20YZeab3rMG6z6O/kHG8I+MliKjGhpf9AHz2kB4LfcDlIT0S/3vmE2Sr1DLCqFbsy2aXNrzBr
	u+fXde7ttsOXxcFG3EkjP/He3TpTaJP5yXkFDVIim2viRpfIJ0iXb2SYrIZQfDlSEmM2dQgu3fW
	/QO2AuwTpPectxITc+4fjKX799WpbGOwm4ezN/mBmabUWP+SL7AMgH6cdYZoLZPH70YR51nTX4y
	hp0dpLfvKtXOs/J51ELGFRtm2C9MWf77L5vBWQXt1p8XOBVr8wXJoLYXCHbB9VOUf4KWw5+4pAi
	7oPPz8l1yTqW6gyBQaC4Im1monN0Qry/K7+doT5sa+1V1HpX65TCXuIQKYmWqSK0yVw/uETKE6g
	etdjWqLiIcjt3r+e9PcZ7GvY9CWJtxcicPCLv98jc5WBEXudTjaMmsacJ2ct899Jiy0LQxe7hA2
	4jORg75fr/rCWNd1pYuEqpKzFqRmXcOGdWQdPfUO/gypUmg34hBijOGQgF7WUQwO16mEskhCWxo
	nlEXjLV6zd9LeHENrIZpMBDEofm7xjCu+3hzHRCyIyQaQnjPzfRxNS61G4SIi0hFcsX3sLElKOt
	QXEGlqWDeNw==
X-Received: by 2002:a05:6830:4411:b0:829:9992:20f0 with SMTP id 46e09a7af769-85ac0fd0da4mr5401244a34.28.1793288042103;
        Thu, 29 Oct 2026 08:34:02 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d34008552sm77736a34.20.2026.10.29.08.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 08:34:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org
In-Reply-To: <20261029150353.2503201-1-hch@lst.de>
References: <20261029150353.2503201-1-hch@lst.de>
Subject: Re: zloop fixes
Message-Id: <179328804102.1479009.6553402059596510652.b4-ty@b4>
Date: Thu, 29 Oct 2026 09:34:01 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 29 Oct 2026 16:03:31 +0100, Christoph Hellwig wrote:
> this series has misc fixes for zloop.
> 
> Diffstat:
>  zloop.c |   80 ++++++++++++++++++++++++++++++----------------------------------
>  1 file changed, 38 insertions(+), 42 deletions(-)

Applied, thanks!

[1/4] zloop: remove a duplicate call to zloop_get_block_size
      commit: 0835f4909553e78a97d1ac59ed6eb776b4f78c92
[2/4] zloop: share more code for opening a zone backing file
      commit: 5e9929e2f03c79574e76605e1a82509575db2d30
[3/4] zloop: fput file after failed zone init
      commit: 134ffb0755626c91af82fc7debc8b6f75f1f777e
[4/4] zloop: check that the zone backing file support ->{read,write}_iter
      commit: 0c10f8a1a7ae1502ea4ea7e13f222df89c28adf4

Best regards,
-- 
Jens Axboe



