Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5B1C3BFC
	for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875667; cv=none; b=llAX48H6wq9h4ZZQ8DT6KZZ6Pkdhgl8HdCTBft1+M751YAvJcKtfl1bzj5/4+/5arJL852Lcd3RZab9MdYB5techVqvb7Uw500m/ZwZ32SjkMqyuNZ0+i6KIJgXXWEOUqB17SRqnX0wCIO653snKB1nKd26htW0l/W8dEv80ObY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875667; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8ryPWVnQeWjzjeNciBUOInTDu9+J8szMMHhP2IILjK/WUVqe9yNv+UEaSWz9vWovYIHmcvGmINQ7mKPgMhpHDRit6iKYZjetOnQRxLWmIa950EHZlJ96C7co4aiCXNUJ9RS2Paav0CrTnn0YHRZEyc+L7Wo3CkbzEkdoEXCWvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 612AE68C7B; Mon, 30 Mar 2026 15:01:01 +0200 (CEST)
Date: Mon, 30 Mar 2026 15:01:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] zloop: add max_open_zones option
Message-ID: <20260330130100.GA32308@lst.de>
References: <20260326203245.946830-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326203245.946830-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

