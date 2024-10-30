Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B041EE039
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299464; cv=none; b=f+bWm6HJ7ELfIH4/6YDS2vTOiP+Sdt5FunLZenggZMGo0FfeJjrGJEYL4VAwZbQoXXTLgSL1P5WVLM8bVgKTooU8ci0M4Hn1Mvu/61zGZODwVfijJKNd9ys2h1QwbMRCZNjiAWPQp+UGRXv8dGbHMlqPSqg99VYwWZ/PL/BxIzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299464; c=relaxed/simple;
	bh=ioxbNEjKdwKPKMNFzvOtKRaK+9QX1XIDq+Bq61CBs7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjhFl7tfMPzXMdHHrhYguzH2JtsUKvIqPqIcpobiX0Nk2ysu1YtgFDv6/Gx26Cl956v3nV1uyku54RPbKMgF+uKMCXW/Ij5REO7Y7h59PAO7RH3Bi5FVydhucTsJdBac4RLy54kgoMRXkXpb6WuWebvrLJaj6Mq0gZ72eSHairc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DC2A2227A8E; Wed, 30 Oct 2024 15:44:18 +0100 (CET)
Date: Wed, 30 Oct 2024 15:44:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 3/5] rbd: convert to blk_mq_freeze_queue_non_owner
Message-ID: <20241030144418.GB32043@lst.de>
References: <20241030124240.230610-1-ming.lei@redhat.com> <20241030124240.230610-4-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030124240.230610-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 30, 2024 at 08:42:35PM +0800, Ming Lei wrote:
> rbd just calls blk_mq_freeze_queue() only, and doesn't unfreeze queue in
> current context, so convert to blk_mq_freeze_queue_non_owner().

I think the right fix here is to unfreeze after marking the disk
dead.

