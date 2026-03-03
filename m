Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522E43976A2;
	Tue,  3 Mar 2026 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772566925; cv=none; b=kbm5BJdHprjP2989uWWAZVxlRPg61fyw59I6BX5hFawPlKr6NhkjLg095ucVzoaoOvrt0Nn1zt/sqe8rbk2vdX4wL8ET2er/KNIC2uZqLV3qaD4cwxSInKcJd0FYBJb6gplP17USEX/I7PBtVA2lC0NFVyJBFe/YK2ADSwm0/CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772566925; c=relaxed/simple;
	bh=H4mG72owGRTWTwZQX2O/h0Z11mxsQLJFkHUjfOmfgHs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UePj5lfWRKVRF0CB5GeMs4cE51jPwLf4e22C+68m0e+Ccx53k7TVEeuq2cfo+ThPes0JAfoGaABE7C5E6ZlJqvjn0tI7Fnbdsw+YOM2DzxAsnz60duR5kUydAMawaBudPZ+Tnd0T9hq6kX3KiQowqIEY1WeR6zY3P8UzhYbWQpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YULONrfw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YULONrfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A119C2BC87;
	Tue,  3 Mar 2026 19:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772566925;
	bh=H4mG72owGRTWTwZQX2O/h0Z11mxsQLJFkHUjfOmfgHs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=YULONrfwiUJJHfNzs1A2iAyqurt2++EC2cUpbU7F/CeBOq1PhUv0UHCI5NNHGqPdg
	 WAFXLwu2AjK8jSfA8ckWoXvVbttyaPOJ43jsGSUK0jS5G/tfrNSEJfzgEZqM3JaoFH
	 3Ao89imjDrd745ChexTw7drDNE+RUIfSVO9Y66yxJmXsCzEkQopiUV6HkDxeFlrYUm
	 AmL98eF9HKC1+jl6Dr18nd3x8c1R9IGdwdqTNOD4lqGpUJ+8lLgkrPsxS9xMMpACLR
	 w0NQ0+8ax3EQUamhwScLJGUBC2D4x+ZgPPr3Wf4XrxaaObVDwvXfZ07R/oDLr6ZXWJ
	 pP1Z+oFnym6fA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3F2EAF40068;
	Tue,  3 Mar 2026 14:42:03 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 03 Mar 2026 14:42:03 -0500
X-ME-Sender: <xms:izmnafQBroN4CG91qhP0QwS14BKG5PiKCYZKboEqDbyyhpvruE7k9Q>
    <xme:izmnabngVqdFv5UTPHWrrsz7LIEXTIaF085FUit_wPOsNtBOysS6LS6Vl1clKSQWC
    aBZuUqIQu6G1FIBMbTdivrz_GVQ8hTYo40RLtHdVADNa6lezpVlgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedugeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehguhhsth
    grvhhorghrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvvghssehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomh
    dprhgtphhtthhopehlihhnuhigqdgslhhotghksehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhhrghruggvnhhinhhgsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukh
X-ME-Proxy: <xmx:izmnaW3BPh6K1tLSpLmw47oHWLGYXUMY_CzEtWuBQ37lyZU4XevX4g>
    <xmx:izmnaRRabts1SNWaW47_wijnFEsni4ikC5Qd874L1c5WPSByGvgAyA>
    <xmx:izmnaacU1X6HfA9cfGkm8tWQtzYq8SmYe1ntkqN5LA2Ldlx3sVGMDQ>
    <xmx:izmnaSdbtK9_I_Hz2RYAoiw03ZnxBCHTfOH4N_PfwHL38fjLN8OlXQ>
    <xmx:izmnaU0d8qpB8qTyWA_0VyV4ciHlMo5_ZXv2U6-BzCNmYP1rP8uOgrJE>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1A4F5780076; Tue,  3 Mar 2026 14:42:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AyMVdAmERJ9c
Date: Tue, 03 Mar 2026 14:41:33 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, kees@kernel.org,
 gustavoars@kernel.org, linux-hardening@vger.kernel.org,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <8c2c2a3f-c718-4275-a2ba-b796438e9a13@app.fastmail.com>
In-Reply-To: <aachxPdUi2puxQKq@casper.infradead.org>
References: <20260303162932.22910-1-cel@kernel.org>
 <aachxPdUi2puxQKq@casper.infradead.org>
Subject: Re: [RFC PATCH] iov: Bypass usercopy hardening for kernel iterators
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Tue, Mar 3, 2026, at 1:00 PM, Matthew Wilcox wrote:
> On Tue, Mar 03, 2026 at 11:29:32AM -0500, Chuck Lever wrote:
>> Profiling NFSD under an iozone workload showed that hardened
>> usercopy checks consume roughly 1.3% of CPU in the TCP receive
>> path. The runtime check in check_object_size() validates that
>> copy buffers reside in expected slab regions, which is
>> meaningful when data crosses the user/kernel boundary but adds
>> no value when both source and destination are kernel addresses.
>
> I'm not sure I'd go as far as "no value".  I could see an attack which
> managed to trick the kernel into copying past the end of a slab object
> and sending the contents of that buffer across the network to an attacker.
>
> Or I guess in this case you're talking about copying _to_ a slab object.
> Then we could see a network attacker somewhow confusing the kernel into
> copying past the end of the object they allocated, overwriting slab
> metadata and/or the contents of the next object in the slab.
>
> Limited value, sure.  And the performance change you're showing here
> certainly isn't nothing!

To be clear, I'm absolutely interested in not degrading our security
posture. But NFSD (and other storage ULPs, for example) do a lot of
internal data copying that could be more efficient.

I would place the "trick the kernel into copying past the end of
a slab object" attack in the category of "you should sanitize your
input better"... Perhaps the existing copy_to_iter protection is
a general salve that could be replaced by something more narrow
and less costly. </hand wave>

-- 
Chuck Lever
