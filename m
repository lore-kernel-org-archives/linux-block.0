Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065F121ABC2
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496386; cv=none; b=rCGkDldtKrvel690Eeg9wKi+PCxYkJn1uMYZPUZvnDbfxbW7BwPt3mao2w8l1BPP2N0Axu0XxEqfBabo/w0STzkUtBavi/QQ3wsoCa9uAA8jqS/Gd5eHVK6JLwkio9hLufnB9s1CmqM+hfVsFM0LqJWkkiOM4Qz1mey7Jlg1/2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496386; c=relaxed/simple;
	bh=sWvoGn109acAqfbnSPV14ClrU8nwegh+u9vlPgxet40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gr6mO27OOyKckFdOa0LXI0DJ7tcG3Yj98GZLJwAeWu4iREYy9x8NlrrPVRvJHOyyXdkRA9nHuGbP1cGoonJt/k3Yxau7HYhbvQWmhfCNYqeUIrcisBIBJwxoVM8IqPkGNtG0Zl/BGcD1ew28QxoBBkzYYBIpWPx3Fk7uZ8DT+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9F0BD68D07; Tue, 25 Feb 2025 16:13:00 +0100 (CET)
Date: Tue, 25 Feb 2025 16:13:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	dlemoal@kernel.org, hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv4 6/7] block: protect wbt_lat_usec using
 q->elevator_lock
Message-ID: <20250225151300.GB6455@lst.de>
References: <20250225133110.1441035-1-nilay@linux.ibm.com> <20250225133110.1441035-7-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225133110.1441035-7-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 25, 2025 at 07:00:41PM +0530, Nilay Shroff wrote:
> The wbt latency and state could be updated while initializing the
> elevator or exiting the elevator. It could be also updates while
> configuring IO latency QoS parameters using cgroup. The elevator
> code path is now protected with q->elevator_lock. So we should
> protect the access to sysfs attribute wbt_lat_usec using q->elevator
> _lock instead of q->sysfs_lock. White we're at it, also protect
> ioc_qos_write(), which configures wbt parameters via cgroup, using
> q->elevator_lock.

Please expand the comment near the elevator_lock field to mention
that it protects wbt_lat_usec.

