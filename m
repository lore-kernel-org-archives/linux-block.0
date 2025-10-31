Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714E71F75A6
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903397; cv=none; b=A9+m+E+oy2YovIggJCqhSfV6P9XMU/DAvE0GAVtkmH/ykxXLxIof43UEOUaVGZvI3SRXGz6CD07hBrinUDEb2HVix/abUJr0WuPehipDGa1FTEk/OEKeQlMl6hbojFJnrb8y2fg0xb8o8656htphgXSP1Mc+m7p1gc7RAHn5Hbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903397; c=relaxed/simple;
	bh=PQgIlECVSRfTU3b67YwWxRQtT3s7QeB4p4Iu88ZXffc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3nr9grODbgmCXxv4imw4M4VRJTFY0rBWx82y83A8W26gpd5lvOIWEwq+uolPegr4N0TEBxLyU+HW8xH4eN2ETAlrUQBw6wVd5ayH2CEg0hdOu1mwGb/FW6qhyb0gf2WBwR++8iwRDGz2VBVQInfXf1t9Gc3rpXJzSd2N72jFJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 25826227A88; Fri, 31 Oct 2025 10:36:31 +0100 (CET)
Date: Fri, 31 Oct 2025 10:36:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hans Holmberg <hans.holmberg@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v3] null_blk: set dma alignment to logical block size
Message-ID: <20251031093630.GA9957@lst.de>
References: <20251031093546.134229-1-hans.holmberg@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031093546.134229-1-hans.holmberg@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 31, 2025 at 10:35:46AM +0100, Hans Holmberg wrote:
> This driver assumes that bio vectors are memory aligned to the logical
> block size, so set the queue limit to reflect that.
> 
> Unless we set up the limit based on the logical block size, we will go
> out of page bounds in copy_to_nullb / copy_from_nullb.
> 
> Apparently this wasn't noticed so far because none of the tests generate
> such buffers, but since commit 851c4c96db00 ("xfs: implement
> XFS_IOC_DIOINFO in terms of vfs_getattr") xfstests generates unaligned
> I/O, which now lead to memory corruption when using null_blk devices
> with 4k block size.
> 
> Fixes: bf8d08532bc1 ("iomap: add support for dma aligned direct-io")
> Fixes: b1a000d3b8ec ("block: relax direct io memory alignment")
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>

Still no reviewed-by tag seen.  But just for the record:

Reviewed-by: Christoph Hellwig <hch@lst.de>

