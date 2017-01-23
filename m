Return-Path: <jthumshirn@suse.de>
Date: Mon, 23 Jan 2017 10:16:10 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/5] blk-throttle: Move an assignment for the variable
 "ret" in tg_set_conf()
Message-ID: <20170123091610.GB3517@linux-x5ow.site>
References: <e734cafa-eec0-9d5b-b368-2de496a96c80@users.sourceforge.net>
 <d20da6bc-b84a-3b2c-614c-68ace67db7e0@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <d20da6bc-b84a-3b2c-614c-68ace67db7e0@users.sourceforge.net>
List-ID: <linux-block@vger.kernel.org>

On Sun, Jan 22, 2017 at 09:32:19AM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 21 Jan 2017 21:40:38 +0100
> 
> A local variable was set to an error code before a concrete error situation
> was detected. Thus move the corresponding assignment into an if branch
> to indicate a software failure there.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

See my answer to the last patch.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
