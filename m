Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792491A23B0
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 06:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008557; cv=none; b=ObBhlX5HWUAkjmarfbg0h7aLF5+5i6P4vQT0oBLX71S4OF2CLWnb3HM98RY+ZPzuvO36RUpvM7gS+UR/2fH+KVy7HQiG1UFQ4+bjGZaq0u/weWEchlPS2FV5gHq7gcRp7AEw9d9WRR/TIbscZmYbmEaUHBPmn0oWk55d0mnucw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008557; c=relaxed/simple;
	bh=LF7JjYQTjQM5AJXV15qiZtem4U+4keJ6dFRwCSXPQ+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGts9V+Y73p9IxnTVp3E7F4MS2brkWt8JlEHm07N8kamB+xS/QlNOMwqHQYR6WmiTpa36Fk5UqeAYbATpWe6ZTyvdSTc0DUT5VniEHBIQb0QaC38n/2wjYEMxcENTjS14WO9N8VqqTHiccSjmqK8WanWkDokgXQ2h5IxOpvKzks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 18BA668BFE; Mon,  7 Apr 2025 08:49:10 +0200 (CEST)
Date: Mon, 7 Apr 2025 08:49:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
	syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: don't grab elevator lock during queue
 initialization
Message-ID: <20250407064909.GB18766@lst.de>
References: <20250403105402.1334206-1-ming.lei@redhat.com> <20250404091037.GB12163@lst.de> <Z-_L-_9fG0Z6CYQM@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-_L-_9fG0Z6CYQM@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 04, 2025 at 08:09:31PM +0800, Ming Lei wrote:
> > I think the problem here is again that because of all the other
> > dependencies elevator_lock really needs to be per-set instead of
> > per-queue which will allows us to have much saner locking hierarchies.
> 
> per-set lock is required in error handling code path, anywhere it is used
> with freezing together can be one deadlock risk if hardware error happens.
> 
> Or can you explain the idea in details?

I fail to parse the above sentence.  What about a per-set lock always
taken before freezing queues has an inherentl deadlock risk?

