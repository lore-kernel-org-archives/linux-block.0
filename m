Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05602F002B;
	Fri, 25 Jul 2025 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753465550; cv=none; b=BHRoB0RIkNoLfZkRehZ2Pvr932rxL8KeBFw/uOlTqJytr8J67kRC/zJoDfSyUhi12qZDLA3qmE69/XFxE0DDRzdq0lwGRNHHCQKrxvgNe8LCzWwGaTyRvkQrRIjAzM1XVLsv7hKvkugI3v3Rvto8KDllIcf+9nlt66G4SC3QfAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753465550; c=relaxed/simple;
	bh=kqjOsYV1dwZtbVp4YcwJK3dkFL2NQdW6Brs3S160ElI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jzXITuMFgbNRJV8zpAGZNwv+DHMnT/OHUKs/1siLCJmmVTz9OEczOa+ATWGMDxKPTOV68coravmBAETuFDLhwFSvMzjCNSwJtCnVr7LL1M+lzMPi84fUR0u81rbEo1t1loGVTEg+1DWVOz20smwjfo2hY6MkPTwx6BpyTICJyBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=aT5Oy0Op; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HmfMytkj; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="aT5Oy0Op";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HmfMytkj"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 930767A0BDC;
	Fri, 25 Jul 2025 13:45:46 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 25 Jul 2025 13:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753465546;
	 x=1753551946; bh=nEOiVj+k4RG5cBWauFfY00x2LUoWxbAG5Bjsu+VXqts=; b=
	aT5Oy0Op2iV6vGDI5TFCTrslSwWXAarVR5n45punqAqk5ai+2z7ks6tOBejazU17
	/nOE4TzqBCEMNKnhO8uTUeADlNER2ZOWCJm+cfnUAmjehrXlT7ZYZR4oXyL+nICe
	OdRLt7G6LEw2L5yiX5J+xZAab4CO+gbtjqYZhf5K/79bBE+JQ6bCptV8N+9CidfX
	UZ30X9Z9Z6DU3clKjgL/zaMjy0TrAGShSVb9wyyh3GY697pBVZ9gSyA2EaT9PZCf
	ckPZQlMAzEeiV4cW8+fBPqceUxvLmeBbryzJGfCcZrSQflk6JQ/T+cmKwH2Z+9/M
	Fa9pqxANGye90qbTd/RLjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753465546; x=
	1753551946; bh=nEOiVj+k4RG5cBWauFfY00x2LUoWxbAG5Bjsu+VXqts=; b=H
	mfMytkj8JPHGMbn3PTAoEFJr/Kd/Gs4FP8sCvAcmSScORYMl7kOhpBPxttFtjihm
	i7bPF+9rjgaNJwaU72zq2T7LZojwQ/OlgOC2ywUn9DnT3BJ9XCpFMu1dlLFQQTp7
	ZQhk0oyeh9TZnpirot6Hp+TPIwbPDkzAiTxgnSLIoWGzaR9X0A63k8Cxj3t3Todi
	sXXPFO8yBlkEBlgKoQCQ8Gpe8Pyek9g5VZNKjo9gOPXlHAA6vTy9mAKDIPR+KRq6
	G+zoKsW/dpYSiO70EJ2J/1jh/ggNnmUmhhpJFySfNwA3eCeyVJrxjUHorIlHMO5c
	qT0jSVfOj2uN557/7zBgw==
X-ME-Sender: <xms:ycKDaGMHZcWNPre-Jye-LV8iC-axMi_4b4ReiiU73v00NoIb4WhYjw>
    <xme:ycKDaE8z4cFOs8i4ahIvx26KlrOB42ZXRe9oFvNH_dWRVeGWxHHI2UikaESj7AtyI
    fkfklyptDVNCokQUO0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekgedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeekleffjeetvedvgefhhfeihfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghp
    thhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrughosghrihihrg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghsmhhlrdhsihhlvghntggvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepkhhlrghrrghsmhhoughinhesghhmrghilhdrtghomh
    dprhgtphhtthhopehhtghhsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprgig
    sghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehksghushgthheskhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:ycKDaB9jOEnq7KjcDjOznLIOJh4sO_lf2E4QrDoT6Y0qfPCDH4hIVQ>
    <xmx:ycKDaAYUUff0OrDluAE_he0UYE4pz4q3lZiLtaPXeiWi7HeCI9R8Uw>
    <xmx:ycKDaHu0jHwawMz1NYVB0Y2puPJkpodOG2YCss9HM7OopkrLVloYxg>
    <xmx:ycKDaMn8aDd1JcJ0_qoA0PoXKNn24K6h8d1w_FvRPVeYOHnrZaXaNw>
    <xmx:ysKDaHmdL2GEK3QxAWojKE_6PGZSxVQJAaHqCYB0G91JxGifjKxVvrql>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7B2BF700069; Fri, 25 Jul 2025 13:45:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tbe00407d24766a89
Date: Fri, 25 Jul 2025 19:45:25 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Klara Modin" <klarasmodin@gmail.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Anuj Gupta" <anuj20.g@samsung.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Kanchan Joshi" <joshi.k@samsung.com>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Keith Busch" <kbusch@kernel.org>,
 "Caleb Sander Mateos" <csander@purestorage.com>,
 "Pavel Begunkov" <asml.silence@gmail.com>,
 "Alexey Dobriyan" <adobriyan@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <2b0865be-c198-434c-bc06-e11a53e7a0cc@app.fastmail.com>
In-Reply-To: <20250725164334.9606-1-klarasmodin@gmail.com>
References: <20250725164334.9606-1-klarasmodin@gmail.com>
Subject: Re: [PATCH] block: change blk_get_meta_cap() stub return -ENOIOCTLCMD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jul 25, 2025, at 18:43, Klara Modin wrote:
> When introduced in commit 9eb22f7fedfc ("fs: add ioctl to query metadata
> and protection info capabilities") the stub of blk_get_meta_cap() for
> !BLK_DEV_INTEGRITY always returns -EOPNOTSUPP. The motivation was that
> while the command was unsupported in that configuration it was still
> recognized.
>
> A later change instead assumed -ENOIOCTLCMD as is required for unknown
> ioctl commands per Documentation/driver-api/ioctl.rst. The result being
> that on !BLK_DEV_INTEGRITY configs, any ioctl which reaches
> blkdev_common_ioctl() will return -EOPNOTSUPP.
>
> Change the stub to return -ENOIOCTLCMD, fixing the issue and better
> matching with expectations.
>
> Link: 
> https://lore.kernel.org/lkml/CACzX3AsRd__fXb9=CJPTTJC494SDnYAtYrN2=+bZgMCvM6UQDg@mail.gmail.com
> Fixes: 42b0ef01e6b5 ("block: fix FS_IOC_GETLBMD_CAP parsing in 
> blkdev_common_ioctl()")
> Signed-off-by: Klara Modin <klarasmodin@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the fix!
