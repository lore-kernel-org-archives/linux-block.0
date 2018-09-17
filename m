Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr680082.outbound.protection.outlook.com ([40.107.68.82]:36016
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727020AbeIQPnw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Sep 2018 11:43:52 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] lightnvm: pblk: retrieve chunk metadata on erase
Date: Mon, 17 Sep 2018 10:17:02 +0000
Message-ID: <FF4925A9-CDC4-45F1-AA2E-478062140501@cnexlabs.com>
References: <1536665734-14305-1-git-send-email-javier@cnexlabs.com>
 <1536665734-14305-3-git-send-email-javier@cnexlabs.com>
 <cc17398e-a3dd-4777-3f71-c10751f1aca0@lightnvm.io>
In-Reply-To: <cc17398e-a3dd-4777-3f71-c10751f1aca0@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C684F6F4-6A64-414C-BBC4-44BAD913F258";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_C684F6F4-6A64-414C-BBC4-44BAD913F258
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 17 Sep 2018, at 10.26, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 09/11/2018 01:35 PM, Javier Gonz=C3=A1lez wrote:
>> On the OCSSD 2.0 spec, the device populates the metadata pointer (if
>> provided) when a chunk is reset. Implement this path in pblk and use =
it
>> for sanity chunk checks.
>> For 1.2, reset the write pointer and the state on core so that the =
erase
>> path is transparent to pblk wrt OCSSD version.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/core.c      | 44 =
++++++++++++++++++++++++++++++++++++--
>>  drivers/lightnvm/pblk-core.c | 51 =
+++++++++++++++++++++++++++++++++-----------
>>  2 files changed, 80 insertions(+), 15 deletions(-)
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index efb976a863d2..dceaae4e795f 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -750,9 +750,40 @@ int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, =
struct nvm_rq *rqd)
>>  }
>>  EXPORT_SYMBOL(nvm_submit_io);
>>  +/* Take only addresses in generic format */
>> +static void nvm_set_chunk_state_12(struct nvm_dev *dev, struct =
nvm_rq *rqd)
>> +{
>> +	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
>> +	int i;
>> +
>> +	for (i =3D 0; i < rqd->nr_ppas; i++) {
>> +		struct ppa_addr ppa;
>> +		struct nvm_chk_meta *chunk;
>> +
>> +		chunk =3D ((struct nvm_chk_meta *)rqd->meta_list) + i;
>> +
>> +		if (rqd->error)
>> +			chunk->state =3D NVM_CHK_ST_OFFLINE;
>> +		else
>> +			chunk->state =3D NVM_CHK_ST_FREE;
>> +
>> +		chunk->wp =3D 0;
>> +		chunk->wi =3D 0;
>> +		chunk->type =3D NVM_CHK_TP_W_SEQ;
>> +		chunk->cnlb =3D dev->geo.clba;
>> +
>> +		/* recalculate slba for the chunk */
>> +		ppa =3D ppa_list[i];
>> +		ppa.g.pg =3D ppa.g.pl =3D ppa.g.sec =3D 0;
>> +
>> +		chunk->slba =3D generic_to_dev_addr(dev, ppa).ppa;
>> +	}
>> +}
>> +
>>  int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev, struct nvm_rq =
*rqd)
>>  {
>>  	struct nvm_dev *dev =3D tgt_dev->parent;
>> +	struct nvm_geo *geo =3D &dev->geo;
>>  	int ret;
>>    	if (!dev->ops->submit_io_sync)
>> @@ -765,8 +796,12 @@ int nvm_submit_io_sync(struct nvm_tgt_dev =
*tgt_dev, struct nvm_rq *rqd)
>>    	/* In case of error, fail with right address format */
>>  	ret =3D dev->ops->submit_io_sync(dev, rqd);
>> +
>>  	nvm_rq_dev_to_tgt(tgt_dev, rqd);
>>  +	if (geo->version =3D=3D NVM_OCSSD_SPEC_12 && rqd->opcode =3D=3D =
NVM_OP_ERASE)
>> +		nvm_set_chunk_state_12(dev, rqd);
>> +
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL(nvm_submit_io_sync);
>> @@ -775,10 +810,15 @@ void nvm_end_io(struct nvm_rq *rqd)
>>  {
>>  	struct nvm_tgt_dev *tgt_dev =3D rqd->dev;
>>  -	/* Convert address space */
>> -	if (tgt_dev)
>> +	if (tgt_dev) {
>> +		/* Convert address space */
>>  		nvm_rq_dev_to_tgt(tgt_dev, rqd);
>>  +		if (tgt_dev->geo.version =3D=3D NVM_OCSSD_SPEC_12 &&
>> +						rqd->opcode =3D=3D =
NVM_OP_ERASE)
>> +			nvm_set_chunk_state_12(tgt_dev->parent, rqd);
>> +	}
>> +
>>  	if (rqd->end_io)
>>  		rqd->end_io(rqd);
>>  }
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index 417d12b274da..80f0ec756672 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -79,7 +79,7 @@ static void __pblk_end_io_erase(struct pblk *pblk, =
struct nvm_rq *rqd)
>>  {
>>  	struct nvm_tgt_dev *dev =3D pblk->dev;
>>  	struct nvm_geo *geo =3D &dev->geo;
>> -	struct nvm_chk_meta *chunk;
>> +	struct nvm_chk_meta *chunk, *dev_chunk;
>>  	struct pblk_line *line;
>>  	int pos;
>>  @@ -89,22 +89,39 @@ static void __pblk_end_io_erase(struct pblk =
*pblk, struct nvm_rq *rqd)
>>    	atomic_dec(&line->left_seblks);
>>  +	/* pblk submits a single erase per command */
>> +	dev_chunk =3D rqd->meta_list;
>> +
>> +	if (dev_chunk->slba !=3D chunk->slba || dev_chunk->wp)
>> +		print_chunk(pblk, chunk, "corrupted erase chunk", 0);
>> +
>> +	memcpy(chunk, dev_chunk, sizeof(struct nvm_chk_meta));
>> +
>>  	if (rqd->error) {
>>  		trace_pblk_chunk_reset(pblk_disk_name(pblk),
>>  				&rqd->ppa_addr, =
PBLK_CHUNK_RESET_FAILED);
>>  -		chunk->state =3D NVM_CHK_ST_OFFLINE;
>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>> +		if (chunk->state !=3D NVM_CHK_ST_OFFLINE)
>> +			print_chunk(pblk, chunk,
>> +					"corrupted erase chunk state", =
0);
>> +#endif
>>  		pblk_mark_bb(pblk, line, rqd->ppa_addr);
>>  	} else {
>>  		trace_pblk_chunk_reset(pblk_disk_name(pblk),
>>  				&rqd->ppa_addr, PBLK_CHUNK_RESET_DONE);
>>  -		chunk->state =3D NVM_CHK_ST_FREE;
>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>> +		if (chunk->state !=3D NVM_CHK_ST_FREE)
>> +			print_chunk(pblk, chunk,
>> +					"corrupted erase chunk state", =
0);
>> +#endif >   	}
>>    	trace_pblk_chunk_state(pblk_disk_name(pblk), &rqd->ppa_addr,
>>  				chunk->state);
>>  +	pblk_free_rqd_meta(pblk, rqd);
>>  	atomic_dec(&pblk->inflight_io);
>>  }
>>  @@ -952,14 +969,16 @@ int pblk_line_emeta_read(struct pblk *pblk, =
struct pblk_line *line,
>>  	return ret;
>>  }
>>  -static void pblk_setup_e_rq(struct pblk *pblk, struct nvm_rq *rqd,
>> -			    struct ppa_addr ppa)
>> +static int pblk_setup_e_rq(struct pblk *pblk, struct nvm_rq *rqd,
>> +			   struct ppa_addr ppa)
>>  {
>>  	rqd->opcode =3D NVM_OP_ERASE;
>>  	rqd->ppa_addr =3D ppa;
>>  	rqd->nr_ppas =3D 1;
>>  	rqd->is_seq =3D 1;
>>  	rqd->bio =3D NULL;
>> +
>> +	return pblk_alloc_rqd_meta(pblk, rqd);
>>  }
>>    static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr =
ppa)
>> @@ -967,10 +986,12 @@ static int pblk_blk_erase_sync(struct pblk =
*pblk, struct ppa_addr ppa)
>>  	struct nvm_rq rqd =3D {NULL};
>>  	int ret;
>>  +	ret =3D pblk_setup_e_rq(pblk, &rqd, ppa);
>> +	if (ret)
>> +		return ret;
>> +
>>  	trace_pblk_chunk_reset(pblk_disk_name(pblk), &ppa,
>> -				PBLK_CHUNK_RESET_START);
>> -
>> -	pblk_setup_e_rq(pblk, &rqd, ppa);
>> +						PBLK_CHUNK_RESET_START);
>>    	/* The write thread schedules erases so that it minimizes =
disturbances
>>  	 * with writes. Thus, there is no need to take the LUN =
semaphore.
>> @@ -1774,11 +1795,15 @@ void pblk_line_put_wq(struct kref *ref)
>>  int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
>>  {
>>  	struct nvm_rq *rqd;
>> -	int err;
>> +	int ret;
>>    	rqd =3D pblk_alloc_rqd(pblk, PBLK_ERASE);
>>  -	pblk_setup_e_rq(pblk, rqd, ppa);
>> +	ret =3D pblk_setup_e_rq(pblk, rqd, ppa);
>> +	if (ret) {
>> +		pblk_free_rqd(pblk, rqd, PBLK_ERASE);
>> +		return ret;
>> +	}
>>    	rqd->end_io =3D pblk_end_io_erase;
>>  	rqd->private =3D pblk;
>> @@ -1789,8 +1814,8 @@ int pblk_blk_erase_async(struct pblk *pblk, =
struct ppa_addr ppa)
>>  	/* The write thread schedules erases so that it minimizes =
disturbances
>>  	 * with writes. Thus, there is no need to take the LUN =
semaphore.
>>  	 */
>> -	err =3D pblk_submit_io(pblk, rqd);
>> -	if (err) {
>> +	ret =3D pblk_submit_io(pblk, rqd);
>> +	if (ret) {
>>  		struct nvm_tgt_dev *dev =3D pblk->dev;
>>  		struct nvm_geo *geo =3D &dev->geo;
>>  @@ -1799,7 +1824,7 @@ int pblk_blk_erase_async(struct pblk *pblk, =
struct ppa_addr ppa)
>>  					pblk_ppa_to_pos(geo, ppa));
>>  	}
>>  -	return err;
>> +	return ret;
>>  }
>>    struct pblk_line *pblk_line_get_data(struct pblk *pblk)
>=20
> I'll lean towards not taking this patch. The usecase adds extra logic,
> overhead, complexity, and its only usecase for debugging.
>=20
> I am not an advocate of defensive coding in the fast path. For
> example, if an SLBA is inequal with the chunk slba, the drive is
> buggy, and does not behave according to the spec. and therefore does
> not warrant the checks. These type of bugs can be caught in the
> general drive testing suite.


The use case for this patch is to retrieve the wear-leveling information
and the CNLB, which only the drive knows about. Also, this will help
removing the bitmap metadata per line and maintain a per-chunk metadata
instead, reusing the chunk structure retrieved on erase. I want to have
this in before pushing the rest of the patches as they will be depending
on it.


As for the checks, they are sanity that I believe do not hurt, but I'm
ok with removing them (or putting them under debug flags).

Javier

--Apple-Mail=_C684F6F4-6A64-414C-BBC4-44BAD913F258
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluffxkACgkQIX4xUKFR
nnTX4Q//do9azEgAgiHXtHbRUw3x3/fJ/HfUDZT122Bs/ZBth00OuTv/wlyDdFRa
Ses4Fuhs70EBmPJSW2ZlB+wMjcyzdz/ThQX24aOle9DenxVNyOCsa84DyYOwa92O
vf9P4zNX7KtC6llXJmQUVeb4QF6A96NV0rFWJF41QiHH5Hw/tbZYdPmxWeREAxur
fbtYGCIqZB+qE/EZlyNes+eIfmqc88HsY85AT6vw6ckh2XkmN8imb2cRAUPrPcMM
uyThI/Vzs82WJbh9XMCo648pwdiI0+sGjbT/Jr6w0bDWaqsYnQAOueJRXGoYTvxT
YkwpTjs50a/NEDKz/l2gTkmSVRs3kYrimADez1CwVS/TZDDg/wqc5PzW5JsE+BvL
HGXHpPBGe1GS+cQsO0yuQ6m3VYEr1k+/94LiGmAsQpbqjsAmfTzZzayeX4i6xowI
29S/RBAvErjJgrGdtq0VM2eq5t5D3jbm+IdWRJgmmPuJ9C1yxIeUFG+m6Nuy3Vbk
jKhANR9LNth8rJnVSl00yOQYFnmwnvpGr/vboZNbRhx12B5drB9qaXUvJ71gspl4
dMoZPe4HW4aufzpzmijOEZw4+0qFrADxgh5hCXPoKokAIC2lyC2o+IFV4z/czGfW
PD0zkRK4kGh7dxAH+I+ERixoxGLOSRHtJs+pnhelpp599ZQuvkY=
=EdKr
-----END PGP SIGNATURE-----

--Apple-Mail=_C684F6F4-6A64-414C-BBC4-44BAD913F258--
