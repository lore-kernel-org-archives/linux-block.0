Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E88A2D0292
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534036; cv=none; b=KSO+dMJb8PhpiDH0EWH7cEwuuJLxCxMEwhAW9yj2OmN763hrMBBfeZF5VTZxy25Ytc0PHU3XoL5MCylJ+OHzdpbqu2/rK/GfCanoV5/t+A5gKNdLrEhyDADanUsxeV/i2nzaKNmqUtOUY0+bt16TIJCltD8uMeZz674/iGbU0Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534036; c=relaxed/simple;
	bh=uhksFp7VhhP8cJRFgAI9vE7ozfUL7UW1TBjPruDlKwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNpxwP9Cscb6/Si6HV2gnPu8hnKVrBfRhwXgTHUyhL4JgrflPnahl8eAEhmmQq6C6OM5e3zZYC/wENDC1i/zVekXUx3ehRl9OQCStONORgEeBZToxQFr0/lFy/mhqwHfkLkgvTYXbOlJ/UghtcCRcC1ROFA3i/s6Fa45gs+8p+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jM1d4fg1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jM1d4fg1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tERqpTDAKTyGUlX5xnZ6HwmJ6v1yJP0+XOrKVPXwTO0=; b=jM1d4fg10zycP+JYQNQexPwD1Y
	YXamnIIk0MDd9ZDowk7n7qSQQs2VvBj9nwDwnHSEV4V+b2Ac7YSnj9vjEElT9mazxSZFaOTJYqyAR
	upixjtH7r3CJGJdgJWoza7CsZlcReYKJxWjrLOpCbRyyALrNGHOo/tGvVCJxCr2tqvyk7RFfp/PWo
	oaNDff+q3vWUhV6tZkkQk0Qc0asHC44sKAabI3zy6u91BtgYB4VBM1ehGyPORYtGDbiLGwZZmA+sO
	xme2E8Wm29QTVnQm5lUNkKk+aFB7XgjRCFgSos41dpvjY36GsZdpfV+RvotARcoYe3q1k9eZqTDjI
	RMkKnA8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXG0v-0000000An17-2hdE;
	Thu, 03 Jul 2025 09:13:53 +0000
Date: Thu, 3 Jul 2025 02:13:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ben Hutchings <benh@debian.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	1107479@bugs.debian.org, Roland Sommer <r.sommer@gmx.de>,
	Chris Hofstaedtler <zeha@debian.org>, linux-block@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
Message-ID: <aGZJ0daUmZkjCmS2@infradead.org>
References: <whjbzs4o3zjgnvbr2p6wkafrqllgfmyrd63xlanhodhtklrejk@pnuxnfxvlwz5>
 <1N4hzj-1uuA3Z1OEh-00rhJD@mail.gmx.net>
 <iry3mdm2bpp2mvteytiiq3umfwfdaoph5oe345yxjx4lujym2f@2p4raxmq2f4i>
 <1MSc1L-1uKBoQ15kv-00Qx9T@mail.gmx.net>
 <aif2stfl4o6unvjn7rqwbqam2v2ntr35ik5e24jdkwvixm3hj4@d3equy4z4xjk>
 <1ML9yc-1uEpgp2oMs-00Se3k@mail.gmx.net>
 <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
 <r253lpckktygniuxobkvgozgoslccov6i5slr5lxa7oev6gtgy@ygqjea7c6xlm>
 <e45a49a4e9656cf892e81cc12328b0983b4ef1da.camel@debian.org>
 <2ba14daf-6733-4d4b-9391-9b1512577f15@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ba14daf-6733-4d4b-9391-9b1512577f15@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 02, 2025 at 05:13:45PM -0600, Jens Axboe wrote:
> > My conslusion is that pktcdvd is eqaully broken for CD-RWs.
> 
> Not surprising. Maybe we should take another stab at killing it
> from the kernel.

Yes, please.  I don't mind having this support, but it needs an
active maintainer.  And even if it was actively maintained it'd
probably do better by being integrated into sr and the generic
cdrom layer than this stacked design.

