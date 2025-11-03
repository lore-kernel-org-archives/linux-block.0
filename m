Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEAD269D17
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177767; cv=none; b=nRFWV78gaP4LGj/osgQaTCFmO91miRvP2TxgjL1feSZ+CqdtGgzrQcfTdWVeYp1mcIA8P6Jn7bA0xUb4kS/FRpi1AButVLWhHXCjvF1B9GzbJHo53gVEs7HIkDLcvggb6+6eKN1YtWw8hCmqhR+l5UtGj2ituG9I3LsP5IHUfvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177767; c=relaxed/simple;
	bh=Vj7Ixi1u1SROw58/HmB0vAfUtl7dWLn38MglaEfkMEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P50raxmNAbOH1triUQ+vsAKEuFwCRwErX895VPaWV1XgY23GQSXjTYFhbw17LMv35Z2zEmsGnrdmLMivnAziZVrGjRp6FgIGsBTCIAnqLuWlsYvSKW9xJo/Z0Tz32MAGZIR8bVtf1447ws7ii06iQ7IexGFQyusPS5ChvR4EQNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4E91B227AAA; Mon,  3 Nov 2025 14:49:22 +0100 (CET)
Date: Mon, 3 Nov 2025 14:49:21 +0100
From: hch <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: make bio auto-integrity deadlock safe
Message-ID: <20251103134921.GA25361@lst.de>
References: <20251103101653.2083310-1-hch@lst.de> <20251103101653.2083310-3-hch@lst.de> <bd4e2d68-bece-442a-8a00-4fe2d5e14645@wdc.com> <20251103134533.GA23818@lst.de> <8c8b5f23-b257-47c0-893e-2a5bde51915d@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c8b5f23-b257-47c0-893e-2a5bde51915d@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 03, 2025 at 01:47:34PM +0000, Johannes Thumshirn wrote:
> >> Why can't we clear the flags when assigning gfp, or at least outside of
> >> kmalloc()s parameter list?
> > We could, but what's the point?
> 
>  From a reader pov it's kind of annoying to it touched twice like this, 
> but I guess that's just my personal style preference here.

Note that the manipulations should eventually disappear in a common
mm-level helper as in v1.  I'm just deferring this to get the fix in
without a cross-subsystem dependency that causes discussion on the
detailed approach.

