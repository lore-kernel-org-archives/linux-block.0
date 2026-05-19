Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AFF3F6C4C;
	Tue, 19 May 2026 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182744; cv=none; b=ut2kc4GW8VOgd44LPP9EW5liCc/C6cW7vAda3hSQfVeh5txrOlpTwdqmSCkn/KTZSJWfE/J7litSdWXZwI4/QBe1NaWTQdIMNvtWIga3KMgHw5pvs4Z+BZKV1LYi9ki2MOra689Imtl+8lc/Wo9qVVuPNMSTTAAwjRbT6l8C854=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182744; c=relaxed/simple;
	bh=CtNNvNnb1Z3Z+dqNXItF+xz1Kd7BrttIjpxzy76M0jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7q9mgeJAlVB++nTbdSplJXvx0YF8cTH7PSChwp4jNRFEQ1xAVd3TG+sO95/r++NLGpGQGXmES14VqAp7DMmoHiYu0lxILCBlJJ6OJKFM0OIk/+cPQ+XhxDUWXUTFtI1e0gY25I9HszOrYQe6/JZXMJrJHfHOXYF0cD9xQc7Q6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A1F868C4E; Tue, 19 May 2026 11:25:38 +0200 (CEST)
Date: Tue, 19 May 2026 11:25:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 05/10] lib: add dmabuf token infrastructure
Message-ID: <20260519092538.GA19935@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com> <20260513082431.GA6461@lst.de> <ebf41920-5852-428f-b98a-e0f44c8f3315@gmail.com> <20260518125326.GA5754@lst.de> <ea47051e-697f-4017-a514-be6ef7c110e9@gmail.com> <20260519065653.GB8173@lst.de> <9933142a-4ce2-4219-9574-73da30edd74e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9933142a-4ce2-4219-9574-73da30edd74e@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 19, 2026 at 08:55:32AM +0100, Pavel Begunkov wrote:
> On 5/19/26 07:56, Christoph Hellwig wrote:
>> On Mon, May 18, 2026 at 03:23:53PM +0100, Pavel Begunkov wrote:
>>> To be fair, it's not that dma-buf specific. This lib/ code only
>>> does some resv locking, fence waiting and queuing fences,
>>
>> But all the dma resv/fence stuff is pretty tied into the dma-buf
>> ecosystem.  I don't think it would really apply to something not
>> doing DMA at all.
>
> The point is that those can be separated to reuse the rest.

Are you actually doing this right now?  If so please share what you
have, otherwise let's keep the dma-buf bits together and move things
if new abstractions emerge.

>> But none of that really sits in the current lib/ code anyway?
>
> It's about naming. E.g. passing a DMABUF_ITER that doesn't have a
> dma-buf would be confusing, and then it'll need renaming at all
> layers to support the use case.

Again, if you concretely are doing this right now, find a good
name and place based on those abstractions.  If not let's ignore
it and move it if needed.

>> drivers/dma-buf is a pretty natural place for it, I could not thing
>
> _If_ there is no dma mappings, drivers/dma-buf would definitely
> be an awkward spot.

Yes.  But that's not the case right now.  And from looking at the
handwaiving for ublk/fuse probably not anytime soon, but maybe I'm
mistaken on the latter.

