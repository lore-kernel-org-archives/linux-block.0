Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF943451C1
	for <linux-block@vger.kernel.org>; Mon, 19 Jan 2026 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812117; cv=none; b=rCsCbCy3M9QZs87KuqNBdK6KQwd8V0aPfnpxmtR3LwY457E1wZ9rHLtCSEHGG9SnuONUIcp/TO154c9LcaygoaUqvX5q7BBrOV6AMXl8zDnBO1g7OVpUkIH0MDXNAoddGO4KnJd8GdjfqQ7ctVhMpBdg1PDqN8tjS8f/1dqzq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812117; c=relaxed/simple;
	bh=6xuBnFdTFsAwR86wtNxn4dCzG7PAuTOanFnvS40tdZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1EIDa0IzewS7AmLCLBdb7Me2wJZZa8TGuMWORJfuqegKwCRzAEsP+Rc/LodmYvm/B97QkraTsap/elXGfpMDDfFDl5/ZPrUE6q14+sYUkZQTsolqnEtdTBsbcpc3/jmvXpSdfSCo8DafGf4Li6s/YtUSr8mgM13NQugdjWtKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B2C92227AAF; Mon, 19 Jan 2026 09:41:44 +0100 (CET)
Date: Mon, 19 Jan 2026 09:41:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 1/2] block: Annotate the queue limits functions
Message-ID: <20260119084143.GA5509@lst.de>
References: <20260114192803.4171847-1-bvanassche@acm.org> <20260114192803.4171847-2-bvanassche@acm.org> <20260115062613.GA9542@lst.de> <1eeca326-9403-4483-8b03-36621e79db81@oracle.com> <33fe1cf9-a779-427b-bf74-1eee4434517c@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33fe1cf9-a779-427b-bf74-1eee4434517c@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 15, 2026 at 08:53:32AM -0800, Bart Van Assche wrote:
> On 1/15/26 1:11 AM, John Garry wrote:
>> On 15/01/2026 06:26, Christoph Hellwig wrote:
>>> This is missing a commit log.  And not really telling what kind
>>> of annotation you're adding.
>>
>> And we removed these previously - see c3042a5403ef2.
>>
>> Does sparse now handle mutexes?
>
> sparse is dead.

It's not.  And even if it was we still need it.

> The most recent commit is from February 2024 (almost two
> years ago).

The repository disagrees:

commit fbdde3127b83e6d09e0ba808d7925dd84407f3c6 (origin/master, origin/HEAD)
Author: Dan Carpenter <dan.carpenter@linaro.org>
Date:   Wed Oct 15 16:08:13 2025 +0300

    builtin: implement __builtin_strlen() for constants


> Additionally, the sparse maintainer doesn't reply anymore to
> emails or bug reports about sparse.

While I'd love to see more activity, that is clearly untrue as well:

[PATCH v2 3/3] module: Add compile-time check for embedded NUL characters


> These annotations aren't for sparse - these are for clang. This patch 
> series has been queued by Peter Zijlstra on the tip master branch and is
> expected to be sent to Linus during the next merge window: "[PATCH v5
> 00/36] Compiler-Based Context- and Locking-Analysis"
> (https://lore.kernel.org/lkml/20251219154418.3592607-1-elver@google.com/).

Until that actually becomes mainstream we can't break the existing
annotations.

