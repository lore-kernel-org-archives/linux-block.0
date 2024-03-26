Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FD1446BA
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434156; cv=none; b=tag3gCfA94LZ3XrElgEFVR0Ke4CmrxoNSEzol6T6rvKd25wGkjaP3Wwp55i24pjJn5g6k4KwOyXEL059Bah8VeX3WksfwgSmzm3iCmSK9cJvY6kCQHS2NLfbxCJ9mkt56sP5BuiNPw/qoLAPCLHRAitRypq10TkHgSU6tX0WN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434156; c=relaxed/simple;
	bh=TIyAkvUSIjF8pjVcU7pb+zGzWLzddNkNpice5C7OMQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cueq4xm0ep2MYOPmy2oGySAFQmmHtSc+KcTEiZnrqDl169/hGvRytRcK8yJ0vvSLhXZ6vXLsBiW+7zS4GPV2BV4iXlrLmDNJ3JGmDixeYlVgHoZh/KWOV4xN+bzpH96k9a1TtjGunq3x9KyFpXBhGYRLqPbCycp39OMs3n0X5NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE8FA68D37; Tue, 26 Mar 2024 07:22:29 +0100 (CET)
Date: Tue, 26 Mar 2024 07:22:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH v2] block: Improve IOPS by removing the fairness code
Message-ID: <20240326062229.GA7554@lst.de>
References: <20240325221420.1468801-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325221420.1468801-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 25, 2024 at 03:14:19PM -0700, Bart Van Assche wrote:
> On my test setup (x86 VM with 72 CPU cores) this patch results in 2.9% more
> IOPS. IOPS have been measured as follows:
> 
> $ modprobe null_blk nr_devices=1 completion_nsec=0
> $ fio --bs=4096 --disable_clat=1 --disable_slat=1 --group_reporting=1 \
>       --gtod_reduce=1 --invalidate=1 --ioengine=psync --ioscheduler=none \
>       --norandommap --runtime=60 --rw=randread --thread --time_based=1 \
>       --buffered=0 --numjobs=64 --name=/dev/nullb0 --filename=/dev/nullb0

And how does it behave when you have multiple request_queues sharing
a tag_set with very unevent use that could cause one to starve all
the tags?  Because that is what this code exists for.

