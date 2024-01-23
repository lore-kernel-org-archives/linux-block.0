Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B8257894;
	Tue, 23 Jan 2024 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001100; cv=none; b=UoyyGrnVNU7+a2IF2drVgcn3zngqakrikpgsOfFSoKnfS4qkSHY+9fyU9wUaQm8xQ7HPqgGVwBLjU0H41mgyxb5shjwUv6bFxTwLocHpzkc6UfeeYW70wHW/24D2vaAYmkCYqVVpf4v0YxhQmOI5zbq3Y7RTGeoOxokav//80Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001100; c=relaxed/simple;
	bh=rNTkSMyFMKE66LIWPF1th8dowNZvvtLXzCqWdmFMmNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtANzQbfXsL1zzED8bAHlNJNQSZk7FVwCgfqInUP3MyQw/82fFgbA09h9FrKAsnLP++elZ1I+0xsO3oD/RVg7VoP+AMJ+uNTcC+iDmX9CNO3Qd2LPdYFTaQ6HhA3uel7qBGosOco5bAkoXJvcEaJ9KjA4qUoIiI1ojQfPTm5yxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D228F68BEB; Tue, 23 Jan 2024 10:11:32 +0100 (CET)
Date: Tue, 23 Jan 2024 10:11:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: mmc vs highmem, was: Re: [PATCH 2/2] blk-mq: ensure a
 q_usage_counter reference is held when splitting bios
Message-ID: <20240123091132.GA32056@lst.de>
References: <20240112054449.GA6829@lst.de> <9eb0f18e-f3ce-497c-931d-339efee2190d@kernel.dk> <CAPDyKFpmEB9FGAmGAQNdEH+DtRtcCNnFszfv_ewihzUU9du+Xg@mail.gmail.com> <20240122073423.GA25859@lst.de> <14ea6933-763f-4ba7-9109-1eea580e1c29@app.fastmail.com> <20240122133932.GB20434@lst.de> <d2289b38-f463-43e6-a60c-486fd479d275@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2289b38-f463-43e6-a60c-486fd479d275@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 22, 2024 at 03:57:16PM +0100, Arnd Bergmann wrote:
> > It would be good to fix the one or two that could use highmem and add a
> > depends on !HIGHMEM for the others
> 
> I would prefer a runtime check here, as one might still have a
> multiplatform kernel where one machine can use highmem and
> another machine can use one of these drivers, e.g. in
> imx_v6_v7_defconfig.

Well, if someone can come up with a good runtime check that's fine with me.
