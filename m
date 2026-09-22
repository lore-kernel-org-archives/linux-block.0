Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A70A5625F3
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083287; cv=none; b=f302ODKuDN8+mGvRV3Hu3CJv84Z6vsMXl2I/GZxJM1lKdnGnfgxrLyB7ZyePZskUJHBmAodQzIfdcEfACxd7tBmknGF3/UCk3j/cHRUvIG2RfBIJSLVSAfQ81LcDlHTLQHnDCO/uQccPwGR7uh3wR6nKQFfZI3M/6yQrs5Qg6a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083287; c=relaxed/simple;
	bh=7YGczbjeje7x8r+pI6F5nYwxiK7ymFdHN2doiHpJs98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTFoZzl/md6vzaqRjf5U19V2gy7Jtb4do9Vt8qrW3GvQT8MBsUhB1AjV5DR1cwTBPXaP3vrbpFeDSpxlATSqMndKGsapejXHIEufUgMDrM6RvbyD4fxkl1ZXwa42K6y/aal/RPhAYaGes4VuDfg3D96+N3PBvoIWQlT0/8VkBxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B57B468BFE; Tue, 22 Sep 2026 15:21:22 +0200 (CEST)
Date: Tue, 22 Sep 2026 15:21:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: 0wnerD1ed <l7z@0b1t.tech>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH blktests] block/046: skip with the new XFS read-bounce
 implementation
Message-ID: <20260922132122.GA31163@lst.de>
References: <CAKTh27_iPvKWV8_bLMwwhEZAD+XPXimBdpz4D8iuue8mSh2A=g@mail.gmail.com> <CAKTh279TUXfzjd52aY7op+TL5VihhXJvy=JSp5mjXz=r272FcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKTh279TUXfzjd52aY7op+TL5VihhXJvy=JSp5mjXz=r272FcQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

The changes look good, thanks:

Reviewed-by: Christoph Hellwig <hch@lst.de>

