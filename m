Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E105427E
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625799; cv=none; b=luQUKjAjeA8677Gx4aEAcmBmuWDXeLqNkneWgkOOkhPVPP1ifD921Dl+EqDKV0CCZYUaQIYVrm1h9gchzdORWONVL/zvrKIfdbx3uq33CsVO/PM242t+LwLJj2ZHFg/QaFn+mnZQKGlpsrGuohXbJOY/e0SWce7B2e3p+AfFXAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625799; c=relaxed/simple;
	bh=wd5wbUO1Mr6CE5hhSJmP+7cRaMTw0eDCGjrDb+eS/Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxIwO8w26Dwi4ShLJALU7gN+53uiKXWzlB/c3S3DT9eIQxaJSBagxoZo6Kwh2D8+Sn1JyXs8lpssaqv2ngGqM0QseQ8/8FJ2MXsM2iGtyKu7SVGI8N83YB8lDSoT+PzItuu3vX6NsCK5IWeCeql96cVCVelaeajltQtFeq5jsQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 112CA68B05; Tue, 30 Jan 2024 15:43:14 +0100 (CET)
Date: Tue, 30 Jan 2024 15:43:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 04/14] block: use queue_limits_commit_update in
 queue_max_sectors_store
Message-ID: <20240130144313.GB32125@lst.de>
References: <20240128165813.3213508-1-hch@lst.de> <20240128165813.3213508-5-hch@lst.de> <e65301d3-7274-45fa-a64c-5039257aa333@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e65301d3-7274-45fa-a64c-5039257aa333@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 30, 2024 at 12:14:32PM +0000, John Garry wrote:
> On 28/01/2024 16:58, Christoph Hellwig wrote:
>> Convert queue_max_sectors_store to use queue_limits_commit_update to
>> check and update the max_sectors limit and freeze the queue before
>> doing so to ensure we don't have requests in flight while changing
>> the limits.
>>
>> Note that this removes the previously held queue_lock that doesn't
>> protect against any other reader or writer.
>
> I don't really get why we specifically locked that code segment in 
> queue_max_sectors_store() previously. Was it to ensure max_sectors and 
> q->disk->bdi->io_pages are always atomically updated?

It's been there basically forever.  Back in the day before blk-mq
and lock splitting it might actually have protected something.

