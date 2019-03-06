Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E553C43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 07:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3046B2064A
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 07:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="BVD6smpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfCFHoo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:44:44 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38046 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfCFHoo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 02:44:44 -0500
Received: by mail-ed1-f67.google.com with SMTP id h58so9475959edb.5
        for <linux-block@vger.kernel.org>; Tue, 05 Mar 2019 23:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Zz9dvymoV1QCFfDxB2GdpW9TcEPzV1SPkZP2VVHetQE=;
        b=BVD6smpPmYJMUaM0ZgJnWW53uqDjEc+uO0Ak8sjUhofLnqh4qMlVTO7s6MtiFQRTnI
         rtcCBNSHCtNNSTLqCe4c8n+OUmEevZrGzUsZejnCSRp/rOYaVTr1bwtBagI9MOgg0R2F
         td9KP17I6kswChEX/DdEdEUWcftcGOPG6A6ydK1qseoDEJq+HUcoOFBGClVzEAD1HxtK
         xdz4ZQZ+egYY2izECG5Ij3MtxfAaaC7rHZXNJ0GJ6RrW3Yc3cyowsJSlsRlf1F7FpitS
         J8xiBBZFxxx0lNXrNwMIaLmiZ8I1NQb9AuUmuC/oW1IK5y86ApsjYsmf9OaC+U7v/DPj
         qIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Zz9dvymoV1QCFfDxB2GdpW9TcEPzV1SPkZP2VVHetQE=;
        b=n/kwt4+1HKmdZPZangoJBcrDSvLVX2W7LErb3ebNI+EJoSnDw5nHu6+qwb9AHJg3h4
         t1YOswNzjunT6pDeBYBK9WffzcGMjTlOyZAd0q70fO8afn42FruVUZTLejmnuYufm5f/
         agLGmwix/KBQGq+6MEpJIXmvzhH2TgnM7OlIirP5/4AdVv7tgyLAnAAeOGQh0AL3A3R/
         aRIyjxedCeDu8loYZ1nnSUnCeNEjEV6cf6nFaR6ZqAEZwJxw4pFRriNOj7Y2RU8ZKPN6
         Fk6uurRFHfEEPgdoE5VOzWy1c2yE/NYW7Rr7wafr4Pd+RL5JlOzVQ//47h/WEj8c6TLE
         bB3g==
X-Gm-Message-State: APjAAAV8mHEPU4R1qZ5OgBF8EwZpAGa00B0NuHMZHM0B6Q3zQ4ZgNKJj
        bE8D+TLoo/xu2iHS9HOURhRKiA==
X-Google-Smtp-Source: APXvYqxSEnoErwjrEyXyY4dVOFe33Kf/Lr5SF42XsFPr6mpdP1tY94z4gBzRaPisdTxuuNv/xdrVIg==
X-Received: by 2002:a50:a932:: with SMTP id l47mr21952836edc.113.1551858281736;
        Tue, 05 Mar 2019 23:44:41 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id y45sm241536edd.33.2019.03.05.23.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 23:44:41 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <9EAC5F97-CFEF-4598-A251-8C5C06F0DC96@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_92238820-2FA1-4A0D-B1B6-FEA79649625F";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 8/8] lightnvm: Inherit mdts from the parent nvme device
Date:   Wed, 6 Mar 2019 08:44:40 +0100
In-Reply-To: <fbe81dc8-fcf4-57ce-5443-11b44f3478bf@lightnvm.io>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <20190305135120.29284-1-igor.j.konopko@intel.com>
 <20190305135120.29284-9-igor.j.konopko@intel.com>
 <fbe81dc8-fcf4-57ce-5443-11b44f3478bf@lightnvm.io>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_92238820-2FA1-4A0D-B1B6-FEA79649625F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 5 Mar 2019, at 15.34, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 3/5/19 2:51 PM, Igor Konopko wrote:
>> Current lightnvm and pblk implementation does not care about NVMe max
>> data transfer size, which can be smaller than 64*K=3D256K. There are
>> existing NVMe controllers which NVMe max data transfer size is lower
>> that 256K (for example 128K, which happens for existing NVMe
>> controllers which are NVMe spec compliant). Such a controllers are =
not
>> able to handle command which contains 64 PPAs, since the the size of
>> DMAed buffer will be above the capabilities of such a controller.
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>
>> ---
>>  drivers/lightnvm/core.c      | 9 +++++++--
>>  drivers/nvme/host/lightnvm.c | 1 +
>>  include/linux/lightnvm.h     | 1 +
>>  3 files changed, 9 insertions(+), 2 deletions(-)
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index 5f82036..c01f83b 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -325,6 +325,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, =
struct nvm_ioctl_create *create)
>>  	struct nvm_target *t;
>>  	struct nvm_tgt_dev *tgt_dev;
>>  	void *targetdata;
>> +	unsigned int mdts;
>>  	int ret;
>>    	switch (create->conf.type) {
>> @@ -412,8 +413,12 @@ static int nvm_create_tgt(struct nvm_dev *dev, =
struct nvm_ioctl_create *create)
>>  	tdisk->private_data =3D targetdata;
>>  	tqueue->queuedata =3D targetdata;
>>  -	blk_queue_max_hw_sectors(tqueue,
>> -			(dev->geo.csecs >> 9) * NVM_MAX_VLBA);
>> +	mdts =3D (dev->geo.csecs >> 9) * NVM_MAX_VLBA;
>> +	if (dev->geo.mdts) {
>> +		mdts =3D min_t(u32, dev->geo.mdts,
>> +				(dev->geo.csecs >> 9) * NVM_MAX_VLBA);
>> +	}
>> +	blk_queue_max_hw_sectors(tqueue, mdts);
>>    	set_capacity(tdisk, tt->capacity(targetdata));
>>  	add_disk(tdisk);
>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>> index 949e29e..4f20a10 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -977,6 +977,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char =
*disk_name, int node)
>>  	geo->csecs =3D 1 << ns->lba_shift;
>>  	geo->sos =3D ns->ms;
>>  	geo->ext =3D ns->ext;
>> +	geo->mdts =3D ns->ctrl->max_hw_sectors;
>>    	dev->q =3D q;
>>  	memcpy(dev->name, disk_name, DISK_NAME_LEN);
>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>> index 5d865a5..d3b0270 100644
>> --- a/include/linux/lightnvm.h
>> +++ b/include/linux/lightnvm.h
>> @@ -358,6 +358,7 @@ struct nvm_geo {
>>  	u16	csecs;		/* sector size */
>>  	u16	sos;		/* out-of-band area size */
>>  	bool	ext;		/* metadata in extended data buffer */
>> +	u32	mdts;		/* Max data transfer size*/
>>    	/* device write constrains */
>>  	u32	ws_min;		/* minimum write size */
>=20
> I think I can pick this up. I'll let Javier/Hans rereview.
>=20
> Given Javier's feedback on broken existing mdts implementations. When
> they are brought to light, we may want to add in a quirk list to
> update MDTS accordingly. Javier, will this address the issue you have
> regarding using mdts?

Sounds good. Thanks for considering this.

Javier

--Apple-Mail=_92238820-2FA1-4A0D-B1B6-FEA79649625F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx/emgACgkQPEYBfS0l
eOA3HBAAk4GNLhVX5XL2nbDpBXIyLH94slYI8PM5cRSFwVVLJdlHwDOwJ2Yhq4OI
LAvul7F4oNWVqnOi6xEp13AzDsTgeqOIEXgY9kLLowlHQ5w7XhJ2nTkAsP9QZDr5
H8wl/TjQ2kyhCpuuBZTbzSEotJiMLDYDEDWQBMQaODowRwScbeykjKPDTVsFLE7U
FiRnSCqAlPgtuGeVd98ImIrGL+iKTHfU5gownDf9GGW9C6tlLy6zpy6VanmD2AyF
DHd3IRjammKmtX02jC4tdfW9H6H/IuWC5nulXPbZY+llROO350HNeuaCFtI7zIfi
ubf7E+W9TGZNBzqhy/OoRIN1NZI8dk6bEw3snowMdq0EoVXoUarvWKGHIAgL1FRp
4HAfdXWQCEZaONb9scs7/78Eh1pFiudKjfy21lzYOdW57TLCHQSYIgJ+TfOveU4e
V5t87wnagN6dPsfA1/PSMF+IFrPl04fceRIYM+AD6tZayNeMl61n3wpMudUhTJE1
IO+o22+O8lqIK7tupWPT8o1ht3ZNQZfbOWGP2OPM1nKmt5lclj5ry6HxJSvOXQwo
ouQRg1a6iIwVrA0RmdYBF63mVrPOEMiwEWWre56zYYr/siF95+Tl3bp0XohMSKnt
DhEQV+TkBX4Sl7I562hXJJYLZTKcEhiDbAiMIoIXR447N4P6/qg=
=oqL5
-----END PGP SIGNATURE-----

--Apple-Mail=_92238820-2FA1-4A0D-B1B6-FEA79649625F--
