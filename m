Return-Path: <jthumshirn@suse.de>
Subject: Re: [PATCH 17/17] null_blk: remove legacy IO path
To: Dongli Zhang <dongli.zhang@oracle.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20181011165909.32615-1-axboe@kernel.dk>
 <20181011165909.32615-18-axboe@kernel.dk>
 <b60e8ad5-3af7-766a-c3c2-b35b0d5fd779@oracle.com>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <477afa55-24b3-b0ac-0f69-0ebe74beb11c@suse.de>
Date: Fri, 12 Oct 2018 10:51:32 +0200
MIME-Version: 1.0
In-Reply-To: <b60e8ad5-3af7-766a-c3c2-b35b0d5fd779@oracle.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/10/18 08:56, Dongli Zhang wrote:
> Hi Jens,
> 
> Will the legacy path be fully deprecated?
> 
> In addition to performance measurement, null_blk is a very good tutorial for
> beginners to understand how to implement a legacy path based block driver from
> scratch. Unless legacy path is not used any longer, why not keep it in the code
> as a tutorial?

But when there is no tutorial on how to write drivers for the legacy
path no one will write drivers for the legacy path and will be upset
when we remove it.

	Johannes

-- 
Johannes Thumshirn                                        SUSE Labs
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
