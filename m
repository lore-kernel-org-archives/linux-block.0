Return-Path: <jthumshirn@suse.de>
Date: Thu, 13 Jul 2017 12:11:54 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Alex Ivanov <yourbestfriend@openmailbox.org>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] elevator: allow specifying elevator by config boot param
 for blk-mq devices
Message-ID: <20170713101154.GH5212@linux-x5ow.site>
References: <20170712185708.5987-1-yourbestfriend@openmailbox.org>
 <0661f4cc-a5dc-5747-dd38-de78586843a2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <0661f4cc-a5dc-5747-dd38-de78586843a2@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 12, 2017 at 04:51:33PM -0600, Jens Axboe wrote:
> No, that boot option was a mistake, let's not propagate that to mq
> scheduling as well.

Can you please explain why? I as well have requests from our users to
select the mq schedulers on the command line.

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
