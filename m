Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5BE1CFB6
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 06:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689950; cv=none; b=QDULHq9CTUXGLnB2Eh1jgF5Ba0hUBweYnb9ccrrCuXYjHbLG/6cVnpA1LkKiVykTco13LXp5VJ3loMglV4xRq3UDs9cVOcwC6KyYAV7ddKijmHurfbNWNHJpTx0EYYN1lj3gADOa6Y73OJpW67bnHPG2KUTY8EQBtU+0wi8KR7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689950; c=relaxed/simple;
	bh=yzWutrAuibejUruu1tmHCGMqox5nkn7ic+aFOvcKw4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHm/kS4KsWibSIwebVIQDSd2OMu2QLePk4UOjZlKxi8BxDW8YgXFBy3ocb1pEsL/Ful0mo9611hho0irwTifAEFyEles5zyLZ749HDeNGcAP1mvU5QEcbStZJm1kbC5OnFID26k5iUw8Ts1cgUQg7syU2U6ZhMsbr1tCCHnZk0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yPygIkm1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yPygIkm1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yzWutrAuibejUruu1tmHCGMqox5nkn7ic+aFOvcKw4I=; b=yPygIkm19DuRgKGx+hf10kjXrM
	SVtrd5rtaG0Ayo/RzldSq5q+72xxdTmZNwL1TYHbgTw80oBdxhU6cacCWQX7ez1OVXpeegPaHN+o+
	i1xZrzj1mQ3MTX81BDK2pxisps5hLSKcVJ9Suflw5BH8aUC7JbhG8eUtWSIFedv0DbMCqM4xb+/aG
	GnXm4bMc7QY6rfoeiQykX5q8HPwvB7p3IHGCSwKjG8LSGNx0mFUiDGHkpR0M6P3xsqOYQTgst7EJ6
	xE8Y+SqO5hIEZH1up/s3xdIf9EkOs2C8PD0y49BkJDAOVzbhMayzkbb4ES6xWWEvXz6NiaC4jbeWn
	aPiSdDPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGBo4-0000000CLn8-2MER;
	Wed, 27 Nov 2024 06:45:48 +0000
Date: Tue, 26 Nov 2024 22:45:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
Message-ID: <Z0bAHKD-j49ILtgv@infradead.org>
References: <20241125211048.1694246-1-bvanassche@acm.org>
 <18022e10-6c05-4f7a-af8a-9a82fdb3bbc5@kernel.org>
 <ef0b613a-d692-4b04-b106-0a244bf4bfc1@acm.org>
 <12c5ee53-dcc6-4c78-b027-8c861e147540@kernel.org>
 <Z0a5Mjqhrvw6DxyM@infradead.org>
 <Z0a6ehUQ0tqPPsfn@infradead.org>
 <73fb6bae-a265-43c3-a362-3cece4b42bbe@kernel.org>
 <Z0a9SGalQ5Sypfpf@infradead.org>
 <9d224032-254f-4b4a-a667-d1538cdbf0dc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d224032-254f-4b4a-a667-d1538cdbf0dc@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 27, 2024 at 03:43:11PM +0900, Damien Le Moal wrote:
> I thought about that one. The problem with it is the significant performance
> penalty that the context switch to the zone write plug BIO work causes. But
> that is for qd=1 writes only... If that is acceptable, that solution is
> actually the easiest. The overhead is not an issue for HDDs and for ZNS SSDs,
> zone append to the rescue ! So maybe for now, it is best to just do that.

The NOWAIT flag doesn't really make much sense for synchronous QD=1
writes, the rationale for it is not block the submission thread when
doing batch submissions with asynchronous completions.

So I think this should be fine (famous last words..)

