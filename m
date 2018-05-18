Return-Path: <jthumshirn@suse.de>
Date: Fri, 18 May 2018 10:23:38 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 02/10] block: Convert bio_set to mempool_init()
Message-ID: <20180518082338.kh2gqck2zvqf7fjs@linux-x5ow.site>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-4-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180518074918.13816-4-kent.overstreet@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 18, 2018 at 03:49:01AM -0400, Kent Overstreet wrote:
> Minor performance improvement by getting rid of pointer indirections
> from allocation/freeing fastpaths.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

Although I'd prefer numbers in the changelog when claiming a
performance improvement.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
