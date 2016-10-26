Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra
 scheduler
To: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
 <20161026113443.GA13587@quack2.suse.cz>
 <4ed3e291-b3e5-5ee3-6838-58644bd3d99b@sandisk.com>
 <12386463.fJy0cVexVD@wuerfel> <20161026152955.GA21262@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, Jan Kara <jack@suse.cz>,
 Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, linus.walleij@linaro.org, broonie@kernel.org,
 hare@suse.de, grant.likely@secretlab.ca,
 James.Bottomley@hansenpartnership.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3ebadbb8-9ac2-851a-66f9-c9db25713695@kernel.dk>
Date: Wed, 26 Oct 2016 09:32:36 -0600
MIME-Version: 1.0
In-Reply-To: <20161026152955.GA21262@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/26/2016 09:29 AM, Christoph Hellwig wrote:
> On Wed, Oct 26, 2016 at 05:13:07PM +0200, Arnd Bergmann wrote:
>> The question to ask first is whether to actually have pluggable
>> schedulers on blk-mq at all, or just have one that is meant to
>> do the right thing in every case (and possibly can be bypassed
>> completely).
>
> That would be my preference.  Have a BFQ-variant for blk-mq as an
> option (default to off unless opted in by the driver or user), and
> not other scheduler for blk-mq.  Don't bother with bfq for non
> blk-mq.  It's not like there is any advantage in the legacy-request
> device even for slow devices, except for the option of having I/O
> scheduling.

It's the only right way forward. blk-mq might not offer any substantial
advantages to rotating storage, but with scheduling, it won't offer a
downside either. And it'll take us towards the real goal, which is to
have just one IO path. Adding a new scheduler for the legacy IO path
makes no sense. Adding one for blk-mq and phasing out the old path is
what we need to do.

-- 
Jens Axboe
