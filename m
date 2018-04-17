Return-Path: <m.tretter@pengutronix.de>
Date: Tue, 17 Apr 2018 11:15:43 +0200
From: Michael Tretter <m.tretter@pengutronix.de>
To: Josef Bacik <jbacik@fb.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
 <axboe@kernel.dk>, "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] nbd: do not update block size if file system is mounted
Message-ID: <20180417111543.65a4617b@litschi.hi.pengutronix.de>
In-Reply-To: <3A32B506-71AE-48AF-A44A-B60F054ED40D@fb.com>
References: <20180228095456.31472-1-m.tretter@pengutronix.de>
 <20180315110057.13eecda6@litschi.hi.pengutronix.de>
 <6c862ddf-b352-6ef4-06f8-516680e9f19f@kernel.dk>
 <20180413162518.47840e6f@litschi.hi.pengutronix.de>
 <3A32B506-71AE-48AF-A44A-B60F054ED40D@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hi Josef,

On Sat, 14 Apr 2018 01:10:27 +0000, Josef Bacik wrote:
> Yeah sorry I screwed that up again.  I=E2=80=99m wondering if we can just
> drop this altogether and leave the zero setting in the config put
> that we already have.

I'm not sure if I understand you correctly. The nbd_config_put()
function does not touch the bdev at all. How should config put take
care of setting the size to 0?

Dropping the bd_set_size to 0 from nbd_start_device_ioctl should be
fine, because usually reset takes care of that. However, if there is
an opener during nbd_bdev_reset(), the size won't be changed to 0
either. This would still be the same behavior as with my patch.

Michael


> Does doing that fix it for you?  Thanks,
>=20
> Josef
>=20
> Sent from my iPhone
>=20
> > On Apr 13, 2018, at 10:26 AM, Michael Tretter
> > <m.tretter@pengutronix.de> wrote:=20
> >> On Fri, 16 Mar 2018 09:36:45 -0700, Jens Axboe wrote: =20
> >>> On 3/15/18 3:00 AM, Michael Tretter wrote: =20
> >>>> On Wed, 28 Feb 2018 10:54:56 +0100, Michael Tretter wrote: =20
> >>>> If a file system is mounted on the nbd during a disconnect,
> >>>> resetting the size to 0, might change the block size and destroy
> >>>> the buffer_head mappings. This will cause a infinite loop when
> >>>> the file system looks for the buffer_heads for flushing.
> >>>>=20
> >>>> Only set the file size to 0, if we are the only opener of the
> >>>> nbd.
> >>>>=20
> >>>> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> >>>> ---
> >>>> drivers/block/nbd.c | 3 ++-
> >>>> 1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>=20
> >>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> >>>> index 5f2a4240a204..0d1dbb60430b 100644
> >>>> --- a/drivers/block/nbd.c
> >>>> +++ b/drivers/block/nbd.c
> >>>> @@ -1118,7 +1118,8 @@ static int nbd_start_device_ioctl(struct
> >>>> nbd_device *nbd, struct block_device *b if (ret)
> >>>>        sock_shutdown(nbd);
> >>>>    mutex_lock(&nbd->config_lock);
> >>>> -    bd_set_size(bdev, 0);
> >>>> +    if (bdev->bd_openers <=3D 1)
> >>>> +        bd_set_size(bdev, 0);
> >>>>    /* user requested, ignore socket errors */
> >>>>    if (test_bit(NBD_DISCONNECT_REQUESTED,
> >>>> &config->runtime_flags)) ret =3D 0;   =20
> >>>=20
> >>> Are there any comments on this patch?   =20
> >>=20
> >> Josef?
> >>  =20
> >=20
> > Maybe some history helps for reviewing the patch:
> >=20
> > Commit abbbdf12497d ("nbd: replace kill_bdev() with
> > __invalidate_device()") already fixed this issue once by changing
> > nbd_size_clear() to only set the size to 0 if the device is only
> > opened once. The line was moved several times during the rework for
> > the netlink interface and the check for the number of openers was
> > dropped, reintroducing the issue.
> >=20
> > Michael =20
