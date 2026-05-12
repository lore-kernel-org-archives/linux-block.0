Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADF72494FE;
	Tue, 12 May 2026 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566656; cv=none; b=E74TcVfq9BKRoTt6YDdK+3M7ge937R8IpVz0AJMXfAm5DN2AA/DhrP+XKy0idjG81CKx6mP6mC5V4dcDMhnywoX2X212fx6PHtPmqOFA3pyTxaaf+BZtppuIaxBpeVUGOBLjoIQQ9pQ9xllkZbaaGeyrwBhbw9JwAZyKSl4sK4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566656; c=relaxed/simple;
	bh=PinGn5MFZTBf43kA8TofRJClYnUgfSMDzQZb9wGwZqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLxjOmaj6VK7MrcFIhI9G9CQu6mNyn8pqTOR1UuXh0xy9agHODOpw0cDy/vKJQuAWiUTUX5ckM6j+zg0xjcm5jXdgCCDKawWL2iyXFGIApfY3mz2vy4IyDlkP9f+oyCYo559309y3xfVTwNTy0mtSnf2CRbpOJufOBWz66QgIqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2644868C4E; Tue, 12 May 2026 08:17:07 +0200 (CEST)
Date: Tue, 12 May 2026 08:17:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Carlier <devnexen@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: don't overwrite bip_vcnt in
 bio_integrity_copy_user()
Message-ID: <20260512061706.GA30204@lst.de>
References: <20260511215151.346228-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511215151.346228-1-devnexen@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 11, 2026 at 10:51:51PM +0100, David Carlier wrote:
> bio_integrity_add_page() already sets bip_vcnt to 1 for the bounce
> segment. Overwriting it with nr_vecs breaks bip_vcnt <= bip_max_vcnt
> on WRITE (bip_max_vcnt is 1), so the gap-merge checks in block/blk.h
> read past the bip_vec[] flex array. On READ the read is in bounds
> but lands on a saved user bvec instead of the bounce.
> 
> The line was added for split propagation, but bio_integrity_clone()
> doesn't copy bip_vcnt and BIP_CLONE_FLAGS excludes BIP_COPY_USER.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

