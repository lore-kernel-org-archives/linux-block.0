Return-Path: <ps@pks.im>
Date: Mon, 16 Jul 2018 17:11:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Message-ID: <20180716151153.GC1787@ncase.pks.im>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
 <CACVXFVPoO7kcEnUVmqGVWDgiTVYup2sD9puBZ8FzY+mDaMp-bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
In-Reply-To: <CACVXFVPoO7kcEnUVmqGVWDgiTVYup2sD9puBZ8FzY+mDaMp-bQ@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>


--ieNMXl1Fr3cevapt
Content-Type: multipart/mixed; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 13, 2018 at 09:41:41PM +0800, Ming Lei wrote:
> On Fri, Jul 13, 2018 at 9:29 PM, Patrick Steinhardt <ps@pks.im> wrote:
> > When power management for SCSI is enabled and if a device uses blk-mq,
> > it is possible to trigger a `NULL` pointer exception when resuming that
> > device. The NPE is triggered when trying to dereference the `request_fn`
> > function pointer of the device's `request_queue`:
> >
> >     __blk_run_queue_uncond:470
> >     __blk_run_queue:490
> >     blk_post_runtime_resume:3889
> >     sdev_runtime_resume:263
> >     scsi_runtime_resume:275
> >
> > When the SCSI device is being allocated by `scsi_alloc_sdev`, the
> > device's request queue will either be initialized via
> > `scsi_mq_alloc_queue` or `scsi_old_alloc_queue`. But the `request_fn`
> > member of the request queue is in fact only being set in
> > `scsi_old_alloc_queue`, which will then later cause the mentioned NPE.
> >
> > Fix the issue by checking whether the `request_fn` is set in
> > `__blk_run_queue_uncond`. In case it is unset, we'll silently return and
> > not try to invoke the callback, thus fixing the NPE.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >
> > Since at least v4.14, I am easily able to trigger above NPE by
> > unplugging USB mass storage devices on my computer (Skylake, ASUS
> > Z170I) with CONFIG_SCSI_MQ_DEFAULT=3Dy. The attached patch fixes
> > the issue, but keep in mind that this is my first patch, so the
> > proposed fix may not be appropriate at all. Feedback would be
> > highly appreciated.
> >
> >  block/blk-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index f84a9b7b6f5a..0a2041660cd9 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -456,7 +456,7 @@ inline void __blk_run_queue_uncond(struct request_q=
ueue *q)
> >         lockdep_assert_held(q->queue_lock);
> >         WARN_ON_ONCE(q->mq_ops);
> >
> > -       if (unlikely(blk_queue_dead(q)))
> > +       if (unlikely(!q->request_fn) || unlikely(blk_queue_dead(q)))
> >                 return;
> >
>=20
> Now runtime PM is disabled for blk-mq/scsi_mq, not sure how this issue is
> triggered on your machine.
>=20
> Could you share the steps for reproducing this issue?

I bet that the issue stems from custom hotplugging scripts then,
which change the value of power/control. See the attachment of
this mail for all sysfs changes that are being performed after
plugging in the USB stick. Basically, the reproduction steps on
my machine are:

1. plug in USB stick (assumed to be /dev/sdb now)
2. wait a short amount of time
3. dd if=3D/dev/sdb of=3D/dev/null bs=3D4M
4. wait a short amount of time
5. unplug the USB stick, which immediately crashes the system

The issue isn't always reproducible, I think there is some
variance depending on how much time passes by at step 2 and/or 4.
It probably is related to the autosuspend delay. From my
experience the crash becomes more likely the longer I wait after
step 4.

Regards
Patrick

--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sysfs.log"

/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/power/autosuspend_delay_ms -> 60000
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/power/control -> auto
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/power/control -> on
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/power/autosuspend_delay_ms -> 60000
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/power/control -> auto
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/scsi_host/host4/power/autosuspend_delay_ms -> 60000
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/scsi_host/host4/power/control -> auto
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/target4:0:0/4:0:0:0/power/autosuspend_delay_ms -> 60000
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/target4:0:0/4:0:0:0/scsi_device/4:0:0:0/power/autosuspend_delay_ms -> 60000
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/target4:0:0/4:0:0:0/bsg/4:0:0:0/power/autosuspend_delay_ms -> 60000
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/target4:0:0/4:0:0:0/power/control -> auto
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/target4:0:0/4:0:0:0/scsi_device/4:0:0:0/power/control -> auto
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/target4:0:0/4:0:0:0/bsg/4:0:0:0/power/control -> auto
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/target4:0:0/power/autosuspend_delay_ms -> 60000
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/target4:0:0/power/control -> auto
/sys//devices/virtual/bdi/8:16/power/autosuspend_delay_ms -> 60000
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/target4:0:0/4:0:0:0/scsi_disk/4:0:0:0/power/autosuspend_delay_ms -> 60000
/sys//devices/virtual/bdi/8:16/power/control -> auto
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/target4:0:0/4:0:0:0/scsi_disk/4:0:0:0/power/control -> auto
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/target4:0:0/4:0:0:0/block/sdb/power/autosuspend_delay_ms -> 60000
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/target4:0:0/4:0:0:0/block/sdb/sdb2/power/autosuspend_delay_ms -> 60000
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/target4:0:0/4:0:0:0/block/sdb/power/control -> auto
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/target4:0:0/4:0:0:0/block/sdb/sdb2/power/control -> auto
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/target4:0:0/4:0:0:0/block/sdb/sdb1/power/autosuspend_delay_ms -> 60000
/sys//devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/host4/target4:0:0/4:0:0:0/block/sdb/sdb1/power/control -> auto

--CblX+4bnyfN0pR09--

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAltMtbkACgkQEXxntp6r
8SzTZw//eymI5QedFIbDBoPdIVsnBJJSdodpu/pMjHcOXIvaPoBAM0ma6V49YRtG
slcAs69j6EA8zbpqwJTwJ6tKKaZSJW9m7BuYowvqtbbkHwDfbwmZWQi8ZwI+LisU
dLHJyrR5cbPCF5it2VcBj0qI2nCmFA44jN5wu2AuUFLTwN7/N48lX57ghRajnOV/
mbqYTrqU4IH9IveNXcJ/knkIrIBzXv630ujML28uuvU8nzCOIyeJ1Um1RNWR3HK4
1yDJE2l3gUwNPFCQdm9Rj7/aRDMZUmDZl9VeAMDRR3EjHbP1yO4Fow6k2xTKH/l9
KYXeBRkuRx8MQZElsEKJ45JknM9oWKpg9AqdFqa8hEPjmqx3MpmDNW3JPKz3k8nK
4tdLVeM+URDwItfqI+WaRpBO66T268huSNgRdd5uROWro2GY0Hoy7hEx57JY6Rb1
n1MEs0rN304iOVO7lhWrY7LUB+6XcP1QXOSYMGwv7/aahNO1aN2QRG923qViDcnY
VpRFZqNIqvchQJhEHYsver5LqmzJ5pOvM9An0Feq3v7clJRknmBo6aXlh21W/1lA
H3oFOKT6CTHHHejfB1g5UUjibPUm6kYCse43qMNHusgW0T1XxvgqeT5+YKCyIkfo
v9xyM8wgaqZGJcpUjP+6RTKdMwve2zSHE2cHCFHWmspYuqZ7cdQ=
=DaPo
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--
