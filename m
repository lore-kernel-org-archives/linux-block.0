Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E15C0
	for <linux-block@vger.kernel.org>; Tue,  5 Dec 2023 10:52:37 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 80D1F227A8E; Tue,  5 Dec 2023 19:52:34 +0100 (CET)
Date: Tue, 5 Dec 2023 19:52:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: support adding less than len in
 bio_add_hw_page
Message-ID: <20231205185234.GB21354@lst.de>
References: <20231204173419.782378-1-hch@lst.de> <20231204173419.782378-3-hch@lst.de> <ZW9R29OUl3j8BH43@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW9R29OUl3j8BH43@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 05, 2023 at 09:37:47AM -0700, Keith Busch wrote:
> > -	if (((bio->bi_iter.bi_size + len) >> SECTOR_SHIFT) > max_sectors)
> > +	len = min3(len, max_size, queue_max_segment_size(q));
> > +	if (len > max_size - bio->bi_iter.bi_size)
> >  		return 0;
> >  
> >  	if (bio->bi_vcnt > 0) {
> 
> Not related to your patch, but noticed while reviewing: would it not be
> beneficial to truncate 'len' down to what can fit in the current-segment
> instead of assuming the max segment size?

That would be pretty intrusive to the code shared with the normal not
hw limited bio add code, so I decided to keep it simple.
