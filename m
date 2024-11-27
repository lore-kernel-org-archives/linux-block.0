Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A06F9DD
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 06:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689226; cv=none; b=VTIWgAbyCyuuwGJIpqhDkCiiPVBI7FxvAfUs3ovXI2Jnu48hqZhz3rtPQv6l9AGDNIOCM6mPLXJHehMQ5lt0lO/dhKgj4xnElMA9hMUMQtZ0AOHeax45E79JSXZlCjBLlIa+FcpCPerMST141IA3E5exJqNe7tzChwM1dVsyz6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689226; c=relaxed/simple;
	bh=xcHgEx3MMh1/TOZzMY5pTRsVaWcOKqBvzWmy6nxYNDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jB373KsCy6fMFue6eKThBLwfA/brgJUZR/M44bosjcynaU9fqvSncJF9cOL2jiGMpQGrNZFQVDA/MqNn0cPvklfc/xzLfQu8wGrx+TjXhB8NIwDUJC+MwndVtyyJ+VmPixw1Pb7yPqIPOXhzS1do4TW4eyxPqyJ3tmJ6y/0m0PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=no8k4VR1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="no8k4VR1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xcHgEx3MMh1/TOZzMY5pTRsVaWcOKqBvzWmy6nxYNDo=; b=no8k4VR1ru62VblfzX2cbSGTRJ
	h/ERVC3ySt6vpqLC9ZT99nZ8A3IsHZUnlOZy5S6Skt5N3pVA8k1+UgOVShUJ5g9W3H+p4US7pC8f9
	4AZGgy1QlD+ftJi9ki+QqYozzJ2LCwvvufT2H+THR+Dh0FVeEHVFPJd3eaY41qoFmbaxSqn22Zvmr
	gCPPIX98Uv6yzhQmw1FabKpCLNZ9Xqi7ugZz9z8488I8/evV8QMIx16XXn9/sOfWjXhr34T2y7rFo
	Ug/xq375fhK/1F3onSnkCiorpOgW0Hl3u+LUQERVg6Oc+yc+ARvlEGuJLt4DerlciQdhU55rRm1pH
	zY4gna+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGBcO-0000000CKq5-1J4m;
	Wed, 27 Nov 2024 06:33:44 +0000
Date: Tue, 26 Nov 2024 22:33:44 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
Message-ID: <Z0a9SGalQ5Sypfpf@infradead.org>
References: <20241125211048.1694246-1-bvanassche@acm.org>
 <18022e10-6c05-4f7a-af8a-9a82fdb3bbc5@kernel.org>
 <ef0b613a-d692-4b04-b106-0a244bf4bfc1@acm.org>
 <12c5ee53-dcc6-4c78-b027-8c861e147540@kernel.org>
 <Z0a5Mjqhrvw6DxyM@infradead.org>
 <Z0a6ehUQ0tqPPsfn@infradead.org>
 <73fb6bae-a265-43c3-a362-3cece4b42bbe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73fb6bae-a265-43c3-a362-3cece4b42bbe@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 27, 2024 at 03:32:04PM +0900, Damien Le Moal wrote:
> Might be good enough. But will also need to clear the REQ_NOWAIT flag for the
> BIO if it is issued from the zone write plug BIO work. Because that one should
> not have to deal with all this.

Yes, by that time there is no point in the nowait.

Another simpler option would be to always use the zone write plug BIO
work to issue NOWAIT bios.

