Return-Path: <BATV+0ce91e3c8ec9178008cb+5000+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 2 May 2017 01:13:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] block: Improvements to bounce-buffer handling
Message-ID: <20170502081314.GB5578@infradead.org>
References: <149369628671.5146.4865312503373040039.stgit@noble>
 <149369654475.5146.215368176129979588.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149369654475.5146.215368176129979588.stgit@noble>
List-ID: <linux-block@vger.kernel.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>

although I think we really should kill off the block level bouncing
rather sooner than later.
