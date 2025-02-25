Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBEA21ABC2
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496456; cv=none; b=kCGZLZfTSW01ERwA4fylPIF+QiAelsAWMQXQjaTH37OWDuPtJT5mtI4oOZQHmHzak5Zk9cExQUeM5p4Z6ZSj831VZCHMo0CE7p0QwdrtvFwkButaJCu665AJBTbQme/BhRvDRaLE1K70FRn6S6XZWS8vooZgSrlt79WcmpBTWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496456; c=relaxed/simple;
	bh=kiUMGLizRKS19yAlVjLZTaQTb0iryYJv+h3Igx26+eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+ciNYyrpXnEWHBu8/v7Rg4rUO5qhSvY9bLsjZe1/NMV0gycBQurKeYPByHQwqiTfw3bXTjd1aYM3hQPG3KUcSmajSQf7p9Q/vpsH1t0/E48UZG7cOGPw8rzhBz85crDpKzGLNyBbd/XPr2u1DhvhUu/N6fKJyCO/18TNBaDMy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5827368D05; Tue, 25 Feb 2025 16:14:10 +0100 (CET)
Date: Tue, 25 Feb 2025 16:14:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	dlemoal@kernel.org, hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv4 7/7] block: protect read_ahead_kb using q->limits_lock
Message-ID: <20250225151410.GC6455@lst.de>
References: <20250225133110.1441035-1-nilay@linux.ibm.com> <20250225133110.1441035-8-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225133110.1441035-8-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 25, 2025 at 07:00:42PM +0530, Nilay Shroff wrote:
> The bdi->ra_pages could be updated under q->limits_lock because it's
> usually calculated from the queue limits by queue_limits_commit_update.
> So protect reading/writing the sysfs attribute read_ahead_kb using
> q->limits_lock instead of q->sysfs_lock.

Please add a comment near limits_lock that mentions that the lock
protects the limits and read_ahead_kb field.  I should have probably
done the former myself when adding it, but now that it also protects
a non-obvious field we really need it.

