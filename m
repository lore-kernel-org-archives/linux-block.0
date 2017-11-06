Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: high overhead of functions blkg_*stats_* in bfq 
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <A9703041-F28C-4068-81AB-4CE36D806716@linaro.org>
Date: Mon, 6 Nov 2017 17:11:44 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 Luca Miccio <lucmiccio@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 dhowells@redhat.com,
 hpa@zytor.com,
 akinobu.mita@gmail.com
Message-Id: <CDDD839D-93E8-4D63-9456-1AEAF101651B@linaro.org>
References: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org> <20171018131918.GB1302522@devbig577.frc2.facebook.com> <76CAD24C-BE7A-4AE0-A207-0FDD0E6506DD@linaro.org> <83aaaeb1-2e04-33ed-193a-7d36024fc9dd@kernel.dk> <20171106150002.GY3252168@devbig577.frc2.facebook.com> <A9703041-F28C-4068-81AB-4CE36D806716@linaro.org>
To: Tejun Heo <tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 06 nov 2017, alle ore 16:47, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>>=20
>> Il giorno 06 nov 2017, alle ore 16:00, Tejun Heo <tj@kernel.org> ha =
scritto:
>>=20
>> Hello,
>>=20
>> On Sun, Nov 05, 2017 at 07:21:01PM -0700, Jens Axboe wrote:
>>> It's pointless to give up on this so soon, when no effort has =
apparently
>>> been dedicated to figuring out what the actual issue is yet. So no, =
no
>>> patch that will just disable the stats is going to be accepted.
>>>=20
>>> That said, I have no idea who uses these stats. Surely someone can
>>> answer that question. Tejun?
>>=20
>> Except for the basic bytes / ios counts, it's all debug fluff, which
>> should have been hidden behind a debug boot param or go under =
debugfs.
>> I'm not sure we can get rid of them at this point for cfq but I don't
>> see why we'd have them for bfq.
>>=20
>=20
> Ok, then I think this is the right time to ask you what I can throw
> way for bfq.  According to your documentation, basic non-debug stats
> should be:
>=20
> blkio.time
> blkio.time_recursive
> blkio.sectors
> blkio.io_service_bytes
> blkio.io_service_bytes_recursive
> blkio.io_serviced
> blkio.io_serviced_recursive
> blkio.io_service_time
> blkio.io_service_time_recursive
> blkio.io_wait_time
> blkio.io_wait_time_recursive
> blkio.io_merged
> blkio.io_merged_recursive
> blkio.io_queued
> blkio.io_queued_recursive
>=20
> So, I have to keep them in bfq, right?  Or is there something I can
> remove for bfq, in your opinion?  Of course, I would be very happy to =
remove stuff!
>=20

Or, more mildly, could some of these stats be moved behind
CONFIG_DEBUG_BLK_CGROUP?

Thanks,
Paolo

> On the other end, here are the debugging stats I have borrowed
> from cfq:
>=20
> blkio.avg_queue_size
> blkio.dequeue
> blkio.empty_time
> blkio.group_wait_time
> blkio.idle_time
> blkio.io_wait_time
> blkio.io_wait_time_recursive
>=20
> These will be hidden behind the CONFIG_DEBUG_BLK_CGROUP option by one =
of the patches we are about to submit. Or do you want me to remove these =
debugging stats completely? ok for me, just, if these parameters are =
removed, then I guess the documentation of cgroups-v1 will have to be =
somehow updated once the interface of bfq and cfq is unified.
>=20
> Thanks,
> Paolo
>=20
>> Thanks.
>>=20
>> --=20
>> tejun
