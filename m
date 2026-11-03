Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716268;
	b=T+gO3b5s5N2xDmg9sadMJngis2b96eU3X7Vqs6SL1z5v/gb9MRftCsNtlVGmr9pT88tT
	 dsnI+t7rehulQPu6N5Y5vAMeaNLqXArGwf/rP21XiO6pkp1ip6HXGmqd1SgscD9lUG/kx
	 vdCzkgmuue8cVqmNH1CCHwp9JFtjzQ6N72NJU9H2lXeN+6YMqLgq98KCTO8bUFvBF7woA
	 8o8XOklwgRoZv2wjm/fDMyzfCB96NhzPg76N0ddCRv01gqUdi2aAlfpwD0RKrqAZgO+Ot
	 9yTVc24mpsap15sQWsak1wTURx/jaD2rEzAp8bj6swxpK6MHLaQ2xvmyAO1YvfsWcMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=TDYXubwg/R2YZMIkfVjvc0zCht1CRa4fwx87fBOfgn0=;
	b=OHVz5z7AkngYyrtBdJ7cX4iKmod2umfEx7EJO7MVzS3I32Hh2JilB8NhmQHM+tkWmZho
	 G82OQ9l38YZXpR/ftGdlPuITGDrn2zk2Xz+ViE4vVzGH9G8elciDDPjV66lcMGnEGcfjS
	 CqoL5NQVOFEcFXiWdo76QbqzpmIemQgOHZGoaJ72ODiLswcZBk9Xnu3F3VocuIVHkoP1W
	 S+3/elMWLidiObswduyf8RQFaN0iv/iufkTUPt0OQ96nvD1Unsfy1hwkN8O//rVpohpAQ
	 elQfmOH073piGINdsN22t5H3JmUqBcYPcMFJMSpU3tfId6b6Xhr28yDaY4Jv2oLHuNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=uZnFdR+L;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114DD606D824
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 114DD606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=uZnFdR+L
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-14394530ec6so5584968c88.1
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716267; x=1794321067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TDYXubwg/R2YZMIkfVjvc0zCht1CRa4fwx87fBOfgn0=;
        b=uZnFdR+L3OPiUEGDCpAZ63X/Q7vx/nNunWYSlDlH2EK35tSe3/smu88ZJx1AAwhuo5
         Q3CY1EAeDaqHnBoDcUJf+EULvzzko0oZXnKZzrnGGQwHTPuAh+o3bw8khaiYMnrkIv8t
         eMstjo6slcdCOXlnXjN1s6rYEEDvcCJWXrVkoSD/QJYsKUgURH1wYAKmqhkZ/hTIMQQl
         teAmWmffecIYuTso12x4VaZ4o678Rc+KMOm906DK4yLeZdXtJrz+xd6Js1hkpyR/cqFM
         lLT4B9F2fL5tjKpWgo0RSY72MlPKzPHeTh+czDsAr8I05RofyJ13fG9FTr4P1goSvM2i
         ryNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716267; x=1794321067;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TDYXubwg/R2YZMIkfVjvc0zCht1CRa4fwx87fBOfgn0=;
        b=O7Nr2/Nm9Vr9hvHipwZLeFKN8b/J8dGJxndoGzpGJzKjtWWBMb2cSE4xWwBVKtu6Rz
         49xY0P+0i6/4x7Z25fkg5nQNw1OnZnsHC6rbRvI8tYqKcd3G6SG7YWveWuBTz5kFHUwG
         AaefdD3+dPR2bQ9BvPx5NuEZS61AtELzgDD+k4bdztnkNKKNVTCWSfF4rsj5jW22naBa
         iK9S0EhzMg8jcccgnM5ADKd1T8ohwAWyorfxKlaf0aWHfEWZeTPE76k86bVXYUL+I8Ox
         q9K0np6x5ww+9BFfxGAaNzm8JIgubMEtxPRGm6HNyiOwjo751ECkBKRQsF21BYiPxIdV
         cd2A==
X-Forwarded-Encrypted: i=1; AKwUvBxYMo1ZyDynT9vmPvcN3ZPXzdT/D18QebFAhKaXBc6ZDel1JubC4ir+Z7UYmDy8cGOk6R/bjbFxVEQtEQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+o5Ypm4l9J4zD3mjeIK48bqtbim3uOl+78UFBbNQKDci/vNb1P
	WfDDIY2CDXXbuYEDcapmx7VVcPgmSOoNX5cT3dSmfBKZdto8MCwji7oOY8HX2KoT0rWrrf/4yP5
	8Ivna5uo=
X-Gm-Gg: AYBFou15G3xcXIt2NMTGxhWFb4Dbo8+HAlzMvd/oLGTK773OTZAL4HnjvuUe6xL+BCA
	HhFQFh21FG+hQDvLIdc22bOoWzsYYH7VA69z/rWfKhJZhwEwcVJqUKa0xcg6OX7vIBWkmfH9Exs
	/Sjv2XuuqZzubjaishqMQulC/IShyfgTdMybmFhE/8Ylv+MMNSzGa7B/AuUkkHRP4TnxQ0BMN2t
	5WV7KA468zepli2H2XTMP8IiDsseITs/CDVEabPfGCrrG7CMOz6+7Mf2z4xugtPHRN8RsUrzcfx
	2FDXPZwPCeyYVVo35xyIp6Qu452MEmfPMJbnV8IQ6c8j2dEelRYEfMYUo1Axq2gxhWmbFyDaXro
	FZzQBI0aM38eLxLN2LmFFeXt7j0zRw7VcWa0yVUa22Tqzxr0hyW5bSaz3zEidJtQxsm+/+ogkdr
	ou0eHGdzuSuJHFNn2PaqmsJ8b15qFvfgQAxgRsirsyQtsTLAwfxLVeC1iCpf5BIr+1o7Q8BSSlm
	Ip6anY3jAYeUyfO+eFNvNTM/1raN0XZTVNGDfvI45wJA+Wph24pzAxGk0CpAdcZ6hZwUiGknXI7
	MAfSDIHmAb49E5Foyk2YytJQYqB8I9PRo2pNYT2CubN7QW/k/ZFLkK6x/DN+nEsms+WgvkHhXlZ
	he4qzTXi3NnvqX+cd/V9GkO81Ubx6tzOxvQ==
X-Received: by 2002:a05:7022:f908:b0:14c:d84c:7182 with SMTP id a92af1059eb24-1ac5da75597mr17665992c88.22.1793716266905;
        Tue, 03 Nov 2026 06:31:06 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: arnd@arndb.de, ben.hutchings@codethink.co.uk, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261023153645.37546-1-dennylin0707@gmail.com>
References: <20261023153645.37546-1-dennylin0707@gmail.com>
Subject: Re: [PATCH] block: Return the soft block size for compat BLKBSZGET
Message-Id: <179371626606.3691261.1284483179085449929.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:06 -0700
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


On Fri, 23 Oct 2026 15:36:45 +0000, Hungyu Lin wrote:
> BLKBSZGET returns the block device's soft block size, while BLKSSZGET
> returns its logical sector size. The compat BLKBSZGET_32 handler uses
> bdev_logical_block_size(), so it returns the wrong value when these
> sizes differ.
> 
> For example, on an x86_64 kernel a native query of a RAM or loop device
> with 512-byte logical sectors returns the initial soft block size of
> 4096 bytes, but an i386 process gets 512 bytes. This makes 32-bit
> blockdev --getbsz and the BSZ column of --report disagree with native
> queries, even without a preceding BLKBSZSET.
> 
> [...]

Applied, thanks!

[1/1] block: Return the soft block size for compat BLKBSZGET
      commit: 57cd1a08717690e5ea01d7ac7a96bb33a2dca117

Best regards,
-- 
Jens Axboe



