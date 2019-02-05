Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0839C282CB
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 10:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DF42083B
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 10:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="dohw6OvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfBEKUT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:20:19 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35383 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfBEKUT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Feb 2019 05:20:19 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so2403696edx.2
        for <linux-block@vger.kernel.org>; Tue, 05 Feb 2019 02:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=bmQtHgoxNbVypD4JWYGNHzxDCxc24h7BczSImVr6DNg=;
        b=dohw6OvWbcuOV+Zltr+QflRk6a0sQc4aI07Ln0bAlYSnbXZ0L1BS3p1Tj9r50dz0Ma
         OPTCEe/mOVPUz1oaKIS4FNMVcTN9Af3oq91uMajUB37Z0ycwDqIkoq/UATsgyvArgSuo
         50UAZkkIHVgmQ3EP9trAqw+uFvF6pIhs701VItgY1Ljq1O/VhRFAJ4LTxgB11dQtE426
         Hmei6PgP37YSN48cKP8VyEc588PrRY4LTI7DF9gL1QVz5M6x0rRPBMUyRuDL2xgvIYMg
         /UKkxWk2v1uqeh2RoX8lWcdZxkYXhtSqZpBFJYKHJC3UbHEBI1XyVLb8mS8DynjiFOnu
         D/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=bmQtHgoxNbVypD4JWYGNHzxDCxc24h7BczSImVr6DNg=;
        b=FlWWEf5FxMNS36+RWpwQuEmM8Lu0bGUbXG8a7X4jwGNRSJAGOiRrLM3OgLEoLS+Ibf
         Vg6AntDOxVYY0GxInyh6uQwRylXLW7MkjWY89VQDiQXxM6IgdlE6RPjSuszmlH1SWB63
         aVTl+qDDofvnVghKy03SXU/z35RkeG7hVQEYNF3s1W7piEOpuPwp2jg5n7xeU+fb5Wid
         BgcZnc+lJBCwXo+28j/Jb5lGwZxazFoRn7DGfFiWk5sgdOTatHSChFpAGsKkhIAwzZQf
         mBmjTTJ5G+UWc0jpv9PxfwPdHZmP/pwkKg2Tq7c9Z548nADylpz2OZIuxQ/fJ+76khZv
         KT+g==
X-Gm-Message-State: AHQUAuapKUu31Ik9zGAIbv0zKDQfgstkUw2RHUivjRvf4Vta4m2pF4U4
        VYlbfFjo28K3IcnEK8JsIXK7lQ==
X-Google-Smtp-Source: AHgI3Ia8gP4XJ+3HmdLg2RKMVRz7+iqqWCINANnblsYCKvxpHe7e/1UBnok+NF9c2VgBFxHWuEy7iw==
X-Received: by 2002:a05:6402:694:: with SMTP id f20mr3135488edy.99.1549362017295;
        Tue, 05 Feb 2019 02:20:17 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id c11sm2252604ejb.43.2019.02.05.02.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 02:20:16 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <0205AB4D-7055-45E4-935D-E858EA2CA9AD@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_AAB05F86-F595-4687-B691-BBB86FA2DD1F";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] lightnvm: pblk: fix bio leak on large sized io
Date:   Tue, 5 Feb 2019 11:20:15 +0100
In-Reply-To: <8d8bae48-be1f-a211-0a62-a5421c77d818@lightnvm.io>
Cc:     chansol.kim@samsung.com,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
To:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <0fd83092-515e-7e59-bc38-66e1d3b5d9c1@lightnvm.io>
 <20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
 <CGME20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
 <20190201082237epcms2p1b58a31cca3f4c130d92f61b5dcf1ca6b@epcms2p1>
 <8d8bae48-be1f-a211-0a62-a5421c77d818@lightnvm.io>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_AAB05F86-F595-4687-B691-BBB86FA2DD1F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 5 Feb 2019, at 10.23, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 2/1/19 9:22 AM, Chansol Kim wrote:
>> On 01/31/19 22:14 PM, Matias Bj=C3=B8rling wrote:
>>> On 1/30/19 2:53 AM, =EA=B9=80=EC=B0=AC=EC=86=94 wrote:
>>>> Changes:
>>>>   1. Function pblk_rw_io to get bio* as a reference
>>>>   2. In pblk_rw_io bio_put call on read case removed
>>>>=20
>>>> A fix to address issue where
>>>>   1. pblk_make_rq calls pblk_rw_io passes bio* pointer as a value =
(0xA)
>>>>   2. pblk_rw_io calls blk_queue_split passing bio* pointer as =
reference
>>>>   3. In blk_queue_split, when there is a split, the original bio* =
(0xA)
>>>>      is passed to generic_make_requests, and the newly allocated =
bio is
>>>>      returned
>>>>   4. If NVM_IO_DONE returned, pblk_make_rq calls bio_endio on the =
bio*,
>>>>      that is not the one returned by blk_queue_split
>>>>   5. As a result bio_endio is not called on the newly allocated =
bio.
>>>>=20
>>>> Signed-off-by: chansol.kim <chansol.kim@samsung.com>
>>>> ---
>>>>   drivers/lightnvm/pblk-init.c | 22 ++++++++--------------
>>>>   1 file changed, 8 insertions(+), 14 deletions(-)
>>>>=20
>>>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>>>> index b57f764d..4efc929 100644
>>>> --- a/drivers/lightnvm/pblk-init.c
>>>> +++ b/drivers/lightnvm/pblk-init.c
>>>> @@ -31,30 +31,24 @@ static DECLARE_RWSEM(pblk_lock);
>>>>   struct bio_set pblk_bio_set;
>>>>      static int pblk_rw_io(struct request_queue *q, struct pblk =
*pblk,
>>>> -			  struct bio *bio)
>>>> +			  struct bio **bio)
>>>>   {
>>>> -	int ret;
>>>> -
>>>>   	/* Read requests must be <=3D 256kb due to NVMe's 64 bit =
completion bitmap
>>>>   	 * constraint. Writes can be of arbitrary size.
>>>>   	 */
>>>> -	if (bio_data_dir(bio) =3D=3D READ) {
>>>> -		blk_queue_split(q, &bio);
>>>> -		ret =3D pblk_submit_read(pblk, bio);
>>>> -		if (ret =3D=3D NVM_IO_DONE && bio_flagged(bio, =
BIO_CLONED))
>>>> -			bio_put(bio);
>>>=20
>>> Could we kill the NVM_DONE_IO check in the pblk_rw_io, that should
>>> achieve the same?
>> I think it is possible to remove NVM_DONE_IO check here. And in that
>> case perhaps it is necessary to change bio_endio call to somewhere =
other
>> than pblk_make_rq, otherwise endio call would not be made to the new
>> bio*.
>> Assuming pblk_rw_io's second parameter is to be remained as bio*, =
There
>> are three cases I think needs consideration. NVM_IO_ERROR return =
case,
>> the read case and the write case.
>> In NVM_IO_ERROR return case, for both read and write. NVM_IO_ERROR
>> received by pblk_make_rq and bio_io_error called on bio, since this =
bio*
>> that pblk_submit_read and pblk_write_to_cache function tried and =
failed
>> might be a new one, so bio_io_error call needs to be made inside
>> pblk_rw_io.
>> In read case, there are three sub-cases. The first is All data is =
available
>> in ring buffer and NVM_IO_DONE is returned. The second is all to be =
read
>> from the device, which currently NVM_IO_OK is returned and endio is
>> called after read completion from the device. The third is partial =
read,
>> where the data that needs to be read from the device is read
>> synchronously and pblk_rw_io returns NVM_IO_DONE.
>> In write case, there are two sub-cases. Firstly, non REQ_PRE_FLUSH =
case,
>> pblk_write_cache wil return either NVM_IO_DONE or NVM_IO_ERROR. A =
endio
>> call is required in place somewhere NVM_IO_DONE is decided.
>> For REQ_PREFLUSH case bio (new bio* if split) is added to w_ctx.bios,
>> pblk_write_to_cache will return either NVM_IO_OK or NVM_IO_ERROR. =
bio*
>> added to w_ctx.bios will be called by bio_endio on write completion =
to
>> the disk. So it is already taken care of.
>> In summary my feeling is that having pblk_rw_io receive bio* as a
>> reference and removing bio_put in pblk_rw_io would be the minimum
>> change. Please share your insight, I will try experimenting =
alternatives.
>=20
> What rubs me the wrong way is that that pattern isn't used in the rest
> of kernel. I would rather move the calls to bio_io_error and bio_endio
> into the pblk_rw_io() function. The implementation of pblk_rw_io()
> leaks out to pblk_make_rq(). The code is a mismatch of some bio_endio
> calls inside the pblk_rw_io, and others outside. It's not coherent.

I agree that NVM_IO_DONE is now more confusing than anything - this
comes from the rrpc days... Removing it here will require some
refactoring on the partial read path, but nothing too dramatic.

I'm also OK with unfolding pblk_rw_io() into pblk_make_rq().

Chansol: do you want to give it a go?

Javier

--Apple-Mail=_AAB05F86-F595-4687-B691-BBB86FA2DD1F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxZY18ACgkQPEYBfS0l
eOA+VQ//TRyuYKo+NLTAD8UW7yn9aX9rK9tGnqrsNKXhiXiVxa5gVM+KDJF4VA3f
9AAHZF8ovVcIVzAlKvIIVRm3r3vQLHEkwRd/HyoYJ82Orl9dO5/PreHu8ZjFs0zf
5SnGce3uuNztK7IRNBd/F5En94985QpNVGvtH2V7q4z2i7XeJy2dosPfwBFNnJSk
FC4bQ77cAg+pRvKYeNjECv1TJr8u8Yij/GmYq3V/iNXcv44rBzGd2VK2uKTsh7MD
JJolkxZGaXGPtvvO6FPU2V5886PGCa7jc2ZZy+WROhiJRHu6qM8EHm7oaaRgQ1+j
8ENAMC95Iur1E4+GMOCtOwHlhfwORLMqoKpxGQJKAIMdPa2N4IM2VCBhXGrpWsBm
weLDjMZ6WhelqDw6B/ya0YB31I7gHxHxKQf6ItFzeRqYITAra3j1qzrsIr13w3Qa
tq1NXhY7Qn/HSJcXRREQ+sqKwqxOy2fTfJW7gyFHwhKw/YqReR8pOMeK05OA7xlj
O515H11klDeMdNnBYB1DkhsZx/hIcBfAz6EdqmgWWnh420q+SwsD5MZ/EFauNOTV
nOpC0B0NJfYm1CbxCR5LOcK9ti9T+YTM/biJpZIixNFGUNbEl+NHsSW+CVIc+Tg+
bcnmpl8RhaSxDvxZl8xZAhnY/jTrEOldmx5s2qIcFh6BGrNJFuU=
=XeeH
-----END PGP SIGNATURE-----

--Apple-Mail=_AAB05F86-F595-4687-B691-BBB86FA2DD1F--
