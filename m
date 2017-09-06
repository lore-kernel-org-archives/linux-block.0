Return-Path: <jg@lightnvm.io>
Return-Path: <jg@lightnvm.io>
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <2559C6D1-3661-48EC-A3F6-11AE30F6C3F1@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9E813B3F-1098-4BA1-BECA-5CC095590668";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/6] lightnvm: pblk: check for failed mempool alloc.
Date: Wed, 6 Sep 2017 20:28:55 +0200
In-Reply-To: <d644f8f8-cb67-38a5-53d9-7b32f7e42902@kernel.dk>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
 =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
 linux-block@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias@cnexlabs.com>
To: Jens Axboe <axboe@kernel.dk>
References: <1504710066-4699-1-git-send-email-javier@cnexlabs.com>
 <1504710066-4699-2-git-send-email-javier@cnexlabs.com>
 <20170906150811.sa3vrrkbpv5rffeb@linux-x5ow.site>
 <d8295f1b-5021-e20b-ffcf-4fbbbe7c70b4@kernel.dk>
 <B52A428A-99AA-4CE3-8C30-3C2BAA30678D@lightnvm.io>
 <086e6df7-65d8-57b7-6605-d585985a3ddf@kernel.dk>
 <d644f8f8-cb67-38a5-53d9-7b32f7e42902@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_9E813B3F-1098-4BA1-BECA-5CC095590668
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 6 Sep 2017, at 17.20, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 09/06/2017 09:13 AM, Jens Axboe wrote:
>> On 09/06/2017 09:12 AM, Javier Gonz=C3=A1lez wrote:
>>>> On 6 Sep 2017, at 17.09, Jens Axboe <axboe@kernel.dk> wrote:
>>>>=20
>>>> On 09/06/2017 09:08 AM, Johannes Thumshirn wrote:
>>>>> On Wed, Sep 06, 2017 at 05:01:01PM +0200, Javier Gonz=C3=A1lez =
wrote:
>>>>>> Check for failed mempool allocations and act accordingly.
>>>>>=20
>>>>> Are you sure it is needed? Quoting from mempool_alloc()s =
Documentation:
>>>>> "[...] Note that due to preallocation, this function *never* fails =
when called
>>>>> from process contexts. (it might fail if called from an IRQ =
context.) [...]"
>>>>=20
>>>> It's not needed, mempool() will never fail if __GFP_WAIT is set in =
the
>>>> mask. The use case here is GFP_KERNEL, which does include =
__GFP_WAIT.
>>>=20
>>> Thanks for the clarification. Do you just drop the patch, or do you =
want
>>> me to re-send the series?
>>=20
>> No need to resend. I'll pick up the others in a day or two, once =
people
>> have had some time to go over them.
>=20
> I took a quick look at your mempool usage, and I'm not sure it's
> correct.  For a mempool to work, you have to ensure that you provide a
> forward progress guarantee. With that guarantee, you know that if you =
do
> end up sleeping on allocation, you already have items inflight that =
will
> be freed when that operation completes. In other words, all =
allocations
> must have a defined and finite life time, as any allocation can
> potentially sleep/block for that life time. You can't allocate =
something
> and hold on to it forever, then you are violating the terms of =
agreement
> that makes a mempool work.

I understood the part of guaranteeing the number of inflight items to
keep the mempool active without waiting, but I must admit that I assumed
that the mempool would resize when getting pressure and that the penalty
would be increased latency, not the mempool giving up and causing a
deadlock.

>=20
> The first one that caught my eye is pblk->page_pool. You have this =
loop:
>=20
> for (i =3D 0; i < nr_pages; i++) {
>        page =3D mempool_alloc(pblk->page_pool, flags);
>        if (!page)
>                goto err;
>=20
>        ret =3D bio_add_pc_page(q, bio, page, PBLK_EXPOSED_PAGE_SIZE, =
0);
>        if (ret !=3D PBLK_EXPOSED_PAGE_SIZE) {
>                pr_err("pblk: could not add page to bio\n");
>                mempool_free(page, pblk->page_pool);
>                goto err;
>        }
> }
>=20
> which looks suspect. This mempool is created with a reserve pool of
> PAGE_POOL_SIZE (16) members. Do we know if the bio has 16 pages or =
less?
> If not, then this is broken and can deadlock forever.

I can see that in this case, the 16 elements do not hold. In the read
path, we can guarantee that a read will be <=3D 64 sectors (4KB pages), =
so
this is definitely wrong. I'll fix it tomorrow.

Since we are at it, I have for some time wondered what's the right way
to balance the mempool sizes so that we are a good citizen and perform
at the same time. I don't see a lot of code using mempool_resize to tune
the min_nr based on load. For example, in our write path, the numbers
are easy to calculate, but on the read path I completely
over-dimensioned the mempool to ensure not having to wait for the
completion path. Any good rule of thumb here?

> You have a lot of mempool usage in the code, would probably not hurt =
to
> audit all of them.

Yes. I will take a look and add comments to the sizes.

Thanks Jens,
Javier

--Apple-Mail=_9E813B3F-1098-4BA1-BECA-5CC095590668
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZsD5oAAoJEGMfBTt1mRjK55EP/RkYbnT61DbDGIMOT35K586r
SNwOBzcYaQb9hoCt7Q/7o5BJJxxHl7wY6vQdq8HdDsTrWZ133bVMiaR+52Mhfkjg
OAxJ6Gy0DNghJpz5Y0ntx7N08aKTMekgjItREQChzDw7sijqqkpgZbiVLyLuhxGG
rjws1aInkNaXsBfmLSVXZ/iINo481PdnguL6/v/1PQyW1CcJmLIelyqwOAL3NnNx
UiHdTyMLY9ywpHzj41VfvBLgUVD15ZWGfGMW9bQ6klo7/SgbvlK4wpQVzJVBUfgT
b0Ib+/InrZgaBI7XsZBwSVw+TnXpetMNGOk43hTNtUpcYZW+UDTNVdggcanjotXT
2vEfZxnJJoRBEs8yofeNcjBbFDyDfbbWqYQL9qsVm5pMS6WjiNGQltuAieYC7K95
CnBevW69uQFBESnHNCVwMfTlZpyAWvM+dHR82LR50+yKp+jXH+RA1DpvxjjE9qbg
n9UzfzbdG8A+Q4ZhgpRN7lxfApsN1ZGGQkQtmM5oeEHt5H9EsyrfAUEZ8t9ChN3G
SVwhXyLIjn9KINxhQG9izuOkmLrGkmabOImiZhL+XAmXg7g6ir/U91QSA6c3GguE
ywjo5fMMDdkK0itXF3PnmC0P7bZ/qekaeMzN5BKoYE5cgNdJfbOfpHfNeOMGT4cO
CMuDbfZjbK259TTHQB0G
=dFGg
-----END PGP SIGNATURE-----

--Apple-Mail=_9E813B3F-1098-4BA1-BECA-5CC095590668--
