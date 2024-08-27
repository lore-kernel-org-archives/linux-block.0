Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA014F9FF;
	Tue, 27 Aug 2024 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743679; cv=none; b=HcVsx464LCLWMQPQq1EykkppJP6I/eudCX9ExojOmhrelyWla9k3Xhb9jxZ+ZyvHRmkwC4ds2J0QJ7APLNKf0croYbO+OH2wqhhwNGqB/oLT6qZdBC0AgNiFoUUpsoB8a687Sk+aVz42BtvBa09MhOaE621PccyN2k57jGt7mRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743679; c=relaxed/simple;
	bh=BZyZ2cvkrIUZObBp8WGC/AhGz5F/J0FSqyr/3/Xjn4w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iYABzZ8j5rABPeZm3eBV59wYCPg5jl5xX6TmMlxThwyeZTPZpUtsuljhUymSwjbpLW3ICOJGY1dfRzkQQuUScju76zJOfkpXC37uapmT72hDpd99Wfv862AiZVDOriq7pMyFOW9Uue7SqI0IjsgwjwvXxT4pU2Xrv0IkbGr6h7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Mdlew4i0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MYaZn9YM; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Mdlew4i0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MYaZn9YM"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5C9F4138FC5A;
	Tue, 27 Aug 2024 03:27:56 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Tue, 27 Aug 2024 03:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724743676;
	 x=1724830076; bh=Esk86+10YT5N76WYsSmhYI74I1I6jgp/wldSeqEhXAw=; b=
	Mdlew4i0/RqAzlKb/M+bHo6td4N5mGnr/6Ps19zfwrX7zzKjv43jG5Yj4yR/dAAk
	2pOyj0ZVoaHVLE6P64WgYFc8xRr+EillYWcnkUh9MD56JRTuYObwEpayqQidOOpt
	tVJ7MmHF1wCSJTgPJm1ApNHwIXdTu94AkeWvSGeFry55EaqTd+WNdp3w8dZGY9Em
	o6UhNqG9wkfw2xy+W1WL6elsWGy4u9BcuMLcKoUVxtFvZPW8M6HwYvcn18denHOi
	7vXpOq3cya4QTyxTQO1aK5OPhTTBsjcuHN1WW4PfFVLhSmeMhdGMINxy7DbS578i
	3Iu1u9jJi7s9CAqGWlpO2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724743676; x=
	1724830076; bh=Esk86+10YT5N76WYsSmhYI74I1I6jgp/wldSeqEhXAw=; b=M
	YaZn9YMUpc0IG7KhLZ20GSAxbkaOSuNIlbX82L5vYPEtwOCL/nHKITetgq28nD+P
	FLRgolvRyFgzz2penuFVTVzT3xw7CXwKhBP//ZSkaCXBlQLkWDzj/0sNMaSf5WTq
	nlaxL+8TxxJc3zDHwPbwy06lqOuGj3CzHbo1y053tO600z9Ts6+BO2z11wm803kS
	0yU2T7NlOvWgbPKp59dP8aNNfUWaZ4A+fAHGauQ2l9nYU5BNmfByD9WejrZ10GPc
	lBZIduAQSctFKsyZgtG8nGQsiEqZ0T84lmnurDSy+xTR0hnZAwySxKKYpwDL0jUa
	bJMcKpovMN88kZA2DJX5g==
X-ME-Sender: <xms:-n_NZpxxTRjjrMe8yWdmKLpuCL4dvV4pg7JyPvMUR3PA5SAwaiPk0A>
    <xme:-n_NZpSj0Thd97RCCmt9MKk0i_NtGxVIc4JzIpoig2jzU7kuXaWfCR_BlRAsu-UPc
    H5Jskkhc0CJy6508vo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvledguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrthhtsegtohhnshholhgvqd
    hpihhmphhsrdhorhhgpdhrtghpthhtohepfihilhhlrdhnvgifthhonhesghhmrghilhdr
    tghomhdprhgtphhtthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtohepsg
    hrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghjsgeslhgrphhtohhp
    rdhorhhgpdhrtghpthhtoheprghnuggvrhhsrdhrohigvghllheslhhinhgrrhhordhorh
    hgpdhrtghpthhtohepuggrnhdrtggrrhhpvghnthgvrheslhhinhgrrhhordhorhhgpdhr
    tghpthhtohepnhgrrhgvshhhrdhkrghmsghojhhusehlihhnrghrohdrohhrghdprhgtph
    htthhopehsvghmvghnrdhprhhothhsvghnkhhosehlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:-n_NZjX2CabCPD6zOP2HTZNKYxS_6XuTYuQ7iY6caY4Au8QENbTA0Q>
    <xmx:-n_NZrjeMNmKLmMV3z7wx_iqS6lWRQr4_xpC706pu53gUcNXABMf5g>
    <xmx:-n_NZrDoy3_GN-4pTDkxXaOqaRvuAHqyG6iRb-4MN1GKUR7r32LZag>
    <xmx:-n_NZkLPBkB6pVK57b3-k-baKbWI8bSnlEm8_rRKd5WViWVfnHbiAg>
    <xmx:_H_NZtTQ16KJybkantfaoavmKB9nXMXz0xSIHBI4RfR9d-Xm5KjM5MPa>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C2AAC222006F; Tue, 27 Aug 2024 03:27:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 27 Aug 2024 09:27:34 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sam Protsenko" <semen.protsenko@linaro.org>
Cc: "jh80.chung" <jh80.chung@samsung.com>,
 "Ulf Hansson" <ulf.hansson@linaro.org>, "Christoph Hellwig" <hch@lst.de>,
 "Chris Ball" <cjb@laptop.org>, "Will Newton" <will.newton@gmail.com>,
 "Matt Fleming" <matt@console-pimps.org>,
 "Christian Brauner" <brauner@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Sumit Semwal" <sumit.semwal@linaro.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <bd334314-25f7-4e87-bcab-e3baed9a7ab5@app.fastmail.com>
In-Reply-To: 
 <CAPLW+4=NcjOFRd14ecYd8sMsiJXH9c+ZXse7BVMCWe5ZbMmKMQ@mail.gmail.com>
References: <20240306232052.21317-1-semen.protsenko@linaro.org>
 <8896bcc5-09b1-4886-9081-c8ce0afc1c40@app.fastmail.com>
 <CAPLW+4=NcjOFRd14ecYd8sMsiJXH9c+ZXse7BVMCWe5ZbMmKMQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024, at 03:28, Sam Protsenko wrote:
> On Thu, Mar 7, 2024 at 1:52=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> w=
rote:

>>
>> The change looks good to me.
>>
>> I see that the host->ring_size depends on PAGE_SIZE as well:
>>
>> #define DESC_RING_BUF_SZ        PAGE_SIZE
>> host->ring_size =3D DESC_RING_BUF_SZ / sizeof(struct idmac_desc_64add=
r);
>> host->sg_cpu =3D dmam_alloc_coherent(host->dev,
>>                DESC_RING_BUF_SZ, &host->sg_dma, GFP_KERNEL);
>>
>> I don't see any reason for the ring buffer size to be tied to
>> PAGE_SIZE at all, it was probably picked as a reasonable
>> default in the initial driver but isn't necessarily ideal.
>>
>> From what I can see, the number of 4KB elements in the
>> ring can be as small as 128 (4KB pages, 64-bit addresses)
>> or as big as 4096 (64KB pages, 32-bit addresses), which is
>> quite a difference. If you are still motivated to drill
>> down into this, could you try changing DESC_RING_BUF_SZ
>> to a fixed size of either 4KB or 64KB and test again
>> with the opposite page size, to see if that changes the
>> throughput?
>>
>
> Sorry for the huge delay. Just ran the tests:
>
> - 4K pages, DESC_RING_BUF_SZ =3D 4K: 97 MB/s
> - 4K pages, DESC_RING_BUF_SZ =3D 16K: 98 MB/s
> - 4K pages, DESC_RING_BUF_SZ =3D 64K: 97 MB/s
> - 16K pages, DESC_RING_BUF_SZ =3D 4K: 123 MB/s
> - 16K pages, DESC_RING_BUF_SZ =3D 16K: 125 MB/s
> - 16K pages, DESC_RING_BUF_SZ =3D 64K: 124 MB/s
> - 64K pages, DESC_RING_BUF_SZ =3D 4K: 137 MB/s
> - 64K pages, DESC_RING_BUF_SZ =3D 16K: 135 MB/s
> - 64K pages, DESC_RING_BUF_SZE =3D 64K: 138 MB/s

Thanks!

> From what you said, it looks like it may make a sense to reduce
> DESC_RING_BUF_SZ down to 4 KiB? If so, I'd suggest we do that in a
> separate patch, as this one actually fixes kernel panic when 16k/64k
> pages are enabled. Please let me know what you think.

Agreed, sounds good to me.

     Arnd
