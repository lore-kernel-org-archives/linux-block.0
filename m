Return-Path: <hch@lst.de>
Date: Thu, 14 Jun 2018 09:20:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [RFC] cleanup bcache bio handling
Message-ID: <20180614072026.GA17275@lst.de>
References: <20180611194806.13222-1-hch@lst.de> <20180613095801.GB15100@kmo-pixel> <20180613110640.GA9712@ming.t460p> <20180613135632.GB32418@lst.de> <20180613145409.GB17292@kmo-pixel> <20180614015531.GE19828@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180614015531.GE19828@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 14, 2018 at 09:55:32AM +0800, Ming Lei wrote:
> > Agreed about bio_for_each_chunk_all(), but I just looked at the patch that
> > introduces them and it looks to me like there's no need, they should just be
> > bio_for_each_segment_all().
> 
> Now we can't change the vector with bio_for_each_segment_all(), so
> bio_for_each_chunk_all() has to be used. So looks it makes sense to use
> bio_add_page() to remove bio_for_each_chunk_all().

For now I'd suggest we just open code bio_for_each_segment_all in bcache
as a first step to get the multipage bio vec work rolling.  The code
already pokes deep into bio internals, so having that iteration right
next to it isn't really an issue.  In the long run I'd still like to
see it cleaned up, though.
