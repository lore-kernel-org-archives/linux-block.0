Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A6F18C01D
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736315350; cv=none; b=PRAedzRBYlfNaoZ1XRRPSGSxprmJg+Gwl18ajjwQypeL11FBgCHPH8x2S48vy2tE0y55IY5iwVzxfusc5AyzmhALXfLKQoiTFSgCCnZF003N9txwsTXR/Q4kfyQfEtbxOJwodjmiYcFv01j5MCc2eex4LmvHDwjo6bUPq9dOMGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736315350; c=relaxed/simple;
	bh=ZfN8+rZRplmmHhXmfQCQGokkfu/gja7TVUFqhDWyefM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HALXiwia38iMT7tdyRMxqvJhDB9syyJhC7NDmNkejhLSqY1nOxKHPlpWt9gNkX2Be/0t41CekpCIzB3SBV6OKZ0bH9yTIuHtTsauwx+beikgeYCWPw8jAKh8+IZQ9xcF2RlBRZHZ9ffltVu8GRTkBkPPW/1PYD9eZUSlpGpSINo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0C74B68BEB; Wed,  8 Jan 2025 06:49:02 +0100 (CET)
Date: Wed, 8 Jan 2025 06:49:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] New zoned loop block device driver
Message-ID: <20250108054901.GC20178@lst.de>
References: <20250106142439.216598-1-dlemoal@kernel.org> <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk> <20250106152118.GB27324@lst.de> <98be988f-5f6a-489d-b0e1-2f783c5b8a32@kernel.dk> <20250106153252.GA27739@lst.de> <0f2eea00-e5e9-4cd1-8fe6-89ed0c2b262b@kernel.dk> <20250106154433.GA28074@lst.de> <5f57ff26-2c87-45fa-bb91-4f68492bac85@kernel.dk> <20250106180527.GA31190@lst.de> <4358e12a-066c-4d5b-b686-945843443353@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4358e12a-066c-4d5b-b686-945843443353@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 07, 2025 at 02:10:45PM -0700, Jens Axboe wrote:
> >  - the double context switch into the kernel and back for a ublk device
> >    backed by a file system will actually show up for some xfstests that
> >    do a lot of synchronous ops
> 
> Like I replied to Damien, that's mostly a bogus argument. If you're
> doing sync stuff, you can do that with a single system call. If you're
> building up depth, then it doesn't matter.

How do I do a single system call for retrive the requet from the
kernel and execture it on the file system after examining it?

