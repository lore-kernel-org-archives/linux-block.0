Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <D397E50E-AEFC-4627-BF5D-8F410BB1CF33@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1278EA54-879A-422B-B39D-5734A43A080F";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 0/11] Add support for write life time hints
Date: Tue, 13 Jun 2017 12:04:06 -0600
In-Reply-To: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_1278EA54-879A-422B-B39D-5734A43A080F
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
> 
> A new iteration of this patchset, previously known as write streams.
> Instead of exposing numeric values for streams, I've previously
> advocated for just doing a set of hints that makes sense instead. See
> the coverage from the LSFMM summit this year:
> 
> https://lwn.net/Articles/717755/
> 
> This patchset attempts to do that. We define 4 flags for the pwritev2
> system call:
> 
> RWF_WRITE_LIFE_SHORT	Data written with this flag is expected to have
> 			a high overwrite rate, or life time.
> 
> RWF_WRITE_LIFE_MEDIUM	Longer life time than SHORT
> 
> RWF_WRITE_LIFE_LONG	Longer life time than MEDIUM
> 
> RWF_WRITE_LIFE_EXTREME	Longer life time than LONG
> 
> The idea is that these are relative values, so an application can
> use them as they see fit. The underlying device can then place
> data appropriately, or be free to ignore the hint. It's just a hint.
> 
> Comments appreciated.

I thought that one of the major attractions of numeric stream IDs was
that they had no semantic meanings, just "N is similar to N" and "M is
similar to M", and it is up to userspace to define what these mean?

That allows userspace to use the IDs for lifetimes (as above), but
also/instead use them for allocation sizes, different applications,
different users, etc.

> A branch based on current master can be pulled from here:
> 
> git://git.kernel.dk/linux-block write-stream.1
> 
> --
> Jens Axboe
> 


Cheers, Andreas






--Apple-Mail=_1278EA54-879A-422B-B39D-5734A43A080F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQCkXpIg59Q01vtYRAlOqAJ4q5leCsZ7KFF1RynnUsJjjmZ/KogCgszg4
4jWGimNaTgzxixkoIbeTa1g=
=u92T
-----END PGP SIGNATURE-----

--Apple-Mail=_1278EA54-879A-422B-B39D-5734A43A080F--
