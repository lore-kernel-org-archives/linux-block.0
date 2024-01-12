Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BDCF4F7
	for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BC33468CFE; Fri, 12 Jan 2024 06:46:36 +0100 (CET)
Date: Fri, 12 Jan 2024 06:46:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter reference is held
 when splitting bios
Message-ID: <20240112054636.GB6829@lst.de>
References: <20240111135705.2155518-1-hch@lst.de> <20240111135705.2155518-3-hch@lst.de> <ZaBqQ0jX6ovHITQo@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaBqQ0jX6ovHITQo@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 12, 2024 at 06:22:59AM +0800, Ming Lei wrote:
> On Thu, Jan 11, 2024 at 02:57:05PM +0100, Christoph Hellwig wrote:
> > q_usage_counter is the only thing preventing us from the limits changing
> > under us in __bio_split_to_limits, but blk_mq_submit_bio doesn't hold it.
> 
> Can you share why the limits change matters wrt. split? If queue is
> live, both new and old one are supposed to work, such as, we don't
> freeze queue when changing `max_sectors_kb` via sysfs.

Hardware reconfigurations for example, which can happen in nvme for
just about every limit, in SCSI for limits controller by the ULD,
and in quite a few places for disabling write zeroes or discard.

