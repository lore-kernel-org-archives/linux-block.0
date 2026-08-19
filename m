Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B033E832B
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130059; cv=none; b=ZsP4Noen5vZMdtZ+1N5WX+9mEEESoHelIdf8qWxOAgL1LWOy7qgJMQXFo488o7gfDIJpq68j3xQDqK5miIsDlbQSOyaz+ZK2xng0T0aB5PVGcmLBDqnqkRMXajqhDgfuyaGcmZjBGNLYRyWc0HhX80TXo2+KMBAIcBAvkUp6XIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130059; c=relaxed/simple;
	bh=dloMoTLMW6BMOguQftJSkqNrkA4a4qXIX3wnHTIufQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljtf8sJVmtZuvF8rVEYWLXzu6/dn+SO2n/kWQ2baHxUnWrFtnfeVQb6wo2xXPM3BEVcbXTCdkFOxJN+u2zYk4VyoGs9bh/1nAHHZRqKChAiEcia1RjmGtlY4RtN4tzpHzJ7IQqiZDs/RT6VyTYrJGcwfQFZTstFusxt3pdKqMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0A5C668C7B; Wed, 19 Aug 2026 11:00:51 +0200 (CEST)
Date: Wed, 19 Aug 2026 11:00:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	John Garry <john.garry@linux.dev>
Subject: Re: [PATCH RFC v2 1/2] block: scan partitions for hidden disks
Message-ID: <20260819090050.GA9267@lst.de>
References: <20260818120854.3151628-1-john.g.garry@oracle.com> <20260818120854.3151628-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818120854.3151628-2-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 18, 2026 at 12:08:53PM +0000, John Garry wrote:
> From: John Garry <john.garry@linux.dev>
> 
> If a disk is hidden (GENHD_FL_HIDDEN flags set), we currently do not scan
> the disk partition table.
> 
> GENHD_FL_HIDDEN is used in NVMe multipath support to hide the per-path
> disk.

It also is used for giving a handle to NVMe devices that we can't support
as block devices and for which we only want a handle to issue passthrough
commands.  For those attempting a partition scan is rather suboptimal.

As is in general doing an extra scan per controller when we know it must
give the same results.  Wouldn't it make more sense to just propagate
the partition table from the ns_head to each individual path?

