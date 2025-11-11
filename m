Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB3E33ADBF
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868409; cv=none; b=WVuYqz0abDHKKBjvZ6W12GfqahBidzTn5kg8fFaKLu3zsaXj31FVyFaepDin9+oMkCjHoqGwCs3QGWONBVNTr9ichc4rqTahqEH2rM8UNJKbFaD7LyG6vLqjTqdIopRRj7W1daBgLLl9bZLgCoIuGUwL3QZ0suLOb+svZkBA/ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868409; c=relaxed/simple;
	bh=3dH/Ivxzrn2sFpyLsAuHV1lUKuW6z7TWtOf0gHe+qiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFuM+GaXqeyvQBitLz9xmZdvpo+J2HooIEVZrJQF0P5kv0rWLv4woxWXc0C+8yQXHtsRH9+2SnXuntiavhZmsmY47pgpVgqrT3tqe1wFmKfWWXHh0jaNX7zgUH8rcAkNU4EBHOIFKd0XRSlUGyMEv5c89VIWDaWobQqnuja6m+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65B86227AAA; Tue, 11 Nov 2025 14:40:01 +0100 (CET)
Date: Tue, 11 Nov 2025 14:40:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Yu Kuai <yukuai@fnnas.com>, Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-ID: <20251111134001.GA708@lst.de>
References: <20251014150456.2219261-1-kbusch@meta.com> <20251014150456.2219261-2-kbusch@meta.com> <aRK67ahJn15u5OGC@casper.infradead.org> <aRLAqyRBY6k4pT2M@kbusch-mbp> <20251111071439.GA4240@lst.de> <024631dc-3c65-49a8-a97a-f9110fd00e9a@fnnas.com> <20251111093903.GB14438@lst.de> <c82cd0f1-f56e-445b-8d78-f55a0c3b2b4c@fnnas.com> <aRM5UoApKZ9_V7PV@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRM5UoApKZ9_V7PV@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 11, 2025 at 08:25:38AM -0500, Keith Busch wrote:
> Ah, so we're merging a discard for a device that doesn't support
> vectored discard. I think we still want to be able to front/back merge
> such requests, though.

Yes, but purely based on bi_sector/bi_size, not based on the payload.
