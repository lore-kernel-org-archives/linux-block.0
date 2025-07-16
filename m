Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D6723ABB0
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668422; cv=none; b=CTMS3nRWPma9fNuIYT7HDWjWpVuLpv7beoZUHzEr8qN3Lk+l8i2Q3BONGluwU+5i6/b+mI39XrsZYNH0CT1mmgyG7zZA6ZrVt/2TN5KKyyvfLouBPXR5HS++Q43cvRHxE3DbrhXMjvA09jKDp23MbIlHp+QULhJHC8uf5IuNSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668422; c=relaxed/simple;
	bh=QNo/SsxxHegwQ/v075cC0ZOaxML3NCfrjRsX5MgIAL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cf6lpun33DJfxpqFCeyBmgINBzHObeag0LcT4FJB/1tp7HC5ai5e2bfjdR2qTYgA+rEMxW9mbq+JnyUrxVOKH8Dd7zPSdEqvusCh9XLaOB6g92RH6ieNyD/cMAi9jZAU7+E7YU+npnI0mlACjqgyRDsDSjmfpKzAbKXdyhei4ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MMJlfGu2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MMJlfGu2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cEhGASYKLz7MvFmf59N2Afmkq6r3+CaQTYATBZjxfmI=; b=MMJlfGu2XlPhX5jzMGTgJWwOau
	spuK6x/fMgV5AmxeaHHM2Rqwx1abErnB+9fcDqixa7bj30M0Eaou7Jh3JwTGWimZKaz29uMUDQW9I
	qaNvaDvlr15RXFCrgEDEag+VUmimb5JSmIIEJ7Iwhcj47Bun9OrCZhBsz4qsOjov+EG1qAaOi5Wpv
	e/yiZ0ZVTYkD6N9RqzF22V+9IqdTUJ0mvTUzxdkvubBpYab/s5OgJZChxTJaXe6WLCZIkn7tSPZIK
	NfBEstXbU7NHuGWPyVaVd+IepT4EL/AeG1l20XludXDuWcsivaVqydY2rBcHJ33d2rmvsNyJE5Ezf
	4ZQgoEFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc17T-00000007e6I-3z4V;
	Wed, 16 Jul 2025 12:20:19 +0000
Date: Wed, 16 Jul 2025 05:20:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Changhui Zhong <czhong@redhat.com>
Subject: Re: [PATCH] loop: use kiocb helpers to fix lockdep warning
Message-ID: <aHeZA3sT_o2O5JWs@infradead.org>
References: <20250716114808.3159657-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716114808.3159657-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 16, 2025 at 07:48:08PM +0800, Ming Lei wrote:
> This patch fixes the issue by using the AIO-specific helpers
> `kiocb_start_write()` and `kiocb_end_write()`. These functions are
> designed to be used with a `kiocb` and manage write sequencing
> correctly for asynchronous I/O without introducing the problematic
> lock dependency.

Maybe explain what it actually does.  That is drop and reacquire the
lockdep notion of a held lock, because the process is not holding it
but instead handing it of to the one handling the completion of the
asynchronous I/O.

The change looks fine to me, but this commit log is rather confusing.

