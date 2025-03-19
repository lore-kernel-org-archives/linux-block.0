Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890F221507C;
	Wed, 19 Mar 2025 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412273; cv=none; b=HRxB1bO9LuYqEy7exKixUErZaXMW9NHbuu4TLzWdajN+DulsuxLRip15JMIFnI+vnhCEqCSl5jeqbDXKwT/wiiDagrovH5VlcAX8foQ0fxrhju2RN8sEHlEhqtvazG3W9B3RJ1IVghHQaA4dCHfwfzbyGJWAV5ciIw55JKLE89Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412273; c=relaxed/simple;
	bh=DrDTgA+tztj5ovrn1XiPKXpb6kAe2O6mVMv5MVwJIrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqwwMup7aRL0Y54bpP/wwP20Y3pL8Q5jL97Jfws8+WVm7m5FW0cLFZc14GqIVkBA+qwjkr/152U7bPMG21WW5Z9M74IX9Y3jgba84ycHIQhhhM1CVnWyQAbXllyIzJty2RGNfc82BX2sH2N+iugyJaUNPolVNfZyvBPjg644Ens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=febyWxe8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="febyWxe8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EpQOjPVa2Beq04kJvvraeY6xvIQbVVFWRl2dfYg/9BQ=; b=febyWxe8indQHW+/DXNc8XwTh7
	pCXPazgrVQb1NC7evVDOPeSQltfuqysNWTFC5oJj3WPOzEA2aD6iRliRra4uBuFJ13mq7UTwbfs/V
	z1n1JUECWHCnmeAomv/S7mWQSA6v0rTDYeF62tAa69tKTTbrMJVuphq3P82FjqMbUN/5W76Abd2cl
	dQpsiF2P9sTan1YH5XPb0LA41V4TPkJ9iNxITxRbCovvgb9tJLA4x84vbYEPWobTccY1GzwbBVd3R
	CjZnVFu71PRuIuEfbzM8Ubd7coSD1oeTCHb8fqZBuDXWVeLlruLDcwvqw6RonAk2AcdNTu4qbyLeL
	pMlxg84A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tuz1c-0000000E0QD-02eg;
	Wed, 19 Mar 2025 19:24:24 +0000
Date: Wed, 19 Mar 2025 19:24:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Oliver Sang <oliver.sang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, John Garry <john.g.garry@oracle.com>,
	linux-block@vger.kernel.org, ltp@lists.linux.it,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	David Bueso <dave@stgolabs.net>
Subject: Re: [linux-next:master] [block/bdev]  3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
Message-ID: <Z9sZ5_lJzTwGShQT@casper.infradead.org>
References: <202503101536.27099c77-lkp@intel.com>
 <20250311-testphasen-behelfen-09b950bbecbf@brauner>
 <Z9kEdPLNT8SOyOQT@xsang-OptiPlex-9020>
 <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
 <Z9mFKa3p5P9TBSTQ@casper.infradead.org>
 <Z9n_Iu6W40ZNnKwT@bombadil.infradead.org>
 <Z9oy3i3n_HKFu1M1@casper.infradead.org>
 <Z9r27eUk993BNWTX@bombadil.infradead.org>
 <Z9sYGccL4TocoITf@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9sYGccL4TocoITf@bombadil.infradead.org>

On Wed, Mar 19, 2025 at 12:16:41PM -0700, Luis Chamberlain wrote:
> On Wed, Mar 19, 2025 at 09:55:11AM -0700, Luis Chamberlain wrote:
> > FWIW, I'm not seeing this crash or any kernel splat within the
> > same time (I'll let this run the full 2.5 hours now to verify) on
> > vanilla 6.14.0-rc3 + the 64k-sector-size patches, which would explain why I
> > hadn't seen this in my earlier testing over 10 ext4 profiles on fstests. This
> > particular crash seems likely to be an artifact on the development cycle on
> > next-20250317.
> 
> I confirm that with a vanilla 6.14.0-rc3 + the 64k-sector-size patches a 2.5
> hour run generic/750 doesn't crash at all. So indeed something on the
> development cycle leads to this particular crash.

We can't debug two problems at once.

FOr the first problem, I've demonstrated what the cause is, and that's
definitely introduced by your patch, so we need to figure out a
solution.

For the second problem, we don't know what it is.  Do you want to bisect
it to figure out which commit introduced it?
