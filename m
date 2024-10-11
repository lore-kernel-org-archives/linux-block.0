Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE72199234;
	Fri, 11 Oct 2024 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667969; cv=none; b=D76q1mvQFrjh7F2tSIph19fQZhksb0ewFICrvP+Jl/iLlH1qm/dNGQpY2U0Ax7l1BqGw6ykXEZas9NfVzs6eH1VZ9D8okfzUFnk84WGnN61YkXVtC2XQMlc3ROqubSYzQOV3jacsiZVXtl2h/JGkJTV1IfE5Wv11ACwTb8IRSak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667969; c=relaxed/simple;
	bh=9CkUuKL47esnuYB4rzdSD0YMfBXPI4yPI1K9UgwAZ30=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IuJu5Xej1hVTzttV3YKpqXClzSE2dKIxxqnEh78J2g1PR+fIOGKZnBIi+tvNrpVR6kcus0hy+8EPujZbnWKuYJne2q0dMxe8qpujcA5nYMeZFU9Zzv+LPtIGZSfNecId0e2XD8XoPwNNeB6/tW4UKrPyWCay6GFf9TPhNWDO8q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me; spf=pass smtp.mailfrom=bjorling.me; dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b=kZO5GIOs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AtDMQtdo; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bjorling.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b="kZO5GIOs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AtDMQtdo"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0CCC913803B0;
	Fri, 11 Oct 2024 13:32:46 -0400 (EDT)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-01.internal (MEProxy); Fri, 11 Oct 2024 13:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728667966;
	 x=1728754366; bh=9CkUuKL47esnuYB4rzdSD0YMfBXPI4yPI1K9UgwAZ30=; b=
	kZO5GIOsjG1Uu6g8+Uq4Nu5sa7ZPNxCvkvjubYn5JWNwUFqAakgGuYdFCnMAxIbE
	JqZLx2zdAF+IZf8vbjA6Rf6cUXgiOrauRtLhArMFqavd0oKa2UeU1gswjYh2LFs1
	WyQAyjt5ZzljKUY/Bfam0EVHSj/dmMY0g19Zyga12/D4eoPE8vD6Uf9F3RVK9fxf
	nEzt0b45GwyNgkAmMqm/5TYrpwXAiri4h7THc0/m8T/xgcbNafdXNow4z09nh+12
	htPRq/JNvMmxF42hM+rq5GSaBJsCcwJ34i1/wbVyOowwIt7BiSOYkFGOsLVd6Okp
	ZUie/Hoc2a8bw2QkYT3n7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728667966; x=
	1728754366; bh=9CkUuKL47esnuYB4rzdSD0YMfBXPI4yPI1K9UgwAZ30=; b=A
	tDMQtdog4MuyDXvTP1C6h7F9+FJbbTm9aGsabGM9HovXFhjKjOwOBYz4q2h7IZZF
	KyJcwG5PW2qUi93W7hj0/lPgH5a088bj2eH3OeXw7Cvw8xmE9kwdf5Qc/G4vrP16
	JQllC5kzPzloqVrvkKkniPCmTyJYkdcqbRMeN5hH6xbBjgnkXKCNyatPTT8p56ud
	S/5GfH1THOy8oAjjibST2LO0RT7lFpuBVnxs1NCXUT7n/OWnsnAbeyeZl5TYZsJT
	3sdbfgypJoz8azLtF8yAhqKZW6uxQHVBmfcL6qqwCrsIGZpQYGzBfCMMY0z463GY
	teRsrK+nDyseoImg2nGRw==
X-ME-Sender: <xms:PWEJZ3C1MGuOZgLU6Z-ANXLuCxiLC0J2ruSWE56pdJ6nFj4mHzCnvQ>
    <xme:PWEJZ9j89RFnFQT5Qa1N9lmKIy0LIMCRJyOkDNK7QZdcHtrdO0bd6ldHDxIvP6riR
    Dp1xIsWAhqFgLaUOHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepofgrthhirghsuceujhpprhhlihhnghcuoehmsegsjhhorhhlihhngh
    drmhgvqeenucggtffrrghtthgvrhhnpeekkeevfefggeduueejleelkeduveeigfeljeff
    udejleduteelffeuffekhfetleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmsegsjhhorhhlihhnghdrmhgvpdhnsggprhgtphhtthhopedu
    uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfigrnhhghihughhuihesvgduie
    dqthgvtghhrdgtohhmpdhrtghpthhtoheptggrshhsvghlsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegulhgvmhhorghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehksg
    hushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhvmhgvsehl
    ihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohephhgthheslhhsthdrug
    gvpdhrtghpthhtohepmhgrrhhtihhnrdhpvghtvghrshgvnhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohephhgrrhgvsehsuhhsvgdruggvpdhrtghpthhtoheplhhinhhugidqsg
    hlohgtkhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PWEJZykQZwWMORQ63au5LvuRQ9ToY6Ybxq7SH0nfbjZu_XroPa1XoQ>
    <xmx:PWEJZ5wjFp7n-e4NxlEIIHeFqrp2b4TguTDlEjWRHIvEo7BtAskwbg>
    <xmx:PWEJZ8QVf4tfOnbjs3-yul9cfQoRfga3A2n0Or37ax0icBPyNs2RkA>
    <xmx:PWEJZ8b4QBzHKx2eWirZ6EsQ4TrccIQnOe57zf4uUSM55wGv3B45mQ>
    <xmx:PmEJZxKhplYi0vd_WYDCm5t7_dAGADrEKF-3ml9u_oIJ-HXsAIuZ4jgE>
Feedback-ID: if4314918:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 23E6C1F00073; Fri, 11 Oct 2024 13:32:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Oct 2024 20:32:23 +0300
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
To: "Christoph Hellwig" <hch@lst.de>
Cc: kbusch@kernel.org, dlemoal@kernel.org, cassel@kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, wangyugui@e16-tech.com,
 martin.petersen@oracle.com, hare@suse.de,
 =?UTF-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Message-Id: <455d17f6-ec55-4bce-b9d3-9f43eb4a056a@app.fastmail.com>
In-Reply-To: <20241011081452.GA3337@lst.de>
References: <20241010123951.1226105-1-m@bjorling.me>
 <20241010123951.1226105-2-m@bjorling.me> <20241011081452.GA3337@lst.de>
Subject: Re: [PATCH 1/3 v2] nvme: make independent ns identify default
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024, at 11:14, Christoph Hellwig wrote:
> On Thu, Oct 10, 2024 at 02:39:49PM +0200, Matias Bj=C3=B8rling wrote:
>> From: Matias Bj=C3=B8rling <matias.bjorling@wdc.com>
>>=20
>> The NVMe 2.0 specification adds an independent identify namespace
>> data structure that contains generic attributes that apply to all
>> namespace types. Some attributes carry over from the NVM command set
>> identify namespace data structure, and others are new.
>>=20
>> Currently, the data structure only considered when CRIMS is enabled or
>> when the namespace type is key-value.
>>=20
>> However, the independent namespace data structure
>> is mandatory for devices that implement features from the 2.0+
>> specification. Therefore, we can check this data structure first. If
>> unavailable, retrieve the generic attributes from the NVM command set
>> identify namespace data structure.
>
> FYI, I still disagree with this for the same reason as before.
> Assuming we're not really going to see hard drivers I'd be fine
> with using it by default for 2.0 (or better even 2.1) by default.

Sounds good. When I am back after next week, I'll update the patch set w=
ith the version check and add the missing logic for hdd support.=20

(Apologies for double e-mail. My phone client formatted the mail in html=
)
