Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB95592F5;
	Tue, 22 Sep 2026 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083225; cv=none; b=Z00OExudsBhzbPQG88ro5awIFr7np9jf6X3Su1fEScRNNVPppl5KUd09YbzhUykL9QiTD2VOLPiEc41oN/e4FYcnzkCC6GgyyB61wnrhm3Bx8WH1mR87HSNcsCS+sPzB0ZqYfm3gb0+name1pxz3GOjFe5f7ZpTWKyEUKY6JFxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083225; c=relaxed/simple;
	bh=Fv5UtnMOkrV4L6o2J600jZ+PSpEfTT3W1fpr7JrMPT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuAESrB94RHI9spBaCsoP96vDSd9MX1eE1WJ7xqhGxJpJg3tgu+D482vtmIEMJ9mzhbEID3AHxp8LYUx8FXN04jo0MW7pGLmkpeYqwZKvrdcLfbemhwG1/7TAnugMnIuiPeDQMumXlcLvUYJcVCumJut3RmgbINfIuILddGaob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8030168C7B; Tue, 22 Sep 2026 15:20:17 +0200 (CEST)
Date: Tue, 22 Sep 2026 15:20:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
Subject: Re: [PATCH v6 06/13] nvme-pci: implement dma-buf backed requests
Message-ID: <20260922132016.GA30684@lst.de>
References: <cover.1789997898.git.asml.silence@gmail.com> <e80c3b1e0de004eaca6c51a2a86115ac9ed36381.1789997898.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e80c3b1e0de004eaca6c51a2a86115ac9ed36381.1789997898.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 21, 2026 at 02:38:50PM +0100, Pavel Begunkov wrote:
> Enable BIO_DMABUF_MAP backed requests. On registration we map the

This is now REQ_DMABUF.

Sashiko had a few comments, which I think are correct - if we use
dma_map_sg to map the data, we need to use the sync_sg APIs to
transfer ownership.  That only matters on non-coherent architectures
with MMU, but we need to get it right.

And the reset deadlock also looks plausible.

