Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F462CA6
	for <linux-block@vger.kernel.org>; Fri,  9 May 2025 04:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746764396; cv=none; b=EtGldPtPNjPQZAUR32qYSlkA1ZhRfDymua7KTZqU3uqhN68NuPgJJhbl83pugodP+IGjh8PJnnHBbSfQu4IvDd/x4nL2cSMNLS127HBOaL1tx0ouURiPPS3dd/TQBf17sAuNh5L6qe+M5itHmrs3FONIV0fBX3Ymd24jzrd4K3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746764396; c=relaxed/simple;
	bh=3etkQ3um5r9nanq8M5TMR2y0h5UbhiWAy3ZFIiHDDqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWrWI4W6R6yB0Uv1/EE7TcIXsgElY1OYjZz1qi3jgfPASpdGVg8aUsjIHh+NWS9rTOoiIXRjzQiHGkplhRXl/m3zT4mlSMiiFOX6U3ZC/0baeZ91R++H7YtsMAlEtq4EN9PXTqgA0vlwjE6cmBXGcnUcRSCzJaHpTfrXg1kCrKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 816F467373; Fri,  9 May 2025 06:19:49 +0200 (CEST)
Date: Fri, 9 May 2025 06:19:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	martin.petersen@oracle.com, hch@lst.de,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] block: always allocate integrity buffer when required
Message-ID: <20250509041949.GA28563@lst.de>
References: <20250508175814.1176459-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508175814.1176459-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 08, 2025 at 10:58:14AM -0700, Keith Busch wrote:
> Add a new blk_integrity flag to indicate if the disk format requires an
> integrity buffer. When this flag is set, provide an unchecked buffer if
> the sysfs attributes disabled verify or generation. This fixes the
> following nvme warning:

Do we even need the flag?  I think we could just deduce it from
tag_size < tuple_size, which feels more robust.

Otherwise this looks good to me.

