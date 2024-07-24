Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B52C54759;
	Wed, 24 Jul 2024 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835237; cv=none; b=OVgrebm33tPXGl2EECtQ/qs4W/jpjr2InOHeTIJxW0f51R6a5/ex0q/MQkjyBoWomHZ42wlQgVWMiQqFhvhwO6Bw/CSUHt1+aQgEdXTf8pk7o2xtCKofXZcycZYsLufpdm3ZHWBmlnyKxHng0lv9+VMFuIULfyjuSVhLQ6nJmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835237; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWg/IieacvpRVloLyJA+xY8YfyZ6CxQt6V3H7eUXcSjeKZGrDFZub7OEvB3RVu32HDgi3np9rv8LVDyW6nHgWislnHjJ47JTiJr2MekqDvFhLs217Bo4m1ckfQTR56B2LCHwVViFutRsTEFgUN7tLseRhZvHxV+BXFQSsrgd4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qntWUtga; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qntWUtga"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=qntWUtgaJv05pn0/K+VH6SrL9y
	eHq9CJRbWzDhpvfk4ZC0toFAjF0fS+adcayh2rsN9BJ7fOdhsx+9Rqlbf9xB5vaOS/EwmcdfTEPaN
	NnKMyAWgXFtKZoG4WZFZerzHQobaVWtS9J7jMRWT8eNk9QNav3PqpsKCiFVz7gvHh956h5sWzN4Pv
	HUBOLqwTqt4uAt1qgTkq8hi06ZzGHnhCaThtz5iR4XP2WcBHuovyIc5KsmA+XYhiFj2XTPEsMEQyZ
	+8o11bZVqqWoZknEexb8xKQUUVFHtfdI0B7FO+ufMYQQKUePhsG+r75G6gxWrCDCfGYNzSnL6dROI
	ZsElJy/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWe02-0000000FmX4-3hlG;
	Wed, 24 Jul 2024 15:33:54 +0000
Date: Wed, 24 Jul 2024 08:33:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yang Yang <yang.yang@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>, Dave Chinner <dchinner@redhat.com>,
	Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v3] block: fix deadlock between sd_remove & sd_release
Message-ID: <ZqEe4oXZfRf6t8VW@infradead.org>
References: <20240724070412.22521-1-yang.yang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724070412.22521-1-yang.yang@vivo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

