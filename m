Return-Path: <linux-block-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45929 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727844AbeHVWsV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Aug 2018 18:48:21 -0400
Message-ID: <526e40ca8f426252377be21f935ddcdec93cb197.camel@decadent.org.uk>
Subject: Re: blk-mq 5-8 times slower for bmap-tools
From: Ben Hutchings <ben@decadent.org.uk>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        ming.lei@redhat.com
Cc: Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org
Date: Wed, 22 Aug 2018 20:22:00 +0100
In-Reply-To: <CAPybu_3QT_qTojTUXFhJFQKVsbhnWUmvyQ0zb5MwDJ5hsECf=A@mail.gmail.com>
References: <CAPybu_2k-0d=8NxL7kr757QcWOnXyU_TAyV7DMwiMrSDkiXfgA@mail.gmail.com>
         <CACVXFVNguNEJ_R7XXvC8dG_yu5tghQk+Hdg6Hp6KKr4Ys4EV_A@mail.gmail.com>
         <CAPybu_2ke4usj9Qwr9iSKTymAk1510pzZnZAgLemRB+cK4Se1A@mail.gmail.com>
         <20180820083032.GA24522@ming.t460p>
         <CAPybu_3QT_qTojTUXFhJFQKVsbhnWUmvyQ0zb5MwDJ5hsECf=A@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-CW7han/mWrFnTQaJKDS2"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--=-CW7han/mWrFnTQaJKDS2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-08-20 at 11:04 +0200, Ricardo Ribalda Delgado wrote:
> Hello Ming
> On Mon, Aug 20, 2018 at 10:30 AM Ming Lei <ming.lei@redhat.com> wrote:
[...]
> > One problem found from your iostat log is that looks there is ~30sec
> > idle period between IO activities when blk-mq is enabled.
>=20
> During all the test the LED on the device was blinking.
>=20
> But a closer look to dmesg reveals a lot of this messages:
>=20
> [  196.929811] sd 6:0:0:0: [sdb] tag#3 data cmplt err -71 uas-tag 1
> inflight: CMD
> [  196.929822] sd 6:0:0:0: [sdb] tag#3 CDB: Write(10) 2a 00 00 04 00
> 68 00 04 00 00
> [  227.764379] sd 6:0:0:0: [sdb] tag#4 uas_eh_abort_handler 0 uas-tag
> 2 inflight: CMD OUT
> [  227.764389] sd 6:0:0:0: [sdb] tag#4 CDB: Write(10) 2a 00 00 04 04
> 68 00 04 00 00
> [  227.766555] sd 6:0:0:0: [sdb] tag#3 uas_eh_abort_handler 0 uas-tag
> 1 inflight: CMD
> [  227.766562] sd 6:0:0:0: [sdb] tag#3 CDB: Write(10) 2a 00 00 04 00
> 68 00 04 00 00
> [  227.784312] scsi host6: uas_eh_device_reset_handler start
> [  227.913672] usb 2-2: reset SuperSpeed USB device number 3 using xhci_h=
cd
> [  227.944842] scsi host6: uas_eh_device_reset_handler success
> [  231.416133] sd 6:0:0:0: [sdb] tag#1 data cmplt err -71 uas-tag 10
> inflight: CMD
> [  231.416147] sd 6:0:0:0: [sdb] tag#1 CDB: Write(10) 2a 00 00 06 d5
> e8 00 04 00 00
>=20
> And they take around 30 secons (227-196)
>=20
>=20
> Maybe this is a hw issue? I will bring the reader home tonight and see
> if I can replicate the bug with my notebook
>=20
> >=20
> > Maybe it is related with timeout, given we had big change in v4.17 time=
out code,
> > and we also fixed one scsi_mq timeout related issue recently, and the p=
atch[1] has
> > been merged to v4.18 release already.
>=20
> I tried with v4.18-rc4 (latest one packaged in debian experimental)
> and after 3 runs, 2 were fine (27 sec), but the last one was over a
> minute.

Is it possible that this is fixed by "block: really disable runtime-pm
for blk-mq"?

That fix went into Debian's version 4.17.14-1, but is not yet in any
4.18-based package.

Ben.

--=20
Ben Hutchings
You can't have everything.  Where would you put it?


--=-CW7han/mWrFnTQaJKDS2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlt9t9gACgkQ57/I7JWG
EQma6hAAqxqgLwoJoO/glrhVa8vgaa95TByfL1JWRh2HiMNKgSbKoNyFV+Oe6nux
pqV+IpwW+DjT6wZyqbr1TUpo53LBKuw5Q1ZJ5/1zCQZM5bZrKL7fZxrSq5HDIOJ2
dJshVJ+MD5IY9blxJ9L9aDWr6p37katO4qQOmR+79VAyIWRRh+hhsHWL3qpt9+Ic
qsv6V6twfvY8g/UdEtYGPB0vk2yNkGSqzNR93jc/ps0k69lFJZHAD6gjHNA185s0
Gpoc7JX0Sh76HrmXPVXLyXTsp+gHZVLulfqSsC17FO9iJ/7M7vSPRTa8Xg6QOl+x
73CD3+G+o/LbKGpzgk25kVvdtOG2kHpPRIpSqwuuO/42t6Z5HVLgIiXhpTPICy2h
IFq7hj0qQeWqc7XOphsP/02c/x088JNqCUZVJzSAHGYFUz2/Rb/M8e2i7vkgyzQl
ddWKtyWuNEwPQxQ50Sqf6kmDlfpFYEmQaTViNY7OW8izyykhZn61NgLBmpAlpP/b
Wns22iVkV/jp5v3WcjICYcBBLFhad2QEv6PBocU+wS4+0wKdGEYRUwCInco/uAbX
2UGq/xAjih306EHL9sLgnQAJiOBJQAmJ3U06VKd4Cyt4RkjJviYzadnuFiV8zFv+
RWB0XT/oSMaOiVjEcS5+W+7VeooZR6cBUR8U6JewkAsnEn756RM=
=WHxh
-----END PGP SIGNATURE-----

--=-CW7han/mWrFnTQaJKDS2--
