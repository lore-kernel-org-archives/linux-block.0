Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740EB7DA6C;
	Tue, 10 Dec 2024 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733814677; cv=none; b=YtwNRnKC83AJvcPfkXnDVwLBSZRq2+knwIviv48L+BLOrO2axBs7IXA1taKgdQH/9knUxexLyUWeEiZcnn8GW7c0zdrWV+xP3ABy/S/lPVepKWbWcdURnRKDvvYWHLQtj6a8w9ngn++/l7E7Yt/dgs+IVYJsAn8y2V81p7AuZ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733814677; c=relaxed/simple;
	bh=TJLiUM7Z9AlP845ji0GkKCsdeWrCkQ2H3dDz9YHL8ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY8o8KvcG/hOIiA5Uwj1AByZuZfNGjl071JDgVGmf7iGU1tFi8AG8F1QJw4D6biGMzbGdvV2paHCh/Bl4dzvnsLQr2Z4SF5ASr9vSWel2XdegO0CzvM5QiPtwYICxkX8bt9tPn64nDv8F1DA8tuOVcveYzDQC83tJ4n2Lvsi+z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s2rGbzaj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s2rGbzaj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xUOsZNvSud+J2XcBaeZooBhEejsi38mNLmac5zeYn5A=; b=s2rGbzajKnwGYD7Ne1vPvq79PZ
	j7Q8HmuavcA8GyubV8DFpZD6tBoyFkxpUFHe86Y8jLm8+aYIU/KIcoNbhy+hWdEbjYteIqS+M779L
	kz4adWqpvVXNNBJKdMSfO84phf8QQ2fLar151IJKO7Cq4Rw+bek07BKRKia3iUFbhmhz1meDAcSlD
	diT/j0cjCarbZpFT34cae2cBLw0HIT+DhscNW9mqzj48ZiQCT45g4Zgyvc9U2wTLwJ0UGR/Pqip2o
	yHjDv1GlTNMOBgji13bIlaYuB1IinD9yFANTDYz07x3848DH9zKQfmkb5GE6ki8/F5i/RBkASyU/9
	fh5MMlGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKuOp-0000000AWGF-42gr;
	Tue, 10 Dec 2024 07:11:15 +0000
Date: Mon, 9 Dec 2024 23:11:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Atharva Tiwari <evepolonium@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] THE INITIAL VALUE OF wp_offset MAY BE NOT THE POWER OF 2
Message-ID: <Z1fpkzrKMcoFncfI@infradead.org>
References: <20241210062340.2386-1-evepolonium@gmail.com>
 <7e04fc51-e7d7-472d-acf9-a7bcdc6c5496@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e04fc51-e7d7-472d-acf9-a7bcdc6c5496@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 10, 2024 at 07:09:00AM +0000, Johannes Thumshirn wrote:
> On 10.12.24 07:24, Atharva Tiwari wrote:
> > Signed-off-by: Atharva Tiwari <evepolonium@gmail.com>
> > ---
> 
> You at least need to state why.

Which will be hard to prove given that we atually check that it can't
during disk registration.

