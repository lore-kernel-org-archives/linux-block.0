Received: from lounge.grep.be (lounge.grep.be [144.76.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED5B34A785;
	Mon, 23 Feb 2026 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840704; cv=none; b=phG1QddaaHWpTBpckMc9qL2K5VhXsRvdEh/NMVCqTE/2kEs4xUIYqT4UXInBDSptEX6+OOCDWG2okzddwwZnOraBdbnwHJ67R9DEY+119rqWog0mo8K9F6lCiGKBUEPgPYrmUE+UcUwPq4V2Ocw2aSjGvijtALF7yh2Ps/FlIRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840704; c=relaxed/simple;
	bh=Iw0Gt16U9GaQulC5u4A0rgAlC9ecuwz937bM6cVUjmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGTlkKEqC5JVEnDwmr71AaTbB8RkHH5oFRwYHm7fldq5u7fcMqQK+mfpvxpTk6uXjZBjtV/9G4G+Aj0c4scZOPLg8TpRayKB4hkm35JuxbwhWXx+NBYllfx2Ul/C4phy5031g4LGAZk5O0uaJf6gSFRWTthqGb+7mQOCGiLT8nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uter.be; spf=pass smtp.mailfrom=uter.be; dkim=pass (2048-bit key) header.d=uter.be header.i=@uter.be header.b=gqxjkDRM; arc=none smtp.client-ip=144.76.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uter.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uter.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uter.be header.i=@uter.be header.b="gqxjkDRM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=uter.be;
	s=2021.lounge; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l7ur/xMoIwQ2QmfUHV3rfzePMQaZM3DKESy7NxWDgx8=; b=gqxjkDRMi7UMD8moDQ7aD/9Mxa
	rsXMoJy5UeyWwvNNBxUgyP4vQXsGZpxY/B0qa/2FR7ThWKP7mrhZHFoLstJljE9hWt3UC05uCJGkW
	kJqb0IIMN83A25VYXzzIbfDFEXBh09pNqJSHlZzbPCTo9gvWcQvp1+pE3VhWa7XWnJYYIDf3MXL2r
	q9Vww+gEZs/lMrOHEH/4+TYXHcyUh/N/X3qsmSMOlcqMN8YkoXuk2TJcFHwi5PZ9j3H/udfXw1NH2
	sB+qvScv+YCHGgX96t1wM4KM2gvgWn44NXzeEqDpu8gHz7QK3iw4Q6uKthh/2cz9Vx8dalwiVbBRP
	t4rdB6QQ==;
Received: from [102.39.233.88] (helo=pc220518)
	by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <w@uter.be>)
	id 1vuSQg-0000000F0gb-2Jmf;
	Mon, 23 Feb 2026 10:40:38 +0100
Received: from wouter by pc220518 with local (Exim 4.99.1)
	(envelope-from <w@uter.be>)
	id 1vuSQU-00000000uTV-3zJQ;
	Mon, 23 Feb 2026 11:40:26 +0200
Date: Mon, 23 Feb 2026 11:40:26 +0200
From: Wouter Verhelst <w@uter.be>
To: Hristo Venev <hristo@venev.name>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, nbd@other.debian.org
Subject: Re: [PATCH] netlink: specs: add specification for NBD
Message-ID: <aZwgiv0vPWPybUF-@pc220518.home.grep.be>
References: <20260215180309.2255721-3-hristo@venev.name>
 <m2o6lnlg2y.fsf@gmail.com>
 <6a1339999b091edaaa15e34aceb7961dfc61581b.camel@venev.name>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a1339999b091edaaa15e34aceb7961dfc61581b.camel@venev.name>
X-Speed: Gates' Law: Every 18 months, the speed of software halves.
Organization: none

On Tue, Feb 17, 2026 at 07:40:33PM +0200, Hristo Venev wrote:
> On Tue, 2026-02-17 at 12:17 +0000, Donald Hunter wrote:
> > There are yamllint errors:
> > 
> > make -C tools/net/ynl lint
> > make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
> > yamllint ../../../Documentation/netlink/specs
> > ../../../Documentation/netlink/specs/nbd.yaml
> >   159:81    error    line too long (104 > 80 characters)  (line-
> > length)
> >   169:6     error    syntax error: expected <block end>, but found
> > '<block mapping start>' (syntax)
> >   170:7     error    wrong indentation: expected 5 but found 6 
> > (indentation)
> 
> Thanks, I will fix the lint errors in v2.
> 
> > > +doc: See :file:`drivers/block/nbd.c`
> > 
> > Prefer to see a meaningful doc string here.
> 
> I will add more proper documentation in v2. I couldn't find any
> existing documentation of this netlink interface, so I guess I will
> write it myself.

As luck would have it, before I saw this message, I had been wanting to
work on some of the messages that nbd-client still needed, and so I
asked an LLM to analyze the code and generate some docs for me.

Heed the "LLM" part. It's probably not perfect. But it could be a good
starting point. Or not. At any rate, you can find it here:

https://github.com/NetworkBlockDevice/nbd/blob/master/doc/netlink-proto.md

-- 
"I never had a C in history!"
"Yeah, but there was so much less of it when you were my age!"
 -- Joe Brockmeier recounting a conversation with his father, cfgmgmtcamp 2026, Ghent
