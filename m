Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] bsg: use pr_debug instead of hand craftet macros
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "jthumshirn@suse.de" <jthumshirn@suse.de>
Cc: "joe@perches.com" <joe@perches.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20180123105538.24860-1-jthumshirn@suse.de>
 <1516811073.3873.0.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3f0260d5-078e-7983-d226-4bf79fb0030d@kernel.dk>
Date: Wed, 24 Jan 2018 09:52:25 -0700
MIME-Version: 1.0
In-Reply-To: <1516811073.3873.0.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/24/18 9:24 AM, Bart Van Assche wrote:
> On Tue, 2018-01-23 at 11:55 +0100, Johannes Thumshirn wrote:
>> Use pr_debug instead of hand craftet macros. This way it is not needed to
>> re-compile the kernel to enable bsg debug outputs and it's possible to
>> selectively enable specific prints.
> 
> Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>

Added, thanks Johannes.

-- 
Jens Axboe
