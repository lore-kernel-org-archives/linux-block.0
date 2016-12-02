Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: blk-mq: preparation of the ground for BFQ inclusion
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <e2d7dff1-06fa-c510-4897-5c828c05c26b@kernel.dk>
Date: Fri, 2 Dec 2016 08:38:55 +0100
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Omar Sandoval <osandov@osandov.com>,
 Jan Kara <jack@suse.cz>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Message-Id: <308A0D96-4A0D-4751-AE6F-005A418DC899@linaro.org>
References: <347F26BB-2D0A-4DBE-9FC5-BA6C05AE02B2@linaro.org> <1b5b6b66-1561-0bf2-f543-15342b00e90f@kernel.dk> <4c23fa60-9ea4-8040-0a06-7f4c1baf3537@kernel.dk> <e2d7dff1-06fa-c510-4897-5c828c05c26b@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 02 dic 2016, alle ore 01:27, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 12/01/2016 02:03 PM, Jens Axboe wrote:
>> On 11/14/2016 03:42 PM, Jens Axboe wrote:
>>> On 11/14/2016 03:13 PM, Paolo Valente wrote:
>>>> Hi Jens,
>>>> have you had time to look into the first extensions/changes =
required?
>>>> Any time plan?
>>>=20
>>> I was busy last week on the writeback and on the polling. I should =
have
>>> something end this week.
>>=20
>> It's coming together, running some testing and fixing some issues. =
But I
>> now have unmodified legacy IO schedulers running under blk-mq, for
>> single queue devices. Scheduler queue depth is independent of the =
device
>> queue depth.
>=20
> Here is the branch, btw:
>=20
> =
http://git.kernel.dk/cgit/linux-block/log/?h=3Dfor-4.11/blk-mq-legacy-sche=
d
>=20
> if you want to look at it or test it. It's not in a clean state, I
> wanted to get this reasonably working before cleaning it up. Should be
> ready for testing, I've successfully run various IO tests on deadline
> and CFQ with null_blk loaded with queue_mode=3D2 submit_queues=3D1
> use_sched=3D1.
>=20

Good news!

I'm familiarizing with your patch.  To avoid useless, too-early report,
tell me if/when I can start doing some test too.

Thanks,
Paolo

> --=20
> Jens Axboe
>=20
