Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3204221B192;
	Wed, 19 Aug 2026 05:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118775; cv=none; b=U3Ak1coZJ762rGsPoG0B4hng+UF93NBECPp63m2daoTNlNGmBXlvohWXOVzo83B7xHeUWSbhud6WGD77EQJ1pLSCz50BQlOBUKqXrzklXxKtMSUJJhxrdqMScLoKN+AlvMi23PqvINAMOmVbro1dlRuOuURdM2kTyrW2bwwHhBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118775; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/tKspoIY2JeXHOhNTgU9a+1GX0fAfCC7suxp41yQ0yni408ywT4ukwbrmWYeKcyz747RRaamSRxPazKv0/jUq4h0L2Q93X4e/eSu9tVlQN9EDoo6VShHxLqnbxJ5RTWRJ+DWib2L/oXuDuiebM9sCGbf0smiBE/aznqAjwAao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CdgWvnmh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CdgWvnmh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=CdgWvnmh2bHQRCWyvZQ3JytJD7
	7FjaKILj+rm5QpChy7/1Cpap9Em1luqQ+TboOyo4CMlB6JYEpV1Q0b2lw+x+t92/pzQYtx/gdhthJ
	EVA8nPoy4oxNOrp1UdZ48VnUF/7C/o1TUO7bM6VVcBoHjVwT+cZzD4MMGQZ3Ps4nGZ1C5Ck2JL8gG
	vXuwtX08DKa2IGIV7Pbh+oyI5g8X2E7UMnvDIXglHRSrmwIjt3Weu0m0jZ2gSvKedHFM5EaMqgNNv
	kE3c4KBFsl4Or52YO1ttJGk2lmOszYaHWv9xKzD8IWmP5ON2CyjX1NqFzh27kGXCRvfN96b9zyqCh
	pzovfwMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwZEH-000000092xI-2VNS;
	Wed, 19 Aug 2026 05:52:49 +0000
Date: Tue, 18 Aug 2026 22:52:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergii Ushakov <sergiiushakov@google.com>
Cc: virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2] virtio-blk: clamp max_segments when indirect
 descriptors are disabled
Message-ID: <aoVEsV6-JeyEfmCd@infradead.org>
References: <20260814105954.4060627-1-sergiiushakov@google.com>
 <20260817134202.160669-1-sergiiushakov@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817134202.160669-1-sergiiushakov@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
