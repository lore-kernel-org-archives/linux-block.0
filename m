Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46961EE01A
	for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742454856; cv=none; b=iC/V/39D9Dzkuow1CuGWlKxWmSOH5Q4ZgFuWcam06SPwcs1uGMTh2ZV9m5GxJgo8inB6x1VXd5Ah1M/cP6PFpHPdpCBqQHIVeg3QeYhQyHO5clfAeh3IQ5VuL6PlO86qnENs81Hrvy4QIhyI+zAa32MOgRl7+CxmUnzPgsdevkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742454856; c=relaxed/simple;
	bh=612RMUlc1OgHpCq9jGwXmN1i3lNF5rdi9f1r/Pv9zjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfDodjLnORi6Zj8WH/6WuAq/4xSlO4o1q+pr4B0Vd5Av7IqiblO5AFo3kdnnNtzvK+N0ucmcBhR6V+W5eu3cepZhFB5iL7yjXugjlNeFXT9E90YCQdTafwA/VwDM4w2nH8Zo+Kriklfbfk0IW6HOZJiuuO8CL+Hxo48cC5Ljl6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C096E68B05; Thu, 20 Mar 2025 08:14:08 +0100 (CET)
Date: Thu, 20 Mar 2025 08:14:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jooyung Han <jooyung@google.com>,
	Mike Snitzer <snitzer@kernel.org>, zkabelac@redhat.com,
	dm-devel@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH V2 3/5] loop: move command blkcg/memcg initialization
 into loop_queue_work
Message-ID: <20250320071408.GC14337@lst.de>
References: <20250314021148.3081954-1-ming.lei@redhat.com> <20250314021148.3081954-4-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314021148.3081954-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Mar 14, 2025 at 10:11:43AM +0800, Ming Lei wrote:
> Move loop command blkcg/memcg initialization into loop_queue_work,
> and prepare for supporting to handle loop io command by IOCB_NOWAIT.

As a cosmetic change this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But based on my digging into this code from the current discussion
I really thing we need to kill the blkcg loop_worker code with
prejudice ASAP in favor of a per-command work_struct.
