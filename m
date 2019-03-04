Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A545C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C8820863
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="qJUM9vvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfCDJFW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:05:22 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46712 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCDJFW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 04:05:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id f2so3574554edy.13
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 01:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=jWiw/VJcyuWXtUyzbrYMWqyhcnyuhTgFSFFsOcVLeiE=;
        b=qJUM9vvZpx04z6ugQ7odK0g+DdlyJgEsoq198f50oyWF/5d/4SDx+3WGvTUpjRwsIG
         G3WoGaED+1MvrC1PU+XwC09dCXG5LzI/5nb2DydZGxUXm2OWbHyeVQ5eBWQcyMJ8UFmr
         A7HMTNMiGZ/VZ8POKeGVYb81cdEhjBHgZafwpUJCK2ObE3sT2ggCYXbgCc+YfRQV4Vdq
         kkpUK8MpR49JHUaqXqYZLYsdzi+QJ25vwiPze3ivWLVZELBC0IGZl63/fRaaC4qoFNg4
         rZlF0DSqQ4RSvxhun9wehUOFdMfbz4+H2M2L9ZE0xW8EhcgAx0bsvnNfbvU4SRYFaNCK
         zrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=jWiw/VJcyuWXtUyzbrYMWqyhcnyuhTgFSFFsOcVLeiE=;
        b=t8DnnDUf5KvTA4/KM94r6msGBoKkvMuQqPPzNMaHusiJbNkF+fxEdin/5jlRDYvgNN
         U+Xscya9SC7Dpzdbp9RJAZkF3WgjLQzg2yCqHioDBXduvkoLykNwQQavBbWNE8xEp/J7
         ZP2gd7RAXP9cHwJdJwj9b8QhxDUBSCP/kOKgR3Lc4xxRm630vupe+0dQGSCizRqTUVUp
         L02upysDv4SMpYbsy4DtFlDruP1sKHqPLFZuTfjdnRWH3U/FnKT550Lg2CFKvZDcMI3N
         qdPU3xEBXdqrztn/J6gkSwVKM3n4vgNhU6/0f2VnS1FI4VuPzk1CQjB/utnbwlmhG70L
         I8CA==
X-Gm-Message-State: APjAAAXe7kGeEZCYHTe8tDUEL+h6e9zeCz5EogaHVRWZvMrjb/EVQ208
        K8TvIuMCYuWCBFMnWpM2RMKnYA==
X-Google-Smtp-Source: APXvYqxL0/0OopJWIMcH5H1eIm3eXGUkEhKbq9sd/VHE4YmqDJir3rxD/PyqYcyr3U2N7lgGzsxwxA==
X-Received: by 2002:a50:8786:: with SMTP id a6mr14531167eda.241.1551690320568;
        Mon, 04 Mar 2019 01:05:20 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id c50sm1921752edc.81.2019.03.04.01.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 01:05:19 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <2776B2AC-19D2-4E38-94AD-E158E3E60A37@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_667B7A9D-3668-413F-A4E9-008668FFEA78";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 13/13] lightnvm: Inherit mdts from the parent nvme device
Date:   Mon, 4 Mar 2019 10:05:18 +0100
In-Reply-To: <20190227171442.11853-14-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-14-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_667B7A9D-3668-413F-A4E9-008668FFEA78
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Current lightnvm and pblk implementation does not care
> about NVMe max data transfer size, which can be smaller
> than 64*K=3D256K. This patch fixes issues related to that.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/core.c      | 9 +++++++--
> drivers/nvme/host/lightnvm.c | 1 +
> include/linux/lightnvm.h     | 1 +
> 3 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 5f82036fe322..c01f83b8fbaf 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -325,6 +325,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, =
struct nvm_ioctl_create *create)
> 	struct nvm_target *t;
> 	struct nvm_tgt_dev *tgt_dev;
> 	void *targetdata;
> +	unsigned int mdts;
> 	int ret;
>=20
> 	switch (create->conf.type) {
> @@ -412,8 +413,12 @@ static int nvm_create_tgt(struct nvm_dev *dev, =
struct nvm_ioctl_create *create)
> 	tdisk->private_data =3D targetdata;
> 	tqueue->queuedata =3D targetdata;
>=20
> -	blk_queue_max_hw_sectors(tqueue,
> -			(dev->geo.csecs >> 9) * NVM_MAX_VLBA);
> +	mdts =3D (dev->geo.csecs >> 9) * NVM_MAX_VLBA;
> +	if (dev->geo.mdts) {
> +		mdts =3D min_t(u32, dev->geo.mdts,
> +				(dev->geo.csecs >> 9) * NVM_MAX_VLBA);
> +	}
> +	blk_queue_max_hw_sectors(tqueue, mdts);
>=20
> 	set_capacity(tdisk, tt->capacity(targetdata));
> 	add_disk(tdisk);
> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
> index b759c25c89c8..b88a39a3cbd1 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -991,6 +991,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char =
*disk_name, int node)
> 	geo->csecs =3D 1 << ns->lba_shift;
> 	geo->sos =3D ns->ms;
> 	geo->ext =3D ns->ext;
> +	geo->mdts =3D ns->ctrl->max_hw_sectors;
>=20
> 	dev->q =3D q;
> 	memcpy(dev->name, disk_name, DISK_NAME_LEN);
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 5d865a5d5cdc..d3b02708e5f0 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -358,6 +358,7 @@ struct nvm_geo {
> 	u16	csecs;		/* sector size */
> 	u16	sos;		/* out-of-band area size */
> 	bool	ext;		/* metadata in extended data buffer */
> +	u32	mdts;		/* Max data transfer size*/
>=20
> 	/* device write constrains */
> 	u32	ws_min;		/* minimum write size */
> --
> 2.17.1

I see where you are going with this and I partially agree, but none of
the OCSSD specs define a way to define this parameter. Thus, adding this
behavior taken from NVMe in Linux can break current implementations. Is
this a real life problem for you? Or this is just for NVMe =
=E2=80=9Ccorrectness=E2=80=9D?

Javier




--Apple-Mail=_667B7A9D-3668-413F-A4E9-008668FFEA78
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx86k4ACgkQPEYBfS0l
eOCKvBAAseIHRkxcn5IxQOXAcpUNrx37Dds9PpEFLPOH3mAE7/Zcd2l5gCD+gOE8
IU6pw8URsJcPHQ0LyH1oqK3N9qqdAaZmnZRtj2/kY6vzWaoh89hZTDy4lrs8WfIv
OV0qJUmZXtq2XhcVDRSd7i88S9pOlASIebYSUQE6+0eWtY70QEC9r3f1VrR4RpD/
B/DtSUsqcV2k1bysyL7bUyfgFATyrGEx4oOr2QpYTHOlzzkQFWObYuYiBLNgOVka
eUz3HcU28C5r4Iss/8Db+4vIPO8N4HyAkcLoIOdyGZmLsIcmGVdTKWZJ5whN4jJu
en6wfgOI7R1Ko38ZRvA1Ien/+5dGbTtG1JO8ZMffiEyShlt4p9QWsicS+DGJo6Im
Bhs9+rF2/JtDVpNZPPFL5k5xjsOj4o3MOIowrRk2AVo8XxK3i6ukGJx9HhV8g6A9
Yc/DMNtgBPnqbhFMnWNPCQlY40CvhrfxsTBa8LMg3d/lCOzs8llKFMuKRh5Miqxq
i62aba5RUFSt0Ejs709m99NuXnm9tpWzyKCH5PKRvT1QL7TaXIdRhms15pEQIBRJ
OKD9erX7cKUDFxKAJ0Qt6xA6vNXkZOExA5JNH0YymyYZ78n6KY03r5c14MQPSsl7
ns6iQbBxd5f7v2Jo2YzRkLtDCw5E9CQIAq1dTedQsnVJusej2eM=
=pgKj
-----END PGP SIGNATURE-----

--Apple-Mail=_667B7A9D-3668-413F-A4E9-008668FFEA78--
