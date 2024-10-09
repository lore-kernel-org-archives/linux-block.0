Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ACD196C86;
	Wed,  9 Oct 2024 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480006; cv=none; b=nlzTeZuajurvg6O9XikGM/KWC5W/Um+P6gvy1DwbReFQsyrUL6ghlYIyG7jCBGCR2u839spgWY/YrxfK/zgajpmjWQWjLiUg3OTCRBA9FKQ3AMP4kLizOpLukOkda7S3BcOOyBra4/7IfmCamoZJeS05OIzvJcE10mPumYnApqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480006; c=relaxed/simple;
	bh=/6zX/Tj8gWAC7yFovU4xDjO2DGh9/SYgizXBiOJ4HZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hz/cqjWCHdW3vhrnWTIaP1Q8c2LppO9H3YNG7yswV3EMaLxWNQkMn+ZxT4NnFkgwQ/ZJNMWfsQbnehPK6xeBqITLdtbiul2sjJP4CvuQwoD3k+/hfUVJUsNA/R51raOE8K0yw9fSsCunTe/NmU6fUbEzRxBaer/TBK48uOaE5Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me; spf=pass smtp.mailfrom=bjorling.me; dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b=i4/u3j5Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zjn6SWKP; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bjorling.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b="i4/u3j5Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zjn6SWKP"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A210313801C5;
	Wed,  9 Oct 2024 09:20:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 09 Oct 2024 09:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728480002;
	 x=1728566402; bh=CCTu9/F6jubvRF/VFjjIwubXxVchs2h+hTOjh90UQGs=; b=
	i4/u3j5YT1iIZTqYwJhTwppxd2xoNTrTtw00BGR3G1afALcb2gbTf8BMU5YAv8io
	yUwQ/XLUwch+gSQ1ItFUaRQQu9cx4IqsUwt3zNQzZL1IHVKZ/21dE1WknXrM8m8b
	saNqjW7PmpDZY6rtWO4HbXsQ8XPi5ePh3OfE78Bc8fpe10ET7vyWXJpt3pq5E7dt
	hbaK7TXaXF3BC/Mnau+59THXZLDE9lbvAxB8p2OIzPRakW4qEHqg58cZeOyxdswH
	07PuMhgvzD6SjCQ6O/FsKnQJt9HLdPWePQX8VQIHbYgKqy5SgsThlykTP91EgWdT
	O6FG6CXGuv9ju874UMZJBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728480002; x=
	1728566402; bh=CCTu9/F6jubvRF/VFjjIwubXxVchs2h+hTOjh90UQGs=; b=Z
	jn6SWKPU3ZQ2MIvA1dHWtOKDOZ/KTvRSfn74/uWGoKpnEUkBt5/JFGZ+YZFbUAaw
	euYx7Mpc1vc/6GOwMC6AXarmXa74DKq2k9hCfup/3QyW2AMsXFlOBu5h/R22lMdK
	GRX9emdpm9ENfmlXW32TY5+7hsqeSNffCi4eZ4xU4oDS3CR+kaWMqYpUzL5n6PKd
	xeNh5B/OLWG4apCIIqct1Xs7Fim4TvTGXeBC8s9aQBIs0lP2uRsPu5BBxH97GnCY
	1nXcfLHnkTEVQatcNZVt1WbQAMPlRtWWmFW3tMBJeWBP3G3/BO4Q16RaGr62hcqh
	8S/EMnEDFyxF9blD8KoqA==
X-ME-Sender: <xms:AoMGZ2WZvbpVFJUzBWGTNc-mTVj6EvRRaewze08bDfMvMRfcFGhN-Q>
    <xme:AoMGZykqnSEEfmv0k8_ci5zMkFXVXAZKk9UGmmIUZqeckRERCknZ_IhIt54udR2z-
    wObyOG_lDzqkGPDQ_w>
X-ME-Received: <xmr:AoMGZ6Yh-OY5jLNaiEqRb-oBw4ZZoFJOxaPicGgwDw-G9zzFn5udqb6aj0QXscPCeCvcqNKcJMRFgm1SSPE0BEgkvNOYlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeforghtihgrshcuuehjpphrlhhinhhguceomhessghjohhrlhhinhhgrd
    hmvgeqnecuggftrfgrthhtvghrnhepkeefieeutddvteeguedthedvudfggfevgeevkeeg
    geefkeeufffffeelleevgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhessghjohhrlhhinhhgrdhmvgdpnhgspghrtghpthhtohepkedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpth
    htohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegulhgvmhhorghl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghsshgvlheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqnhhvmhgvsehlihhsthhsrdhinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmrghtihgrshdrsghjohhrlhhinhhgseifuggtrdgtoh
    hm
X-ME-Proxy: <xmx:AoMGZ9XjzIMSXX8pK1x_zN2RgLy1XmMEZuVDMTuFFcVKzkA38mvimQ>
    <xmx:AoMGZwkkji1XEuA3C4S9tbSRE1iygIjrrgkA2ZljO87i6ex3_mXlUQ>
    <xmx:AoMGZycKGKEfsaOF1UnwwxTT4yCW_0zAB1yhICkGs5k8mpKwd330wg>
    <xmx:AoMGZyHu7NBhajM-dyGJE2UhBlBw-CEW4tcuKEEdFajc9aILx8ipkw>
    <xmx:AoMGZ66_KkwLb2Rz5GwZFZk1Dvk4s5hujPDod_mvbIbk68XiGd50xsBv>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 09:20:00 -0400 (EDT)
Message-ID: <0076eb5e-6816-490e-abaf-a0a4a25a2915@bjorling.me>
Date: Wed, 9 Oct 2024 15:19:59 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: make independent ns identify default
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, dlemoal@kernel.org, cassel@kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Matias_Bj=C3=B8rling?=
 <matias.bjorling@wdc.com>
References: <20241008145503.987195-1-m@bjorling.me>
 <20241008145503.987195-2-m@bjorling.me> <20241009074611.GB16181@lst.de>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <20241009074611.GB16181@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09-10-2024 09:46, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 04:55:02PM +0200, Matias Bjørling wrote:
>> However, the independent namespace data structure
>> is mandatory for devices that implement features from the 2.0+
>> specification. Therefore, we can check this data structure first. If
>> unavailable, retrieve the generic attributes from the NVM command set
>> identify namespace data structure.
> 
> I'm not a huge fan of this.  For pre-2.0 controllers this means
> we'll now send a command that will fail most of them time.  And for
> all the cheap low-end consumer device I'm actually worried that they'll
> get it wrong and break something.
> 

It's a good point. Damien, Keith, and I were debating it during ALPSS. 
They preferred the "send command and see if it fails" approach over 
writing specific conditions where it would apply. Note that Keith did 
suggest to avoid the command on 1.0 and 1.1 devices, and they were known 
to fail with unsupported CNS ids.

If making the check conditional, I think checking if the device follows 
2.0 specification isn't sufficient, as some devices may implement a 
subset of the 2.0 features (for example the independent ns data struct), 
while reporting as a 1.4 device.

Is there maybe better way, that isn't dependent on some feature being 
implemented (such as CRIMS capability)?




