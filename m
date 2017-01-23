Return-Path: <jthumshirn@suse.de>
Date: Mon, 23 Jan 2017 10:20:17 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/5] blk-throttle: Adjust two function calls together
 with a variable assignment
Message-ID: <20170123091821.GC3517@linux-x5ow.site>
References: <e734cafa-eec0-9d5b-b368-2de496a96c80@users.sourceforge.net>
 <7d68f93d-c14c-60aa-2b02-5005a0a62cad@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <7d68f93d-c14c-60aa-2b02-5005a0a62cad@users.sourceforge.net>
List-ID: <linux-block@vger.kernel.org>

On Sun, Jan 22, 2017 at 09:33:08AM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 21 Jan 2017 22:15:33 +0100
> 
> The script "checkpatch.pl" pointed information out like the following.
> 
> ERROR: do not use assignment in if condition
> 
> Thus fix the affected source code places.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
if Jens wants doesn't mind.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
