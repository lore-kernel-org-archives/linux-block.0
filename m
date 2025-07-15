Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B0929B8E4
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752615899; cv=none; b=tgxEXqKXD29v6qjGvsSbrxafJCybgFdcpdKQMv+R02SgKlrQAO/MMiMqypk4GchkETHeuNF+hsIAfDDd3KvwbiZDnbvcoVjqB9Q4S+p14Uz+6SGOVPAuYfhgsAM1xUq2KIefJCL0sQUMEvh8/WBMmJ29n1N2UKtrLt3hbSUoynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752615899; c=relaxed/simple;
	bh=FRWUUCWhPKFToIQd0nFXhqkclscsYjy2l6b6I1gwF04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEFzuM0W3WDtDkAFkO1hrZrkOhI1wGgEwSzGPoGJLOCy5BMzWdR8JVBFT4HU0bJ5QY1sCas1Uc+mxi82culDuv4J7DvtRnaSqFWVyOIuMhdAMOAN4UNkcyuf7jXLdbPc0ZejG7ZvJY3L29sPxcAfuQaNBm8LbldpU1c/bTMtFpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABvpJIMv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABvpJIMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A073C4CEE3;
	Tue, 15 Jul 2025 21:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752615898;
	bh=FRWUUCWhPKFToIQd0nFXhqkclscsYjy2l6b6I1gwF04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABvpJIMvwrxK2URfBWIsxZfzulaHxrXY+bHjrS8YFtYKjXolU0RyAkPNLiTrJjVRr
	 HQ44MpEIeWZl7/Eiwx0BTV0Gf7iGWRcC75j2MYvPHzbyZ2Zw0wBeeyIwrDGLddm9pj
	 ya8waF0zM9ZWtIj6Ck2nB9FLKAy+E3nkmKVKDhMjGYgKMON+eiokMRLP5s7lF4Evhh
	 1YlRTE0eamT2wMv4qzqCwi6P+rT+ezLkBQTjqWo2V25SgpPnmeRGXDRg4f/0gmp6vQ
	 GbwsvR1froJy38mAecv7SylFa1fI29UBkeXcXJB3bVSoQh8/6edJL4cSN0lb940ZjM
	 maJ2A49aD1rQg==
Date: Tue, 15 Jul 2025 21:44:56 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 0/7] Fix bio splitting by the crypto fallback code
Message-ID: <20250715214456.GA765749@google.com>
References: <20250715201057.1176740-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715201057.1176740-1-bvanassche@acm.org>

On Tue, Jul 15, 2025 at 01:10:48PM -0700, Bart Van Assche wrote:
> Changes compared to v2:
>  - Added a patch that optimizes blk_crypto_max_io_size().
>  - Added three patches that change calling conventions in the crypto fallback
>    code.
>  - Added a patch to remove crypto_bio_split.
>  - Moved the blk_crypto_max_io_size() call into get_max_io_size().

But this doesn't address the issue we're discussing where this patchset
makes data be silently left unencrypted on some block devices.

If it's really only a "few random drivers that almost no one cares
about", then it's possible we can drop the blk-crypto-fallback support
for them anyway, as Christoph is suggesting.

However, it needs to be done safely.  That means at least making
blk_crypto_config_supported() continue to return false when called on a
block_device that doesn't support any form of blk-crypto (either native
or fallback), and likewise making blk_crypto_start_using_key() continue
to return an error.  Ideally, the actual I/O would also continue to fail
if it's attempted anyway.

Overall, it's a bit frustrating seeing these patches go by that propose
to silently leave data unencrypted when upper layers requested that it
be encrypted.  IMO this is actually a point against handling encryption
in the block layer...  The whole point of storage encryption (whether
fscrypt, dm-crypt, dm-inlinecrypt, or something else) is that the data
is actually encrypted.  But if the actual encryption is done using code
whose developers / maintainers don't really consider encryption to be a
priority, that's not a great place to be.

- Eric
