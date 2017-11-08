Return-Path: <BATV+a67e4e696b4474702002+5190+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 8 Nov 2017 01:47:30 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	dm-devel@redhat.com
Subject: Re: [PATCH] bio: have bio_kmap_irq return the size of mapped data
 (fwd)
Message-ID: <20171108094730.GA7074@infradead.org>
References: <alpine.LRH.2.02.1711071641090.1339@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.02.1711071641090.1339@file01.intranet.prod.int.rdu2.redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 07, 2017 at 04:45:17PM -0500, Mikulas Patocka wrote:
> Hi
> 
> I need the function bio_kmap_irq in the driver that I am developing, but 
> it doesn't return the size of the mapped data. I've made this patch to fix 
> it.

To be honest I think we should just remove bio_kmap_irq.  It is currently
unused and assumes there is only a single bvec to map.

I think you're much better off using a proper bvec iterator in your
caller and then call bvec_kmap_irq/bvec_kunmap_irq manually.
