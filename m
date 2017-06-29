Return-Path: <jthumshirn@suse.de>
Date: Thu, 29 Jun 2017 16:13:20 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Omar Sandoval <osandov@osandov.com>,
	Linux Block Layer Mailinglist <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] tests: use nproc to get number of CPUs for fio
 jobs
Message-ID: <20170629141320.GQ3808@linux-x5ow.site>
References: <20170629114050.11733-1-jthumshirn@suse.de>
 <31774cc0-7aa5-7be0-eee4-ea466ac3fd1a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <31774cc0-7aa5-7be0-eee4-ea466ac3fd1a@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 29, 2017 at 08:08:32AM -0600, Jens Axboe wrote:
> For the other tests in your patch, the change looks fine. But I would
> greatly prefer if we just turned that into a
> 
> __run_fio_mix

Sounds reasonable. I'll prepare a v2

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
