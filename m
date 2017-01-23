Return-Path: <jthumshirn@suse.de>
Date: Mon, 23 Jan 2017 10:21:24 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 5/5] cfq-iosched: Adjust one function call together with
 a variable assignment
Message-ID: <20170123092124.GD3517@linux-x5ow.site>
References: <e734cafa-eec0-9d5b-b368-2de496a96c80@users.sourceforge.net>
 <f28c7ce0-ae89-4eb5-8270-4ab300caa98b@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <f28c7ce0-ae89-4eb5-8270-4ab300caa98b@users.sourceforge.net>
List-ID: <linux-block@vger.kernel.org>

On Sun, Jan 22, 2017 at 09:35:13AM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 21 Jan 2017 22:44:07 +0100
> 
> The script "checkpatch.pl" pointed information out like the following.
> 
> ERROR: do not use assignment in if condition
> 
> Thus fix the affected source code place.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
