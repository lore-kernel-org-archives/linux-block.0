Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1261AA791
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 05:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745298193; cv=none; b=JA+PkXt4Pu7PHVG7Anb95K5U6OTiSqJfjj/zUXjvb+aMW+qK2oRlnlLdEQ6bb0Zw70g0Ldu/AZNCi0ezIvmn4wxKAVRUmgawyXU06q7zL4pX2sjalgXPjvp0zuThLBRLbow5/YFzA0vPby5gkVBbzcGmMjA5bxki9VPNHvO0OE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745298193; c=relaxed/simple;
	bh=u7KiBX9i9mxqqLW1b7mTqCXmJ8F8AULP3w3amNiQAP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k38TburtawzrVjBhzVqRrb3hpcNsWINwk6zVB1dN6IpYcGi2hcZUw4YmZgLGQVb9Ia57EQLVr5nOMLHkZh6719zDaqQCrJyWjQyubNX6oy1y3cevBUpamfcu97ukUp63iOMRtuRsxWV0t7p0kQdlAwttp//N5haKrBdjyFnvr1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4hIqqFNQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4hIqqFNQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u7KiBX9i9mxqqLW1b7mTqCXmJ8F8AULP3w3amNiQAP8=; b=4hIqqFNQzHHTJc0Lt/AeUzPgu9
	2TSs/T3d7m7Nu7PcjREmDahWDdV/nLmVlwfUe8gNgbtB88MKp4aZ9NNjmOxf+7a7ehSbbSbL6LDzT
	zI3bBWwSqgUMhpfQJdCVDblz1VdSD2A6r4vVySmU1ZLWH49eGZY/GXOTp5U1o/tOeZhCTnWs8Apkn
	tsK/+Lnf92dx4a+TokDctDG13Duw1aQBym3mbULgzkpzGJQVlTZV16PPAZBjF6TvRnz7JCZ6jNsJq
	fGFnOxqwhxjFdfI+kON9+f1rXYIiRHT60ZsJyagB/ihtD+WHFb4Vl9HS/CQhEboKRssaZXbsdAIIU
	LgK1EH5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u75mo-00000005pPH-1dkx;
	Tue, 22 Apr 2025 05:03:10 +0000
Date: Mon, 21 Apr 2025 22:03:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, yangerkun@huawei.com,
	yukuai3@huawei.com, ming.lei@redhat.com, tj@kernel.org
Subject: Re: [PATCH V3 4/7] blk-throttle: Introduce flag
 "BIO_TG_BPS_THROTTLED"
Message-ID: <aAcjDvCvmSiLd4zx@infradead.org>
References: <20250418040924.486324-1-wozizhi@huaweicloud.com>
 <20250418040924.486324-5-wozizhi@huaweicloud.com>
 <aAY0GNzcJH28OEtA@infradead.org>
 <818c7a4b-50b7-4933-ae01-e6fbb93417b9@huawei.com>
 <aAY9jhJr1VOh0sMm@infradead.org>
 <a5d1f436-9d31-407a-9653-5fd48f3dc80f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5d1f436-9d31-407a-9653-5fd48f3dc80f@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 21, 2025 at 08:53:10PM +0800, Zizhi Wo wrote:
> Yes, otherwise they will interfere with each other. We can currently
> ensure that this flag is cleared in the throttle process.

Can you explain that a bit better in the comment?

