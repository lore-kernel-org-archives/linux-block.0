Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893241AF0C8;
	Thu, 29 May 2025 22:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748556806; cv=none; b=Giw9Pda13X/2Ej8DnFq3Ren6vRAfvFesM231/nfT1IooGUwcXNnjBrHZ5y3iF9vaAH8VkwsP3jf3iycXWkrckfwpdyLj8urRFefKJdkqdYcv0k34jmxV45VAdy5iqesJGEkMC9AlTpPwvDx3fdN2UsDUFyMWiwvk3aXzVodoJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748556806; c=relaxed/simple;
	bh=q0eBMKlDwAs8NFjYwQFQjGfQ+gHCHGGcfAf/pDUAN48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOv9rP3RsNUixTD45KgRay9RnBVZw1TzK/7vTlySf8/vOyk1RdkU6aLkPqf7UqGPVoSBWL3n630SVjlbAldzsug5abEAUN60or5ve5p+PHQMp5MlZst9H9jXbZDYK2bJnLC71ghAG5RDiMzRUh+1I3JrCfeBsHtg/HCzY5RrxOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGyIwl7+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGyIwl7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DB5C4CEE7;
	Thu, 29 May 2025 22:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748556805;
	bh=q0eBMKlDwAs8NFjYwQFQjGfQ+gHCHGGcfAf/pDUAN48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aGyIwl7+9CxWN2VRNXZPuCGH9ajEhdOoDdRtw/WiCsSLSvNknQ2XVHVkaflGEewue
	 TLQ0UykblHPvBzBXcnrg/6fwWBbNPHBDs1JPwZdiC4iWxR98mhOzxXHyI7KNPesrit
	 r+IGli3PbeL2gZAceSEWnk4n8Zuj+OGjFIC2YdeCL1TPpGmxXZFo4m+jt7Chhsq/GG
	 Mbrf5y0CkH8KT40ooqdScHKBBHaS7KurCPJFwHnCyWFo5p+GuTBzVzXaJz8B3qR2GC
	 YIjfljCcxGjmg+/QCNVaSFhZbZIlX9h+1YyLqU3J9rK9KBVfXHxkn+aL/lngc732Sb
	 B3MdRZX9izuWA==
Date: Thu, 29 May 2025 16:13:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Michael Liang <mliang@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>
Subject: Re: [PATCH] block: Fix blk_sync_queue() to properly stop timeout
 timer
Message-ID: <aDjcA_H7Ec9VICps@kbusch-mbp>
References: <20250529214928.2112990-1-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529214928.2112990-1-mkhalfella@purestorage.com>

On Thu, May 29, 2025 at 03:49:28PM -0600, Mohamed Khalfella wrote:
> nvme-fc initiator hit hung_task with stacktrace above while handling
> request timeout call. The work thread is waiting for itself to finish
> which is never going to happen. From the stacktrace the nvme controller
> was in NVME_CTRL_CONNECTING state when nvme_fc_timeout() was called.
> We do not expect to get IO timeout call in NVME_CTRL_CONNECTING state
> because blk_sync_queue() must have been called on this queue before
> switching from NVME_CTRL_RESETTING to NVME_CTRL_CONNECTING.
> 
> It turned out that blk_sync_queue() did not stop q->timeout_work from
> running as expected. nvme_fc_timeout() returned BLK_EH_RESET_TIMER
> causing q->timeout to be rearmed after it was canceled earlier.
> q->timeout queued q->timeout_work after the controller switched to
> NVME_CTRL_CONNECTING state causing deadlock above.
> 
> Add QUEUE_FLAG_NOTIMEOUT queue flag to tell q->timeout not to queue
> q->timeout_work while queue is being synced. Update blk_sync_queue() to
> cancel q->timeout_work first and then cancel q->timeout.

I feel like this is a nvme-fc problem that doesn't need the block layer
to handle. Just don't sync the queues within the timeout workqueue
context.
