Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5D3442F
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 04:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734410463; cv=none; b=C67dxI0BKC95Uogn5hrGmnlPiCdIghQ3wxT8Lw/Zv/YL0UrXTIic3mVyjsyR4jltjCIlPzlSDZXEw7UG6KpibejH4M9nSRBfbzyLm+cTdZPEE2+vHbmaG2Hw5TGISfULiD8GjE1PNXJ+rZuoZKHBjlHE0gncK6dv1Z/CU91rLEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734410463; c=relaxed/simple;
	bh=3zGFEyGaSW4Mtgs+ybmUB8yz7ZejN39fXyY9s4q4h+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNM6jt+W+6Jq7rl/vufcKDXe1x1Mrrh05JtDw46eWHhafZfy+KLGw+yMo6ytExMHYky5HaEifoqvF31AimBSc1AqYrzXEHfYROUPJhOBxF6D6RXi0A4+vyOK8p3wItC+/RDBB8hjaVPGEc8eN8NPZ91VFm8vSfHSgixCmuUafaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7AFA868BEB; Tue, 17 Dec 2024 05:40:56 +0100 (CET)
Date: Tue, 17 Dec 2024 05:40:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs
 for atomic update queue limits
Message-ID: <20241217044056.GA15764@lst.de>
References: <20241216080206.2850773-1-ming.lei@redhat.com> <20241216080206.2850773-2-ming.lei@redhat.com> <20241216154901.GA23786@lst.de> <Z2DZc1cVzonHfMIe@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2DZc1cVzonHfMIe@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 17, 2024 at 09:52:51AM +0800, Ming Lei wrote:
> The local copy can be updated in any way with any data, so does another
> concurrent update on q->limits really matter?

Yes, because that means one of the updates get lost even if it is
for entirely separate fields.

