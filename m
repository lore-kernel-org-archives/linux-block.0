Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra
 scheduler
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
 <20161026101903.GA22361@infradead.org>
 <20161026113443.GA13587@quack2.suse.cz>
CC: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
	<linus.walleij@linaro.org>, <broonie@kernel.org>, <hare@suse.de>,
	<arnd@arndb.de>, <bart.vanassche@sandisk.com>, <grant.likely@secretlab.ca>,
	<James.Bottomley@HansenPartnership.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <4ed3e291-b3e5-5ee3-6838-58644bd3d99b@sandisk.com>
Date: Wed, 26 Oct 2016 08:05:11 -0700
MIME-Version: 1.0
In-Reply-To: <20161026113443.GA13587@quack2.suse.cz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 10/26/2016 04:34 AM, Jan Kara wrote:
> On Wed 26-10-16 03:19:03, Christoph Hellwig wrote:
>> Just as last time:
>>
>> big NAK for introducing giant new infrastructure like a new I/O scheduler
>> for the legacy request structure.
>>
>> Please direct your engergy towards blk-mq instead.
>
> Christoph, we will probably talk about this next week but IMO rotating
> disks and SATA based SSDs are going to stay with us for another 15 years,
> likely more. For them blk-mq is no win, relatively complex IO scheduling
> like CFQ or BFQ does is a big win for them in some cases. So I think IO
> scheduling (and thus place for something like BFQ) is going to stay with us
> for quite a long time still. So are we going to add hooks in blk-mq to
> support full-blown IO scheduling at least for single queue devices? Or how
> else do we want to support that HW?

Hello Jan,

Having two versions (one for non-blk-mq, one for blk-mq) of every I/O 
scheduler would be a maintenance nightmare. Has anyone already analyzed 
whether it would be possible to come up with an API for I/O schedulers 
that makes it possible to use the same I/O scheduler for both blk-mq and 
the traditional block layer?

Bart.
