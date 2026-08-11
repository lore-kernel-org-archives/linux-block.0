Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C82331EBC
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 00:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786409754; cv=none; b=S6wT+1qjdmEuZZS0ucL8exRP/AzWjj+/UL87ZlCiY3US86xJ/QJ2CS/hk/JVradbdWv1s/ruskSfabDAC8GhGg/KRyvhXnzlI/t8iMJhonoOwEmq6bISa7Hm3c/0F57IG7yRZrdVkNdBsUfPoN/YrrIQgtOCcVbFyNWZCAHd22o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786409754; c=relaxed/simple;
	bh=j9gnFNhzOx6O7He/zjHLWAcaW2sDXyhn2hFK9rMlai4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV1KwXd5MBGzcGBmnYsIjEIk8qkwyMWLpXWJWDZ5prMnc3WdQeod4nRMhNrbN0LENzBMry05WCAYuHoyeUihGJ6XFGYIlBz7YhM/h+TjB8efOOZL2cJ88OxRWtk1YKcc8ylFKkz+bZh4S6pEsjPPXcqqlNM6l8Rl3yuo+Go4A4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h976ZzrA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h976ZzrA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE071F000E9;
	Tue, 11 Aug 2026 00:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786409745;
	bh=YXDPeV0frzKO1XCETmGtDDKJhEwmiS95+OxrQDY2p/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h976ZzrArYIP/kUdX6Ae/iQclmMCtoZe2sp9rmhfqBiHqJnvhrj5jazg7mSagtQkk
	 Z8g3esSrZLX7LR461IfdwO1fU8M3G29hcTU8i3GOYN2oqmq0qYuTdn9IoPWsp5y6OU
	 q1+JR1GQJwREi1lNUH0oz5B6055YVdODXmHJo9jjXFWyB7EcqFK4vV0HLng3cYwltg
	 896GO6dFXHfcvXhORgs2XCwOtLbe1cbmKIInlFZvwz2Nu2IDviDuYrV61cTJQhWgTR
	 5B/Rkc4ejsDKjEd9ac/r7ZUW1cjXXC5+4wbF/X4bSU/uJzjw9IjzLHdTW/O3xfhqF+
	 D22gHZs3RJ+ZA==
Date: Mon, 10 Aug 2026 18:55:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: John Garry <john.garry@linux.dev>, Christoph Hellwig <hch@lst.de>,
	sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH RFC] nvme-multipath: fix diskstats for partitions
Message-ID: <anpzD5PaOn-_K5hn@kbusch-mbp>
References: <20260721114553.1657841-1-john.g.garry@oracle.com>
 <20260724050152.GA3680@lst.de>
 <987782a9-e12a-4098-b438-a54a5765c2ae@oracle.com>
 <amNegPEvRX99EvPN@kbusch-mbp>
 <f76e9466-4b66-4a32-a491-728e24d34052@linux.dev>
 <amOGxr3rxvDflHLv@kbusch-mbp>
 <94ed42ce-895d-4197-994b-60fc1d3f040c@linux.dev>
 <d3058b64-e162-4bfc-990d-13ff5f03143a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3058b64-e162-4bfc-990d-13ff5f03143a@oracle.com>

On Thu, Jul 30, 2026 at 01:52:00PM +0100, John Garry wrote:
> 
> With that, /sys/class/block/ looks a bit different (with the per-path
> partitions):
> 
> #ls -l /sys/class/block/ | grep nvme0
> lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0c0n1 ->
> ../../devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n1
> lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0c0n1p1
> -> ../../devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n1/nvme0c0n1p1
> lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0c1n1 ->
> ../../devices/virtual/nvme-fabrics/ctl/nvme1/nvme0c1n1
> lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0c1n1p1
> -> ../../devices/virtual/nvme-fabrics/ctl/nvme1/nvme0c1n1/nvme0c1n1p1
> lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0n1 ->
> ../../devices/virtual/nvme-subsystem/nvme-subsys0/nvme0n1
> lrwxrwxrwx    1 root     root             0 Jul 30 12:39 nvme0n1p1 ->
> ../../devices/virtual/nvme-subsystem/nvme-subsys0/nvme0n1/nvme0n1p1
> 
> Thoughts?

Yes, looks good to me, though I don't really know why partition scanning
was skipped in the first place. I always thought the important part was
the HIDDEN devices don't automatically enumerate in /dev/.
