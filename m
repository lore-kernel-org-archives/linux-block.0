Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76AABE71
	for <linux-block@vger.kernel.org>; Sat,  6 Jul 2024 06:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720246953; cv=none; b=LKWVGXpsYOc/bbNDsfjDrG7ml6d7lsR3S6Xis/3YzifOSBQhRZXMIkGoWMi69LGQSuwHalLs7CzM+3sGzbUGBiyRFrTjB3L911fSDjSaZVEWqC3BQTfiaAwEBw444MlpmfdBGM4O8qigGLWFjM+hWhh67khgWR9zN4Y9dZ7iEgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720246953; c=relaxed/simple;
	bh=/5cKy6VPHKqN8FFeLyY2y7KCyyGXQc/yaPQ/y47WThU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L31CvUgFb0rxXZ60AukUi4jmi7RKNzVCgPZHEDOFjNaXghL/KU7dLFgSFjxQrOiHYOi6rNatXsniOoOMWlxcjZU5nc8RwLGvLJKB7hElGoqXHMpxrkS5fm3VDycrHWi15lYjNhly3WD2WXpvQBWdM2Nj3W4/EqE37ZynMF7/3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4F27E68D0E; Sat,  6 Jul 2024 08:22:28 +0200 (CEST)
Date: Sat, 6 Jul 2024 08:22:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: pass a phys_addr_t to get_max_segment_size
Message-ID: <20240706062228.GA13842@lst.de>
References: <20240705123232.2165187-1-hch@lst.de> <20240705123232.2165187-3-hch@lst.de> <c2333a14-04bc-49be-8cc6-a03dcdb2eec3@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2333a14-04bc-49be-8cc6-a03dcdb2eec3@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Jul 06, 2024 at 12:21:06AM -0600, Jens Axboe wrote:
> >  /**
> > - * get_max_segment_size() - maximum number of bytes to add as a single segment
> > + * get_max_segment_size() - maximum number of bytes to add to a single segment
> 
> v1 had this change too, not sure why? The previous description seems
> better than the changed one.

Because it is used to also append data from another bio_vec to a
pre-existing SG segment, not just to create new ones.

