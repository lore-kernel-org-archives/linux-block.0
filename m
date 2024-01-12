Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8C75B5D9;
	Fri, 12 Jan 2024 05:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DA8E268CFE; Fri, 12 Jan 2024 06:44:49 +0100 (CET)
Date: Fri, 12 Jan 2024 06:44:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter reference is held
 when splitting bios
Message-ID: <20240112054449.GA6829@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d682398-9922-404b-ac50-2fb292793ddb@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 11, 2024 at 01:06:43PM -0700, Jens Axboe wrote:
> Something like this? Not super pretty with the duplication, but...
> Should suffice for a fix, and then we can refactor it on top of that.
> ioprio is inherited when cloning, so we don't need to do that post the
> split.

Yes, this could work.  It'll get worse with anything we need to do under
q_usage_counter counter, though.  I mean, it is a perpcu_counter, which
should be really light-weight compared to all the other stuff you do.
I'd really love to see numbers that show it matters.

> For the bounce side, how would these settings change at runtime?

Well, we don't really prevent any setting from changing at runtime.
But yes, neither mmc nor the few scsi drivers using it seems to do
any runtime re-configuration.

> Should
> be set at init time and then never change. And agree would be so nice to
> kill that code...

I wish we could see some more folks from the mmc maintainers to do
proper scatterlist (or bio/request) kmap helpers.  The scsi drivers
could easily piggy back on that or just be disabled for HIGHMEM configs.

