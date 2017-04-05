Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751098AbdDEE1q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Apr 2017 00:27:46 -0400
From: NeilBrown <neilb@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Date: Wed, 05 Apr 2017 14:27:02 +1000
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] loop: Add PF_LESS_THROTTLE to block/loop device thread.
In-Reply-To: <20170404071033.GA25855@infradead.org>
References: <871staffus.fsf@notabene.neil.brown.name> <20170404071033.GA25855@infradead.org>
Message-ID: <8760ijiind.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Tue, Apr 04 2017, Christoph Hellwig wrote:

> Looks fine,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> But if you actually care about performance in any way I'd suggest
> to use the loop device in direct I/O mode..

The losetup on my test VM is too old to support that :-(
I guess it might be time to upgraded.

It seems that there is not "mount -o direct_loop" or similar, so you
have to do the losetup and the mount separately.  Any thoughts on
whether that should be changed ?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAljkchYACgkQOeye3VZi
gbnNyA/8CYbI2TclJYsIDY6t3ChgU5qXSUw9k7WCj+Y1Je5xqxKiHDFkmTZIET+G
bmyzVT+J3I+sWSqX42ptGSYHSaxNJHazLsnBg2Gm/pChuNy5QlQm5EVclUEjWDJs
nU3eGbOQbFb4/uQpSdnonr91ODRGD9jFNS23NvTR5jkAORI6LS45Ex5Eg4zKiMH/
B/LcP4RKwHGKYHNoy/F5RyrObYM7kXsl0JNgNXPh/EZpkyXk0jSaqVpZ0a6P+z7e
nW8O9GbmxpmdEkS04nQ69BQ2Dq9Quf6GIuQRXUmeNWVUG2wnYTE1Ly7G50bWM+16
UKLpsCGHgKTAl1fdood4J+V+P8VFMMnsu5nbpMwkVq0nQw5B8g5M0pzl9ojF8bDe
w/3+yQoVfpu1waE+rqKsDEA+hszeq1T9qHAA2FZn/jAdDIUE4dnOT/e2rHmMN9P9
Tsfh92n5nFI0PvE61tEi7n/eHlw5e+nCGrBfxG/bHS/+eIDnP3zGborT31fa6C65
fV3VcwD244e9TVtM400qgHt6aUs2H3GzzedFDTt0TGE+4V5zON4DGdJ4gDwoyk4a
9NDpJoYWEkxyosxU8U9huKkeE1LIlEOJpGFi2f+KM0zNwVoU+m1R1dizQGLkb+/P
ANtntKix8d6qEYvgtfWB3pt61wFkd3wLWXPXpjFbwI2USfs68Oc=
=o4IH
-----END PGP SIGNATURE-----
--=-=-=--
