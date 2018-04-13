Return-Path: <jthumshirn@suse.de>
Message-ID: <1523608284.7787.3.camel@suse.de>
Subject: Re: [PATCH v2] block: do not use interruptible wait anywhere
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Alan Jenkins <alan.christopher.jenkins@gmail.com>, Jens Axboe
	 <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Fri, 13 Apr 2018 10:31:24 +0200
In-Reply-To: <20180412181158.8884-1-alan.christopher.jenkins@gmail.com>
References: <13e67e1243ebd96f3f56a150d47444ada47ebde0.camel@wdc.com>
	 <20180412181158.8884-1-alan.christopher.jenkins@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Hi Alan,

On Thu, 2018-04-12 at 19:11 +0100, Alan Jenkins wrote:
> # dd if=/dev/sda of=/dev/null iflag=direct & \
>   while killall -SIGUSR1 dd; do sleep 0.1; done & \
>   echo mem > /sys/power/state ; \
>   sleep 5; killall dd  # stop after 5 seconds

Can you please also add a regression test to blktests[1] for this?

[1] https://github.com/osandov/blktests

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
