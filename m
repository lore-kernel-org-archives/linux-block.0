Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F9350248
	for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527356; cv=none; b=DX7Jgu+k9NSbk1M3I4j5zsQbrECE0746tDqot/VbpM7Dtjfkh0UL6jIK7Bc02qgBaYsulXBthH35f6WMnRZsv0pQqsTqkThvVHH84sV7+4xtmzNWBGu4ryV/EeZ1UBA7rUyA4vAkmomFxZpLNfUC4Xl2fbej74MLnZSm6Y0+XeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527356; c=relaxed/simple;
	bh=9knK10+BEoyzTIMEMLSDiFiVDuuG3FU2VmES7EGEIHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWTwVXQQlwIXxH0URhWlmd+AaMLtU80+aQUuS4bxf6z4ONe7zhEt+gRT0VfLw6jLNx5FezXr8kyfNaEpJEvjRZGntOKKDe9ymKuqrK3PIRcq/gzyJN4DrlVLLq/IELraGCE6bhlacxzGEqNDbH/whm4T93sPtZKzUUuO/6Xw4Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V1hAd4i4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V1hAd4i4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=runr5kiWnxf4bjtMBQvWtZBTgr3DVyh7jHp9gFitVjI=; b=V1hAd4i4HUBhLvc6+7NUUx1w1j
	og2IIazs3Mj4noKqaO5zWlxE0eRV4Sm+oPW3+OI2u/qoC117SHB57EItRRYQvuOu2I8sFewGvV3Az
	BIAHIjvyaXoufRTaYYQY7Cfdqn8Slc7rqiJL11iCRPbolca2v3Xjk0yQ/v5ndtbNwlkcNlA5GY7Pp
	RU3fZNt3Is4Iq3pi1FgSMl8THSm3YGQ2r3XzJ77j3pMGInBCLVFL+hih/JfO2K5k9svOR9O66/WbD
	UeZgNWfwo29PVPKlwnqxYf8d4d17VX/3aODgaBDfI/DyQbTrTRoKPeusEPrmJQY7Jx3Vf1H9S0rH5
	L9qTAIAA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlCIn-0000000AorX-3YSt;
	Fri, 15 Mar 2024 18:29:09 +0000
Date: Fri, 15 Mar 2024 18:29:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] brd: Remove use of page->index
Message-ID: <ZfSTdS_YMnQ_v-Wa@casper.infradead.org>
References: <20240315181212.2573753-1-willy@infradead.org>
 <ZfSSG3z0rQffkwGy@kbusch-mbp>
 <ZfSTE4pEiKjKecbj@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfSTE4pEiKjKecbj@kbusch-mbp>

On Fri, Mar 15, 2024 at 12:27:31PM -0600, Keith Busch wrote:
> On Fri, Mar 15, 2024 at 12:23:23PM -0600, Keith Busch wrote:
> > This looks good. Unnecessary suggestion, but since you're already
> > changing these, might as well replace "sector" with "idx" here and skip
> > the duplicated shift in brd_lookup_page().
> 
> Sorry forget that, all the other existing callers just want the
> sector_t.

Yeah, but I could just inline the xa_load().  Doesn't really seem
like a big deal to me, so I left it for now.  Got to leave something for
other people to do ;-)
