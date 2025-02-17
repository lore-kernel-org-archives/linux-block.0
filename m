Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A5F215795
	for <linux-block@vger.kernel.org>; Mon, 17 Feb 2025 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739785299; cv=none; b=nlAS8JfmsD05Q0uT2ub4tkD2O591hLkp39SQJ6yh9ji2+tTbcb14bftaYuvoimtdiNdc/vgj9xNFwP4HqiX/sdr+Fl4l+p2yKToxwDP8h0Sn7t9L60BAOUI4AWsN6440+RqRIf3KLL1/lMbb/zEOXE1c3OfI8nbdZn2Nt7jqKuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739785299; c=relaxed/simple;
	bh=+xE+4bAvz9J5GxAz0/tCMPgdiKOLAE5mTZpHnWZbi1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iylw1rMwhcUWBY7Zv49aMZuSatE0AL3rE/FSsXSi6aWq0U9LkcxublNBA3wCfwCzbym45iH9LkxE2Hv59oUBPtToTMxLil3N0LvTWvvUSTmfwGgGLnnWAlztofE+bftoRrbYu5Q7fBHjWbM6O/DbXPnWnEzNI7X3VPlx5vqfQmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BB9A368BEB; Mon, 17 Feb 2025 10:41:32 +0100 (CET)
Date: Mon, 17 Feb 2025 10:41:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 0/7] block: remove all debugfs dir & don't grab
 debugfs_mutex
Message-ID: <20250217094132.GA30499@lst.de>
References: <20250209122035.1327325-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209122035.1327325-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Feb 09, 2025 at 08:20:24PM +0800, Ming Lei wrote:
> Hi,
> 
> The 1st 6 patch removes all kinds of debugfs dir entries of block layer,
> instead always retrieves them debugfs, so avoid to maintain block
> internal debugfs state.

I'm still not sure this is a good idea.  Yes, unregistration is not
a fast path, but having to reconstruct path names to remove them
just creates annoying racyness.  Now we'd need to make sure now
one is creating the same names at the same time.  Which is probably
fine now, but something entirely non-obvious to keep it mind.  There's
also a reason why the debugfs API isn't built that way to start with.

> The 7 patch removes debugfs_mutex for adding/removing debugfs entry
> because we needn't the protection any more, then one lockdep warning
> can be fixed.

I don't see the lockdep dependency anywhere in this thread, but I
assume it's the mess with updating nr_hw_queues again?

In that case the fix is going probably going to be the same
tag_set-wide lock Nilay is looking into for sysfs.
