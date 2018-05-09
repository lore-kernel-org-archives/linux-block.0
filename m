Return-Path: <jthumshirn@suse.de>
Date: Wed, 9 May 2018 09:54:07 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 01/10] mempool: Add mempool_init()/mempool_exit()
Message-ID: <20180509075407.oz7l6gkolepciudx@linux-x5ow.site>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
 <20180509013358.16399-2-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180509013358.16399-2-kent.overstreet@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 08, 2018 at 09:33:49PM -0400, Kent Overstreet wrote:
> +/**
> + * mempool_destroy - exit a mempool initialized with mempool_init()

^ mempool_exit()

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
