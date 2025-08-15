Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1E423817A;
	Fri, 15 Aug 2025 05:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755234665; cv=none; b=n1HUpVcAGsenyroKZW8ej7Hj6E+KtH5oJteEN17QIETakqu9weoMXSj/Z7qeW6z3Qj4NOE+moPoz3Q4ZJUQ0PMGG3DlnWiqVCpSq+FGeLRwooAIes2wt2Tko8Su8QECw38ojWisKKau6pJpbQIL/Ap7J3wmi/hyBmuMQBG8KeAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755234665; c=relaxed/simple;
	bh=rjs/V71n+3a48sbczUimLUbQ99An++PfjAuhQIEa13s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NHxjDFuSQEVNg3wE1HtqJicmMoCPtaZyI+pvKrg2Yq/HmwCkomnu5Q5/Yd+QFgtX+dKSsHYxXIV4PPIbT3AqFcHC7z18Gn7GjBdgnUgBEljnMbOeebrwxWmbg0pib4VeQpjq02p7kpUHcjL/OfKCkEYXPHKC37OQx/uNq8V9gQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaZHeg2/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaZHeg2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACBBC4CEEB;
	Fri, 15 Aug 2025 05:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755234665;
	bh=rjs/V71n+3a48sbczUimLUbQ99An++PfjAuhQIEa13s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qaZHeg2/5a1nlFDrCh+QQq8+2z+k/HIBWZUD4nh0+1i6c37KB42J7MuL6+NCG/t+L
	 Sb4lS+mkZ14VoVX+YlDNVGPRMcWMXRHAGigO6GBs+JD82O/j0LxY54D+zDNDsJYKAo
	 sXevI5VIzQWOLFfl/WV5zUlxyV+wLZ1J0REOzQc8KXCWGG5zo4v1sD8WTb37YmZh26
	 fQvGeRnhGwhiRkaAiLioOMAOHFUuoJ1KDM4vS7BfgMxeW43efHE9YPv+gnweYXLTPM
	 XrWCUBDKKDrqe8banORHuWlWg0uTJGuY3c9EmS4cdtxIgiUKad4TjoW3OXKR2Ys5uU
	 wi4dFrypsvChQ==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id CD58BF40066;
	Fri, 15 Aug 2025 01:11:02 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Fri, 15 Aug 2025 01:11:02 -0400
X-ME-Sender: <xms:ZsGeaEjCAtEWX1UaHLA2gfColtQZO7w89chtZ2uFaG4vMYHweTmDIQ>
    <xme:ZsGeaNCED0uQ78E9d2j9GAg3NYkGAhxwrM8S6giPlAbcy5DsDkd_hrjkIGTNdnggG
    4eL_xWyjdx6jEOR_bI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeftdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfnfgvohhn
    ucftohhmrghnohhvshhkhidfuceolhgvohhnsehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepffegjefgueegffffjeevheektdekgeevheelvdekieehvdejvdejjefh
    hfelhfefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlvghonhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidquddvfedtheefleekgedqvdejjeeljeejvdekqdhlvghonh
    eppehkvghrnhgvlhdrohhrgheslhgvohhnrdhnuhdpnhgspghrtghpthhtohepfeejpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhgpd
    hrtghpthhtoheprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtohep
    tghhrhhishhtohhphhgvrdhlvghrohihsegtshhgrhhouhhprdgvuhdprhgtphhtthhope
    hmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopegrsgguihgvlhdrjhgr
    nhhulhhguhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlvgigrdhgrgihnhhorh
    esghhmrghilhdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdho
    rhhgpdhrtghpthhtohepghhlihguvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hkrghsrghnqdguvghvsehgohhoghhlvghgrhhouhhpshdrtghomh
X-ME-Proxy: <xmx:ZsGeaPWPNXdI6VvYib3k9QdMC2XlJbr86LA_KN5YspkDL_EEK6BRlA>
    <xmx:ZsGeaI3d1bh3fFRFl4aiXZUts9ejR-WHFcon7KnhJbC_6nOGWjjn2Q>
    <xmx:ZsGeaIdgKvfZyaCQpAF_MAary9Xg8Dva0Q5zSBAie2gJ8xC3nka9fw>
    <xmx:ZsGeaNVlXDFhOQ5jT6MnFggS_FVesjsSUNJLf3EVumbGV5Io7NaXkQ>
    <xmx:ZsGeaG9LccLFJ2EboOYrfkTWU2yRr6gsoUbWRyvB7Ij-X0QWOgy49Rp5>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8094E2CE0071; Fri, 15 Aug 2025 01:11:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWyaQ402xWe7
Date: Fri, 15 Aug 2025 08:10:43 +0300
From: "Leon Romanovsky" <leon@kernel.org>
To: "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>,
 "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Alexander Potapenko" <glider@google.com>,
 "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Christoph Hellwig" <hch@lst.de>, "Danilo Krummrich" <dakr@kernel.org>,
 iommu@lists.linux.dev, "Jason Wang" <jasowang@redhat.com>,
 "Jens Axboe" <axboe@kernel.dk>, "Joerg Roedel" <joro@8bytes.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Juergen Gross" <jgross@suse.com>,
 kasan-dev@googlegroups.com, "Keith Busch" <kbusch@kernel.org>,
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-trace-kernel@vger.kernel.org,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Robin Murphy" <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
 "Sagi Grimberg" <sagi@grimberg.me>,
 "Stefano Stabellini" <sstabellini@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, virtualization@lists.linux.dev,
 "Will Deacon" <will@kernel.org>, xen-devel@lists.xenproject.org
Message-Id: <45552b38-5717-4b0c-b0eb-8c463d8cf816@app.fastmail.com>
In-Reply-To: <ccc8eeba-757a-440d-80d3-9158e80c19fe@csgroup.eu>
References: <cover.1755193625.git.leon@kernel.org>
 <ccc8eeba-757a-440d-80d3-9158e80c19fe@csgroup.eu>
Subject: Re: [PATCH v3 00/16] dma-mapping: migrate to physical address-based API
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, Aug 14, 2025, at 22:05, Christophe Leroy wrote:
> Le 14/08/2025 =C3=A0 19:53, Leon Romanovsky a =C3=A9crit=C2=A0:
>> Changelog:
>> v3:
>>   * Fixed typo in "cacheable" word
>>   * Simplified kmsan patch a lot to be simple argument refactoring
>
> v2 sent today at 12:13, v3 sent today at 19:53 .... for only that ?
>
> Have you read=20
> https://docs.kernel.org//process/submitting-patches.html#don-t-get-dis=
couraged-or-impatient=20
> ?

Yes, I'm aware of that section. It is not even remotely close to the rea=
lity in different subsystems.

There are some places in the kernel where you never get any responses.

Thanks
