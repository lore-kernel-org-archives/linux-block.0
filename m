Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193060;
	b=awiyw/CDEOFPHVRfmg5sCQac/PWLZsi0MVIBCWW8hCGkDsqOO3Flt5NFd/Tnor94RUHA
	 IJ8r1Hdu+gXqlQsq7/a3n3DOGxtt4WUl0/E/56HUq59/zkY/ChgfH6ZL0f/IRnre1OvEM
	 zvj6D0uZ4tz8NLeGCAF+1uF/xEMU14eEjSXFOiTpMWyDnCZ/O/Srs8YVPGKHPtpsqnOAb
	 2sVWKa69htcC0N0TzdY/58q3tJTvZAsYwnmBBAX+l6Ufy/BZHJM6W8DwDtl4oUyjOCYEc
	 6GDzXATD4luzeTkCgPb6gyZl9j3XwarZ65BfNmWCQNkDEyWmcyuRzezQrcVQ1L8OkXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193060;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=iFnY1r7VPZMvfsmIdgKeHitSyOhWnW2d8B1Ry5abjKs=;
	b=lrH5VKmcHkQ6wV1X9B2eVwINeyJmFUXbt8fQPn52nW5LsgBbp7DIMbYjzARUNoben64Q
	 nLTZcnxarSvVOVZAbRSthZsseGZgPO+R94NXPRwWrSzADa/bdH9mY194txtsuI906zVh8
	 FnIeTIAHjN9hNnCpCx9HdMS56hm0+kugn26k5zmM/I/kji3hCSYXZYXUvHZ2EosVayfky
	 a8l/pJEpTK8cfFbXl4zx4wXlqw1lVqNbRyJSwOKx3uyChQdorXrcTX0pOJMdDdgFe0RP6
	 qPQfYF2OCvude/J/ZlJAi9qK45tQ13DAQE4+4MEoeOrAkEPB9KvJZdBLbjXxuvL3VZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBCB606A33C;
	Fri, 20 Nov 2026 16:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DBCB606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBAFB6732A; Fri, 20 Nov 2026 17:44:16 +0100 (CET)
Date: Fri, 20 Nov 2026 17:44:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Md Haris Iqbal <haris.iqbal@linux.dev>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [v4 0/3] block: delay support for error injection
Message-ID: <20261120164416.GA32719@lst.de>
References: <20261111215838.103356-1-haris.iqbal@linux.dev> <179501806989.17649.3138860274842922761.b4-ty@b4>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179501806989.17649.3138860274842922761.b4-ty@b4>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 18, 2026 at 09:07:49AM -0700, Jens Axboe wrote:
> 
> On Wed, 11 Nov 2026 22:58:35 +0100, Md Haris Iqbal wrote:
> > Error injection can only fail a bio today.  This adds a delay_us option so
> > that a rule can hold a bio back first, to model a slow device.  The delay
> > happens above the driver, so it tests the code waiting above the block
> > layer, not the blk-mq timeout handler.
> > 
> > A delayed bio is marked with a new BIO_ERROR_INJECTED flag so the rules
> > are not applied to it again, even after a split.  Christoph asked on v2
> > to avoid the flag by allowing a delay only together with an error.  I kept
> > delay-only rules, as a slow device that succeeds is the more useful case,
> > so the flag question is still open.
> > 
> > [...]
> 
> Applied, thanks!
> 

Hmm.  This still has rela issues as pointed out by Sashiko.  I'd very
much expect a resend to address them.

