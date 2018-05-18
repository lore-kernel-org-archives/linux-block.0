Return-Path: <BATV+77ddf8e9b1b344f28472+5381+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 18 May 2018 09:20:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 02/10] block: Convert bio_set to mempool_init()
Message-ID: <20180518162028.GA25227@infradead.org>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
 <20180509013358.16399-3-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180509013358.16399-3-kent.overstreet@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 08, 2018 at 09:33:50PM -0400, Kent Overstreet wrote:
> Minor performance improvement by getting rid of pointer indirections
> from allocation/freeing fastpaths.

Can you please also send a long conversion for the remaining
few bioset_create users?  It would be rather silly to keep two
almost the same interfaces around for just about two hand full
of users.
