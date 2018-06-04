Return-Path: <neilb@suse.com>
From: NeilBrown <neilb@suse.com>
To: Kent Overstreet <kent.overstreet@gmail.com>
Date: Tue, 05 Jun 2018 08:52:32 +1000
Cc: Jens Axboe <axboe@kernel.dk>, Linus Torvalds <torvalds@linux-foundation.org>, linux-block <linux-block@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Shaohua Li <shli@kernel.org>
Subject: Re: [GIT PULL] Block changes for 4.18-rc
In-Reply-To: <20180604212100.GB30325@kmo-pixel>
References: <11b01169-8e11-34ed-8137-aa5cd50a39c2@kernel.dk> <CA+55aFy6_+90WKyDAbhh0NcN22N11AyaCaJu0nrafmf49+h6tQ@mail.gmail.com> <52aaf207-ef5d-a886-66fe-566de9d9bbee@kernel.dk> <87efhmp7zw.fsf@notabene.neil.brown.name> <20180604212100.GB30325@kmo-pixel>
Message-ID: <8736y2p3kf.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain

On Mon, Jun 04 2018, Kent Overstreet wrote:

> On Tue, Jun 05, 2018 at 07:16:51AM +1000, NeilBrown wrote:
>> I really should get back to BIOSET_NEED_RESCUER and see if I can discard
>> it completely.
>> Kent - the only remaining user is bcache, and the main reason I haven't
>> removed it is that I cannot follow the code (or at least, I couldn't
>> last time I tried).  Are you able to see if it is still needed?
>
> Oh man, rescueurs make my head hurt. I remember you changed something so that
> they weren't needed most of the time, but I can't remember what you did - can
> you remind me what that was and whatever else you can remember offhand?

(and closures make my head hurt :-)

There were two closely related changes.
One is make sure that generic_make_request processed bios strictly
in a depth-first order.  The other is to ensure that all (stacking)
block device drivers never block in their make_request_fn waiting
for something that have themselves submitted.

Together these mean that a thread in generic_make_request will never
block waiting for a bio that might be queued in current->bio_list.
The bio chosen by generic_make_request will be a leaf and won't depend
on anything else in the list, and the handler for that request won't
block after submitting a lower-level request.

The  second property is the important one for drivers and the one we
need to ensure that bcache follows.
A common bad pattern is something like:

 while (too_big(bio)) {
    split = bio_spilt(bio,...))
    process(split)
 }
 process(bio)

That needs to be more like
  if (too_big(bio)) {
     split = bio_split(bio,...);
     generic_make_request(bio);
     bio = split;
  }
  process(bio)

so that generic_make_request() gets to do that while-loop
and can control the order in which bios are handled.

I cannot convince myself that bcache doesn't have something similar to
that while loop (structured with closures).

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsVwrAACgkQOeye3VZi
gbnhbxAAqdEGqrPjTgmznEfUXyLhPg+RcKqa8f3gAJ/S2xbH5Ot6WmE8wNsVVH/a
xSCmJzPYf2TEpVCAkK95QoA0S0l44lQeLgHIiqTjAXXRvPek8Trqpe7225cb6XxU
heHn3Zq2nI8zqEcEfnZoaOXuugqNc/o8glDACyiSbHDTTeov25ZQmHwkCwNM3Zge
EvP8LaQTuXgnga0QhsADh+DW0iHqbOYsd/CO/27+2UhrjTryrbinNxLo+r6Wpb45
6i1gewEzgWPNzpjgLENdTK01Ro6z2axFdvmcbamot/MmoZ8TRS633tAQnBOpX2L4
fsOSN485xt6Y9FpfU9t97akrmne+7dNExrgV3gAoP8rvMEblILkksQGlyFPULyBH
HLIAmc0gltvlCm8mtWPwB2CGUhQwF7Oo9jdTONBI0MfoRbEC+3WwI3d/hoIS84MR
qeQ56Jg1RsiFvZXfgYMS/AmDy/wS/YYloatpn4KP2Uk0h8c5weSMRVGBJbHin0x7
ksPLAQYKxrmnkoFqobm8hKjek640TxctH/83/xngGxALXq3WEbJ/HX6hb39AlVGW
ftCPxxJecbpsOOEUX5qsxc7pJ+lXm2ELC2UwrsTVW9yJT9CWciMJX7pnje+CS6ND
4bjmP8q0bM5cYnQjkUFi2M+XfPM3vm59/5Eye6mGPHJD1fj8VNo=
=5vL/
-----END PGP SIGNATURE-----
--=-=-=--
