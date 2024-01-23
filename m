Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5D56B65
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999538; cv=none; b=ObWfT0eiE604YIPqGixTqNzKJk3dOGumrcA1ugphZ2ABc5gP77qPZ1BgDQ9OWJxvz6B3VnobzLPt8l8Zlypn0wcIyYcPkNTmgw7J/6f3P6pzU00VuwiFJeYOhHQ/+1a6T+W2On2on/i0yWwhg+37r3df+MyEqzd95weTcm3ppFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999538; c=relaxed/simple;
	bh=IGWxeDGvAVRpfu8Qw1CC/z/F0AIWBIGIgkCgkoEyemA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1BHQvLImWVRNb8y1QiEY21FVJINg4gB1k5lZMiUZdkpe7w0+TB9gGkS5hEUWS6KzVg/7rJsfxJj0YB9UFYiU4w0pxocDDgyu8gwD86fPOGTH30zSUEzljVAULPT4TlwhWTLPvQGNVKn7v66zNfdbavLsXXUL9oVNyrxH2SgJNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6DCCA68C4E; Tue, 23 Jan 2024 09:45:33 +0100 (CET)
Date: Tue, 23 Jan 2024 09:45:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 06/15] nvme: remove the hack to not update the discard
 limits in nvme_config_discard
Message-ID: <20240123084532.GC29041@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-7-hch@lst.de> <c0738ba9-2eb8-4997-b357-af481da0a457@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0738ba9-2eb8-4997-b357-af481da0a457@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 23, 2024 at 02:12:37PM +0900, Damien Le Moal wrote:
> >  	blk_queue_max_discard_sectors(queue, max_discard_sectors);
> 
> This function references max_user_discard_sectors but that access is done
> without holding the queue limits mutex. Is that safe ?

No.  But fixing nvme will be done in a follow series.
