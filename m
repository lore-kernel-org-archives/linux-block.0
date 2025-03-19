Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14FA20E704;
	Wed, 19 Mar 2025 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411803; cv=none; b=QkTTQIRENjuYvk7mgYXDMQMOThMz++ilIlOqEhprH/gpaDI68PnzbnQMHtX0y8TJoKaW1lMRAbGl6+SPl57aYTpQFH7kVC/noew0dqETXwOxQHfQN7r3j8K5Jn+nqBnm+DwusslA1X6gm0CUqB+OYwN62SkrFxWjoljbE2in7FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411803; c=relaxed/simple;
	bh=qjx1B59hoS6fWrjlxV8KqXGYvk4wKJyBCj4Y5hG4/gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/+ViLjgudEYh0LEd3wwoBOWYsj43DB6RQX8GnuKrdH3IrL5wWPbughxIhPxzBu0AKoTWhkGVVnoMsQiQZzRQhyM9tyIOw9oHsGCTcbUvMFLNUIVlciqRgZfP8CPMlzVRLm9EGZvk3JMPnESlxkLEw31uVFmk+jBhxISUFlO1DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf0MV1S+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf0MV1S+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC98BC4CEE4;
	Wed, 19 Mar 2025 19:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742411803;
	bh=qjx1B59hoS6fWrjlxV8KqXGYvk4wKJyBCj4Y5hG4/gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nf0MV1S+x03uJtoprF9Fu0OaQNr/sJO0Rg5YAsotBru3nXsJF4F3E97Lp2oJbgjb9
	 jla4voX6Eq03V7rGcCpnvD9/0HTbaYePcLmYqF/iqF8mHXtVdfmQrzpMFyh7xsE+IJ
	 HiECSRS8lBou0qWgPpfAc7lY9b430yWTzqA1a2MI6KgP9v/IlxXav6cnTp3enchzMx
	 Kx4PAUYV53+vkrerfG+TVPWTnqF9Vc2hCktYsleh0rlotzUFBBctIjC6Z7w5fkSmLa
	 Jf5Srmo1CSlnmZfSBa/rzHybpVDwwegNY8KA5+4TFSJfeMbZevQUVJwgDiOZCrBWrc
	 hvU5+P+HcSreA==
Date: Wed, 19 Mar 2025 12:16:41 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
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
Message-ID: <Z9sYGccL4TocoITf@bombadil.infradead.org>
References: <202503101536.27099c77-lkp@intel.com>
 <20250311-testphasen-behelfen-09b950bbecbf@brauner>
 <Z9kEdPLNT8SOyOQT@xsang-OptiPlex-9020>
 <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
 <Z9mFKa3p5P9TBSTQ@casper.infradead.org>
 <Z9n_Iu6W40ZNnKwT@bombadil.infradead.org>
 <Z9oy3i3n_HKFu1M1@casper.infradead.org>
 <Z9r27eUk993BNWTX@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9r27eUk993BNWTX@bombadil.infradead.org>

On Wed, Mar 19, 2025 at 09:55:11AM -0700, Luis Chamberlain wrote:
> FWIW, I'm not seeing this crash or any kernel splat within the
> same time (I'll let this run the full 2.5 hours now to verify) on
> vanilla 6.14.0-rc3 + the 64k-sector-size patches, which would explain why I
> hadn't seen this in my earlier testing over 10 ext4 profiles on fstests. This
> particular crash seems likely to be an artifact on the development cycle on
> next-20250317.

I confirm that with a vanilla 6.14.0-rc3 + the 64k-sector-size patches a 2.5
hour run generic/750 doesn't crash at all. So indeed something on the
development cycle leads to this particular crash.

  Luis
