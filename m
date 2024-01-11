Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59FC4F5F8
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 11CC268CFE; Thu, 11 Jan 2024 17:14:41 +0100 (CET)
Date: Thu, 11 Jan 2024 17:14:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter reference is held
 when splitting bios
Message-ID: <20240111161440.GA16626@lst.de>
References: <20240111135705.2155518-1-hch@lst.de> <20240111135705.2155518-3-hch@lst.de> <d713fe1b-3eaa-4de4-99a6-5910247ffad5@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d713fe1b-3eaa-4de4-99a6-5910247ffad5@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 11, 2024 at 09:12:23AM -0700, Jens Axboe wrote:
> On 1/11/24 6:57 AM, Christoph Hellwig wrote:
> > q_usage_counter is the only thing preventing us from the limits changing
> > under us in __bio_split_to_limits, but blk_mq_submit_bio doesn't hold it.
> > 
> > Change __submit_bio to always acquire the q_usage_counter counter before
> > branching out into bio vs request based helper, and let blk_mq_submit_bio
> > tell it if it consumed the reference by handing it off to the request.
> 
> This causes hangs for me on shutdown/reset:

> which seems to indicate that a reference is being leaked. Haven't poked
> any further at it, I'll drop these two for now.

Can you send me your .config?
