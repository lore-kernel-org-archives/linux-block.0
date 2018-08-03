Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr700064.outbound.protection.outlook.com ([40.107.70.64]:50000
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729924AbeHCPB2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Aug 2018 11:01:28 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: remove unnecessary drive version check
Date: Fri, 3 Aug 2018 13:05:08 +0000
Message-ID: <E3EFEEB3-8B6A-4743-B383-B29482081CC7@cnexlabs.com>
References: <20180802205841.22039-1-mb@lightnvm.io>
 <4382FFAE-0602-4A16-8120-E930141606ED@cnexlabs.com>
 <130c689a-723f-a32a-96e3-a7a59ff6b7b8@lightnvm.io>
 <ef8cd1ac-623b-96ed-1a7f-3e390fcc51d5@lightnvm.io>
In-Reply-To: <ef8cd1ac-623b-96ed-1a7f-3e390fcc51d5@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D8DCCA97-C7DE-4292-8FEA-6940FAF370BA";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_D8DCCA97-C7DE-4292-8FEA-6940FAF370BA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 3 Aug 2018, at 14.55, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/03/2018 02:39 PM, Matias Bj=C3=B8rling wrote:
>> On 08/03/2018 02:18 PM, Javier Gonzalez wrote:
>>>> On 2 Aug 2018, at 22.58, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>=20
>>>> The nvme driver checks for 1.2 and 2.0 compatibility. If an =
unsupported
>>>> version is reported, the device will not be initialized.
>>>>=20
>>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>>> ---
>>>> drivers/lightnvm/pblk-init.c | 8 --------
>>>> 1 file changed, 8 deletions(-)
>>>>=20
>>>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>>>> index 537e98f2b24a..e9e2fedff387 100644
>>>> --- a/drivers/lightnvm/pblk-init.c
>>>> +++ b/drivers/lightnvm/pblk-init.c
>>>> @@ -1202,14 +1202,6 @@ static void *pblk_init(struct nvm_tgt_dev =
*dev, struct gendisk *tdisk,
>>>>     pblk->state =3D PBLK_STATE_RUNNING;
>>>>     pblk->gc.gc_enabled =3D 0;
>>>>=20
>>>> -    if (!(geo->version =3D=3D NVM_OCSSD_SPEC_12 ||
>>>> -                    geo->version =3D=3D NVM_OCSSD_SPEC_20)) {
>>>> -        pblk_err(pblk, "OCSSD version not supported (%u)\n",
>>>> -                            geo->version);
>>>> -        kfree(pblk);
>>>> -        return ERR_PTR(-EINVAL);
>>>> -    }
>>>> -
>>>>     if (geo->version =3D=3D NVM_OCSSD_SPEC_12 && geo->dom & =
NVM_RSP_L2P) {
>>>>         pblk_err(pblk, "host-side L2P table not supported. (%x)\n",
>>>>                             geo->dom);
>>>> --
>>>> 2.11.0
>>>=20
>>> The same comment goes for this patch. pblk does support 2.0 and 1.2
>>> today, but it is not guaranteed it will support a new revision =
straight
>>> away. So I think that a check wither here or through the =
.capabilities I
>>> proposed on the other patch is necessary.
>> Works for me. I'll send another patch that enables pblk target to =
tell which version it supports.
>=20
> On second thought. The idea is that pblk will not have to think about
> 1.2/2.0. The core will expose a general address format, etc., such
> that pblk doesn't have to be complicated by that.
>=20

Yes! This was the main motivation for me starting looking into moving
things down.

An issue you might hit is that some conversions are very tightly couple
with pblk (e.g., 32/64 bit L2P conversions). In the code I have on my
end, I ended up having helpers for it, but it does not feel right.

i'm happy to share some thoughts if you want...

> I am working on the various pieces and moving them to core. The patch
> may have gone out a bit early. I will send this again when the 1.2/2.0
> conversions have been applied.

Cool.

Thanks!
Javier



--Apple-Mail=_D8DCCA97-C7DE-4292-8FEA-6940FAF370BA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkUwEACgkQIX4xUKFR
nnQ2YA/9G1/+YAEznhbuy0dA5rLQV74CDXYsN5AV7809aKxjSPpl7K8J4BPELETL
GOxtYpJTw5PlrWyM6n8yzrxcM0f0MJBW7+P/lkFZwyaPQR95R5LKX1YSODUNq0Om
yKofS8CxQxVIkFoero62mtTO5MNXB1hKs6WJdo6z0zwYZlzYw95upWpv5jyAimUx
EwHbIk+sEgbyyB6pmK3j158fuAMpWw2JtytvnKCGtMvK2Z8pbUAgcOy4XTfB5llT
fuAHwJ9M/P5I1+bmz4JybZy3PlDsEgjqqlmG9hFVeUiKBL6wwrfE6ZNt2DLGGonS
VpWxjr8HWlK/Hw0bbhVrLbsip/wEi6hImcV6SeISr0oLnPp9DmacAl7WzBtstdMQ
trc5WXmyvl11pRkX/g3TitjqtfXU1y7Hx5DwJCr47pSwFMGq0FSYJm4Xdbp371M1
Gj/bjRpgIF5WbKar9KMbsHhozQoJBusXOiEOxpzFcwcmAEFAtYPOB7JM3gyQuymx
AnOFNrbzYc7bypWa5oUrf6gbPZG8lBrGs4QnF4ivK/L75h0lrBeEkGLwWxr2C7XX
DnIXvkncU6zs51C1d39R/7/6ZfOHKeZldSYacLME72GMDvv7m1ajqjwf6dPrZrW8
7Y8uRlZLA7M4ob0fWrQ9FAeqFdxDEhdijMFVFCxpHvwU723kjPY=
=F1ar
-----END PGP SIGNATURE-----

--Apple-Mail=_D8DCCA97-C7DE-4292-8FEA-6940FAF370BA--
