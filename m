Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930DD19AD70
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745305479; cv=none; b=TWOfTyqgQ6ts1km9e/Hv6GHzxbB9U1D827nHT0vCfZGR0+iXyT9ncUvZAXWfcB8vbkey8SHNX8Iv7T9/TA8U3lBnhuCECzVFw/r9PjThnfLk4GHq3goMeh503a3ajz9y0mzvtaqIAyL7UJMBRVUaosx5DrlJERikp7j4GGdH2yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745305479; c=relaxed/simple;
	bh=XBq26j3AC5h1vWHMNTnYEp7EYhMRCTo8NmFtz1FIB2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQcoRS4YaigDrlh4qZyfEzbqYa9w9c/P7lGYSCF1dSPF+SntSVHMDGLoBbN/DsZ9D0fwbz4ujzJn2C4lzcxppvKdSPpC0idmpPopCQoQ/frrkInX08zaYx/Q0e0QBUdN9Hoy8NqxWf1ql7lHE9MGqoSrYHmGDDon9PCLSUmJryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C95FA68AA6; Tue, 22 Apr 2025 09:04:32 +0200 (CEST)
Date: Tue, 22 Apr 2025 09:04:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 07/20] block: prevent adding/deleting disk during
 updating nr_hw_queues
Message-ID: <20250422070432.GB30990@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com> <20250418163708.442085-8-ming.lei@redhat.com> <094c312a-38ec-4c5b-9db3-2269c37de36a@linux.ibm.com> <aAWv3NPtNIKKvJZc@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAWv3NPtNIKKvJZc@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Apr 21, 2025 at 10:39:24AM +0800, Ming Lei wrote:
> > In my view, RCU is optimized for read-heavy workloads with:
> > - Non-blocking readers
> 
> srcu allows blocking reader

It does.  But it's certainly not optimized for long blocking readers.

> Basically I agree with you that rwsem(instead of rwlock) should match with
> this case in theory, but I feel that rwsem is stronger than srcu from lock
> viewpoint, and we will add new dependency if rwsem is held inside
> ->store(), such as the following splat.

How does manually implementing a reader/write lock using SRCU avoid
that dependency vs just hiding it?

I'd rather sort this out as a rwsem is very natural her as Nilay pointed
out, and also avoids the whole giv up and retry pattern.
