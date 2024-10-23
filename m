Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85D91ABEA7;
	Wed, 23 Oct 2024 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729686178; cv=none; b=AgC+H1m0GiICqnQTsLipAgSgXZHKFJMRR9hH8ZAOY/nnMJ0WFktlWmpswVGJRBedhIAsaQJyGhErJc6T+gmK59JRYI/0cXA9TTJ6EyYFHqdyLcF9s5BzrEf8BD+2AcZqzzDQ/hSA0MtwmfeWPEf645jIoYpWSi76s/f+8bSH4GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729686178; c=relaxed/simple;
	bh=UWmNfNS2UUSGblrx5o0wtKven7vwDB0pFAHvPKl39wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fa+pfDTDAZSzVZGwdw7bYn01XIaEkig1IoPk+2Y2/4HkhLODJSLuDl1YeqcrLc2TWHrYh7v00iDZWvkkwMiTkX9gv89lJVWmrEAkkmoMPdlyudIM6zy9Gg/EI4LZys9w+zrTHgH6K3TsB5atv/rYa8U5oMmnLvcDNZiTNVbBhGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47790227AA8; Wed, 23 Oct 2024 14:22:53 +0200 (CEST)
Date: Wed, 23 Oct 2024 14:22:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
Message-ID: <20241023122251.GC28777@lst.de>
References: <20241023095438.3451156-1-ming.lei@redhat.com> <20241023095438.3451156-4-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023095438.3451156-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 23, 2024 at 05:54:35PM +0800, Ming Lei wrote:
> Recently we got several deadlock report[1][2][3] caused by blk_mq_freeze_queue
> and blk_enter_queue().

Please wrap your commit logs a 73 characters.

> For example, the following lockdep report can be triggered in the
> report[3].

And I think the commit log would be a lot more readable without the
long trace.

The code itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

