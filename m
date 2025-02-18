Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF626B2BE
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896203; cv=none; b=FSbE4vuTJF7IG+Tlrxe3wuXGs05vGbk19O1AxynubxfT1giug41UjgrFqi+R2FI6Uh6dLGi0yHvLtfGw+LgBTcxgCM84SqTrHFt0KSknaPUeRg+yxoO1lzp45BKGrXnKhHdoZI+ctzT07xRWOILq0+UjZmo30pgiaxPkh6uO1uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896203; c=relaxed/simple;
	bh=irpEgPf1r2gwvQqy6RALu9VEG7w5vwPLVqHmH9SNhuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzDl647icdq4CyF42bCm2d88uyY9lZ1CIuYMXcgYfvforfbl9fd5aGQztK2qghHb9IvrDL48Jj3kXr90B7soPfs1Jd2Qn/zxpAxvkev9onSgwkf5KVhfckEh8/dIHHvb4H6DfmILtyHRQtkJiF70GWQkTlYw+3xrk8a7mBr1ODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 142DA68D07; Tue, 18 Feb 2025 17:29:54 +0100 (CET)
Date: Tue, 18 Feb 2025 17:29:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	hch@lst.de, dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes
 which don't need it
Message-ID: <20250218162953.GA16439@lst.de>
References: <20250218082908.265283-1-nilay@linux.ibm.com> <20250218082908.265283-2-nilay@linux.ibm.com> <Z7R4sBoVnCMIFYsu@fedora> <5b240fe8-0b67-48aa-8277-892b3ab7e9c5@linux.ibm.com> <Z7SO3lPfTWdqneqA@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7SO3lPfTWdqneqA@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 18, 2025 at 09:45:02PM +0800, Ming Lei wrote:
> IMO, this RO attributes needn't protection from q->limits_lock:
> 
> - no lifetime issue
> 
> - in-tree code needn't limits_lock.
> 
> - all are scalar variable, so the attribute itself is updated atomically

Except in the memory model they aren't without READ_ONCE/WRITE_ONCE.

Given that the limits_lock is not a hot lock taking the lock is a very
easy way to mark our intent.  And if we get things like thread thread
sanitizer patches merged that will become essential.  Even KCSAN
might object already without it.

