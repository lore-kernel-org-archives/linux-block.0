Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A6D3BB40;
	Thu, 13 Nov 2025 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045296; cv=none; b=W6jA+K36sAf/fKe9s3I8w/O/s0rR0Gk0r5zayhaAjInolLDyW1wgnbEUCN0oe14WlOVp0FII3JQ3uJlHED8+r6d4NiPxLn6XctSZ/EBaIq9TWOKoJsy9IoFX8u7A/TU3Gsx4eMmqwEHr3vcknTIEkKbT8tgLRtQpYGyuDPblc80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045296; c=relaxed/simple;
	bh=OxfoW1Dh9676++qCMgasaVAlOz6ZwrObL8Ff57CqOr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UG7Lr8C4WYibWWrzclR5BosnaYeXhiUg4neIYzEs/sGxnEONECKZ8+igGBjfxq7VpxClQoCyCwnIBzW3GLFX0Nsqy3MFgZZ6phpL4Cd38fF4vSihifzjnKx8xP6AN8zvc/LF2FDH0/5tRa+aMkVBdbRw7TzmocqILRmMk7gRSWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8A319227A88; Thu, 13 Nov 2025 15:48:07 +0100 (CET)
Date: Thu, 13 Nov 2025 15:48:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Oliver Sang <oliver.sang@intel.com>, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
	oe-lkp@lists.linux.dev, lkp@intel.com, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: poison_element vs highmem, was Re: [linux-next:master] [block]
 ec7f31b2a2: BUG:unable_to_handle_page_fault_for_address
Message-ID: <20251113144807.GA31071@lst.de>
References: <202511111411.9ebfa1ba-lkp@intel.com> <20251111074828.GA6596@lst.de> <a90b1707-b97a-454c-bced-a25068b28325@suse.cz> <aRWMT6DTNhAdudn+@xsang-OptiPlex-9020> <e88f9909-cb5e-4205-b4cb-461fdd71120a@suse.cz>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e88f9909-cb5e-4205-b4cb-461fdd71120a@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 13, 2025 at 02:48:06PM +0100, Vlastimil Babka wrote:
> I'll make this a full patch then. How urgent is it, Christoph? I suppose
> this is related to the bulk mempool changes, and we discussed the users will
> target 6.20 (7.0?) merge window? So landing this fix in 6.19 is enough?

The trigger is a change in the block tree that is in linux-next.  So 6.19
should be fine, although getting it into linux-next ASAP would be great.

