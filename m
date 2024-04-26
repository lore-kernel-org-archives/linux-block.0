Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A6B1487D0
	for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714140172; cv=none; b=hfitUn+xUFAa+orqeOB5JUO5weWx2lp9YQpIHaP28K7TGBgbv7MoqTWtvHuWicfk2h26Lgf17fD6/bgiLZ0PaHv5ycky+nTS26CJHjCTAnapuDb1yYyrdgbYnCd0k5CBBtLVSHHp8iC/qE7HA5HsnbHaXXmIuFbt7j53XzHdU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714140172; c=relaxed/simple;
	bh=uA2J74Ipu05ANkOULyKaszNBvWbVwBM69hQWCgBhUzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdVjXRhfu00gKFNjpBjGL8XLHYUtYeBdwSJDIP9m3TUhL9ANX9rLgRbPI+SKmIOvNhQC3msK5LxIWaZzo6U1WaZGpvVs5bjTg1iCEfid9hK2kRsv2eOR9vOG+3bC+ylVVIy5XrXfAZyg5FTAwCDGexuxUFRkBhUlNJpVUNwhN4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FXiU9hwR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FXiU9hwR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iDIcC01toJl7I37FnR/VtK5Osj/RlFfn8+zHQjQBVNU=; b=FXiU9hwRb1wMp3zivzvOH26gbF
	fI7ldOmnlvJmcO1mrwBB7Fk/ULkUgm6QMpWlismZ0XeKE/CHaShaMoonNCGYVjst6q5jpVrjHHPYc
	SrVaXpHVN6TmuniovN62Yvk0iCWcqtZh2e7OYZzpHw3XmcAS0kRtB6jy1yMUWvWs1xTtla+xevJAx
	5BYxoy5j/2nrs6WMWQYCTpO2AyY1PcRbJIbALPs0OxJZSqpb1JP1EfBVj7F+cyTtT1eiHn2GkaAHC
	VsJUMrcUL4gpyeWp6Fu3V1/Q8T5yH4cvgUuloG2PQtdcjDXc3yNC8VPTHRwkvBvYiKtUD3rpIg5jf
	PC7gFT9g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0MA2-00000005LRT-3pZT;
	Fri, 26 Apr 2024 14:02:47 +0000
Date: Fri, 26 Apr 2024 15:02:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: David Sterba <dsterba@suse.cz>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] bio: Export bio_add_folio_nofail to modules
Message-ID: <Ziu0But3Q6kc1DhK@casper.infradead.org>
References: <20240425163758.809025-1-willy@infradead.org>
 <aba5fed0-9f0c-4857-927d-d2cdccf8ca88@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aba5fed0-9f0c-4857-927d-d2cdccf8ca88@kernel.dk>

On Fri, Apr 26, 2024 at 07:41:29AM -0600, Jens Axboe wrote:
> On 4/25/24 10:37 AM, Matthew Wilcox (Oracle) wrote:
> > Several modules use __bio_add_page() today and may need to be converted
> > to bio_add_folio_nofail().
> 
> Confused, we don't have any modular users of this. A change like this
> should be submitted with a conversion.

Thank you for reinforcing my point.

https://lore.kernel.org/linux-fsdevel/ZiqHIH3lIzcRXCkU@casper.infradead.org/

Can I have an Acked-by so David can take it through the btrfs tree?
