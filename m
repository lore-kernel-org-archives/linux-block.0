Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E8922AE48
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 05:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069692; cv=none; b=XoPU7v88xbucrVEHXndcXLCxxzG+dESh6x0X4O4cdNfWx/QvlRKxcjrGchw8zxCSO9qTxLBXAlxvjTNHm4F9pMLWOtWvn32KOv2Aisl2snrx4sjfIYvvJKDRfcq4K+wfFgzF2tPDPQM9oRETKSWZkq73GIetZ6oBWM0yOwWBw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069692; c=relaxed/simple;
	bh=hF/hYB8mNrSUByJi0jbz5uFtTQyEsQXhjBBc9SXdgcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK17pa+vtcdrsAASj3W7JLd3VD3f6i/z5U9dcGjkdWd/ovBcR3Gv6QyLQFL9iawfXjBIWv7vgPgXtmWrUadusQ1HX6wEATQSnsVUKFputA8HOeCb9znZv9Ll0nmhlrtFCf+bi5Dws0OPNkk+zKi/NzxmJKURcTU1ikVuCdlBW6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cA6+8hOx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cA6+8hOx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YGBGqFgsa7WCPiE646qH+u3NSRQ5t/i4HU54gHarn50=; b=cA6+8hOxFxZz23Z4rK74bfq7ws
	5pPEt2WB2qSAy4TYEjNUkTCUQIdvez2d3lq5Mt5KGMiUpC3iLh3XzlNv8gj0arUTRIojjKhf3nVPS
	XOKXFZy3lHk4jCKzZSvhi9Ol59UHth0ISPgv7qdlPXuXcc/8aa89/xnjQiEbiMp/HfU1x95SEqSOd
	oIfkWiBV1tTm3sYockwmeDpKASS2aYS9ZhqF/BxLeuBGYHNaHtpyOmmxiyP7+U+gg7q650d3XKD29
	b+f2Vsq3LOCPdByelK/QL+CL+X0onf0J3fboXYePoTeJLXstfmjT08+GZQ9sjyWB9RidvHMKdSNZ9
	8KwVvWXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBaV-00000006pxn-1C5Y;
	Wed, 10 Jun 2026 05:34:51 +0000
Date: Tue, 9 Jun 2026 22:34:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH 00/27] Enable lock context analysis in drivers/block/
Message-ID: <aij3e1WKFQunNUS2@infradead.org>
References: <cover.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781042470.git.bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Can you please split your series up in a saner way?  A bunch of the
patches for drivers with their own subdirectories could be merged ASAP,
but you bundle them with lots of unrelated bits.  Similarly having
a standalone series for drbd probably makes life easier as you don't
have to CC random other driver authors on it.

Marco: is there a way to enable the context analysis for parts of
a directory?  I'm not sure that always converting a whole directory
is going to be feasible in the long run.
