Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C4F355F54;
	Wed, 13 May 2026 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659882; cv=none; b=W2J6Fl3N0RiUiAHT2DZIMpunYs1MQV0i7CjiCJiIGoyR9o+4VIbCW7B9j/9FooCNEIaXlcPcYAPMHP1OV15qnLNSI3tLI2exponkgRrSDevRAg2plfKIF7JWmSlLecdi0pE/46kSyHRPQq+DDRQKUz5GWKopzKW/7brli7KIRHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659882; c=relaxed/simple;
	bh=i2NNY3tRVyMLYyOuXzNHCDWuGjU4m6ld8d+n0mH3ShY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkvmX/cLvpollMpTTvaxzIPcHHfWFbwhjkOa13eK15rMtxGJJQKF3nj4yQ7DeRFNmsSr39nF7laAyLLgkD5wICH4xivNpmOg4ZsPtfWyi0La2dz5R7lRkT+oIVNMowS/dz3kQFw8Dc/Gjl6bv2B3F1msHIy7Ej1RX17+Hu/NgJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1BB8D68BEB; Wed, 13 May 2026 10:11:16 +0200 (CEST)
Date: Wed, 13 May 2026 10:11:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 01/10] file: add callback for creating long-term
 dmabuf maps
Message-ID: <20260513081115.GA5477@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <ae941457cf6cacb9d4c16b6ec904da9ef7fed97f.1777475843.git.asml.silence@gmail.com> <f0dd8f89-835e-4331-b593-4405ec59f4fe@amd.com> <6cce2f4d-7400-4618-82ce-cbd5004c92a4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cce2f4d-7400-4618-82ce-cbd5004c92a4@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 30, 2026 at 07:33:39PM +0100, Pavel Begunkov wrote:
>> Then the patch should probably define the full interface and not just add the callback here and then the structure in a follow up patch.
>
> I strongly prefer splitting patches so that they touch one tree at
> a time whenever possible. tbh, I don't see much of a problem it being
> not defined as it's just forwarded in first patches, but I can shuffle
> it around in the series so that definitions come first.

file operations without users are pointless.  This really should go
with "lib: add dmabuf token infrastructure" as it is the only way for
the reviewer to make any sense of it.  I'll move my discussion of the
interface there for that reason.

