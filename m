Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773BB218585;
	Thu, 20 Mar 2025 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473121; cv=none; b=UrzeLRUgKCR1PvlXwjTADYFStBVVyFW/9xu6SebxVD7mTqgbhqaLNWoyhO5hxEG4/YpdCQwfSvPaEcBEQ3d299Jr7nLDgUWYt/9bXrGZjU/xKZxT6qeveAcNf7TqY1SamIj11TiK5wsaU2su7m2gRkVSPGB3wpEuUqsxD18mpoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473121; c=relaxed/simple;
	bh=K2/BZGoFSC6TQw/cxXRdYTP8MwP9Rvb39XqZtWmojH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jrsb2M0bSzNFpTuD3YxyImHrIXpg1xs1Ab6zhacZIvcQjkdZHdpjrbEOxG1AtfeOjYvWHgAwVYRVVRZKGOGRq+J3ywyPSjyaeIeVgYp0bMY57KJZArnQywrxRVui5hwxXBr1oe6RfumV4O1nfXqXBuk/7J+k3mPlXM4Oqggo7uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF9CPQba; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF9CPQba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BC0C4CEDD;
	Thu, 20 Mar 2025 12:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742473120;
	bh=K2/BZGoFSC6TQw/cxXRdYTP8MwP9Rvb39XqZtWmojH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KF9CPQbajSzxspd6Xf8MQjoIk/2zRdL0CkWtpTdjhjG9V/wXbGEQQhelwh5bgKFXG
	 uv09BvTPRO5L5cts+sXTbrNpMSt+4Qx/u5eN3id3xX9P8CkN8GpOK+SYh3NvxPbxHJ
	 B14QyMiQ6ls8/0PvZvXiOaEHDzDbUp6llc9qGbuybchomC5MEJel2ly0WtNmy/uVpn
	 n/1yl6iUY4rH3FLZOYJFTVlY0ZU51Ozov7TNI7+fOEU6sC1OobSH3nQD3u2mS+wuXh
	 UkGG6eQqeIwWQwOY38Twpuo8VXR5mvuch7EmOBqzsjAYvMKgGKFyg0TBH/VfyWEp1r
	 kGaZpJg7Izy7g==
Date: Thu, 20 Mar 2025 05:18:39 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>
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
Message-ID: <Z9wHnw4qE_6rjpxh@bombadil.infradead.org>
References: <20250311-testphasen-behelfen-09b950bbecbf@brauner>
 <Z9kEdPLNT8SOyOQT@xsang-OptiPlex-9020>
 <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
 <Z9mFKa3p5P9TBSTQ@casper.infradead.org>
 <Z9n_Iu6W40ZNnKwT@bombadil.infradead.org>
 <Z9oy3i3n_HKFu1M1@casper.infradead.org>
 <Z9r27eUk993BNWTX@bombadil.infradead.org>
 <Z9sYGccL4TocoITf@bombadil.infradead.org>
 <Z9sZ5_lJzTwGShQT@casper.infradead.org>
 <Z9wF57eEBR-42K9a@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9wF57eEBR-42K9a@bombadil.infradead.org>

On Thu, Mar 20, 2025 at 05:11:21AM -0700, Luis Chamberlain wrote:
> Sure, the culprit is the patch titled:
> 
> mm: page_alloc: trace type pollution from compaction capturing

Sorry.. that's incorrect, the right title is:

mm: compaction: push watermark into compaction_suitable() callers

  Luis
