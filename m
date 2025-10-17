Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E11FBEB0;
	Fri, 17 Oct 2025 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682470; cv=none; b=ZWg7P8z22j50gmolohg78eke2UvOoKe+KMKUouZp8YBuibmQmU1SjhlERW9X9wqchghhgUB4B7qfbWbgnK4em3o2ASB+JZwbpQlWaGJaymLXKiLNxfLSx8snZwnmrdCaE9zJGOozOlxDGPgidUNwMKXUGIkat2gYZedRx86SqYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682470; c=relaxed/simple;
	bh=qqXJK2Km4NxgUHp6NoyieAk8vwSL25NX5VDaVnUy5kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH8W0EBcHeyGtBuxlWkBVuCleElPTA8iAGDn5IrqYA9rvMRErpNxyLPiACZDlN6vWv9WktRgTW37KY2C+XefQA9G1tSXRd9bAqc47qqxK0Oc02n4+N+7TiOpGcEkmHjF4n53JUc9+QGEp7ThIvilueBvoisgXvE5fK+NFGm3Ppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LkHQQTby; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LkHQQTby"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L9u6qgaFFPFtaJchpewDMkZNS7I1XQP7Tbwn8tkFcco=; b=LkHQQTbydnSVZd8FqQqHjTElVx
	d6rhB6pJB/VJHXv1HKl1b0TOfqwNU6QdZSEvnqbNZXowy6QbXvZ5gmpdNvHHEMNiU79VDJbU8Xfkq
	TJdDGhrpkQjnlXEPiWGAoN25Nfc3Tc3/DHY4F3dG1PBxk5OlXW24B7Tq0g40+2snZlrc07ZCaXsgl
	3YwNV2WGevuf/ZPVoMAsV4ytPNCmrlgq1L+9EBYArdEia1OsXIhXkINzd+G/38JE/lZfsGpt0y8iA
	0omPyL57rJUcyAUBASakvf7mqh+gQ2uE0TuwZk9zCv+0KwzJHoYqyV+z6QPR2uRZ8CZyz8/294+rn
	O2jd6KwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9dw5-00000006mCA-1A2m;
	Fri, 17 Oct 2025 06:27:33 +0000
Date: Thu, 16 Oct 2025 23:27:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: chengkaitao <pilgrimtao@gmail.com>
Cc: axboe@kernel.dk, dlemoal@kernel.org, yukuai3@huawei.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: Re: [PATCH] block: Remove redundant hctx pointer dereferencing
 operation
Message-ID: <aPHh1eTQRDO3z6Yb@infradead.org>
References: <20251016131651.83182-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016131651.83182-1-pilgrimtao@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 16, 2025 at 09:16:51PM +0800, chengkaitao wrote:
> From: Chengkaitao <chengkaitao@kylinos.cn>
> 
> The {*q = hctx->queue} statement in the dd_insert_requestfunction is
> redundant. This patch removes the operation and modifies the function's
> formal parameters accordingly.

What formal parameters?

Basically you're passing a pointless extra argument instead of deriving
it locally.  Why would you do that?

