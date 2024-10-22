Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5951547E7
	for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581947; cv=none; b=iWc26mpNd/N5rowYAvYGBozEkY1YCmSsm38QIAuuyTcNzeyMDC/Uo5g4acD8NtyE3GXZi2Vb7srz7LzzJhLbsvBFk+TOyBmSHj1NgdmWWSWxnFEoMMwddDX6GzbG8wdbKDyTzPeAFrw1lqjGqS89W4A40H2zl1OK2c5D8oWMb8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581947; c=relaxed/simple;
	bh=x649dIQrADi0nzqoP302966VhfAHQ3PdZPsEBfGKGqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqTQAU8UCi0pfBCVeJVUlysGMrXJajgWT8TB2CePHHsz1VUno7iTHkH1ygSwOuJX9/Jnv3pm8fnpKZNH+zpKKOsujhVrPzeqdZfiwSWp5UdPz6wfC/AbBoX8g+mrkgc89IUZmzblDGjW1O1jM3GuclMknfcDvPQEHeGVeXQscb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 79BE6227AA8; Tue, 22 Oct 2024 09:25:41 +0200 (CEST)
Date: Tue, 22 Oct 2024 09:25:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [Regression] b1a000d3b8ec ("block: relax direct io memory
 alignment")
Message-ID: <20241022072541.GB12249@lst.de>
References: <Zw6a7SlNGMlsHJ19@fedora> <20241016080419.GA30713@lst.de> <Zw958YtMExrNhUxy@fedora> <20241016123153.GA18219@lst.de> <Zxb-EWevBxzjbYL3@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxb-EWevBxzjbYL3@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 22, 2024 at 09:21:21AM +0800, Ming Lei wrote:
> Can you take coherent DMA into account on kernel/dma/debug.c first?

We intentionally don't to force people to write portable code.

> Otherwise the warning still may be triggered on coherent DMA.

Well, it is a valid warning for the above reason.

