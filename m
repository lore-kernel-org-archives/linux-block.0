Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34634 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754606AbdIGLUr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Sep 2017 07:20:47 -0400
Received: by mail-wm0-f45.google.com with SMTP id 137so33168672wmj.1
        for <linux-block@vger.kernel.org>; Thu, 07 Sep 2017 04:20:46 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <5D19B3AB-19FB-4EBD-83DE-5965385AACC3@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_687B4672-E9A7-4086-BCE7-F2960E40DA09";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 10/18] lightnvm: pblk: use bio_copy_kern when possible
Date: Thu, 7 Sep 2017 13:20:43 +0200
In-Reply-To: <20170907110801.GA17144@infradead.org>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias@cnexlabs.com>
To: Christoph Hellwig <hch@infradead.org>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
 <1504695071-25928-11-git-send-email-javier@cnexlabs.com>
 <20170906134731.GD3960@infradead.org>
 <EE4FE7F3-88CF-42DD-B18F-B0AC2CB5EB2C@lightnvm.io>
 <20170907110801.GA17144@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_687B4672-E9A7-4086-BCE7-F2960E40DA09
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 7 Sep 2017, at 13.08, Christoph Hellwig <hch@infradead.org> wrote:
>=20
> On Wed, Sep 06, 2017 at 04:00:56PM +0200, Javier Gonz=C3=A1lez wrote:
>>> Nope.  You want to loop over vmalloc_to_page and call bio_add_page
>>> for each page,
>>=20
>> Yes. This is basically what I did before.
>>=20
>>> after taking care of virtually tagged caches instead
>>> of this bounce buffering.
>>=20
>> And thus I considered bio_copy_kern to be a better solution, since it
>> will through time take care of doing the vmalloc_to_page correctly =
for
>> all cases.
>=20
> bio_copy_kern copies all the data, so it is generally not a good
> idea.  The cache flushing isn't too hard - take a look at the XFS
> buffer cache for an existing version.
>=20
> It would be good to just to do the right thing inside bio_map_kern
> for that so that callers don't need to care if it is vmalloced or
> not.

Yes. That would help. I know md also needs to manually add pages on
vmalloced memory. Probably other do too.

>=20
>> Ok. So this would mean that targets (e.g., pblk) deal with struct
>> request instead of only dealing with bios and then letting the =
LightNVM
>> core transforming bios to requests. This way we can directly map to =
the
>> request. Is this what you mean?
>=20
> Yes.
>=20
>> Just out of curiosity, why is forming the bio trough bio_copy_kern =
(or
>> manually doing the same) and then transforming to a request incorrect =
/
>> worse?
>=20
> Because you expose yourself to the details of mapping a bio to =
request.
> We had to export blk_init_request_from_bio just for lightnvm to do =
this,
> and it also has to do weird other bits about requests.  If you go
> through blk_rq_map_* the block layer takes care of all that for you.

Ok. It makes sense. I'll talk to Matias about it.


Thanks!
Javier

--Apple-Mail=_687B4672-E9A7-4086-BCE7-F2960E40DA09
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZsSuLAAoJEGMfBTt1mRjKtYQQANgn+X53ld+OokO3p2BfG6Dt
izqP906EWbPZykySluZvEApW8nAJM+5bU3GMnK6jySinqh3XqqVJT5m6k8kQt8gU
aMalwGx5G7Ya0rnnWJHX2yb6OFgRJ7Z4dNag3c/pCE955pY0Nve0Th2ZKI8fn5wH
uZIxHfFfw6WSdvX8IKvh1vECFJJdx8OmjvveR9Pkfr2i7/eCTjPtJ+9142gYaWC1
g3JQYZzBr4Z2nSsU3Zd9vR63BNJ/Z975VOvqpo9fIpH1y6GW6PXmQApOkcpiPiyM
j9Xf1BM+uQU7X9cjVAswUIdhonmZj44/raUfK+DWRrSJBtx2AOjOP8nyGJOPxFDj
JXlJlaHKXvx4u33rdtKhs/+m2I60XmTPxfwmzFdnxDXX0N//45gbMAER792RhKBy
u/axL+E4ThKxh0PEZVaLmB+rtSzyifZfc2QyjmMjh5S/kA07WkQ53IF7aATejRTT
zAqbIxIPeCPpwDW8PsjaqZ0IChyfBw9DA6aalIFWrLHTdGOYCSWY7X/I+SJ7yYKr
rmJf8hDhopn8OlqnNmlt3IGWyS6ubbnN0PYAUrv5bQZDTHAZvh8oZpmmmjtekyIQ
DKkV5FcVvlLcjQzuelb1igaTyHEDd8GVys+1dld/7U+VsJ/srS9tQC3apIGCO+4K
Ylh+EEMuN4NdWsy0qRWq
=jGuh
-----END PGP SIGNATURE-----

--Apple-Mail=_687B4672-E9A7-4086-BCE7-F2960E40DA09--
