Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287ADC282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 15:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDF5218A3
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 15:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="0yFBBPpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfA3PCI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:02:08 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42549 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfA3PCI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 10:02:08 -0500
Received: by mail-ed1-f67.google.com with SMTP id y20so19229381edw.9
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 07:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ghGTwRqOYuMtViCjkiZHdkfbqBhJcAVOjmt4Z41B4Ac=;
        b=0yFBBPpI77ZLQmcMYFC9UVxJs5KWXwl5flIu3Ye+elGZMNmgIMYmFp/I9ADsnOKMh5
         Y6y2X7cOmZWfDJAOvYFB3c56bHG/33w1kH+2Oy/LCp258cLwRVZpoVDA9yljK2jY0IKA
         X7AtzgwUhvTHvLepIOAgKspGNaR5ZbKcnA/0HPGY0L5td+b3MV5Fwr4sDDWbyz7JW43L
         OkVEFICS/T9uAsFx7aXENZDZcegsl9jWKPKG8HS3qLVCD7EWAMInSb+Jy1Y/k4Kv/SoS
         NCN4vZGVkxiSQruCjOcY30OnoohefOb90Hc/MQu5xMYUYo/GJdPMud+dDc7hKCEn+IHc
         D1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ghGTwRqOYuMtViCjkiZHdkfbqBhJcAVOjmt4Z41B4Ac=;
        b=Ujq0s8fsgEqy8s9cgZ6/mdz83m+7xuyldS15M395YztC+al3EZoaWAn+c5EsJXkVQx
         6cZHZTSADfXnPvjzdPQei2PFhfftDIHoC8eMkwwogfLRxm4XHFpQOkF4DCpov/C/3QEb
         2g23M6FVi0pPjz5PhfubErjOxBb7DBT3TP1ns71TLZ0vLG0KB7J4UdGPdHaNKWl8gUby
         ol2b9E9rKhT0jrN9Sj6p4IXj4jgjvzeHoBf8FE7XBrD4kJYJtTBW235Nw+uCjpg7eMSx
         Y47sfRjewyzxy3nnRkqbamVhOYJzfQ1ZEqj0KFGWvSQqpFDDTXHVh8rbXTSw52atOBcL
         ALtA==
X-Gm-Message-State: AJcUukfa6A20rIY9EdRktnnW+WU82ZGGoSk6R1lR+8jBKz6FPdkacNVD
        860p0+fvpUM7th8FkWdxizWMvQ==
X-Google-Smtp-Source: ALg8bN6UjL+ZEMFkiKM+/4VqZWA361uxoS1G9HiS4Q2RXbfFs3ONj4xZroZAv5j2a9QRlKxMjeJlcg==
X-Received: by 2002:a50:8907:: with SMTP id e7mr30694291ede.252.1548860526108;
        Wed, 30 Jan 2019 07:02:06 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id x47sm564969eda.91.2019.01.30.07.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 07:02:05 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <1EBBDBD0-E316-4585-A481-51942C75E484@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_756D0CBB-AFA3-4938-B301-C713054F2909";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] lightnvm: pblk: fix bio leak on large sized io
Date:   Wed, 30 Jan 2019 16:02:04 +0100
In-Reply-To: <5aa5596b-6394-0d09-533b-0365bc064152@lightnvm.io>
Cc:     chansol.kim@samsung.com,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Matias Bjorling <matias.bjorling@wdc.com>
To:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <CGME20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
 <20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
 <5aa5596b-6394-0d09-533b-0365bc064152@lightnvm.io>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_756D0CBB-AFA3-4938-B301-C713054F2909
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 30 Jan 2019, at 15.06, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 1/30/19 2:53 AM, =EA=B9=80=EC=B0=AC=EC=86=94 wrote:
>> Changes:
>>  1. Function pblk_rw_io to get bio* as a reference
>>  2. In pblk_rw_io bio_put call on read case removed
>> A fix to address issue where
>>  1. pblk_make_rq calls pblk_rw_io passes bio* pointer as a value =
(0xA)
>>  2. pblk_rw_io calls blk_queue_split passing bio* pointer as =
reference
>>  3. In blk_queue_split, when there is a split, the original bio* =
(0xA)
>>     is passed to generic_make_requests, and the newly allocated bio =
is
>>     returned
>>  4. If NVM_IO_DONE returned, pblk_make_rq calls bio_endio on the =
bio*,
>>     that is not the one returned by blk_queue_split
>>  5. As a result bio_endio is not called on the newly allocated bio.
>=20
> The commit message needs a bit of massaging. The Changes: paragraph is =
not needed (that is what the patch is for). Also, please redo the second =
paragraph in without the bullets.
>=20
>> Signed-off-by: chansol.kim <chansol.kim@samsung.com>
>> ---
>>  drivers/lightnvm/pblk-init.c | 22 ++++++++--------------
>>  1 file changed, 8 insertions(+), 14 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>> index b57f764d..4efc929 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -31,30 +31,24 @@ static DECLARE_RWSEM(pblk_lock);
>>  struct bio_set pblk_bio_set;
>>    static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
>> -			  struct bio *bio)
>> +			  struct bio **bio)
>=20
> I am not sure why the **bio change is needed. Can you elaborate?

bio_split creates a new bio and queues the original one again. If the
reference is not updated then the newly created bio is never freed when
NVM_IO_DONE is returned to pblk_make_rq(), thus resulting on a leak.

Javier

--Apple-Mail=_756D0CBB-AFA3-4938-B301-C713054F2909
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxRvGwACgkQPEYBfS0l
eOAa+A/9HURLn3xkHzftV7aBRyZB9lrSAgsDaYVV5kRFrgk5dqEGm1S8ssokjCXM
OUwHKx4ckXAwypEk6Dl2+C7jP6PGxOUVwDAXhEIW3Xb+f63cPQLm1cpXwBUEfzh2
iR4pHL66L+1gngqJI7BS0BKsLWc2el7wkeDQy/zMTn4T/Tw25TK1s85ZcdHfNPJI
RhGeoTIVHos5+MRad2YdW9YMN5D+yvSuT+MyJ6uUfEF6SQ4U7hXY8ELBhCxjQG67
W0Vi02WWCYtrX8FiwjZngHHmxhPM5oU4+jO0mKOzd1C42Z5XbMNeFea5oHhhIUD8
Z3QA/TGdR1/1unGnAMcdoMqF0c5C1yUXMlEEytX5mP7qdsxPsCe3Dvxa9aic+Xd6
djOvZfawYhiNK44dTlevH2GKLZ1pOltR5BeYnbz89l3lDGOK8i/nkMWcaTpFcoRv
vYf1T7YGWoakoyLn9NwpTiwgnyFUXGfMJVMdH+b5dJiax1qt7JaqqW+WfV0Wck3W
GYSq0ZxSc1J7rbDUBo35IxPWHTJIJ37X4gSeHHfVGGQ+dp8BFhv8wmAWxoMAZQH+
V3fDFCd9RkDJOOwpHgi0LtZx78R4BbrmSAdm73BOhZYAtnJr9qLP/lmT6RGQyrTY
HTvqw6e2e7XL0grJy8cO2qoWerpzxOXCohDJSaZ+FsNBODbo3Es=
=enpK
-----END PGP SIGNATURE-----

--Apple-Mail=_756D0CBB-AFA3-4938-B301-C713054F2909--
