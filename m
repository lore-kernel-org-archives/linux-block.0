Return-Path: <linux-block-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:46834 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbeHWEjL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Aug 2018 00:39:11 -0400
Message-ID: <f6f6d89ff6f73ccece3411615d1ef907e28e4b8d.camel@decadent.org.uk>
Subject: Re: blk-mq 5-8 times slower for bmap-tools
From: Ben Hutchings <ben@decadent.org.uk>
To: Ming Lei <ming.lei@redhat.com>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org
Date: Thu, 23 Aug 2018 01:51:05 +0100
In-Reply-To: <20180822220220.GA8846@ming.t460p>
References: <CAPybu_2k-0d=8NxL7kr757QcWOnXyU_TAyV7DMwiMrSDkiXfgA@mail.gmail.com>
         <CACVXFVNguNEJ_R7XXvC8dG_yu5tghQk+Hdg6Hp6KKr4Ys4EV_A@mail.gmail.com>
         <CAPybu_2ke4usj9Qwr9iSKTymAk1510pzZnZAgLemRB+cK4Se1A@mail.gmail.com>
         <20180820083032.GA24522@ming.t460p>
         <CAPybu_3QT_qTojTUXFhJFQKVsbhnWUmvyQ0zb5MwDJ5hsECf=A@mail.gmail.com>
         <526e40ca8f426252377be21f935ddcdec93cb197.camel@decadent.org.uk>
         <20180822220220.GA8846@ming.t460p>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-2kDsupvgDyCry3k7gMXy"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--=-2kDsupvgDyCry3k7gMXy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-08-23 at 06:02 +0800, Ming Lei wrote:
> On Wed, Aug 22, 2018 at 08:22:00PM +0100, Ben Hutchings wrote:
> > On Mon, 2018-08-20 at 11:04 +0200, Ricardo Ribalda Delgado wrote:
> > > Hello Ming
> > > On Mon, Aug 20, 2018 at 10:30 AM Ming Lei <ming.lei@redhat.com> wrote=
:
> >=20
> > [...]
> > > > One problem found from your iostat log is that looks there is ~30se=
c
> > > > idle period between IO activities when blk-mq is enabled.
> > >=20
> > > During all the test the LED on the device was blinking.
> > >=20
> > > But a closer look to dmesg reveals a lot of this messages:
> > >=20
> > > [  196.929811] sd 6:0:0:0: [sdb] tag#3 data cmplt err -71 uas-tag 1
> > > inflight: CMD
> > > [  196.929822] sd 6:0:0:0: [sdb] tag#3 CDB: Write(10) 2a 00 00 04 00
> > > 68 00 04 00 00
> > > [  227.764379] sd 6:0:0:0: [sdb] tag#4 uas_eh_abort_handler 0 uas-tag
> > > 2 inflight: CMD OUT
> > > [  227.764389] sd 6:0:0:0: [sdb] tag#4 CDB: Write(10) 2a 00 00 04 04
> > > 68 00 04 00 00
> > > [  227.766555] sd 6:0:0:0: [sdb] tag#3 uas_eh_abort_handler 0 uas-tag
> > > 1 inflight: CMD
> > > [  227.766562] sd 6:0:0:0: [sdb] tag#3 CDB: Write(10) 2a 00 00 04 00
> > > 68 00 04 00 00
> > > [  227.784312] scsi host6: uas_eh_device_reset_handler start
> > > [  227.913672] usb 2-2: reset SuperSpeed USB device number 3 using xh=
ci_hcd
> > > [  227.944842] scsi host6: uas_eh_device_reset_handler success
> > > [  231.416133] sd 6:0:0:0: [sdb] tag#1 data cmplt err -71 uas-tag 10
> > > inflight: CMD
> > > [  231.416147] sd 6:0:0:0: [sdb] tag#1 CDB: Write(10) 2a 00 00 06 d5
> > > e8 00 04 00 00
> > >=20
> > > And they take around 30 secons (227-196)
> > >=20
> > >=20
> > > Maybe this is a hw issue? I will bring the reader home tonight and se=
e
> > > if I can replicate the bug with my notebook
> > >=20
> > > >=20
> > > > Maybe it is related with timeout, given we had big change in v4.17 =
timeout code,
> > > > and we also fixed one scsi_mq timeout related issue recently, and t=
he patch[1] has
> > > > been merged to v4.18 release already.
> > >=20
> > > I tried with v4.18-rc4 (latest one packaged in debian experimental)
> > > and after 3 runs, 2 were fine (27 sec), but the last one was over a
> > > minute.
> >=20
> > Is it possible that this is fixed by "block: really disable runtime-pm
> > for blk-mq"?
> >=20
>=20
> As I mentioned, the similar issue can be triggered in both blk-mq and
> non-blk-mq, so it shouldn't be related with runtime PM.
>=20
> We need our UAS guys to take a look at this issue.

I saw that you found a problem with UAS in both modes, but Ricardo's
problem seemed to be specific to blk-mq.

Ben.

--=20
Ben Hutchings
Quantity is no substitute for quality, but it's the only one we've got.



--=-2kDsupvgDyCry3k7gMXy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlt+BPkACgkQ57/I7JWG
EQlK+hAAqc9DKs82tWhrjQCULO1/nd2qCb8gm1mSQqeMoopvBNZTFx+aVPzDg3JM
fuMXlA6mtrbg28pzSKGDC21gJML61KMRlKVmUbohbb4uY7IBm8HuHxugzE3v0bE3
DIE2UImuYyR0TYt6PffI38T5uvGEo4+lInoQZJyxHUHcAxkJKvi2YbT2fkApCvwO
Y7nQE3H8V9ChwTmj/ujFwHHuaNqTq/a7eoF9Nxkrq61TXE0D1gXdAyiMImBrqqkj
l3ngVHIkDLVJe100B2pZ8Cbfqy+8wtJZMwaJUgPIqNKnMRKRi1uL6lhZtcW0uGC/
gIN26hL1azWSZMGpiW4JxRjwESwAc5NVJhnsCnm0JVD49J+UUh5UycVI8O2dabcW
8JFsfLGIbQ932QuEwtgKZouqx+2X0Z3EKv2KVO6SeiDeLBWSUlrQnJHVB6NGkYB/
ISgWO543+dj2w8Drb7CrfuTcks+4bvHd2x72Bb1NrEg+QpwYF0RfXNznYw/5g9Jt
YCL8BUjPNz6gOoonzdktS3spGrGWiEkQRKiNfIBPZF5KsMdxM1IWeInn5YDILlJk
lpbHqmAWHUFMbCcxOxrulGYVtfFU6UZQozyFIWVFGex/QFfgNhXTUyMxVSJYzGqE
+sBD+HLFlt1gP5hd4fT0NfeEjtFFYWOodQh/bdAUNY/idD6QH2o=
=eyWr
-----END PGP SIGNATURE-----

--=-2kDsupvgDyCry3k7gMXy--
