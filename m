Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7636D2FCBF1;
	Thu, 14 Aug 2025 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179679; cv=none; b=tSP4+ovGwPEtbuI9Kj0EfPoOLlfTHs+4sIl1rwyjEux972duxtiNPwTnJ3Kxyvz3rUdS7urViz02gry7qIwXx+fLhEoNNnRoULdvwu5miSDIqr7aR0mOQ1Im1W6kZe3PaOc0TTXNrRSZg3GvKKMtZgTbRtdlR+3RV8vvezZm7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179679; c=relaxed/simple;
	bh=Pq9K4lFVCjWXcoUHMD2/NQ/zY/jH7W1uAx+GiZVQeQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3I5uStS4qLq0pPthHcO5APwEFLevJVM91YThbBzHElnEymhL6Hlky38aLPovZ1TtThfvPUIZweefAadF0Z/Vu8+7nSsKpzUhe8XWNSLfkKp/RXFe26XDzrr9BWYkNdJKdjYiO8GSc/ex+NP1++8VmHpPtziRtqZgpTZ6zeRT88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e03NKnZ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e03NKnZ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B435C4CEED;
	Thu, 14 Aug 2025 13:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755179677;
	bh=Pq9K4lFVCjWXcoUHMD2/NQ/zY/jH7W1uAx+GiZVQeQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e03NKnZ5pRDJGkYy7nHE7La3Qop/W5zFF6vmyQ2hPvJtNNddT/LjGILExqFQbIlKi
	 ZhAJKlB6eZIyJGFGVlHtw9U8YNpAfv74nS1gwqxD9oxbplgtXp12aOi/gG4T8drbe3
	 5sKXOsKAmQZV+a0d1v+fU5idUKIIxqvRr7bUMN+c=
Date: Thu, 14 Aug 2025 15:54:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardeep Sharma <quic_hardshar@quicinc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y v2 1/1] block: Fix bounce check logic in
 blk_queue_may_bounce()
Message-ID: <2025081404-conceal-next-8858@gregkh>
References: <20250814063655.1902688-1-quic_hardshar@quicinc.com>
 <2025081450-pacifist-laxative-bb4c@gregkh>
 <21bf1ed6-9343-40e1-9532-c353718aee92@quicinc.com>
 <2025081449-dangling-citation-90d7@gregkh>
 <4a898590-e1ca-41dc-b8b7-a5884d10db5d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a898590-e1ca-41dc-b8b7-a5884d10db5d@quicinc.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Aug 14, 2025 at 06:36:29PM +0530, Hardeep Sharma wrote:
> This change to blk_queue_may_bounce() in block/blk.h will only affect
> systems with the following configuration:
> 
> 1. 32-bit ARM architecture
> 2. Physical DDR memory greater than 1GB
> 3. CONFIG_HIGHMEM enabled
> 4. Virtual memory split of 1GB for kernel and 3GB for userspace
> 
> Under these conditions, the logic for buffer bouncing is relevant because
> the kernel may need to handle memory above the low memory threshold, which
> is typical for highmem-enabled 32-bit systems with large RAM. On other
> architectures or configurations, this code path will not be exercised.

You did not answer most of the questions I asked for some reason :(

