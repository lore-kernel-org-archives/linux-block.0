Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34952 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753323AbeBPGkY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Feb 2018 01:40:24 -0500
Received: by mail-pg0-f67.google.com with SMTP id l131so1734231pga.2
        for <linux-block@vger.kernel.org>; Thu, 15 Feb 2018 22:40:23 -0800 (PST)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <ADD0E58F-DBA5-4A53-9666-0B046F5DAE8E@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_7085E976-BDA0-4187-A9A6-E5013718E758";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 6/8] lightnvm: pblk: implement get log report chunk
Date: Thu, 15 Feb 2018 22:38:56 -0800
In-Reply-To: <0287b2a1-34b3-d069-04ef-79170def571f@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <1518530768-20956-1-git-send-email-javier@cnexlabs.com>
 <1518530768-20956-7-git-send-email-javier@cnexlabs.com>
 <0287b2a1-34b3-d069-04ef-79170def571f@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_7085E976-BDA0-4187-A9A6-E5013718E758
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 15 Feb 2018, at 02.59, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/13/2018 03:06 PM, Javier Gonz=C3=A1lez wrote:
>> From: Javier Gonz=C3=A1lez <javier@javigon.com>
>> In preparation of pblk supporting 2.0, implement the get log report
>> chunk in pblk.
>> This patch only replicates de bad block functionality as the rest of =
the
>> metadata requires new pblk functionality (e.g., wear-index to =
implement
>> wear-leveling). This functionality will come in future patches.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk-core.c  | 118 +++++++++++++++++++++++----
>>  drivers/lightnvm/pblk-init.c  | 186 =
+++++++++++++++++++++++++++++++-----------
>>  drivers/lightnvm/pblk-sysfs.c |  67 +++++++++++++++
>>  drivers/lightnvm/pblk.h       |  20 +++++
>>  4 files changed, 327 insertions(+), 64 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index 519af8b9eab7..01b78ee5c0e0 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -44,11 +44,12 @@ static void pblk_line_mark_bb(struct work_struct =
*work)
>>  }
>>    static void pblk_mark_bb(struct pblk *pblk, struct pblk_line =
*line,
>> -			 struct ppa_addr *ppa)
>> +			 struct ppa_addr ppa_addr)
>>  {
>>  	struct nvm_tgt_dev *dev =3D pblk->dev;
>>  	struct nvm_geo *geo =3D &dev->geo;
>> -	int pos =3D pblk_ppa_to_pos(geo, *ppa);
>> +	struct ppa_addr *ppa;
>> +	int pos =3D pblk_ppa_to_pos(geo, ppa_addr);
>>    	pr_debug("pblk: erase failed: line:%d, pos:%d\n", line->id, =
pos);
>>  	atomic_long_inc(&pblk->erase_failed);
>> @@ -58,6 +59,15 @@ static void pblk_mark_bb(struct pblk *pblk, struct =
pblk_line *line,
>>  		pr_err("pblk: attempted to erase bb: line:%d, pos:%d\n",
>>  							line->id, pos);
>>  +	/* Not necessary to mark bad blocks on 2.0 spec. */
>> +	if (geo->c.version =3D=3D NVM_OCSSD_SPEC_20)
>> +		return;
>> +
>> +	ppa =3D kmalloc(sizeof(struct ppa_addr), GFP_ATOMIC);
>> +	if (!ppa)
>> +		return;
>> +
>> +	*ppa =3D ppa_addr;
>>  	pblk_gen_run_ws(pblk, NULL, ppa, pblk_line_mark_bb,
>>  						GFP_ATOMIC, =
pblk->bb_wq);
>>  }
>> @@ -69,16 +79,8 @@ static void __pblk_end_io_erase(struct pblk *pblk, =
struct nvm_rq *rqd)
>>  	line =3D &pblk->lines[pblk_ppa_to_line(rqd->ppa_addr)];
>>  	atomic_dec(&line->left_seblks);
>>  -	if (rqd->error) {
>> -		struct ppa_addr *ppa;
>> -
>> -		ppa =3D kmalloc(sizeof(struct ppa_addr), GFP_ATOMIC);
>> -		if (!ppa)
>> -			return;
>> -
>> -		*ppa =3D rqd->ppa_addr;
>> -		pblk_mark_bb(pblk, line, ppa);
>> -	}
>> +	if (rqd->error)
>> +		pblk_mark_bb(pblk, line, rqd->ppa_addr);
>>    	atomic_dec(&pblk->inflight_io);
>>  }
>> @@ -92,6 +94,47 @@ static void pblk_end_io_erase(struct nvm_rq *rqd)
>>  	mempool_free(rqd, pblk->e_rq_pool);
>>  }
>>  +/*
>> + * Get information for all chunks from the device.
>> + *
>> + * The caller is responsible for freeing the returned structure
>> + */
>> +struct nvm_chunk_log_page *pblk_chunk_get_info(struct pblk *pblk)
>> +{
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +	struct nvm_geo *geo =3D &dev->geo;
>> +	struct nvm_chunk_log_page *log;
>> +	unsigned long len;
>> +	int ret;
>> +
>> +	len =3D geo->all_chunks * sizeof(*log);
>> +	log =3D kzalloc(len, GFP_KERNEL);
>> +	if (!log)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	ret =3D nvm_get_chunk_log_page(dev, log, 0, len);
>> +	if (ret) {
>> +		pr_err("pblk: could not get chunk log page (%d)\n", =
ret);
>> +		kfree(log);
>> +		return ERR_PTR(-EIO);
>> +	}
>> +
>> +	return log;
>> +}
>> +
>> +struct nvm_chunk_log_page *pblk_chunk_get_off(struct pblk *pblk,
>> +					      struct nvm_chunk_log_page =
*lp,
>> +					      struct ppa_addr ppa)
>> +{
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +	struct nvm_geo *geo =3D &dev->geo;
>> +	int ch_off =3D ppa.m.ch * geo->c.num_chk * geo->num_lun;
>> +	int lun_off =3D ppa.m.lun * geo->c.num_chk;
>> +	int chk_off =3D ppa.m.chk;
>> +
>> +	return lp + ch_off + lun_off + chk_off;
>> +}
>> +
>>  void __pblk_map_invalidate(struct pblk *pblk, struct pblk_line =
*line,
>>  			   u64 paddr)
>>  {
>> @@ -1094,10 +1137,38 @@ static int pblk_line_init_bb(struct pblk =
*pblk, struct pblk_line *line,
>>  	return 1;
>>  }
>>  +static int pblk_prepare_new_line(struct pblk *pblk, struct =
pblk_line *line)
>> +{
>> +	struct pblk_line_meta *lm =3D &pblk->lm;
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +	struct nvm_geo *geo =3D &dev->geo;
>> +	int blk_to_erase =3D atomic_read(&line->blk_in_line);
>> +	int i;
>> +
>> +	for (i =3D 0; i < lm->blk_per_line; i++) {
>> +		int state =3D line->chks[i].state;
>> +		struct pblk_lun *rlun =3D &pblk->luns[i];
>> +
>> +		/* Free chunks should not be erased */
>> +		if (state & NVM_CHK_ST_FREE) {
>> +			set_bit(pblk_ppa_to_pos(geo, rlun->chunk_bppa),
>> +					line->erase_bitmap);
>> +			blk_to_erase--;
>> +			line->chks[i].state =3D NVM_CHK_ST_HOST_USE;
>> +		}
>> +
>> +		WARN_ONCE(state & NVM_CHK_ST_OPEN,
>> +				"pblk: open chunk in new line: %d\n",
>> +				line->id);
>> +	}
>> +
>> +	return blk_to_erase;
>> +}
>> +
>>  static int pblk_line_prepare(struct pblk *pblk, struct pblk_line =
*line)
>>  {
>>  	struct pblk_line_meta *lm =3D &pblk->lm;
>> -	int blk_in_line =3D atomic_read(&line->blk_in_line);
>> +	int blk_to_erase;
>>    	line->map_bitmap =3D kzalloc(lm->sec_bitmap_len, GFP_ATOMIC);
>>  	if (!line->map_bitmap)
>> @@ -1110,7 +1181,21 @@ static int pblk_line_prepare(struct pblk =
*pblk, struct pblk_line *line)
>>  		return -ENOMEM;
>>  	}
>>  +	/* Bad blocks do not need to be erased */
>> +	bitmap_copy(line->erase_bitmap, line->blk_bitmap, =
lm->blk_per_line);
>> +
>>  	spin_lock(&line->lock);
>> +
>> +	/* If we have not written to this line, we need to mark up free =
chunks
>> +	 * as already erased
>> +	 */
>> +	if (line->state =3D=3D PBLK_LINESTATE_NEW) {
>> +		blk_to_erase =3D pblk_prepare_new_line(pblk, line);
>> +		line->state =3D PBLK_LINESTATE_FREE;
>> +	} else {
>> +		blk_to_erase =3D atomic_read(&line->blk_in_line);
>> +	}
>> +
>>  	if (line->state !=3D PBLK_LINESTATE_FREE) {
>>  		kfree(line->map_bitmap);
>>  		kfree(line->invalid_bitmap);
>> @@ -1122,15 +1207,12 @@ static int pblk_line_prepare(struct pblk =
*pblk, struct pblk_line *line)
>>    	line->state =3D PBLK_LINESTATE_OPEN;
>>  -	atomic_set(&line->left_eblks, blk_in_line);
>> -	atomic_set(&line->left_seblks, blk_in_line);
>> +	atomic_set(&line->left_eblks, blk_to_erase);
>> +	atomic_set(&line->left_seblks, blk_to_erase);
>>    	line->meta_distance =3D lm->meta_distance;
>>  	spin_unlock(&line->lock);
>>  -	/* Bad blocks do not need to be erased */
>> -	bitmap_copy(line->erase_bitmap, line->blk_bitmap, =
lm->blk_per_line);
>> -
>>  	kref_init(&line->ref);
>>    	return 0;
>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>> index 72b7902e5d1c..dfc68718e27e 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -402,6 +402,7 @@ static void pblk_line_meta_free(struct pblk_line =
*line)
>>  {
>>  	kfree(line->blk_bitmap);
>>  	kfree(line->erase_bitmap);
>> +	kfree(line->chks);
>>  }
>>    static void pblk_lines_free(struct pblk *pblk)
>> @@ -470,25 +471,15 @@ static void *pblk_bb_get_log(struct pblk *pblk)
>>  	return log;
>>  }
>>  -static int pblk_bb_line(struct pblk *pblk, struct pblk_line *line,
>> -			u8 *bb_log, int blk_per_line)
>> +static void *pblk_chunk_get_log(struct pblk *pblk)
>>  {
>>  	struct nvm_tgt_dev *dev =3D pblk->dev;
>>  	struct nvm_geo *geo =3D &dev->geo;
>> -	int i, bb_cnt =3D 0;
>>  -	for (i =3D 0; i < blk_per_line; i++) {
>> -		struct pblk_lun *rlun =3D &pblk->luns[i];
>> -		u8 *lun_bb_log =3D bb_log + i * blk_per_line;
>> -
>> -		if (lun_bb_log[line->id] =3D=3D NVM_BLK_T_FREE)
>> -			continue;
>> -
>> -		set_bit(pblk_ppa_to_pos(geo, rlun->bppa), =
line->blk_bitmap);
>> -		bb_cnt++;
>> -	}
>> -
>> -	return bb_cnt;
>> +	if (geo->c.version =3D=3D NVM_OCSSD_SPEC_12)
>> +		return pblk_bb_get_log(pblk);
>> +	else
>> +		return pblk_chunk_get_info(pblk);
>>  }
>>    static int pblk_luns_init(struct pblk *pblk, struct ppa_addr =
*luns)
>> @@ -517,6 +508,7 @@ static int pblk_luns_init(struct pblk *pblk, =
struct ppa_addr *luns)
>>    		rlun =3D &pblk->luns[i];
>>  		rlun->bppa =3D luns[lunid];
>> +		rlun->chunk_bppa =3D luns[i];
>>    		sema_init(&rlun->wr_sem, 1);
>>  	}
>> @@ -696,8 +688,125 @@ static int pblk_lines_alloc_metadata(struct =
pblk *pblk)
>>  	return -ENOMEM;
>>  }
>>  -static int pblk_setup_line_meta(struct pblk *pblk, struct pblk_line =
*line,
>> -				void *chunk_log, long *nr_bad_blks)
>> +static int pblk_setup_line_meta_12(struct pblk *pblk, struct =
pblk_line *line,
>> +				   void *chunk_log)
>> +{
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +	struct nvm_geo *geo =3D &dev->geo;
>> +	struct pblk_line_meta *lm =3D &pblk->lm;
>> +	int i, chk_per_lun, nr_bad_chks =3D 0;
>> +
>> +	chk_per_lun =3D geo->c.num_chk * geo->c.pln_mode;
>> +
>> +	for (i =3D 0; i < lm->blk_per_line; i++) {
>> +		struct pblk_chunk *chunk =3D &line->chks[i];
>> +		struct pblk_lun *rlun =3D &pblk->luns[i];
>> +		u8 *lun_bb_log =3D chunk_log + i * chk_per_lun;
>> +
>> +		/*
>> +		 * In 1.2 spec. chunk state is not persisted by the =
device. Thus
>> +		 * some of the values are reset each time pblk is =
instantiated.
>> +		 */
>> +		if (lun_bb_log[line->id] =3D=3D NVM_BLK_T_FREE)
>> +			chunk->state =3D  NVM_CHK_ST_HOST_USE;
>> +		else
>> +			chunk->state =3D NVM_CHK_ST_OFFLINE;
>> +
>> +		chunk->type =3D NVM_CHK_TP_W_SEQ;
>> +		chunk->wi =3D 0;
>> +		chunk->slba =3D -1;
>> +		chunk->cnlb =3D geo->c.clba;
>> +		chunk->wp =3D 0;
>> +
>> +		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
>> +			continue;
>> +
>> +		set_bit(pblk_ppa_to_pos(geo, rlun->bppa), =
line->blk_bitmap);
>> +		nr_bad_chks++;
>> +	}
>> +
>> +	return nr_bad_chks;
>> +}
>> +
>> +static int pblk_setup_line_meta_20(struct pblk *pblk, struct =
pblk_line *line,
>> +				   struct nvm_chunk_log_page *log_page)
>> +{
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +	struct nvm_geo *geo =3D &dev->geo;
>> +	struct pblk_line_meta *lm =3D &pblk->lm;
>> +	int i, nr_bad_chks =3D 0;
>> +
>> +	for (i =3D 0; i < lm->blk_per_line; i++) {
>> +		struct pblk_chunk *chunk =3D &line->chks[i];
>> +		struct pblk_lun *rlun =3D &pblk->luns[i];
>> +		struct nvm_chunk_log_page *chunk_log_page;
>> +		struct ppa_addr ppa;
>> +
>> +		ppa =3D rlun->chunk_bppa;
>> +		ppa.m.chk =3D line->id;
>> +		chunk_log_page =3D pblk_chunk_get_off(pblk, log_page, =
ppa);
>> +
>> +		chunk->state =3D chunk_log_page->state;
>> +		chunk->type =3D chunk_log_page->type;
>> +		chunk->wi =3D chunk_log_page->wear_index;
>> +		chunk->slba =3D le64_to_cpu(chunk_log_page->slba);
>> +		chunk->cnlb =3D le64_to_cpu(chunk_log_page->cnlb);
>> +		chunk->wp =3D le64_to_cpu(chunk_log_page->wp);
>> +
>> +		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
>> +			continue;
>> +
>> +		if (chunk->type & NVM_CHK_TP_SZ_SPEC) {
>> +			WARN_ONCE(1, "pblk: custom-sized chunks =
unsupported\n");
>> +			continue;
>> +		}
>> +
>> +		set_bit(pblk_ppa_to_pos(geo, rlun->chunk_bppa),
>> +							=
line->blk_bitmap);
>> +		nr_bad_chks++;
>> +	}
>> +
>> +	return nr_bad_chks;
>> +}
>> +
>=20
> The device chunk to nvm_chunk logic belongs in the lightnvm core. A
> target should preferably not handle the case between 1.2 and 2.0
> interface.
>=20

I thought about this and it is cleaner, the problem is that the return
values from these two interfaces are completely different. My other
approach was asking only for report chunk and then create the log page
format for 1.2 I can see this working good. I'll give it another spin.

Javier

--Apple-Mail=_7085E976-BDA0-4187-A9A6-E5013718E758
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlqGfIAACgkQYx8FO3WZ
GMreuBAAkj+g60wRH3o1kYMF4o2ecYy+ZjetbFxOILG915eF8qL2Ti2YzCSAX4Km
c+BFhkzTw7pAI/R9IvHLV53QDRXQT6yKPa43mVNHhdYYHuZyhYes3D4pWhYEmvTd
p030xlb28jmTwN6vGumBn92Qo+4FxJjk6LA93IUgbnVzRg5C6uVO4lOF6aZSwfsr
JBnA5xoNGENX5AMTzMiPGqp46ntTaWxrfQ2g2KZwI1NqRdGM0hea2eUgQB2Jga+P
NfFLPXAouWj8xcy+1rodi1oG0MUFqhzIYgS6K7HyMuI5IAJILWQoDP0+1Bo9Uz89
cdaRiAI9+u8MprMy+t676d6mD0jpZC0W+hskURVac3zUxjEDbVNPXcOZfCISLT9o
uXmhFXVLU9KKA1c/Al8uptitpCkreLsvf/Q2KgWXhakfsYGUUvha7sudtcxrqHkY
UcDRDukNr4e1Hrs7fkiXYxbn1c9B6tnnF+jgCyn+9ESsM3G6XUIL+5eiRTBCm/cg
aHRYTRzlaGJvCAfaWF15rrqlCl5FsuB7VEgBCCAaH9H1eZiagIlg3RvRMO6wpWF8
1aQth6yy+9uI/kLG4lyN+4whLM7ggzZLI9SZpmCqMvKVDGydvsQF2w8AxWfHQAeH
lg9uTFCsPLbWa09bdATOd6zh0obNuAks+etIokB5ywQ7xdvUzCY=
=NmRG
-----END PGP SIGNATURE-----

--Apple-Mail=_7085E976-BDA0-4187-A9A6-E5013718E758--
