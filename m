Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE0455C00
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6F0FC68CFE; Thu, 11 Jan 2024 18:24:39 +0100 (CET)
Date: Thu, 11 Jan 2024 18:24:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter reference is held
 when splitting bios
Message-ID: <20240111172438.GA22255@lst.de>
References: <20240111135705.2155518-1-hch@lst.de> <20240111135705.2155518-3-hch@lst.de> <d713fe1b-3eaa-4de4-99a6-5910247ffad5@kernel.dk> <20240111161440.GA16626@lst.de> <d91cb6ee-50bd-4397-b82f-d34dfc135b4a@kernel.dk> <20240111171002.GA20150@lst.de> <8a2ab893-c4e1-4bc3-9c0a-556c62f8f921@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a2ab893-c4e1-4bc3-9c0a-556c62f8f921@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 11, 2024 at 10:18:31AM -0700, Jens Axboe wrote:
> This also highlights a potential inefficiency in the patch, as now we're
> grabbing+dropping references when we don't need to. May not be a big
> deal, but it's one of the things that cached requests got rid of. Though
> I'm not quite sure how to refactor to get rid of that, as we'd need to
> shuffle the splitting and request get for that.
> 
> Could you take another look at the series with that in mind?

I thought about it, but it gets pretty ugly quickly.  bio_queue_enter
needs to move back into blk_mq_submit_bio, and then we'd skip it
initially if bio_may_exceed_limits is false, and then we later need
to add it back.  (we'll probably also need to special case
blk_queue_bounce as that setting could change to.  I wish we could
finally kill that)

