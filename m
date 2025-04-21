Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C75CA5E
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238902; cv=none; b=pc0zgx1D4/RI5RlRfJhiJM+zjcKncmGBRKpMWxXFSXq++w7b695EFUfY5qVlz6SLfMRwfaGn4dm89D0vYw4ob2KHwFhZ7T36YmWvgdejE7SaaBGsRutLSPOUOE3nH6ltz/5h12HZW4Q4fDJ3yD+TQKjR+WbhC3rKd22shxmNW1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238902; c=relaxed/simple;
	bh=ZXVhf/TU1I4evvYkACQmAqSiL3nICV0UZypS1kZHQJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgXtiXV/WfiU/WNNlRG+CppTGyQMqXASr5l88CnO+0wEpgQFYVMPv8nt0ZfT4zQljMM2bMTodO/90yg1lJyd494siDRDy2prS9mCGOAqrFggEAR0hpgDE6dD+wK5fzN93v+NH2rHWTDb3BubPbAiONW6XU91U8GiItO6Pt4WA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BE48068AFE; Mon, 21 Apr 2025 14:34:56 +0200 (CEST)
Date: Mon, 21 Apr 2025 14:34:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 03/20] block: don't call freeze queue in
 elevator_switch() and elevator_disable()
Message-ID: <20250421123456.GC24038@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com> <20250418163708.442085-4-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418163708.442085-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Apr 19, 2025 at 12:36:44AM +0800, Ming Lei wrote:
> Both elevator_switch() and elevator_disable() are called from sysfs
> store and updating nr_hw_queue code paths only.

I don't understand this sentence.  What does
"and updating nr_hw_queue code paths only" mean?

