Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2801D89EF
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736152298; cv=none; b=JdiPmnUQlISaqib1O1UgfKd/A5RM1gzxAru7DV+Time901PdIE74SdeQzFPmFBaY3QVrE+cML+9JVLgXVCYLCapy5thkV1GZNBFEePcP4OT5+LkfTDiDJWGHZHaNsWzKa3pja9xQOYDwnjtgLrGnqBP8rCSg0qRmG1aozgC2XtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736152298; c=relaxed/simple;
	bh=/sBQbqLZVvaHd/P9BTrnbbtSvHbNZa76+IQbt0DPTFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoypOSFEEwUhNzi7kkDNKaQEXtTGg23esJ/NKuSCuk/HY7dZbb4NT2++Ig8Jgq6Fxt69OxIyg00STvgcsei1XruZMmKVjUzQ+KmPyPUR9UQdcJmgdMvi7+5bwXtDcrWALDl3Mznp8AqI8cGQHQ3aHFsFPfFh8wi6OMQBOvGtC70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CCA8E68BFE; Mon,  6 Jan 2025 09:31:29 +0100 (CET)
Date: Mon, 6 Jan 2025 09:31:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 3/3] nvme: Fix queue freeze and limits lock order
Message-ID: <20250106083129.GE18408@lst.de>
References: <20250104132522.247376-1-dlemoal@kernel.org> <20250104132522.247376-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104132522.247376-4-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Jan 04, 2025 at 10:25:22PM +0900, Damien Le Moal wrote:
> Modify the functions nvme_update_ns_info_generic(),
> nvme_update_ns_info_block() and nvme_update_ns_info() to freeze a
> namespace queue using blk_mq_freeze_queue() after starting the queue
> limits update with queue_limits_start_update() so that the queue
> freezing is always done after obtaining the device queue limits lock (as
> per the block layer convention for sysfs attributes).

FYI, there's a few more like this.  In my WIP series I've basically
made the normal queue_limits_commit_update contain the freeze and add
a special version without the freeze, which makes a lot of this
more obvious.  Let me dust it off even before sorting out the poll
flag so that we have a little more discussion material.

