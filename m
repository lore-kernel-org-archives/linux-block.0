Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EEE28935D
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134628; cv=none; b=Dk4nL7RR8VCfXovjFfPRgQs472zHfHMY5JgUMC65uWXjPkahMTRMpaVAKWmbJook46ix8LVVj4qxbMcj7wOWAh52Ub5x6tWue2lUmILw1CT2kAuoFnprcUl5kFhEIsJ0ceIccQ2HNjdfCle81Vxl4miws6dEAD8yPgb39K69wVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134628; c=relaxed/simple;
	bh=tABg9cdrJ9tPFMs99lq2WazD83tr86JLM6QguN57cmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ki34hoz2yAA5W+sRbz7ual9fcbUnY4cdzUT3tU43xkZfKeEWgaj87zHTFlmQaYnXNvcspn363GjqU4eha9sxU2CUaucqEO4Zrhc+Bi8/O25ANgLvAt5u9QvNcRDtTX1F/ZJofdt6eO8Bwkn1cx/nDVQEuG727wxfVNWkVmyejL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE4BC67373; Thu, 10 Jul 2025 10:03:41 +0200 (CEST)
Date: Thu, 10 Jul 2025 10:03:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix a deadlock related to modifying queue
 attributes
Message-ID: <20250710080341.GA8622@lst.de>
References: <20250702182430.3764163-1-bvanassche@acm.org> <20250703090906.GG4757@lst.de> <918963a5-a349-433a-80a8-6d06c609f20e@acm.org> <20250708095707.GA28737@lst.de> <b23c05be-2bde-424a-a275-811ccc01567c@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b23c05be-2bde-424a-a275-811ccc01567c@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 08, 2025 at 09:11:41AM -0700, Bart Van Assche wrote:
> I will look into modifying the SRP tests in the blktests repository such
> that these use bio-based mode instead of request-based mode.

Note that this just fixes the test case.  The fact that request
based dm-multipath keeps active requests and thus an elevated 
q_usage_counter around still exists then, with effects both to sysfs
and other users of queue freezing.

> So the question remains what to do about these two regressions:
> * The deadlock triggered by modifying a sysfs attribute of a
>   dm-multipath device configured with "queue_if_no_path" and no paths
>   (temporarily).

That's not a deadlock by the classic definition, but yes, it is hang
that should be addressed.

> * Slower booting of Linux devices that modify sysfs attributes
>   synchronously during boot.


So which attributes are regularly modified?  Note that for read-ahead
it should be safe to drop the freeze as unlike the others it is not
used for splitting I/O to the limits accepted by the hardware.  So
we could probably drop the freeze IFF the patch documents that it is
safe.  But it still won't fix the root cause.

