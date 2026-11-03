Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716275;
	b=Yj0zphWjJkoB12WK/xrWCcv2tFmiWS7CiDXtXwVA/713p1XNTiYM57oNY5e/W4Cwx4IQ
	 A9Gzdf5+Ujelb9L9PHDDAZKWiD+wvTp72qfUyyagcJUMcXxVIovPtmkrrUULq2DO3A9Q2
	 t4j8oDkukszCDYeyE3GchzTrWy3gkvOBONM3r6fZlDK8pZfszrSeY3uJunqJFZaW0jSL7
	 qeEJIODdrsdFCTOG581VY9BexL1Lf15AYt6XpFO1ae+XxDmtGItfCSGCeNC1rteVlxGAV
	 bQjNrLMTVq070sn6/XRUb6AR371eTinErgFMs6oTxoaIgT+Axhlr/oQwYDtrYDUURjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=mQHIItj+qvoGznmNDSAc+oLyoddjsgyl65N2G457jxQ=;
	b=bY4CqAgqgnOox89dYB3/vlO1jKeS3wOE2Z3EAlp7mn2xG5ATB732n2pQCiN+SG954jbk
	 lYI6/5WectjG9Jn81zj5pU7Yinp5zPAf46JeFPdHAYbboHfxE35DdTzBa2xNe4t7SgdD8
	 vzknaIUO6ctollvaRJeDPXCzaq53AuaBtc1Yl4pT0eSepwpDsKMr1yavmbCfozYmOt+1K
	 gXUcq00lNM6A2A9igMX0V6j+car6ehF6ZLwEmuWVxVFZoDoTtAdH/36DH+TFYg+ssqE/P
	 NfKU+0ilJOTj2QhpjH4SnxED78zr9Ljnvdpky5JUn9n7xUWigLGJ359ivwKwb95HaOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="jVnxhA/E";
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B03606EEA1
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4B03606EEA1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jVnxhA/E
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14394530ec6so5585187c88.1
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716274; x=1794321074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mQHIItj+qvoGznmNDSAc+oLyoddjsgyl65N2G457jxQ=;
        b=jVnxhA/EG8/jwWHgyUd/YGEYAOWsVLRlwNPRXwYEGVwswK2+uIGauWBraLJnUWUA/t
         h4t6pngRbbrUOVUbmqrlWAVUK3/ta+8Zown4zVadfvmTepZik3oUQ0nWhWqTcs98Qb66
         02BsiQK1wpIb/OOt8q3I/7EIuN3e8R/LQhAdXYpgMIzEI1JUwWmQnBlbKGfgtP5z2r98
         5fZlpur1KqKKd59doL9dDbmgKB2ljBPZBLjqhSkoWF9OFIM/aX5CyXWKG+MrJbtp8m50
         4lzdrVw6eECucGAexedcU/afcUfRw5ncCH4jSpuo9V/mwzGNqPLBXWXtcd0RvEigPHVN
         /0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716274; x=1794321074;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mQHIItj+qvoGznmNDSAc+oLyoddjsgyl65N2G457jxQ=;
        b=oicuNiyRNAnJEVn4VoJPSC3GV6ILWt+V/tM2Ddjc+BKzvTF27Vd9ZXVl457OJByy5M
         JVSRQ5kXky5D48/ZUdLdYjRU3mULYeina8F+t+1XGgQZfPlCILC6xBfOVu7SYkLhu53n
         5rvF0NvpC3wq8bmoofLrdvIZvYZrr9oYQ7D6j2h7SqNzx+0ZjPdiaRYXN5sRZqA73EQT
         Oh/IjdjL7Cwn5MLE+wKFu1mVB16LSPL4uLTOhf2phWMe9RFTDexQMTxxzRvhepx5lV5A
         MVSKopqNEdh4Kipkyxo9Yzc1FxIL5E9iE9JhILzjefk556UUZugeg0g5qkti+D6jHp6T
         yjZA==
X-Forwarded-Encrypted: i=1; AKwUvBxNDwcuBbNcU5eHML2HtNdpVMNSA80wM+FLlh2xIyljGJUPvG2Lk7D74YdXdiF+RYylHeDK2zHsyTICCA==@vger.kernel.org
X-Gm-Message-State: APuU4Z976RdthEIhBIDxUbQWsGuo3Jwz5VBTVPZycR76eGR+H0/4UhGF
	NWeivm8O3bd2frfMESc17IZAJChv29hAvsUV6/EXu4swaLswNqkwNQq066xb6L5X1GE=
X-Gm-Gg: AYBFou3pah5fJikbOoRrKGJqSbOEaA74UVLEtN+kb/RIssR0KHj3karnmAYrT5Ima8S
	v9rSzyHbZDGj/myE7eSCFoPDmDyM9h0cr48f3RE8g8nPQkNCJQ1WYH+vi9hvqDYBv3az7MSC+fB
	i/MBxFSNwp6tzuP4GILxtupvM1XMHhKOlXwDpae3x7t6tgRufmSqhl5iBd0+BsBu2f8uCZ8ptx+
	ynj8GPKpsmpX5SB8uR5HU7Rwd6EIgrJdiD0nubF7a5hSSGwFU/QkgvOzk6zcZ+ojQhv1zZWTsOn
	mFsOzJQn9dByzvJ9v0GmUo8wLrQF/3mQ3WokViQr294MuC+DKNsSXeG89ykk/JUYRSm0wqDWVt5
	tZnXYZ8qmSx+wNQUdzIyZVoEL8AqrV1O282yMJO8h1m9I4BM/m1XS0nW/aefMeyRqmBkoeNTF6q
	MAjayqsLeBOeybLXtJcVRVZaQRZl6LG8FA43WxaYuzLZdR6Z2MdepG8OjfJLQeCydDe1S8aLBd6
	XTZfG7BnPYEGs5V+GgqXz6aANF6j24Fdwkwls+dY/TwP1/bo1Hd+n73tIZPYJpsLK4Ht8g8sgKQ
	97wPYovGAoidAnfWshoXVB7seXNoRirCcdpgjVqTDNxT1vH4f2CiQ+CrePkQzKr0FkJh1WuJtw0
	l3dpFp8jvRJSI
X-Received: by 2002:a05:7022:3a03:b0:152:9e88:daaa with SMTP id a92af1059eb24-1ac5f181628mr22731309c88.36.1793716273870;
        Tue, 03 Nov 2026 06:31:13 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:13 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, Kyle Bader <kbader@redhat.com>
Cc: Kyle Bader <kbader@ibm.com>, Anuj Gupta <anuj20.g@samsung.com>, 
 Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>, Tushar Gohad <tushar.gohad@intel.com>, 
 linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Martin K. Petersen" <mkp@kernel.org>
In-Reply-To: <20261029155821.2983229-1-kbader@redhat.com>
References: <20261029155821.2983229-1-kbader@redhat.com>
Subject: Re: [PATCH v2] block: only fail dma-buf bios that need block layer
 PI
Message-Id: <179371627250.3691261.14418388073265426531.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:12 -0700
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


On Thu, 29 Oct 2026 15:58:21 +0000, Kyle Bader wrote:
> All dma-buf (P2P) I/O to a device with integrity data is rejected
> today, at registration and in blk_mq_submit_bio(). Only a bio for which
> the block layer generates or verifies PI needs that. The block layer
> then walks the bio_vecs, and a dma-buf bio has none.
> 
> Reject only those bios, and remove the check at registration. Then a
> submitter that attaches its own PI, for example with
> IORING_RW_ATTR_FLAG_PI, can do dma-buf I/O to such a device.
> 
> [...]

Applied, thanks!

[1/1] block: only fail dma-buf bios that need block layer PI
      commit: d734b6433b2fd248bc25a2ea1fa60c34b40ba15c

Best regards,
-- 
Jens Axboe



