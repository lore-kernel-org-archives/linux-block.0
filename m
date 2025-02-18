Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBA123237B
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870469; cv=none; b=dLfSya2sFg1+a7MQVY6OOtzom5GzfgGn5o5Ns5bKVbJ3LPOF/gMp4WNTMIfJRrm3rI9+8y3RadVMDzdLhxCv+odrN0Rkzoo4ECpFdtLzQrH1dUMIbR2KMs9oHp2f1yWCFeoRpxajzZCqz711f2DEDvXlPEE3aAUQSIVPj6vrOc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870469; c=relaxed/simple;
	bh=Sx8za+6aa7/bTwzxuIx4rcLyqiCgdCaJec+rV33Ay1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHNkkiPls6H1nhtfvRXhcXLM1GZkdSfJg85hKxyL+MBhzOUOW3OiLh58KSz1N+aFYss4GRuwBCAfj/UA7cf8c9IcIn3mWma7u4ErKz9XtTLfuKnxfuEs8QLhNItFV707hmz+efRUxF8gLmlQ/k1PnNlyrrK7A0DXERHf9w3E9mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 88EB368C7B; Tue, 18 Feb 2025 10:21:01 +0100 (CET)
Date: Tue, 18 Feb 2025 10:21:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv2 0/6] block: fix lock order and remove redundant
 locking
Message-ID: <20250218092100.GB13262@lst.de>
References: <20250218082908.265283-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218082908.265283-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

The mix of blk-sysfs and block in the subject lines is a bit odd.
Maybe just use the block prefix everywhere?

Also q->sysfs_lock is almost unused now and we should probably look
into killing it entirely.

blk_mq_hw_sysfs_show takes it around the ->show methods which
looks pretty useless.  The debugfs code takes it for a few undocumented
things, which are worth digging into and if needed split into a separate
lock.

The concurrent ranges code takes it - I think that is because it does
register a complex sysfs hierarchy from something that could race with
add_disk / del_gendisk.  Damien, can you help with your thoughts?
(sd.c also has a comment reference it and the removed sysfs_dir_lock
which needs fixing anyway).

blk_register_queue still takes it around a pretty random range of code
including nesting with other locks.  I can't see what it protects
against, but it could use a careful look.

blk_unregister_queue takes it just to clear QUEUE_FLAG_REGISTERED,
which by definition can't really protect against anything.

Also the sysfs_lock in the elevator_queue should probably go away or
be replaced with the new elevator_lock for the non-show/store path
for the same reasons as outlined in this series.
