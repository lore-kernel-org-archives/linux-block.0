Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6FD148830;
	Mon, 20 Oct 2025 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973239; cv=none; b=Iiw5NLROJO9W6fhhYCz3CZHjw+OiZH/hCIzALhRd2NHnA+ouBWGLC0yKrgMj+tk9zyFWWA3iJlVH3tuoxwmq/PmfHJ9T48OqH9A/P9/DHtxWBQ3LsBzogPGFq8Wauos57KUR8qC9uCAN6WlJPJM9V7RiYuQymgeb12zfVjXvuI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973239; c=relaxed/simple;
	bh=GK5XpQbAgwQo3pNeDKAZeoqVl0TujKNotxfdbKkL1xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogd97e8o/1dpqke1FTSk+6Eb4HZybgcQUSPGvyFFTIfwbqWrbaKSA+zJ1cCh1IQ7mQ7uTKLIB3w0A46IrCA0rzlA2p0KSYhztR3KQuNDV+pJhTLbCUodLBg3gKtS2iuIZM9eG2PlsmDEZIbYv9/WS1FHqGPh2fbFyTaytDRTQ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XT9aA3oy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XT9aA3oy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7D8C4CEF9;
	Mon, 20 Oct 2025 15:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760973239;
	bh=GK5XpQbAgwQo3pNeDKAZeoqVl0TujKNotxfdbKkL1xE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XT9aA3oy0kAcor+zAtjl3zGV2WZFKXLb96B16d79vfmXnJS5WvVKj2O/xh91RMkzB
	 4Cn4n3s3aNtdvOa9XDh8oEolvfkQFNlL5jSjDrZ8FT8VYx7/vSV4Vcm3az/H79y+yl
	 ao2o3sagz9/mlsyDgTBaLxuDrqpNSK1dj0YY8HLg=
Date: Mon, 20 Oct 2025 17:13:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [GIT PULL] block-bio_iov_iter_export
Message-ID: <2025102019-aerobics-broker-b66c@gregkh>
References: <ov54jszhism7mbeu74vtyoysxnx3y3tsjbj5esszlrx3edq77s@j2vtyy45gsna>
 <aPHemg-xpVLkiEt9@infradead.org>
 <6strysb6whhovk4rlaujravntyt2umocsjfsaxtl4jnuvjjbsp@sqf6ncn3yrlm>
 <aPYCbIrvAkOf5L3g@infradead.org>
 <lyqal3mcvjwmzoxltydw2aoyhjllwcvv5ix2axpw24kh2iotkx@lygocjo66enh>
 <aPY3YKzGbIKxFbl-@infradead.org>
 <wrcaluw3pxx65tgznv5z3td3xb2tdf6rwucze5sy7bqrutj4jp@srde54eo3iyz>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrcaluw3pxx65tgznv5z3td3xb2tdf6rwucze5sy7bqrutj4jp@srde54eo3iyz>

On Mon, Oct 20, 2025 at 10:49:57AM -0400, Kent Overstreet wrote:
> There was no need for you to drop the EXPORT_SYMBOL.

We don't keep symbols exported when there is no in-kernel user of that
export, sorry.  Otherwise, that way lies madness.

thanks,

greg k-h
