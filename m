Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59E91ADFFB
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 04:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752727431; cv=none; b=YzyhCh73BVbjqxeT+ZHeWN21jYBrgkGiJqcMeNDfBdsmGtqq90fs4Ekd1vDqRKNReaxq/7UZxGHL50DZYo8/yZLmHrScfUx8YoON4IoY/C1wTtW0mOr3n3Uin8eVutB1MIPrFJRmm/G7rgzGQ38XcSFJ2zPFjNLSif1XB3VWv0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752727431; c=relaxed/simple;
	bh=dng3xfXcwSkfpXsZ7pZ54ry+QYJwjgyS4HsFMaEU6+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luDM3LOAOuu9KqvAuMxSzIXHKB1gVEFwvOKU4b8/fz/+zXx1qnvl3c3+r5jvq0XLNy61bwemMzpu2QkGlZbGxhIrcKrvxfRoxSA1is0wiysdLenaB9W2YQNvSiKmNRirwfe8XkYZvXr3ubTtHrgV4jIP8XzUrZdrC14WthTNnus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C1045227A87; Thu, 17 Jul 2025 06:43:42 +0200 (CEST)
Date: Thu, 17 Jul 2025 06:43:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 0/7] Fix bio splitting by the crypto fallback code
Message-ID: <20250717044342.GA26995@lst.de>
References: <20250715201057.1176740-1-bvanassche@acm.org> <20250715214456.GA765749@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715214456.GA765749@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 15, 2025 at 09:44:56PM +0000, Eric Biggers wrote:
> Overall, it's a bit frustrating seeing these patches go by that propose
> to silently leave data unencrypted when upper layers requested that it
> be encrypted.  IMO this is actually a point against handling encryption
> in the block layer...  The whole point of storage encryption (whether
> fscrypt, dm-crypt, dm-inlinecrypt, or something else) is that the data
> is actually encrypted.  But if the actual encryption is done using code
> whose developers / maintainers don't really consider encryption to be a
> priority, that's not a great place to be.

Getting back to this.  While the ton is a bit snarky, it brings up a good
point.  Relying on the block layer to ensure that data is always
encrypted seems like a bad idea, given that is really not what the block
layer is about, and definitively not high on the mind of anyone touching
the code.  So I would not want to rely on the block layer developers to
ensure that data is encrypted properly through APIs not one believes part
that mission.

So I think you'd indeed be much better off not handling the (non-inline)
incryption in the block layer.

Doing that in fact sounds pretty easy - instead of calling the
blk-crypto-fallback code from inside the block layer, call it from the
callers instead of submit_bio when inline encryption is not actually
supported, e.g.

	if (!blk_crypto_config_supported(bdev, &crypto_cfg))
		blk_crypto_fallback_submit_bio(bio);
	else
		submit_bio(bio);

combined with checks in the low-level block code that we never get a
crypto context into the low-level submission into ->submit_bio or
->queue_rq when not supported.

That approach not only is much easier to verify for correct encryption
operation, but also makes things like bio splitting and the required
memory allocation for it less fragile.
