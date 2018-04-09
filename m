Return-Path: <BATV+d9901c46b23ecc19815a+5342+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 9 Apr 2018 01:26:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
	"willy@infradead.org" <willy@infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"martin@lichtvoll.de" <martin@lichtvoll.de>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Block layer use of __GFP flags
Message-ID: <20180409082650.GA869@infradead.org>
References: <20180408065425.GD16007@bombadil.infradead.org>
 <aea2f6bcae3fe2b88e020d6a258706af1ce1a58b.camel@wdc.com>
 <20180408190825.GC5704@bombadil.infradead.org>
 <63d16891d115de25ac2776088571d7e90dab867a.camel@wdc.com>
 <20180409085349.31b10550@pentland.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180409085349.31b10550@pentland.suse.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 09, 2018 at 08:53:49AM +0200, Hannes Reinecke wrote:
> Why don't you fold the 'flags' argument into the 'gfp_flags', and drop
> the 'flags' argument completely?
> Looks a bit pointless to me, having two arguments denoting basically
> the same ...

Wrong way around.  gfp_flags doesn't really make much sense in this
context.  We just want the plain flags argument, including a non-block
flag for it.
