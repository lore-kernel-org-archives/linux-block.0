Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE73257452
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 05:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068671; cv=none; b=IiYNVnYcjFgp0cIgCxS52owYr9YHIFBdv0000uxJ2ilTFb9z+OrtyV8WlkdRdQ5PFyRIwScNPvzgRv3/Ze456uj3moOH3S7ei6kZgRSuod0VHk9jr/4KsmQSOS+kKDxkkE79b6IVXskPUBLaII9N0WoxQFRuJmMynqBWAZ2fhtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068671; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE90Rls/PzCbcXHpRJwzZ5MLDbGBW62dklBlWJG6DGlWeV48H7UGDl3Qj/j55n7Hwisdbsc1dUuCJYLL2CL00CMVyE5YPhDa1EYSl0YjMj/yLgFBaP2NwA1TXk7qJoheDC6stA7psTVMeRpFdJXEshKiJH7HDmhJS5K9mp4e6GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ygw/sCM5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ygw/sCM5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Ygw/sCM5onT7HHKBXQJeTgHoCG
	fQg0bJueAjnNdqo2crDT0I8NJxLTuYRflSDdOw4gSqJ4209KJisbGXqDm2j1XN2ctyaU2aCPWLl7i
	mP0KYO5kXohHRnU/owNNvgXl5K+sENFPgZ81jEb9Nv434TMAHyYLABH4Pdlw4A+oeWUcT6lEWeyOc
	S8UEPORNPOrnfWLq7d1JVV62rBldB6tkDVVJTgXjV+RMNUa8G83QX5WakzkN3R3oWayLtLZ7H4CO4
	inQTMXWuNMQvY66Y036HJOA3WjbCMsow0mGW7e8OjkWQPZ3x2Lqsg2L6tKh9PqdmQs088+dcLeRje
	NTdBcw7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBK1-00000006oil-2Efk;
	Wed, 10 Jun 2026 05:17:49 +0000
Date: Tue, 9 Jun 2026 22:17:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 02/27] drbd: Remove "extern" from function declarations
Message-ID: <aijzfe45SMm3duLU@infradead.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <d9c2b6f320770bc0cb543d24f39fe5c9d28bcd99.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9c2b6f320770bc0cb543d24f39fe5c9d28bcd99.1781042470.git.bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

