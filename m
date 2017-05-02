Return-Path: <BATV+0ce91e3c8ec9178008cb+5000+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 2 May 2017 01:15:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org,
	Javier Gonzalez <jg@lightnvm.io>
Subject: Re: [PATCH 09/13] lightnvm/pblk-read: use bio_clone_fast()
Message-ID: <20170502081501.GD5578@infradead.org>
References: <149369628671.5146.4865312503373040039.stgit@noble>
 <149369654558.5146.13818001419050826182.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149369654558.5146.13818001419050826182.stgit@noble>
List-ID: <linux-block@vger.kernel.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
