Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7578613A888
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732688184; cv=none; b=VP8IRc1Zq5JMyCwDx4XHrqqeBhc/lxsFNTynUuYdpKnTo5eheudAg+vsayzY4Kv+yJH1ekq3CfafMbYlxy/gJSHQCnwB2/hsTrqfwbw521CfxsG2b3ZysDDepzalNu5CNoHufWWu9wB1YDCAX1wzH2e6KXgB21PZRm8k5ujBG0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732688184; c=relaxed/simple;
	bh=qpGo4L8JfHcc6Cw4aJhv2XimizIUFSE4rthwbuHdbYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8MHIKwB4Yx4mr2dZm1mnPEW4PGf3QAeZMOSk9VMdhVOHfnWgjpcO5BD4D2xH/T9E7pbXHF24tPgSTcJGO4Di5+5WPHGnsgRifMRyYwVG/7JG3Z17iQupK5OApcNSW5kj9/XKZCcfBWYJj3niTDs9nzKnPyJ5SvuLUvi94szAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=klqGZidb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="klqGZidb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rky8U8JLYAdQGbWrATzQwn6Ef4yweEVuy/ZrbUk+2dQ=; b=klqGZidbETNeuPbOF+YwD3NTOI
	4sCHvs31PiUuSOmTE29H6BhrK+EKrDzjqGMK5R1EFRvPx/s6xtP81MlBNqRdF2ZvtTXFxft+Lx1pg
	sQaJE1D+d/h8KH+8KFboEhqVuXZTcc9R09DgqdYSnNtp50tAZrrLsG4c6QZ7Qf6N5HY81uGwynj6/
	Kn85b1oKh1JaRqA+dgNzjbVTrKFHcNOCUMJ0piep4AkdlEdnsdUoDyXufbMvM8ntV3a1D35ov08iV
	Ws7fv/ic4kjA+SlTyQN6nTD0i8pex+T+e+uWvg927woWU0vkalymCoXpzU8DwjJbEPXiQuUKL+UOS
	WkFTi5yw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGBLW-0000000CJWr-3qIq;
	Wed, 27 Nov 2024 06:16:18 +0000
Date: Tue, 26 Nov 2024 22:16:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
Message-ID: <Z0a5Mjqhrvw6DxyM@infradead.org>
References: <20241125211048.1694246-1-bvanassche@acm.org>
 <18022e10-6c05-4f7a-af8a-9a82fdb3bbc5@kernel.org>
 <ef0b613a-d692-4b04-b106-0a244bf4bfc1@acm.org>
 <12c5ee53-dcc6-4c78-b027-8c861e147540@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c5ee53-dcc6-4c78-b027-8c861e147540@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 27, 2024 at 02:18:34PM +0900, Damien Le Moal wrote:
> After some debugging, I understood the issue. It is not a problem with the
> queue usage counter but rather an issue with REQ_NOWAIT BIOs that may be failed
> with bio_wouldblock_error() *after* having been processed by
> blk_zone_plug_bio(). E.g. blk_mq_get_new_requests() may fail to get a request
> due to REQ_NOWAIT being set and fail the BIO using bio_wouldblock_error(). This
> in turn will lead to a call to disk_zone_wplug_set_error() which will mark the
> zone write plug with the ERROR flag. However, since the BIO failure is not from
> a failed request, we are not calling disk_zone_wplug_unplug_bio(), which if
> called would run the error recovery for the zone. That is, the zone write plug
> of the BLK_STS_AGAIN failed BIO is left "busy", which result in the BIO to be
> added to the plug BIO list when it is re-submitted again. But we donot have any
> write BIO on-going for this zone, the BIO ends up stuck in the zone write plug
> list holding a queue reference count, which causes the freeze to never terminate.

Did you trace where the bio_wouldblock_error is coming from?  Probably
a failing request allocation?  Can we call the guts of blk_zone_plug_bio
after allocating the request to avoid this?

