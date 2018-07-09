Return-Path: <hare@suse.de>
Subject: Re: [PATCH] block/DAC960.c: fix defined but not used build warnings
To: Randy Dunlap <rdunlap@infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 axboe <axboe@kernel.dk>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <880681dd-f72f-6687-d2cc-59116acd5216@infradead.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <614c54d4-0d38-26e3-5dc1-6c66e2c67f7b@suse.de>
Date: Mon, 9 Jul 2018 08:07:37 +0200
MIME-Version: 1.0
In-Reply-To: <880681dd-f72f-6687-d2cc-59116acd5216@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/07/2018 05:49 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build warnings in DAC960.c when CONFIG_PROC_FS is not enabled
> by marking the unused functions as __maybe_unused.
> 
> ../drivers/block/DAC960.c:6429:12: warning: 'dac960_proc_show' defined but not used [-Wunused-function]
> ../drivers/block/DAC960.c:6449:12: warning: 'dac960_initial_status_proc_show' defined but not used [-Wunused-function]
> ../drivers/block/DAC960.c:6456:12: warning: 'dac960_current_status_proc_show' defined but not used [-Wunused-function]
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> ---
>  drivers/block/DAC960.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Guess it's about time to resubmit my DAC960 rewrite.
Hope it get it done sometimes this week.

Cheers

Hannes

-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
