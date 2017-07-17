Return-Path: <jthumshirn@suse.de>
Date: Mon, 17 Jul 2017 08:55:05 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Alex Ivanov <yourbestfriend@openmailbox.org>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] elevator: allow specifying elevator by config boot param
 for blk-mq devices
Message-ID: <20170717065505.GB3526@linux-x5ow.site>
References: <20170712185708.5987-1-yourbestfriend@openmailbox.org>
 <0661f4cc-a5dc-5747-dd38-de78586843a2@kernel.dk>
 <20170713101154.GH5212@linux-x5ow.site>
 <49033d7d-8941-3c17-962f-dab170401bcf@kernel.dk>
 <20170714064026.GB3484@linux-x5ow.site>
 <8080a6a6-ccc5-95d8-031b-01a156b2cd65@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <8080a6a6-ccc5-95d8-031b-01a156b2cd65@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 14, 2017 at 08:26:52AM -0600, Jens Axboe wrote:
 
> Maybe we can add something about the API being deprecated, if someone
> tries to select an mq scheduler. The old scheduler will die in due
> course once that path goes away, and once that happens, we can kill
> the parameter.

Yes this sounds like a good idea.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
