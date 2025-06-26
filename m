Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB412139C9;
	Thu, 26 Jun 2025 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932720; cv=none; b=kA1S+a3ZSORMyIh74u1yaLyW+H0qZ2M7GXIg+xq/tjFK811gNx+aZiD9DT7lCYMgW2dl/Y8ZzGPB9I7X6eUZtSrfbMayJSn3Es/LLq/DcOARY8IOtYVBLQaQoJ8PFumdKIcCiWENJd1otuuRAnypeolk/Uzb8Da1/fjceuFGH30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932720; c=relaxed/simple;
	bh=hzy5yEV8hkRk2qbsiJBSxT26MDWVIO+96KZ6jKG+fCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCGM/HNKHmi0PxPnXU4TedRP+q3212nTDkUYNSUlXCjfs32b+HePHArY+WoZYhdQXLZSIXHEzBXPivKlBGzbpH4bIf4i62fFSrEcTD8ylQJVNKK75QjSf9X5pF6pVbwzEdBSHNhRp4sqqBbxQVA6yGDSty7NV5a1IjgjTXuZdBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lr/svb4y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lr/svb4y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2odAZD/Bf6Z8HgX3d/nEDv01jfMZQjNxKDduDZAzWOg=; b=Lr/svb4yeAjjMdEp4PrPwLa2Tl
	kBTf0pcEGILwcllbR4aVzKrl8FX7MTOnRaswtrmfCmzTs6/bSek8PGh9Iw7Z+4ltwSzZk7/zsuZQp
	aIJd0yRDgt+oF4fJVdgWdIb17tzgud8UpIRHGpDNbc4cAvHiq2uklJzZRXRI3opV+lXlQrKYcGfzz
	mEv2e6UkQNZUAGO3qfK+86WlPLLWHXmoSQr9NUglr5cQZoXMLikk+58V7b8a7DlEkxOtAHWokgjGy
	52S3S1CLo3Hv46Qan8pdreBAx/sL4fMPAGF6kAZhm+dTLwGDIzlIzoF6Me1OqchjpWfs1KToZk03E
	Y3fKgzJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUjaE-0000000BFiz-3kr0;
	Thu, 26 Jun 2025 10:11:54 +0000
Date: Thu, 26 Jun 2025 03:11:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, hare@suse.de, hch@infradead.org, yukuai3@huawei.com,
	john.g.garry@oracle.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@redhat.com,
	calvin@wbinvd.org, david@fromorbit.com, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH] block: fix false warning in bdev_count_inflight_rw()
Message-ID: <aF0c6nqRwpyCFuAq@infradead.org>
References: <20250626083927.576207-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626083927.576207-1-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I think you want to make the inflight array a signed type instead,
so that if the earlier CPUs have negative counts due to migration
that gets even out later on.  Which should also make the
counter not trigger normally.

