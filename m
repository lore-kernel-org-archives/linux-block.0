Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: high overhead of functions blkg_*stats_* in bfq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20171106163040.GC3252168@devbig577.frc2.facebook.com>
Date: Mon, 6 Nov 2017 17:33:45 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 Luca Miccio <lucmiccio@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 dhowells@redhat.com,
 hpa@zytor.com,
 akinobu.mita@gmail.com
Message-Id: <6BC5F831-9777-47A9-A141-B03453F7AF46@linaro.org>
References: <20171018131918.GB1302522@devbig577.frc2.facebook.com> <76CAD24C-BE7A-4AE0-A207-0FDD0E6506DD@linaro.org> <83aaaeb1-2e04-33ed-193a-7d36024fc9dd@kernel.dk> <20171106150002.GY3252168@devbig577.frc2.facebook.com> <A9703041-F28C-4068-81AB-4CE36D806716@linaro.org> <CDDD839D-93E8-4D63-9456-1AEAF101651B@linaro.org> <01f923d7-f263-0664-e214-3d37c63dbfaa@kernel.dk> <C223E9AE-BE2D-4603-86BC-E72097DCD6D5@linaro.org> <f9483b0c-e1b2-9ed4-f217-01568d1aaa7e@kernel.dk> <A4406E55-0956-4A8C-B14D-B95E8743D399@linaro.org> <20171106163040.GC3252168@devbig577.frc2.facebook.com>
To: Tejun Heo <tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 06 nov 2017, alle ore 17:30, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello,
>=20
> On Mon, Nov 06, 2017 at 05:26:38PM +0100, Paolo Valente wrote:
>> Yes.  DEBUG_BLK_CGROUP will just serve to keep the for-debugging
>> subset switched off even when the dynamic parameter is on.
>>=20
>> We'll wait for possible counter-arguments from Tejun, and then start
>> to work on what you propose.
>=20
> So, I think the only *really* required ones are io_serviced and the
> corresponding byte counts, which are tracked by blk-cgroup core
> anyway.  Everything else can be hidden behind an obviously debug boot
> param, say, bfq.__DEBUG__extra_stats or whatever.
>=20

ok, can we change it, or do you want us to change it, for cfq too?

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun
