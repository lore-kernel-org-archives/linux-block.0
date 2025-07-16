Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882C62F3C1B
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752665141; cv=none; b=I6hhtOk4vD5n6TQY/K+e1s3DcohD4lNJUJP2NNG4/10yqBXcZyMdsoS+QZE7Mcc1H3mqIE4a66p+44hB+4eRBaYXimdFbdKBpi0/6xcedtvMEtRrLWY6Jy0rNmAWCTme5xfPDI1ue6SLA3vaGXyhOR6+A6jog5IGoyDbJ4BcNVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752665141; c=relaxed/simple;
	bh=nKAvhJkyT1xbXMAvHJsi0HzB+7tC4lf3NQHcG849g40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEcVSMOTQpP6ghUP68NsGENn6AmK/0zhPxgTlVLItBa5e3QHzjKMBerGa00zVCZSdd0/oMZaF8BtZ18wV5ae8IyDGrAgENrG/Lj/lKEP5PYt2EZk7kGleu75Vrn63SnolRYGVNpQzw0KSWpDALNpNYBjYJeAa2VA7gctOsE4hqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E0AAF68B05; Wed, 16 Jul 2025 13:25:33 +0200 (CEST)
Date: Wed, 16 Jul 2025 13:25:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 0/7] Fix bio splitting by the crypto fallback code
Message-ID: <20250716112533.GA30703@lst.de>
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
> However, it needs to be done safely.  That means at least making
> blk_crypto_config_supported() continue to return false when called on a
> block_device that doesn't support any form of blk-crypto (either native
> or fallback), and likewise making blk_crypto_start_using_key() continue
> to return an error.  Ideally, the actual I/O would also continue to fail
> if it's attempted anyway.

Yes, both are absolutely required.

