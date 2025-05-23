Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D8821D5BC
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019739; cv=none; b=ukOvPRtm3zCFckCEFh4sMMuODNTtwJUB5QJTlRWiG67g89bwcwT+IgqI3qn4uwL0pU/tsJU1wjdFt2T64WY0P9AkyxhsR5vQ1/L8LjZ4/q0F7/dETnPIeCHKvfedY6OUaoHN3DyybEhplqnI5G2btLulA1fz4bv3YjP5SGEX0Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019739; c=relaxed/simple;
	bh=d06y+t7JFqi/D6PQ4ks72NPGGFC2M7hmUEw6fWfr6CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xu1cqq05T9si/6TNFxq6/DGdoZxL4mflHuIcPxuc8JX8HAI+woRjh2s++lj/DxJHNns8IUCqbzTV/OnhHLc1uKDGf4796dShYUYQaov+w1LHAFtcqJbuux5qJcjTe9SiNTwkQNZ+3cl8O45f9kmIx/lTnJu4cPSE7XLjt7JAAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOJZcwPO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOJZcwPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F6FC4CEE9;
	Fri, 23 May 2025 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748019739;
	bh=d06y+t7JFqi/D6PQ4ks72NPGGFC2M7hmUEw6fWfr6CQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOJZcwPOAvEpIhy3iz/yw5CtssnznRPy+5kRbz5clt+hujQUJOwkt0oXyivXApajy
	 ahHkYBX6Sw5qaw3IMmQgLyTDIL+hjTCDr6phBk4NTmgXPAp30S20o9PWt2TLvQUOnp
	 gWTnt0pwr1QWOMDwMX+OvX4dZGgocjssQnyC4k11XJbRINJppL0R9WcDkJ+rePw8QW
	 Zx/MjAJtnHPzc6jcNrOhDhugF76uucpWnfz6aOXE5qj+1fsVQ8gaQSF7T/4YtOFaw8
	 Cp+2RkrfcNOPsb3VzdEwvf90krsPvstSEgmU9H+eZTvXHZ4cCT/XPVyR311l+hJoOE
	 4wh5HoWAQFblg==
Date: Fri, 23 May 2025 11:02:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/5] block: new sector copy api
Message-ID: <aDCqGLY4irp-6N5M@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
 <aDBt1qXj90JO1y2v@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDBt1qXj90JO1y2v@infradead.org>

On Fri, May 23, 2025 at 05:45:10AM -0700, Christoph Hellwig wrote:
> On Wed, May 21, 2025 at 03:31:03PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Provide a basic block level api to copy a range of a block device's
> > sectors to a new destination on the same device. This just reads the
> > source data into host memory, then writes it back out to the device at
> > the requested destination.
> 
> As someone who recently spent a lot of time on optimizing such loops:
> having a general API that allocates a buffer for each copy is a bad
> idea.  You'll want some kind of caller provided longer living allocation
> if you do regularly do such copies.
> 
> Maybe having common code is good to avoid copies, but I suspect most
> real users would want their own.

But the end goal is that no host memory buffer would be needed at all.
A buffer is allocated only in the fallback path. If we have the caller
provide their buffer for that fallback case, that kind of defeats the
benefit of reduced memory utilization. So it sounds like you might be
suggesting that I don't even bother providing the host instrumented copy
fallback and provide an API that performs the copy only if it can be
offloaded. Yes?
