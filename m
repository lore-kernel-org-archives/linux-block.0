Return-Path: <axboe@kernel.dk>
Subject: Re: [RFC] block: deprecate choosing elevator via boot param
To: Oleksandr Natalenko <oleksandr@redhat.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20170814092712.14062-1-oleksandr@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3efb4cb6-a545-9e1e-8c6e-c2faee7dd8f4@kernel.dk>
Date: Wed, 30 Aug 2017 08:24:28 -0600
MIME-Version: 1.0
In-Reply-To: <20170814092712.14062-1-oleksandr@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/14/2017 03:27 AM, Oleksandr Natalenko wrote:
> Setting I/O scheduler via kernel command line is not flexible enough
> anymore. Different schedulers might be desirable for different types
> of devices (SSDs and HDDs, for instance). Moreover, setting elevator
> while using blk-mq framework does not work in this way already.
> 
> This commit enables warning if user specifies "elevator" boot param.
> Removing this option at all might be considered in some future.

Not a huge fan of doing it like this, it'll just add a bunch of noise to
the dmesg output that people will ignore. It doesn't bring us closer to
being able to remove the option.

I think we should just let it die over time. This will happen naturally
since the blk-mq scheduling framework does not support it. Once we have
everything converted, the option will end up doing nothing. Then we can
eventually kill it.

-- 
Jens Axboe
