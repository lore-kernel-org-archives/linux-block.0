Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 15 Jun 2017 23:42:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org,
	Shaohua Li <shli@kernel.org>, Javier Gonzalez <jg@lightnvm.io>
Subject: Re: [PATCH 00/13] block: assorted cleanup for bio splitting and
 cloning.
Message-ID: <20170616064246.GA2979@infradead.org>
References: <149369628671.5146.4865312503373040039.stgit@noble>
 <877f1omcpo.fsf@notabene.neil.brown.name>
 <87shj05vft.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87shj05vft.fsf@notabene.neil.brown.name>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 16, 2017 at 03:54:30PM +1000, NeilBrown wrote:
> Hi Jens,
>  I didn't hear back ... have you had a chance to look?
>  In case it helps, you can pull the full set, based on a recent Linus tree,
>  from
>      git://neil.brown.name/linux bioset
> 
>  or I can resend the patches if you like.

Can yo uresend it on top of the latest for-4.13/block tree?  It has
a lot of changes that could potentially conflict.
