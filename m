Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C91A1878
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 22:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711061301; cv=none; b=Q0RiXnTEvWt5Jvvr5sYxgG/j55UnuImhBalF2r38Pfn8zqV1I2SVJG+mi/MCTzciYPAPxZtQTWLdWgciqF/QmXnPHfvy5cB/fiYucxbzwdllUEtkY5Y6XL7R4ugPJkT/Pq1SwtBi8kIhHQ1pFbgngYnHBLhlpIhv7tmWmOd7dx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711061301; c=relaxed/simple;
	bh=7qCO0zl0f/ql1MOJu32WauD5ZQp9MezYcW1otTb3heQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaYlYYtQ5iQMpMc/KInAGYKsileBM3RZkVE3gOYYpEPXE28sVvt6D7r/Z2T4JTUA4m0/Qj1Z5G1p7VU6z2tSVrS18ihXRcjDOaP4n5t25Cf7TSlvqbhgvrFB2R987XgS6n/mCRM0cxKgdnwSe0eXbjw6ht5nvGZNof7AbY8oJ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2E2A968B05; Thu, 21 Mar 2024 23:48:15 +0100 (CET)
Date: Thu, 21 Mar 2024 23:48:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH] block: Improve IOPS by removing the fairness code
Message-ID: <20240321224814.GA23127@lst.de>
References: <20240321224605.107783-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321224605.107783-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 21, 2024 at 03:46:05PM -0700, Bart Van Assche wrote:
> There is an algorithm in the block layer for maintaining fairness
> across queues that share a tag set. The sbitmap implementation has
> improved so much that we don't need the block layer fairness algorithm
> anymore and that we can rely on the sbitmap implementation to guarantee
> fairness.

IFF that was true it would be awesome.  But do you have proof for that
assertation?

