Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5978CC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA472075B
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="CbZG8oTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfCDNrd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:47:33 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39036 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfCDNrd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 08:47:33 -0500
Received: by mail-ed1-f65.google.com with SMTP id p27so4276973edc.6
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 05:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=GAtdA8uwU5IjNwCGouksQjSd3LrAAZ2nZwKsKKnmLyY=;
        b=CbZG8oTlJtVYrCk8hfQgljcXRHvm4t2c+PoWWo6pqATZz76WWFzicUZ1+LzhrDjNO4
         CvlSp1iQRxKVD5xGnw7HJJCXOS9fcEcrTbZE1Fv3blSoJG8V/3OCMvR3Lo/rTrzdQHvg
         zU6Nk5drctymhjdKJbFMe61J3TT3JnGjWXo5JjxK6167R/uLLcQIJsnEIVJx22JGMaJ6
         Xlu+0lNrTV9SBdn5LGqZDTi2olfY48UtLZrT+3nNgs18jaqJh//wtQIVCUK1Y/ucfF2h
         1fwKx5OxT14m3FYsfM2nUF0819dDoue6dzvt0KndzMcbRu9eixjkkdoyPypAOf/Wa/ZC
         tAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=GAtdA8uwU5IjNwCGouksQjSd3LrAAZ2nZwKsKKnmLyY=;
        b=GRr10dK2mXGt00CKgTawhd1l7U02l7uTHo10GZ9Rbd/ponrGCxf4lqZR0PIXVPtWKX
         VHo9ff4JoRFkLzpY4x3Qa0B9nXI76rkKoUZ9x+QuRf8+fRhigTDBxiut6LxzTPwfU2ch
         DECAG3CqbP+r9vIzcWcgKpc0h68W1mw/eOB2kfGndhCt7RR05YQXygubm9nGtNnwqkvZ
         utjVEcdWnmq5wfCauT5ZJcPDZ2JPtWv0B5kwVDRsq408mw31ko27NWP+rVnwyRs5tThq
         O0lk7bnocwY1qlblYImdMqqvkKF1xjYlB6ktb6Qir+UpC6oPeNdW90PnrUZdplOkZH7j
         SF/w==
X-Gm-Message-State: APjAAAWhDrqcMaXPd4xg5MZgjnq8o9Wc72Ej7RlUkO4100S5q7BkdqnL
        DkujsPdtrX1rde5eU9W8D9cjtQ==
X-Google-Smtp-Source: APXvYqxYJ1rDL+Z32DhPDfenRR7R8aUfWpP8xHgmw2e6e4pRGPun8GRXnJOPzDAk1tL1jIXH1cRKSw==
X-Received: by 2002:aa7:d445:: with SMTP id q5mr15132167edr.294.1551707250739;
        Mon, 04 Mar 2019 05:47:30 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id e27sm2111322eda.52.2019.03.04.05.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:47:29 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <A07AF884-0C71-4ABA-9FAF-6C7E6B65B2AC@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_72C64B30-A0B4-466F-AF98-8257631F48CC";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 12/13] lightnvm: pblk: close opened chunks
Date:   Mon, 4 Mar 2019 14:47:29 +0100
In-Reply-To: <5917a585-9c31-929d-68cb-32b6be1f7235@lightnvm.io>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-13-igor.j.konopko@intel.com>
 <C2286529-B0FE-4DFE-8CD1-5BB6591549A4@javigon.com>
 <5917a585-9c31-929d-68cb-32b6be1f7235@lightnvm.io>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_72C64B30-A0B4-466F-AF98-8257631F48CC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 4 Mar 2019, at 14.18, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 3/4/19 9:27 AM, Javier Gonz=C3=A1lez wrote:
>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>>>=20
>>> When we creating pblk instance with factory
>>> flag, there is a possibility that some chunks
>>> are in open state, which does not allow to
>>> issue erase request to them directly. Such a
>>> chunk should be filled with some empty data in
>>> order to achieve close state. Without that we
>>> are risking that some erase operation will be
>>> rejected by the drive due to inproper chunk
>>> state.
>>>=20
>>> This patch implements closing chunk logic in pblk
>>> for that case, when creating instance with factory
>>> flag in order to fix that issue
>>>=20
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> ---
>>> drivers/lightnvm/pblk-core.c | 114 =
+++++++++++++++++++++++++++++++++++
>>> drivers/lightnvm/pblk-init.c |  14 ++++-
>>> drivers/lightnvm/pblk.h      |   2 +
>>> 3 files changed, 128 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>>> index fa4dc05608ff..d3c45393f093 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -161,6 +161,120 @@ struct nvm_chk_meta *pblk_chunk_get_off(struct =
pblk *pblk,
>>> 	return meta + ch_off + lun_off + chk_off;
>>> }
>>>=20
>>> +static void pblk_close_chunk(struct pblk *pblk, struct ppa_addr =
ppa, int count)
>>> +{
>>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>>> +	struct nvm_geo *geo =3D &dev->geo;
>>> +	struct bio *bio;
>>> +	struct ppa_addr *ppa_list;
>>> +	struct nvm_rq rqd;
>>> +	void *meta_list, *data;
>>> +	dma_addr_t dma_meta_list, dma_ppa_list;
>>> +	int i, rq_ppas, rq_len, ret;
>>> +
>>> +	meta_list =3D nvm_dev_dma_alloc(dev->parent, GFP_KERNEL, =
&dma_meta_list);
>>> +	if (!meta_list)
>>> +		return;
>>> +
>>> +	ppa_list =3D meta_list + pblk_dma_meta_size(pblk);
>>> +	dma_ppa_list =3D dma_meta_list + pblk_dma_meta_size(pblk);
>>> +
>>> +	rq_ppas =3D pblk_calc_secs(pblk, count, 0, false);
>>> +	if (!rq_ppas)
>>> +		rq_ppas =3D pblk->min_write_pgs;
>>> +	rq_len =3D rq_ppas * geo->csecs;
>>> +
>>> +	data =3D kzalloc(rq_len, GFP_KERNEL);
>>> +	if (!data)
>>> +		goto free_meta_list;
>>> +
>>> +	memset(&rqd, 0, sizeof(struct nvm_rq));
>>> +	rqd.opcode =3D NVM_OP_PWRITE;
>>> +	rqd.nr_ppas =3D rq_ppas;
>>> +	rqd.meta_list =3D meta_list;
>>> +	rqd.ppa_list =3D ppa_list;
>>> +	rqd.dma_ppa_list =3D dma_ppa_list;
>>> +	rqd.dma_meta_list =3D dma_meta_list;
>>> +
>>> +next_rq:
>>> +	bio =3D bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
>>> +	if (IS_ERR(bio))
>>> +		goto out_next;
>>> +
>>> +	bio->bi_iter.bi_sector =3D 0; /* artificial bio */
>>> +	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
>>> +
>>> +	rqd.bio =3D bio;
>>> +	for (i =3D 0; i < rqd.nr_ppas; i++) {
>>> +		rqd.ppa_list[i] =3D ppa;
>>> +		rqd.ppa_list[i].m.sec +=3D i;
>>> +		pblk_get_meta(pblk, meta_list, i)->lba =3D
>>> +					cpu_to_le64(ADDR_EMPTY);
>>> +	}
>>> +
>>> +	ret =3D nvm_submit_io_sync(dev, &rqd);
>>> +	if (ret) {
>>> +		bio_put(bio);
>>> +		goto out_next;
>>> +	}
>>> +
>>> +	if (rqd.error)
>>> +		goto free_data;
>>> +
>>> +out_next:
>>> +	count -=3D rqd.nr_ppas;
>>> +	ppa.m.sec +=3D rqd.nr_ppas;
>>> +	if (count > 0)
>>> +		goto next_rq;
>>> +
>>> +free_data:
>>> +	kfree(data);
>>> +free_meta_list:
>>> +	nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
>>> +}
>>> +
>>> +void pblk_close_opened_chunks(struct pblk *pblk, struct =
nvm_chk_meta *meta)
>>> +{
>>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>>> +	struct nvm_geo *geo =3D &dev->geo;
>>> +	struct nvm_chk_meta *chunk_meta;
>>> +	struct ppa_addr ppa;
>>> +	int i, j, k, count;
>>> +
>>> +	for (i =3D 0; i < geo->num_chk; i++) {
>>> +		for (j =3D 0; j < geo->num_lun; j++) {
>>> +			for (k =3D 0; k < geo->num_ch; k++) {
>>> +				ppa.ppa =3D 0;
>>> +				ppa.m.grp =3D k;
>>> +				ppa.m.pu =3D j;
>>> +				ppa.m.chk =3D i;
>>> +
>>> +				chunk_meta =3D pblk_chunk_get_off(pblk,
>>> +								meta, =
ppa);
>>> +				if (chunk_meta->state =3D=3D =
NVM_CHK_ST_OPEN) {
>>> +					ppa.m.sec =3D chunk_meta->wp;
>>> +					count =3D geo->clba - =
chunk_meta->wp;
>>> +					pblk_close_chunk(pblk, ppa, =
count);
>>> +				}
>>> +			}
>>> +		}
>>> +	}
>>> +}
>>> +
>>> +bool pblk_are_opened_chunks(struct pblk *pblk, struct nvm_chk_meta =
*meta)
>>> +{
>>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>>> +	struct nvm_geo *geo =3D &dev->geo;
>>> +	int i;
>>> +
>>> +	for (i =3D 0; i < geo->all_luns; i++) {
>>> +		if (meta[i].state =3D=3D NVM_CHK_ST_OPEN)
>>> +			return true;
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +
>>> void __pblk_map_invalidate(struct pblk *pblk, struct pblk_line =
*line,
>>> 			   u64 paddr)
>>> {
>>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>>> index 9913a4514eb6..83abe6960b46 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -1028,13 +1028,14 @@ static int pblk_line_meta_init(struct pblk =
*pblk)
>>> 	return 0;
>>> }
>>>=20
>>> -static int pblk_lines_init(struct pblk *pblk)
>>> +static int pblk_lines_init(struct pblk *pblk, bool factory_init)
>>> {
>>> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
>>> 	struct pblk_line *line;
>>> 	void *chunk_meta;
>>> 	int nr_free_chks =3D 0;
>>> 	int i, ret;
>>> +	bool retry =3D false;
>>>=20
>>> 	ret =3D pblk_line_meta_init(pblk);
>>> 	if (ret)
>>> @@ -1048,12 +1049,21 @@ static int pblk_lines_init(struct pblk =
*pblk)
>>> 	if (ret)
>>> 		goto fail_free_meta;
>>>=20
>>> +get_chunk_meta:
>>> 	chunk_meta =3D pblk_get_chunk_meta(pblk);
>>> 	if (IS_ERR(chunk_meta)) {
>>> 		ret =3D PTR_ERR(chunk_meta);
>>> 		goto fail_free_luns;
>>> 	}
>>>=20
>>> +	if (factory_init && !retry &&
>>> +	    pblk_are_opened_chunks(pblk, chunk_meta)) {
>>> +		pblk_close_opened_chunks(pblk, chunk_meta);
>>> +		retry =3D true;
>>> +		vfree(chunk_meta);
>>> +		goto get_chunk_meta;
>>> +	}
>>> +
>>> 	pblk->lines =3D kcalloc(l_mg->nr_lines, sizeof(struct =
pblk_line),
>>> 								=
GFP_KERNEL);
>>> 	if (!pblk->lines) {
>>> @@ -1244,7 +1254,7 @@ static void *pblk_init(struct nvm_tgt_dev =
*dev, struct gendisk *tdisk,
>>> 		goto fail;
>>> 	}
>>>=20
>>> -	ret =3D pblk_lines_init(pblk);
>>> +	ret =3D pblk_lines_init(pblk, flags & NVM_TARGET_FACTORY);
>>> 	if (ret) {
>>> 		pblk_err(pblk, "could not initialize lines\n");
>>> 		goto fail_free_core;
>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>> index b266563508e6..b248642c4dfb 100644
>>> --- a/drivers/lightnvm/pblk.h
>>> +++ b/drivers/lightnvm/pblk.h
>>> @@ -793,6 +793,8 @@ struct nvm_chk_meta *pblk_get_chunk_meta(struct =
pblk *pblk);
>>> struct nvm_chk_meta *pblk_chunk_get_off(struct pblk *pblk,
>>> 					      struct nvm_chk_meta *lp,
>>> 					      struct ppa_addr ppa);
>>> +void pblk_close_opened_chunks(struct pblk *pblk, struct =
nvm_chk_meta *_meta);
>>> +bool pblk_are_opened_chunks(struct pblk *pblk, struct nvm_chk_meta =
*_meta);
>>> void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
>>> void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
>>> int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
>>> --
>>> 2.17.1
>> I know that the OCSSD 2.0 spec does not allow to transition from open =
to
>> free, but to me this is a spec bug as there is no underlying issue in
>> reading an open block. Note that all controllers I know support this,
>> and the upcoming Denali spec. fixes this too.
>=20
> The issue is not whether the chunk can be read. It is that going from
> Open -> Empty -> Open causes an erase on some implementations, and
> causes the media to wear out prematurely.

If the host is padding data to be able to close, the effect on wear is =
the same.


--Apple-Mail=_72C64B30-A0B4-466F-AF98-8257631F48CC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx9LHEACgkQPEYBfS0l
eODq9BAAnCcKT2BHoQHUhIzvNznvIKq1wu0FIPM4FTIr559g3qWY1NeyMFWT6XEv
5wu1YVkQlqXgvH0NW4L0sjvQeMOzKRZw0Uz0ObugLQZZgtDvvgKrTw5xuRrPGNwL
fWaokKhYGTMOOzoyOQCytmfJNHy9fGTOZjg81qE7oi3dJdJ2wlvMZGeuI08VlaI/
LSE2QIFqjl+9PhGmlmpnDuHVgIoRzdtDoUhXssqsylcspeDWHy9m640jdhhtQ5zR
/hywt9w8NIsfvENxuZ+nQvw1VUAV0lEs7xd962YybVQFQMbyQDb/cniJ+IQFxMAt
iiFe7GiyOFZWzDZnyrDIrkRy9NjOcF2H+NbAyT3E/S272CuToOlQluGnS54roHN9
pQN5W2SlFxXhDAeenFTvm3Jm84A26P4VhWLeqYc9MU+bHkdBR3rwamtwYrfp6mMX
io1BLchEbGS7xrs9ljA/WAAxEQ+3XXitNlLVj5BISRYMefLyX3Rdc/JlTizl+jtV
Tc1NconA482cpB/3U7nMBl7MJU6N0vWDVLbcSdpt1eB/TQE3yVb2q8YHdmnXxvns
4/B8RdGr0iT8NAAPmPXCzSKRBJYBEQThQeo/0lWSpyXtIQWz4kwD1HYuLwaGwLZe
0t7ZWGdiMC+idJkEdqvFQN8Rr5Cd57pPJVl7k2ydkG2Ftzyf85U=
=ZZiZ
-----END PGP SIGNATURE-----

--Apple-Mail=_72C64B30-A0B4-466F-AF98-8257631F48CC--
