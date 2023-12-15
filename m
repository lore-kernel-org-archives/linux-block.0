Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D6ECA64
	for <linux-block@vger.kernel.org>; Fri, 15 Dec 2023 04:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 398B468AFE; Fri, 15 Dec 2023 05:49:24 +0100 (CET)
Date: Fri, 15 Dec 2023 05:49:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Message-ID: <20231215044924.GA15775@lst.de>
References: <19cd459e-d79e-4ecd-8ec8-778be0066e84@acm.org> <20231212182613.GA1216@lst.de> <ZXiual-UkUY4OWY2@google.com> <20231213155606.GA8748@lst.de> <ZXnevBo4eIZEXbhK@google.com> <20231214085729.GA9099@lst.de> <ZXs563M66THrUw50@google.com> <168ed2f4-cf58-4ee9-bfbb-449f06f7348d@kernel.org> <ZXuz36STuYajyccm@google.com> <ZXu3vJHhJLFhQMYn@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXu3vJHhJLFhQMYn@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 14, 2023 at 06:20:16PM -0800, Keith Busch wrote:
> On Thu, Dec 14, 2023 at 06:03:11PM -0800, Jaegeuk Kim wrote:
> > 
> > Okay, it seems there's first disconnect here, which fails to explain all the
> > below gaps. Do you think the device supporting zone_append keeps LBAs inline
> > with PBAs within a zone? E.g., LBA#n guarantees to map to PBA#n in a zone.
> > If LBA order is exactly matching to the PBA order all the time, the mapping
> > granularity is zone. Otherwise, it should be page.
> 
> Yah, you're describing how 'zone append' works.

Haha.  I'm glad I read through all the answers as Damien and you already
did the explaining.

Note that in a complex SSD of course there can still be some remapping
due to wear leveling, worn out blocks or similar policy decisions, but
that usuall happens below the superblock level and the SSDs can be much
smarter about the algorithms used for that as it knows all data will
be written sequentially.
