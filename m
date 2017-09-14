Return-Path: <philipp.guendisch@fau.de>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Support for secure erase functionality
From: Philipp <philipp.guendisch@fau.de>
In-Reply-To: <2b2d3855-00e9-77d0-7ee4-050c210b718e@wdc.com>
Date: Thu, 14 Sep 2017 14:51:52 +0200
Cc: linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org,
 axboe@kernel.dk,
 viro@zeniv.linux.org.uk,
 bart.vanassche@sandisk.com,
 martin.petersen@oracle.com,
 hare@suse.de,
 osandov@fb.com,
 dan.j.williams@intel.com,
 ming.lei@redhat.com,
 linux-kernel@i4.cs.fau.de,
 Mate Horvath <horvatmate@gmail.com>
Message-Id: <B5C3A846-D993-4356-8F89-1CEE253D54F7@fau.de>
References: <1505317073-22567-1-git-send-email-philipp.guendisch@fau.de>
 <2b2d3855-00e9-77d0-7ee4-050c210b718e@wdc.com>
To: Damien Le Moal <damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Dear Damien,

Thank you for your feedback.=20

> On 14. Sep 2017, at 10:46, Damien Le Moal <damien.lemoal@wdc.com> =
wrote:

[=E2=80=A6]

> Writing once to a sector stored on spinning rust will *not* fully =
erase
> the previous data. Part of the signal used for storing that data will
> remain on the track (because the disk head is never perfectly aligned =
on
> the track). With some signal processing work, the old data can be =
retrieved.
>=20
> You will need a *lot* of normal writes to make sure nothing remains of
> the old data signal. Granted, even a single write will make it hard to
> get to the old data, but it is possible nevertheless. Hence the =
standard
> defined SANITIZE with cryptographic erase option to ensure that the =
old
> data is really dead.


We constructed our patch based on a paper called=20
=E2=80=9COverwriting Hard Drive Data: The Great Wiping Controversy=E2=80=9D=
 which stated that a single overwrite
of the data is sufficient.
Nevertheless this should not be a solution to replace encryption but to =
improve data security when
better techniques are not viable (e.g. travelling between countries =
while importing or exporting
encrypted data may be prohibited without a license).

> I think that a similar problem also exist for SSDs, and it is even =
worse
> there since writing twice to the same logical sector does not even go =
to
> the same physical sector. The old data is not even overwritten.

We know about the problems regarding the data placement on SSDs, but =
there is very little we can
do with code against the hardware controller of specific devices.
On SSDs, you would probably want to use full disk encryption, because it =
should be no problem,
when encrypted blocks are left on the drive.

However in cases where encryption is too slow or not possible, this =
could improve data confidentiality.

Best regards,
Philipp=
