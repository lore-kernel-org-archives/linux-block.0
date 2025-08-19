Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CBF31194C;
	Tue, 19 Aug 2025 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629369; cv=none; b=DrcOmwmwbmqGd2CEyU3I83+meYaphS6Iao/DZvrboQDwk12SO4Lo3W9TU/rbAhfmPVSj3F9gVppFzflvthBQWv9QqXHs7H5LW45lnCimbU/HQaRsgpINZoYKRqziCG09b2nNtWbZ76MOQmAff0LBiEELNT1Byc3mzElHdnXujs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629369; c=relaxed/simple;
	bh=7PY2nvBiFg+PmH3kasIozmSCqMsV1czCdVRZ4HT8eEo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PFhFWGsV0BLhdRwsrs4Al3QuEiLYGCQsE83FkqiywlD0uxw3ocP+yGJpO/DqxVwwCeDH+sid0d12Jm2hGTjnQtfXkkdYZ881ANwqzmWOIDmfwIBcgG1Zxh444CaEci/F296yJf20RM95iAJFVGW/WD9FCjOVL4q7QXN1Tc9aqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xmpr6nUl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xmpr6nUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0B9C4CEF4;
	Tue, 19 Aug 2025 18:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755629369;
	bh=7PY2nvBiFg+PmH3kasIozmSCqMsV1czCdVRZ4HT8eEo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Xmpr6nUlxhT4ML+rFt1gIMnPEVpYqIqWjpUkgUQR5tX3Ea3qBYnKk1IyWsYC7sBet
	 QBsMrRk3r7iMu12daYBH1ylIKK33Dgbw2Y1MuCT43OUlbupun65NOdzuJa9IY8ytGJ
	 F2KoEBiwNJLZb2M/WkquLSxMBkG+zUTjWlAYLvA7NXHrkQmzA8GdxTTiqKCPXXi78g
	 mN0g5G7szNsgyUdSlZmbkMIIrt7pMw7M4uyf1LOzcmC10UoLlqg1CBOGjbTIEq00Ec
	 HfGNVq0UJwNkN4j62cFWRW+/HtCdXt1of9/eic9VtPkqlZST1PzxASg8IfYr3RIGmP
	 SUG+MxNe67pLw==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 31D3DF40066;
	Tue, 19 Aug 2025 14:49:27 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Tue, 19 Aug 2025 14:49:27 -0400
X-ME-Sender: <xms:NsekaGLkpYYn_tL5rT3yO_BkXqxiddfgdxidgKxcHaH-MXl652p3cQ>
    <xme:NsekaOJlIC7TCSjCwYmRCpvzsFljgqYaxuYOZolEbVOqnFcN0Yb2GZzTgHG2uybzM
    aWMSS4nJkDgbbBx7tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeivdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfnfgvohhn
    ucftohhmrghnohhvshhkhidfuceolhgvohhnsehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepjeevffelgfelvdfgvedvteelhefhvdffheegffekveelieevfeejteei
    leeuuedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eplhgvohhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdeftdehfeel
    keegqddvjeejleejjedvkedqlhgvohhnpeepkhgvrhhnvghlrdhorhhgsehlvghonhdrnh
    hupdhnsggprhgtphhtthhopeefjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    jhhorhhoseeksgihthgvshdrohhrghdprhgtphhtthhopehrohgsihhnrdhmuhhrphhhhi
    esrghrmhdrtghomhdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdp
    rhgtphhtthhopegrsgguihgvlhdrjhgrnhhulhhguhgvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehr
    ohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepghhlihguvghrsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehkrghsrghnqdguvghvsehgohhoghhlvghgrhho
    uhhpshdrtghomhdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvg
X-ME-Proxy: <xmx:N8ekaMdwa-bjfjKiy_bnjKe5pj-w5KnECjXqAsQ2QeQdV4SQA7pQwg>
    <xmx:N8ekaPdCW9gH5-vPa6JOMA4aaqp_1mwWnXjSovauczKDDBtpYQ57dA>
    <xmx:N8ekaKnKy6VKuw8SWj7LEaUJFkqm2rbcIMv54YWlw8KOdD3OfERqqw>
    <xmx:N8ekaE8iyeSnMuDLLObkGrzOSgmAQEbj_4QdVJQzRyQ8881Jp0dwDQ>
    <xmx:N8ekaGEni2UyRaNp_TjZoxjj4fIEinDxeQ57M5QUT8SDp3Eg6UepfRUM>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E45512CE0071; Tue, 19 Aug 2025 14:49:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A0xmfm2pPGfg
Date: Tue, 19 Aug 2025 20:49:08 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Leon Romanovsky" <leonro@nvidia.com>,
 "Jason Gunthorpe" <jgg@nvidia.com>,
 "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Alexander Potapenko" <glider@google.com>,
 "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Christoph Hellwig" <hch@lst.de>, "Danilo Krummrich" <dakr@kernel.org>,
 iommu@lists.linux.dev, "Jason Wang" <jasowang@redhat.com>,
 "Jens Axboe" <axboe@kernel.dk>, "Joerg Roedel" <joro@8bytes.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Juergen Gross" <jgross@suse.com>,
 kasan-dev@googlegroups.com, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-nvme@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-trace-kernel@vger.kernel.org,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Robin Murphy" <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
 "Sagi Grimberg" <sagi@grimberg.me>,
 "Stefano Stabellini" <sstabellini@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, virtualization@lists.linux.dev,
 "Will Deacon" <will@kernel.org>, xen-devel@lists.xenproject.org
Message-Id: <82f3cf3c-960b-41bc-82a8-ce84353706ed@app.fastmail.com>
In-Reply-To: <aKTAVOBp0u6ZSC4w@kbusch-mbp>
References: <cover.1755624249.git.leon@kernel.org>
 <22b824931bc8ba090979ab902e4c1c2ec8327b65.1755624249.git.leon@kernel.org>
 <aKTAVOBp0u6ZSC4w@kbusch-mbp>
Subject: Re: [PATCH v4 14/16] block-dma: migrate to dma_map_phys instead of map_page
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Aug 19, 2025, at 20:20, Keith Busch wrote:
> On Tue, Aug 19, 2025 at 08:36:58PM +0300, Leon Romanovsky wrote:
>>  static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
>>  		struct blk_dma_iter *iter, struct phys_vec *vec)
>>  {
>> -	iter->addr = dma_map_page(dma_dev, phys_to_page(vec->paddr),
>> -			offset_in_page(vec->paddr), vec->len, rq_dma_dir(req));
>> +	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
>> +			rq_dma_dir(req), 0);
>
> Looks good.
>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
>
> Just a random thought when I had to double back to check what the "0"
> means: many dma_ api's have a default macro without an "attrs" argument,
> then an _attrs() version for when you need it. Not sure if you want to
> strictly follow that pattern, but merely a suggestion.

At some point,  I had both functions with and without attrs, but Christoph said that it is an artefact and I should introduce one function which accepts attrs but without _attrs in the name.

Thanks 
