Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365E3B19AE
	for <linux-block@vger.kernel.org>; Fri,  1 May 2026 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777646033; cv=none; b=QHPubRW1zorj+4L1DWJP5xxZv6PHwPAMh7VsDo6zyBba4m3qDQb8yfAcm+LR1dAVY8uHOri8/VsW8c/s7jKlsKUxdzz+2YT0O7wmtlXJNDpoIX3RxLfw1Pv0VNg4vW0hiY0zTg6PeVe14W5VGn/Kb2csFdbf+wLDPibMcx0VxoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777646033; c=relaxed/simple;
	bh=hr3zuWVKo6TNMCFTePLXhF7OaJEg9epIW2wQwa7jjps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0SJi1VRkbpgRV8GRGOjx9PQoepqL61TLc0yuPJa8YMHUpUP2OwkiArjLZSP6EP/gME3SnccHVLdK8b3NcQdXjZmBcOSDwDxBRMAIqekcB2wL7W9OaawFU1hXkiNKetCPxMZyfWT6wylZ5TRmozTc0EYy2LOR6PDK8C9tN1/72Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JlLp3nC5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JlLp3nC5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j8jd2Ibhvngu1lVvyqeiKgt0aWWT1GOPQoZ/zlGkZL8=; b=JlLp3nC5QFGk3BtYNoCroq6B0j
	W8vgg5A36MBeE73KXsh7wwLma6wYSWPSTTkHLwVBwvjVZjFOW3sgYis6Gct1JQfK163Hh61tV4qMp
	KMEh+6l5BPnjaI49jE5mhay65vaEoA+TXFSkRoeQUI4e1T2jB/Za29AARfRwBtumwLtBW1Ab37L19
	+bxEysJ3BHvjlBsh9nAxPA1FnJHLJ1h1GRnAXVUn5g+AxhgXfUXC6qFGQx5bOQA1LnB8y2nO/ajar
	uwjkKWnejgmtab5TkN7pECXk6Zp8p1VfQeopvoT7wj/ei6uY7GislSmeaNeUw/arZYxbGSTSTxmdD
	KVP2yyow==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIow6-00000008v1n-2Dtr;
	Fri, 01 May 2026 14:33:47 +0000
Date: Fri, 1 May 2026 15:33:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Memory fragmentation with large block sizes
Message-ID: <afS5yn5QreBFQWLi@casper.infradead.org>
References: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>

On Thu, Feb 19, 2026 at 10:54:48AM +0100, Hannes Reinecke wrote:
> I (together with the Czech Technical University) did some experiments trying
> to measure memory fragmentation with large block sizes.
> 
> Doing so raised some challenges:
> 
> - How do you _generate_ memory fragmentation? The MM subsystem is
>   precisely geared up to avoid it, so you would need to come up
>   with some idea how to defeat it. With the help from Willy I managed
>   to come up with something, but I really would like to discuss
>   what would be the best option here.
> - What is acceptable memory fragmentation? Are we good enough if the
>   measured fragmentation does not grow during the test runs?
> - Do we have better visibility into memory fragmentation other than
>   just reading /proc/buddyinfo?
> 
> And, of course, I would like to present (and discuss) the results
> of the testruns done on 4k, 8k, and 16k blocksizes.

I think that Rik's recent work is going to affect discussion of this
topic (summary: with a "small amount" of work, reliable allocation of
1GB folios is possible):

https://lore.kernel.org/linux-mm/20260430202233.111010-1-riel@surriel.com/

but another aspect to it is the recent performance problem reported by
Amazon (summary: compaction takes too long):

https://lore.kernel.org/linux-mm/20260428150240.3009-1-dipiets@amazon.it/

Anyway, I'm putting you on notice that I may hijack this session to talk
about how GFP flags suck.  I may even have a proposal for a replacement,
depending how inspired I am over the next few days.

I still think this discussion is useful because we wouldn't want an
attacker to be able to make Linux unreliable.  So it's useful to think
about how userspace can make memory unreclaimable and if large folios
make the problem worse in any meaningful way.
