Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040D015CB;
	Wed, 10 Jul 2024 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720590730; cv=none; b=SWrWOgK4R5F85dw3PCgjsghHkKFq8UBhn1IdfpjqKBmXW5gokagkEacDLbUy7hYL4DEmAX8HruRj3xVepGB4aGlFUn4TAr+DAVTo4bVDD3bUC63Yc0IEcXCURhNByMgse8QnUy5/gAyQXy/7jmVxvBrWDkhwk97nk/wC8DtIk2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720590730; c=relaxed/simple;
	bh=CwzolPh5wXutE+8LiEJsz2B7+6zSTi1yf7RqHufm/WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRBXFHNrVlNpSINTwBCb7nT/rmZmFCNgHHXZohetnpTiUCxwDlPGUYpK+ZQva++J7UOpVAFP+SYvNBuYqb7iFAtYLJYNgUF2j4pLKIUBndxGh6FV2wSsHVPAicF/0uU6FZqkPj/MILRCca5gcBI1Zn1U+/UZqPCLtHRUAbhaCt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C088227A87; Wed, 10 Jul 2024 07:52:04 +0200 (CEST)
Date: Wed, 10 Jul 2024 07:52:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: pass a phys_addr_t to get_max_segment_size
Message-ID: <20240710055203.GA25248@lst.de>
References: <20240706075228.2350978-1-hch@lst.de> <20240706075228.2350978-3-hch@lst.de> <CAMuHMdV95g78=2GmLP95Kn3_0DL5zVuv2KCDYVsk8D2gNnu7SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV95g78=2GmLP95Kn3_0DL5zVuv2KCDYVsk8D2gNnu7SQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Geert,

the fix is queued up here:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-6.11/block&id=61353a63a22890f2c642232ae1ab4a2e02e6a27c

and should be in linux-next.  And next time I need to do a full
retest after doing your suggested patch order change :)

