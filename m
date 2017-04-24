Return-Path: <BATV+253d158279d9b4f3ffaf+4992+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 24 Apr 2017 08:10:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] blk: make the bioset rescue_workqueue optional.
Message-ID: <20170424151013.GA17867@infradead.org>
References: <149266645258.27388.14083229348123176454.stgit@noble>
 <149266672858.27388.11409778158413625707.stgit@noble>
 <20170421112458.GB12523@infradead.org>
 <87h91er2t6.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87h91er2t6.fsf@notabene.neil.brown.name>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 24, 2017 at 11:51:01AM +1000, NeilBrown wrote:
> 
> I was following the existing practice exemplified by
> bioset_create_nobvec().

Which is pretty ugly to start with..

> By not changing the signature of the function, I can avoid touching
> quite a few places where it is called.

There are 13 callers of bioset_create and one caller of
bioset_create_nobvec, and your series touches many of those.

So just adding a flags argument to bioset_create and passing
BIOSET_NEED_BVECS and BIOSET_NEED_RESUER flags to it doesn't seem
to much of an effort, and it's going to create a much nicer and easier
to extend interface.
