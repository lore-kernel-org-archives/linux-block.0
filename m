Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <adfd57be-1e12-e900-6a78-3e9607017a10@kernel.dk>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
 <20161026113443.GA13587@quack2.suse.cz> <4ed3e291-b3e5-5ee3-6838-58644bd3d99b@sandisk.com>
 <12386463.fJy0cVexVD@wuerfel> <20161026152955.GA21262@infradead.org>
 <3ebadbb8-9ac2-851a-66f9-c9db25713695@kernel.dk> <38156FA7-9A66-44DC-8D0C-28F149D1E49B@linaro.org>
 <09fc1e06-3fd6-b13d-0dd9-0edfb55b01d1@kernel.dk> <CAPDyKFrCNS_ZWzVU9Y=J9q0ewp-7=VFs4LwV69SzgSGHBxTn-g@mail.gmail.com>
 <15ee2d0e-2d3a-81e2-9f83-f875e41bf388@kernel.dk> <CAPDyKFoi64Q0H9x2F35oY85PMDNq4hRsmqGYiP+En+qtQ4+Bag@mail.gmail.com>
 <1ac9b794-7e7f-0748-e4c8-a13034aecbc3@kernel.dk> <CAPDyKFpLhp0eoS8LWy-jU0_U_cWq4immq2+bPdi-j7=oa24OjA@mail.gmail.com>
 <e792e932-cf16-4272-2388-ae813a0372b6@kernel.dk> <CACRpkdbngAKuwDaUwZ=QaW9POb4U2tFJA60aLKD6QZKf60bq6g@mail.gmail.com>
 <CACRpkda0fmPdM2WZ_gtW=T7xvMfP_4ErtNZseExN2AggzZbcDQ@mail.gmail.com> <adfd57be-1e12-e900-6a78-3e9607017a10@kernel.dk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Oct 2016 22:38:36 +0200
Message-ID: <CACRpkdYNfOzfnA-9a87PzSiA_YkLv4fq9y2cCtCZDK7CScEnFw@mail.gmail.com>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra scheduler
To: Jens Axboe <axboe@kernel.dk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Paolo Valente <paolo.valente@linaro.org>,
	Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
	Bart Van Assche <bart.vanassche@sandisk.com>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
	linux-block@vger.kernel.org, Linux-Kernal <linux-kernel@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 28, 2016 at 4:22 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 10/28/2016 03:32 AM, Linus Walleij wrote:
>>
>> This is without using Bartlomiej's clever hack to pretend we have
>> 2 elements in the HW queue though. His early tests indicate that
>> it doesn't help much: the performance regression we see is due to
>> lack of block scheduling.
>
> A simple dd test, I don't see how that can be slower due to lack of
> scheduling. There's nothing to schedule there, just issue them in order?

Yeah I guess you're right, I guess it could be in part to not having
activated front- and back-end merges properly as Christoph pointed
out, I'll look closer at this.

> So that would probably be where I would start looking. A blktrace of the
> in-kernel code and the blk-mq enabled code would perhaps be
> enlightening. I don't think it's worth looking at the more complex test
> cases until the dd test case is at least as fast as the non-mq version.

Yeah.

> Was that with CFQ, btw, or what scheduler did it run?

CFQ, just plain defconfig.

> It'd be nice to NOT have to rely on that fake QD=2 setup, since it will
> mess with the IO scheduling as well.

I agree.

>> I try to find a way forward with this, and also massage the MMC/SD
>> code to be more MQ friendly to begin with (like only pick requests
>> when we get a request notification and stop pulling NULL requests
>> off the queue) but it's really a messy piece of code.
>
> Yeah, it does look pretty messy... I'd be happy to help out with that,
> and particularly in figuring out why the direct conversion is slower for
> a basic 'dd' test case.

I'm looking into it.

Yours,
Linus Walleij
