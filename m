Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40055 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1164053AbdDXBvJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Apr 2017 21:51:09 -0400
From: NeilBrown <neilb@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Date: Mon, 24 Apr 2017 11:51:01 +1000
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] blk: make the bioset rescue_workqueue optional.
In-Reply-To: <20170421112458.GB12523@infradead.org>
References: <149266645258.27388.14083229348123176454.stgit@noble> <149266672858.27388.11409778158413625707.stgit@noble> <20170421112458.GB12523@infradead.org>
Message-ID: <87h91er2t6.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Fri, Apr 21 2017, Christoph Hellwig wrote:

> On Thu, Apr 20, 2017 at 03:38:48PM +1000, NeilBrown wrote:
>> This patch converts bioset_create() and
>> bioset_create_nobvec() to not create a workqueue so
>> alloctions will never trigger punt_bios_to_rescuer().  It
>> also introduces bioset_create_rescued() and
>> bioset_create_nobvec_rescued() which preserve the old
>> behaviour.
>
> Why these super-early line breaks in the committ message?  They make
> the text much more awkware compared to say:

I usually set a smaller wrap-margin for git comments because of the
extra space that git inserts on the left.  Maybe I over-do it.

>
> This patch converts bioset_create() and bioset_create_nobvec() to not
> create a workqueue so alloctions will never trigger
> punt_bios_to_rescuer(). It also introduces bioset_create_rescued() and
> bioset_create_nobvec_rescued() which preserve the old behaviour.
>
>>  static struct bio_set *__bioset_create(unsigned int pool_size,
>>  				       unsigned int front_pad,
>> -				       bool create_bvec_pool)
>> +				       bool create_bvec_pool,
>> +				       bool create_rescue_workqueue)
>
> I'd much prefer a single new bioset_create with a bunch of flags
> arguments over the number of new functions and these bool arguments.

I was following the existing practice exemplified by
bioset_create_nobvec().
By not changing the signature of the function, I can avoid touching
quite a few places where it is called.
I hope to get rid of the _rescued() versions eventually.  That is easier
if there are a separate function rather than an extra arg that needs
to be removed everywhere.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlj9WgUACgkQOeye3VZi
gbmj3A/+JjMChXRtYB3Wx76jPG/RJtevtFkS1sq0YRwOHCnlXamq6gEZRgOwYV8E
0zOjZdYF/c9VT2IN7MEb1CVjRJZqdt5ly7yFJmWuJ6xz/kNwBgghKDpPc/asXZez
sb1exH5b/qJbdJ+Ns/xiGhhbwdbiQAI11+e9yBDsPWB25yQnzJy830D8pgIodKOS
1+Af0blfb/Ax6I8PxHvbjaeyVz4E+oypogaL7Q97nvJhfxyxYLW6tdyU0THLp9K5
GwojhOQogWdf5Cy9uscgQLmYgz02i4ekKLjSsKd/DkGiqo/5xdwayG5RO7/Jqg20
+VATt/nr8rAsowmCKxAAxGLHR7zou8I8BrA1sfj+RuZ8IONmqcBHApM3aw3nighx
8MvOFMjwLFnmBScBLrRCwrQmKV03vuwS8D2XeeERRXCT17KUXayYwS0KTtHw7b+B
OY3pONT86WFdmotYsoAyWFJy/zClhBSdo2/ev2e+9OrZgLoiFROoBXKR3DY4mZ9W
h4S/xJ6wAsvsTuW/x2w61HJgbojCcbL/ud1XhRcqxGNH/0SKuvRgjQdt2WM04Id6
G76oHfu3edN9Dxnb+XOWOKN9Ydc5RUxYG783EKLFIOH62jHXRFs9ocOC8Pk5ej9+
s7u7OKehu2E1EPDEkaIK//QUDNZPdM2EXmc9kygMwgMEBPxhCew=
=spfJ
-----END PGP SIGNATURE-----
--=-=-=--
