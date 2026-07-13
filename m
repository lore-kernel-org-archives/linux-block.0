Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D842DA2E
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957145; cv=none; b=O+NrKWNKg8MCR01/L495hcr673s4vfCp6Kw40DO/LNIzK6tth8H5hkv3xe3wB/QIu6YooN97S3QFZP/VGHxURHVavkS5Ed5r6G1+ekS1NcczjLel2CqYTH3MCccsHsw/Yh2jW4AzkyOHtvRZ1+W3zmc/Omwiw2Er5LtrKRWcq7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957145; c=relaxed/simple;
	bh=Gq9aBkKPI3oyxYjv91kjM4Ab9DgW8r3xLJ7V1ajwynQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNvYS8YUCsH2DFRmPGda6WUJ3p0OXt8cl+NWehiWS/ZPuMKv1AvVQ0SEcpLV2rOyhMoeY//UtTXK9RPHCZIdZ04XGkE8a65m328a/4YyqiviShSnrCFI9vX+qnhxCAamMrblIyCHeNkCrRwuh8ZI0KlLCMUV4wr+PkuBk0E9/qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ey6MMLB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ey6MMLB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8855F1F00A3A;
	Mon, 13 Jul 2026 15:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783957143;
	bh=hsuQK71Bz7bdxxQXRaenqb0VyJlK5ZAk6wIM4Kb6sd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ey6MMLB2R+pUCIocnFle+mrv+uZKG0frzJY5DhoVLTrSxvu7eJiUA0wULGE7/HIvF
	 Q69oedj4zRQCZERuqhFArx6mze5kadTGROqmvkOZ/iARKjh7Rnt1lOeGKF9WZIhqiy
	 F25QvCDZLDkK8osmdV/ACwkO+FKthGYOS4G5ld+hJR53ThzJq/ij/BUuA1J660RHHt
	 hQ+I0iLSA7JvBcWwb7czj1PobTqAHk/j+S6eLLcRncE/2u5ylm6XxLsBWtT7XC+O1z
	 SW2DWTSM1jVs1IECjSLoGnGMzdeZPdJ+UIitsjv8huuf/Vf/7ImSs6yPDJM/JvM9Sa
	 PuHGMLPeoVe1Q==
Date: Mon, 13 Jul 2026 09:39:01 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, z1281552865@gmail.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix aligning of bounced dio read bios
Message-ID: <alUGlVDWkZNyUE4N@kbusch-mbp>
References: <20260713152912.2333321-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713152912.2333321-1-hch@lst.de>

On Mon, Jul 13, 2026 at 05:29:11PM +0200, Christoph Hellwig wrote:
> bio_iov_iter_align_down expects the "normal" biovec layout from vector 0,
> while bio_iov_iter_bounce_read abuses vector 0 for a bounce buffer
> allocation.  Pass an explicit bvec to bio_iov_iter_align_down to deal
> with this case to avoid a double unpin.

Can you instead just have bio_iov_iter_bounce_read() align down the size
it extracts rather than letting it over-extract and reverting the excess?
