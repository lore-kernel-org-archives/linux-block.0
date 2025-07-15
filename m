Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7D02CCC5
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752558050; cv=none; b=d3kvMZez7MJj+/kZOes6wd56rODhypjYrOPzp5R7NIx9jaRtBsMg8mT/hvxzl5vOAZLu41kfm8k1Fr2vtjhv0vkJEGpiwJtqg6CzacHUCDHUKepPedTSdrsH9TDE+h9GjNiP/DX51HP/MeR+7FvsSMAAsq50M2Gyr/S/o5ezOC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752558050; c=relaxed/simple;
	bh=JdTRMLGJl/n1z3sHNdcZh4ibbUD267vBFMWNSbfyQIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kpf+zsCBxsnjDGeZysV92MDPN1uzo3vchdK8rVOqOHYWuFtLgSxBtoyURueVidL4M8OnNemo6/qf12niqk35AlFZLnyzsGC+QGCNicnYVQpZPTKvndYGIHbLZK7/7MJAaXVAXeeKfUg2fLO5/ni8CMPi0rLYQYANKFFzmkzzBnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BEB1E227AAC; Tue, 15 Jul 2025 07:40:44 +0200 (CEST)
Date: Tue, 15 Jul 2025 07:40:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: John Garry <john.g.garry@oracle.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 1/2] block: Split
 blk_crypto_fallback_split_bio_if_needed()
Message-ID: <20250715054044.GA18159@lst.de>
References: <20250711171853.68596-1-bvanassche@acm.org> <20250711171853.68596-2-bvanassche@acm.org> <a276765d-665d-49af-9776-d06e88c766cd@oracle.com> <52c19699-cead-41b7-a5c5-517f412bcbec@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52c19699-cead-41b7-a5c5-517f412bcbec@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 14, 2025 at 08:35:33AM -0700, Bart Van Assche wrote:
> On 7/14/25 6:48 AM, John Garry wrote:
>> since you are touching this code:
>>
>>      bio_for_each_segment(bv, bio, iter) {
>>          num_sectors += bv.bv_len >> SECTOR_SHIFT;
>>          if (++i == BIO_MAX_VECS)
>>              break;
>>      }
>>
>> if efficiency is a concern, then it seems better to keep the running total 
>> in bytes and then >> SECTOR_SHIFT
> Anyone who cares about efficiency should support encryption in hardware
> instead of using the software fallback code. As far as I know, on
> Android phones, the crypto fallback code is only used during hardware
> bringup and not on any devices that are shipped to consumers.

I don't think that's a good argument to not clean something so
obvious up.  It doesn't belong into this patch, but if you touch
the area anyway it would be really helpful if you added another patch
for this trivial cleanup and obvious optimization.

