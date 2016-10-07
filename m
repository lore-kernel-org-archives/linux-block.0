Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750801AbcJGEvj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Oct 2016 00:51:39 -0400
From: NeilBrown <neilb@suse.com>
To: Tomasz Majchrzak <tomasz.majchrzak@intel.com>,
        linux-block@vger.kernel.org
Date: Fri, 07 Oct 2016 15:50:34 +1100
Subject: Re: [PATCH] badblocks: fix overlapping check for clearing
In-Reply-To: <1473152338-30539-1-git-send-email-tomasz.majchrzak@intel.com>
References: <1473152338-30539-1-git-send-email-tomasz.majchrzak@intel.com>
cc: Dan Williams <dan.j.williams@intel.com>
Message-ID: <87wphk3gpx.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 06 2016, Tomasz Majchrzak wrote:

> Current bad block clear implementation assumes the range to clear
> overlaps with at least one bad block already stored. If given range to
> clear precedes first bad block in a list, the first entry is incorrectly
> updated.

In the original md context, it would only ever be called on a block that
was already in the list.
But you are right that it is best not to assume this, and to code more
safely.



>
> Check not only if stored block end is past clear block end but also if
> stored block start is before clear block end.
>
> Signed-off-by: Tomasz Majchrzak <tomasz.majchrzak@intel.com>

Dan Williams seems to have taken responsibility for this code through
his nvdimm tree, so I've added him to 'cc' in the hope that he looks at
this (I wonder if he is even on linux-block ....)


> ---
>  block/badblocks.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/block/badblocks.c b/block/badblocks.c
> index 7be53cb..b2ffcc7 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -354,7 +354,8 @@ int badblocks_clear(struct badblocks *bb, sector_t s,=
 int sectors)
>  		 * current range.  Earlier ranges could also overlap,
>  		 * but only this one can overlap the end of the range.
>  		 */
> -		if (BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > target) {
> +		if ((BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > target) &&
> +		    (BB_OFFSET(p[lo]) <=3D target)) {

hmmm..
'target' is the sector just beyond the set of sectors to remove from the
list.
BB_OFFSET(p[lo]) is the first sector in a range that was found in the
list.
If these are equal, then are aren't clearing anything in this range.
So I would have '<', not '<=3D'.

I don't think this makes the code wrong as we end up assigning to p[lo]
the value that is already there.  But it might be confusing.


>  			/* Partial overlap, leave the tail of this range */
>  			int ack =3D BB_ACK(p[lo]);
>  			sector_t a =3D BB_OFFSET(p[lo]);
> @@ -377,7 +378,8 @@ int badblocks_clear(struct badblocks *bb, sector_t s,=
 int sectors)
>  			lo--;
>  		}
>  		while (lo >=3D 0 &&
> -		       BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > s) {
> +		       (BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > s) &&
> +		       (BB_OFFSET(p[lo]) <=3D target)) {

Ditto.

But the code is, I think, correct. Just not how I would have written it.
So

 Acked-by: NeilBrown <neilb@suse.com>

Thanks,
NeilBrown


>  			/* This range does overlap */
>  			if (BB_OFFSET(p[lo]) < s) {
>  				/* Keep the early parts of this range. */
> --=20
> 1.8.3.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX9ymaAAoJEDnsnt1WYoG5cz0QAJVJOVRV56vKO79/2pO0PEkN
+vLDk6fsSmZanV+p0oF4cr6XgjuULyYg4aySld3f72RgIw4rVu5gr89bHkxUzU9H
XzdiEkvya3viv6cny1xbuZJVJS+VWksU+5bhhgPBFMDWegblKxfFZcGMhpejCW9X
jBZBUxLXDK0uIw1Ea7Vi7vrG/CP+9FR1XoWMMI/nby4KAcTdmwApO0lMIsNYQmD7
4g1KFKlHpa9EHXbW+m5J6E/k2z6Hg1BXQpoWi8O+FFhNVzx5XDRb1grFuQdLduE8
h11a1vveSlk03x/m05t2g4dFjyABzmo/WyunPoIKGIxAfdqHKQcOf6GeIPwj84q9
frBQQGaj8rGUBG099VUQ8WrTbep6YX3M/N/AL5ma3fGtLrZbEkPGQBDUsfJHwr2b
lskBYyoPzSLqbSN1lR8+S1xJ1T5b/9es+s7n+OQ9s0HqxZVm5Vi8J3xgsuhQl89s
rQuvG27JlBTHlW81VN+jDAOhDsELC4Cy8TMgrHhJTKSy1HA7xah4MNZoE3A9h4EI
o9m5l2LvDaTpNCq95RqReOJvyxwxyBTMel5rhmUBBm0GnP2bIMYLOGKhwbbBOZu0
3DObL0UIXVumM6UsANzbJsrSht0QTFA1qgHNv1zqNIeh8hIKjYI5WeuB41NWdH42
RfRXNAeQYlgJCm49bVYV
=QX7c
-----END PGP SIGNATURE-----
--=-=-=--
