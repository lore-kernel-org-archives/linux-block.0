Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn3nam01on0048.outbound.protection.outlook.com ([104.47.33.48]:20051
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936116AbeF2LYI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jun 2018 07:24:08 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] lightnvm: pblk: expose generic disk name on pr_* msgs
Date: Fri, 29 Jun 2018 11:24:02 +0000
Message-ID: <F46CD276-79D4-47AB-AC37-6ABA5A579AD4@cnexlabs.com>
References: <20180628134305.26910-1-mb@lightnvm.io>
 <72C0D646-DD42-4DE9-877B-27A028A0C7DA@cnexlabs.com>
 <0a83d2bd-c41b-4ecc-5ee8-f1e7e6aae30c@lightnvm.io>
 <D0B243BC-41B7-47D6-9440-E8F8033E449A@cnexlabs.com>
 <0f4d0bae-a30e-72fb-113f-68a967b793a8@lightnvm.io>
In-Reply-To: <0f4d0bae-a30e-72fb-113f-68a967b793a8@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_297A22E8-7A06-41D7-BAC6-8937884114A0";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_297A22E8-7A06-41D7-BAC6-8937884114A0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 29 Jun 2018, at 13.22, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 06/29/2018 01:07 PM, Javier Gonzalez wrote:
>>> On 29 Jun 2018, at 12.59, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 06/29/2018 11:36 AM, Javier Gonzalez wrote:
>>>>> On 28 Jun 2018, at 15.43, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>> The error messages in pblk does not say which pblk instance that
>>>>> a message occurred from. Update each error message to reflect the
>>>>> instance it belongs to, and also prefix it with pblk, so we know
>>>>> the message comes from the pblk module.
>>>>>=20
>>>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>>> This could be a good moment to make error reporting mroe =
consistent.
>>>> Some times we used "could not ..." and others "failed to ...".
>>>=20
>>> Agree. This should properly be another patch, such that it does not
>>> pollute the raw conversion.
>> Cool.
>>>> There is also an unnecessary error for a memory allocation (see
>>>> checkpatch).
>>>=20
>>> That is intentional since I wanted to keep the existing wording.
>>> Although, I also looked at it, and kind of came to the conclusion =
that
>>> it was put there for a reason (since exports more than a no memory
>>> message).
>> Ok. We can have a separate patch to make this better, as mentioned
>> below.
>>>> See below.
>>>>> ---
>>>>>=20
>>>>> Forgot to test with NVM_PBLK_DEBUG on. Fixed up the broken code.
>>>>> ---
>>>>> drivers/lightnvm/pblk-core.c     | 51 +++++++++++++-------------
>>>>> drivers/lightnvm/pblk-gc.c       | 32 ++++++++---------
>>>>> drivers/lightnvm/pblk-init.c     | 78 =
++++++++++++++++++++--------------------
>>>>> drivers/lightnvm/pblk-rb.c       |  8 ++---
>>>>> drivers/lightnvm/pblk-read.c     | 25 ++++++-------
>>>>> drivers/lightnvm/pblk-recovery.c | 44 +++++++++++------------
>>>>> drivers/lightnvm/pblk-sysfs.c    |  5 ++-
>>>>> drivers/lightnvm/pblk-write.c    | 21 +++++------
>>>>> drivers/lightnvm/pblk.h          | 29 ++++++++++-----
>>>>> 9 files changed, 153 insertions(+), 140 deletions(-)
>>>>>=20
>>>>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>>>>> index 66ab1036f2fb..b829460fe827 100644
>>>>> --- a/drivers/lightnvm/pblk-core.c
>>>>> +++ b/drivers/lightnvm/pblk-core.c
>>>>> @@ -35,7 +35,7 @@ static void pblk_line_mark_bb(struct work_struct =
*work)
>>>>> 		line =3D &pblk->lines[pblk_ppa_to_line(*ppa)];
>>>>> 		pos =3D pblk_ppa_to_pos(&dev->geo, *ppa);
>>>>>=20
>>>>> -		pr_err("pblk: failed to mark bb, line:%d, pos:%d\n",
>>>>> +		pblk_err(pblk, "failed to mark bb, line:%d, pos:%d\n",
>>>>> 				line->id, pos);
>>>>> 	}
>>>>>=20
>>>>> @@ -51,12 +51,12 @@ static void pblk_mark_bb(struct pblk *pblk, =
struct pblk_line *line,
>>>>> 	struct ppa_addr *ppa;
>>>>> 	int pos =3D pblk_ppa_to_pos(geo, ppa_addr);
>>>>>=20
>>>>> -	pr_debug("pblk: erase failed: line:%d, pos:%d\n", line->id, =
pos);
>>>>> +	pblk_debug(pblk, "erase failed: line:%d, pos:%d\n", line->id, =
pos);
>>>>> 	atomic_long_inc(&pblk->erase_failed);
>>>>>=20
>>>>> 	atomic_dec(&line->blk_in_line);
>>>>> 	if (test_and_set_bit(pos, line->blk_bitmap))
>>>>> -		pr_err("pblk: attempted to erase bb: line:%d, pos:%d\n",
>>>>> +		pblk_err(pblk, "attempted to erase bb: line:%d, =
pos:%d\n",
>>>>> 							line->id, pos);
>>>>>=20
>>>>> 	/* Not necessary to mark bad blocks on 2.0 spec. */
>>>>> @@ -274,7 +274,7 @@ void pblk_free_rqd(struct pblk *pblk, struct =
nvm_rq *rqd, int type)
>>>>> 		pool =3D &pblk->e_rq_pool;
>>>>> 		break;
>>>>> 	default:
>>>>> -		pr_err("pblk: trying to free unknown rqd type\n");
>>>>> +		pblk_err(pblk, "trying to free unknown rqd type\n");
>>>>> 		return;
>>>>> 	}
>>>>>=20
>>>>> @@ -310,7 +310,7 @@ int pblk_bio_add_pages(struct pblk *pblk, =
struct bio *bio, gfp_t flags,
>>>>>=20
>>>>> 		ret =3D bio_add_pc_page(q, bio, page, =
PBLK_EXPOSED_PAGE_SIZE, 0);
>>>>> 		if (ret !=3D PBLK_EXPOSED_PAGE_SIZE) {
>>>>> -			pr_err("pblk: could not add page to bio\n");
>>>>> +			pblk_err(pblk, "could not add page to bio\n");
>>>>> 			mempool_free(page, &pblk->page_bio_pool);
>>>>> 			goto err;
>>>>> 		}
>>>>> @@ -410,7 +410,7 @@ struct list_head *pblk_line_gc_list(struct =
pblk *pblk, struct pblk_line *line)
>>>>> 		line->state =3D PBLK_LINESTATE_CORRUPT;
>>>>> 		line->gc_group =3D PBLK_LINEGC_NONE;
>>>>> 		move_list =3D  &l_mg->corrupt_list;
>>>>> -		pr_err("pblk: corrupted vsc for line %d, vsc:%d =
(%d/%d/%d)\n",
>>>>> +		pblk_err(pblk, "corrupted vsc for line %d, vsc:%d =
(%d/%d/%d)\n",
>>>>> 						line->id, vsc,
>>>>> 						line->sec_in_line,
>>>>> 						lm->high_thrs, =
lm->mid_thrs);
>>>>> @@ -452,7 +452,7 @@ void pblk_log_read_err(struct pblk *pblk, =
struct nvm_rq *rqd)
>>>>> 		atomic_long_inc(&pblk->read_failed);
>>>>> 		break;
>>>>> 	default:
>>>>> -		pr_err("pblk: unknown read error:%d\n", rqd->error);
>>>>> +		pblk_err(pblk, "unknown read error:%d\n", rqd->error);
>>>>> 	}
>>>>> #ifdef CONFIG_NVM_PBLK_DEBUG
>>>>> 	pblk_print_failed_rqd(pblk, rqd, rqd->error);
>>>>> @@ -517,7 +517,7 @@ struct bio *pblk_bio_map_addr(struct pblk =
*pblk, void *data,
>>>>> 	for (i =3D 0; i < nr_secs; i++) {
>>>>> 		page =3D vmalloc_to_page(kaddr);
>>>>> 		if (!page) {
>>>>> -			pr_err("pblk: could not map vmalloc bio\n");
>>>>> +			pblk_err(pblk, "could not map vmalloc bio\n");
>>>>> 			bio_put(bio);
>>>>> 			bio =3D ERR_PTR(-ENOMEM);
>>>>> 			goto out;
>>>>> @@ -525,7 +525,7 @@ struct bio *pblk_bio_map_addr(struct pblk =
*pblk, void *data,
>>>>>=20
>>>>> 		ret =3D bio_add_pc_page(dev->q, bio, page, PAGE_SIZE, =
0);
>>>>> 		if (ret !=3D PAGE_SIZE) {
>>>>> -			pr_err("pblk: could not add page to bio\n");
>>>>> +			pblk_err(pblk, "could not add page to bio\n");
>>>>> 			bio_put(bio);
>>>>> 			bio =3D ERR_PTR(-ENOMEM);
>>>>> 			goto out;
>>>>> @@ -711,7 +711,7 @@ static int pblk_line_submit_emeta_io(struct =
pblk *pblk, struct pblk_line *line,
>>>>> 			while (test_bit(pos, line->blk_bitmap)) {
>>>>> 				paddr +=3D min;
>>>>> 				if (pblk_boundary_paddr_checks(pblk, =
paddr)) {
>>>>> -					pr_err("pblk: corrupt emeta =
line:%d\n",
>>>>> +					pblk_err(pblk, "corrupt emeta =
line:%d\n",
>>>>> 								=
line->id);
>>>>> 					bio_put(bio);
>>>>> 					ret =3D -EINTR;
>>>>> @@ -723,7 +723,7 @@ static int pblk_line_submit_emeta_io(struct =
pblk *pblk, struct pblk_line *line,
>>>>> 			}
>>>>>=20
>>>>> 			if (pblk_boundary_paddr_checks(pblk, paddr + =
min)) {
>>>>> -				pr_err("pblk: corrupt emeta line:%d\n",
>>>>> +				pblk_err(pblk, "corrupt emeta =
line:%d\n",
>>>>> 								=
line->id);
>>>>> 				bio_put(bio);
>>>>> 				ret =3D -EINTR;
>>>>> @@ -738,7 +738,7 @@ static int pblk_line_submit_emeta_io(struct =
pblk *pblk, struct pblk_line *line,
>>>>>=20
>>>>> 	ret =3D pblk_submit_io_sync(pblk, &rqd);
>>>>> 	if (ret) {
>>>>> -		pr_err("pblk: emeta I/O submission failed: %d\n", ret);
>>>>> +		pblk_err(pblk, "emeta I/O submission failed: %d\n", =
ret);
>>>>> 		bio_put(bio);
>>>>> 		goto free_rqd_dma;
>>>>> 	}
>>>>> @@ -843,7 +843,7 @@ static int pblk_line_submit_smeta_io(struct =
pblk *pblk, struct pblk_line *line,
>>>>> 	 */
>>>>> 	ret =3D pblk_submit_io_sync(pblk, &rqd);
>>>>> 	if (ret) {
>>>>> -		pr_err("pblk: smeta I/O submission failed: %d\n", ret);
>>>>> +		pblk_err(pblk, "smeta I/O submission failed: %d\n", =
ret);
>>>>> 		bio_put(bio);
>>>>> 		goto free_ppa_list;
>>>>> 	}
>>>>> @@ -905,7 +905,7 @@ static int pblk_blk_erase_sync(struct pblk =
*pblk, struct ppa_addr ppa)
>>>>> 		struct nvm_tgt_dev *dev =3D pblk->dev;
>>>>> 		struct nvm_geo *geo =3D &dev->geo;
>>>>>=20
>>>>> -		pr_err("pblk: could not sync erase line:%d,blk:%d\n",
>>>>> +		pblk_err(pblk, "could not sync erase line:%d,blk:%d\n",
>>>>> 					pblk_ppa_to_line(ppa),
>>>>> 					pblk_ppa_to_pos(geo, ppa));
>>>>>=20
>>>>> @@ -945,7 +945,7 @@ int pblk_line_erase(struct pblk *pblk, struct =
pblk_line *line)
>>>>>=20
>>>>> 		ret =3D pblk_blk_erase_sync(pblk, ppa);
>>>>> 		if (ret) {
>>>>> -			pr_err("pblk: failed to erase line %d\n", =
line->id);
>>>>> +			pblk_err(pblk, "failed to erase line %d\n", =
line->id);
>>>>> 			return ret;
>>>>> 		}
>>>>> 	} while (1);
>>>>> @@ -1012,7 +1012,7 @@ static int pblk_line_init_metadata(struct =
pblk *pblk, struct pblk_line *line,
>>>>> 		list_add_tail(&line->list, &l_mg->bad_list);
>>>>> 		spin_unlock(&l_mg->free_lock);
>>>>>=20
>>>>> -		pr_debug("pblk: line %d is bad\n", line->id);
>>>>> +		pblk_debug(pblk, "line %d is bad\n", line->id);
>>>>>=20
>>>>> 		return 0;
>>>>> 	}
>>>>> @@ -1122,7 +1122,7 @@ static int pblk_line_init_bb(struct pblk =
*pblk, struct pblk_line *line,
>>>>> 	line->cur_sec =3D off + lm->smeta_sec;
>>>>>=20
>>>>> 	if (init && pblk_line_submit_smeta_io(pblk, line, off, =
PBLK_WRITE)) {
>>>>> -		pr_debug("pblk: line smeta I/O failed. Retry\n");
>>>>> +		pblk_debug(pblk, "line smeta I/O failed. Retry\n");
>>>>> 		return 0;
>>>>> 	}
>>>>>=20
>>>>> @@ -1154,7 +1154,7 @@ static int pblk_line_init_bb(struct pblk =
*pblk, struct pblk_line *line,
>>>>> 		spin_unlock(&line->lock);
>>>>>=20
>>>>> 		list_add_tail(&line->list, &l_mg->bad_list);
>>>>> -		pr_err("pblk: unexpected line %d is bad\n", line->id);
>>>>> +		pblk_err(pblk, "unexpected line %d is bad\n", line->id);
>>>>>=20
>>>>> 		return 0;
>>>>> 	}
>>>>> @@ -1299,7 +1299,7 @@ struct pblk_line *pblk_line_get(struct pblk =
*pblk)
>>>>>=20
>>>>> retry:
>>>>> 	if (list_empty(&l_mg->free_list)) {
>>>>> -		pr_err("pblk: no free lines\n");
>>>>> +		pblk_err(pblk, "no free lines\n");
>>>>> 		return NULL;
>>>>> 	}
>>>>>=20
>>>>> @@ -1315,7 +1315,7 @@ struct pblk_line *pblk_line_get(struct pblk =
*pblk)
>>>>>=20
>>>>> 		list_add_tail(&line->list, &l_mg->bad_list);
>>>>>=20
>>>>> -		pr_debug("pblk: line %d is bad\n", line->id);
>>>>> +		pblk_debug(pblk, "line %d is bad\n", line->id);
>>>>> 		goto retry;
>>>>> 	}
>>>>>=20
>>>>> @@ -1329,7 +1329,7 @@ struct pblk_line *pblk_line_get(struct pblk =
*pblk)
>>>>> 			list_add(&line->list, &l_mg->corrupt_list);
>>>>> 			goto retry;
>>>>> 		default:
>>>>> -			pr_err("pblk: failed to prepare line %d\n", =
line->id);
>>>>> +			pblk_err(pblk, "failed to prepare line %d\n", =
line->id);
>>>>> 			list_add(&line->list, &l_mg->free_list);
>>>>> 			l_mg->nr_free_lines++;
>>>>> 			return NULL;
>>>>> @@ -1477,7 +1477,7 @@ static void pblk_line_close_meta_sync(struct =
pblk *pblk)
>>>>>=20
>>>>> 			ret =3D pblk_submit_meta_io(pblk, line);
>>>>> 			if (ret) {
>>>>> -				pr_err("pblk: sync meta line %d failed =
(%d)\n",
>>>>> +				pblk_err(pblk, "sync meta line %d failed =
(%d)\n",
>>>>> 							line->id, ret);
>>>>> 				return;
>>>>> 			}
>>>>> @@ -1507,7 +1507,7 @@ void __pblk_pipeline_flush(struct pblk =
*pblk)
>>>>>=20
>>>>> 	ret =3D pblk_recov_pad(pblk);
>>>>> 	if (ret) {
>>>>> -		pr_err("pblk: could not close data on teardown(%d)\n", =
ret);
>>>>> +		pblk_err(pblk, "could not close data on teardown(%d)\n", =
ret);
>>>>> 		return;
>>>>> 	}
>>>>>=20
>>>>> @@ -1687,7 +1687,7 @@ int pblk_blk_erase_async(struct pblk *pblk, =
struct ppa_addr ppa)
>>>>> 		struct nvm_tgt_dev *dev =3D pblk->dev;
>>>>> 		struct nvm_geo *geo =3D &dev->geo;
>>>>>=20
>>>>> -		pr_err("pblk: could not async erase line:%d,blk:%d\n",
>>>>> +		pblk_err(pblk, "could not async erase line:%d,blk:%d\n",
>>>>> 					pblk_ppa_to_line(ppa),
>>>>> 					pblk_ppa_to_pos(geo, ppa));
>>>>> 	}
>>>>> @@ -1866,7 +1866,8 @@ static void __pblk_down_page(struct pblk =
*pblk, struct ppa_addr *ppa_list,
>>>>>=20
>>>>> 	ret =3D down_timeout(&rlun->wr_sem, msecs_to_jiffies(30000));
>>>>> 	if (ret =3D=3D -ETIME || ret =3D=3D -EINTR)
>>>>> -		pr_err("pblk: taking lun semaphore timed out: err %d\n", =
-ret);
>>>>> +		pblk_err(pblk, "taking lun semaphore timed out: err =
%d\n",
>>>>> +				-ret);
>>>>> }
>>>>>=20
>>>>> void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, =
int nr_ppas)
>>>>> diff --git a/drivers/lightnvm/pblk-gc.c =
b/drivers/lightnvm/pblk-gc.c
>>>>> index ec56f581397b..93e06b613b6b 100644
>>>>> --- a/drivers/lightnvm/pblk-gc.c
>>>>> +++ b/drivers/lightnvm/pblk-gc.c
>>>>> @@ -90,7 +90,7 @@ static void pblk_gc_line_ws(struct work_struct =
*work)
>>>>>=20
>>>>> 	gc_rq->data =3D vmalloc(gc_rq->nr_secs * geo->csecs);
>>>>> 	if (!gc_rq->data) {
>>>>> -		pr_err("pblk: could not GC line:%d (%d/%d)\n",
>>>>> +		pblk_err(pblk, "could not GC line:%d (%d/%d)\n",
>>>>> 					line->id, *line->vsc, =
gc_rq->nr_secs);
>>>> No need for this check. Maybe you can move the error to the out: =
tag and
>>>> report the same as when pblk_submit_read_gc() fails.
>>>>> goto out;
>>>>> 	}
>>>>> @@ -98,7 +98,7 @@ static void pblk_gc_line_ws(struct work_struct =
*work)
>>>>> 	/* Read from GC victim block */
>>>>> 	ret =3D pblk_submit_read_gc(pblk, gc_rq);
>>>>> 	if (ret) {
>>>>> -		pr_err("pblk: failed GC read in line:%d (err:%d)\n",
>>>>> +		pblk_err(pblk, "failed GC read in line:%d (err:%d)\n",
>>>>> 								=
line->id, ret);
>>>>> 		goto out;
>>>>> 	}
>>>>> @@ -146,7 +146,7 @@ static __le64 *get_lba_list_from_emeta(struct =
pblk *pblk,
>>>>>=20
>>>>> 	ret =3D pblk_line_read_emeta(pblk, line, emeta_buf);
>>>>> 	if (ret) {
>>>>> -		pr_err("pblk: line %d read emeta failed (%d)\n",
>>>>> +		pblk_err(pblk, "line %d read emeta failed (%d)\n",
>>>>> 				line->id, ret);
>>>>> 		pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
>>>>> 		return NULL;
>>>>> @@ -160,7 +160,7 @@ static __le64 *get_lba_list_from_emeta(struct =
pblk *pblk,
>>>>>=20
>>>>> 	ret =3D pblk_recov_check_emeta(pblk, emeta_buf);
>>>>> 	if (ret) {
>>>>> -		pr_err("pblk: inconsistent emeta (line %d)\n",
>>>>> +		pblk_err(pblk, "inconsistent emeta (line %d)\n",
>>>>> 				line->id);
>>>>> 		pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
>>>>> 		return NULL;
>>>>> @@ -201,7 +201,7 @@ static void pblk_gc_line_prepare_ws(struct =
work_struct *work)
>>>>> 	} else {
>>>>> 		lba_list =3D get_lba_list_from_emeta(pblk, line);
>>>>> 		if (!lba_list) {
>>>>> -			pr_err("pblk: could not interpret emeta (line =
%d)\n",
>>>>> +			pblk_err(pblk, "could not interpret emeta (line =
%d)\n",
>>>>> 					line->id);
>>>>> 			goto fail_free_invalid_bitmap;
>>>>> 		}
>>>>> @@ -213,7 +213,7 @@ static void pblk_gc_line_prepare_ws(struct =
work_struct *work)
>>>>> 	spin_unlock(&line->lock);
>>>>>=20
>>>>> 	if (sec_left < 0) {
>>>>> -		pr_err("pblk: corrupted GC line (%d)\n", line->id);
>>>>> +		pblk_err(pblk, "corrupted GC line (%d)\n", line->id);
>>>>> 		goto fail_free_lba_list;
>>>>> 	}
>>>>>=20
>>>>> @@ -289,7 +289,7 @@ static void pblk_gc_line_prepare_ws(struct =
work_struct *work)
>>>>> 	kref_put(&line->ref, pblk_line_put);
>>>>> 	atomic_dec(&gc->read_inflight_gc);
>>>>>=20
>>>>> -	pr_err("pblk: Failed to GC line %d\n", line->id);
>>>>> +	pblk_err(pblk, "failed to GC line %d\n", line->id);
>>>>> }
>>>>>=20
>>>>> static int pblk_gc_line(struct pblk *pblk, struct pblk_line *line)
>>>>> @@ -297,7 +297,7 @@ static int pblk_gc_line(struct pblk *pblk, =
struct pblk_line *line)
>>>>> 	struct pblk_gc *gc =3D &pblk->gc;
>>>>> 	struct pblk_line_ws *line_ws;
>>>>>=20
>>>>> -	pr_debug("pblk: line '%d' being reclaimed for GC\n", line->id);
>>>>> +	pblk_debug(pblk, "line '%d' being reclaimed for GC\n", =
line->id);
>>>>>=20
>>>>> 	line_ws =3D kmalloc(sizeof(struct pblk_line_ws), GFP_KERNEL);
>>>>> 	if (!line_ws)
>>>>> @@ -351,7 +351,7 @@ static int pblk_gc_read(struct pblk *pblk)
>>>>> 	pblk_gc_kick(pblk);
>>>>>=20
>>>>> 	if (pblk_gc_line(pblk, line))
>>>>> -		pr_err("pblk: failed to GC line %d\n", line->id);
>>>>> +		pblk_err(pblk, "failed to GC line %d\n", line->id);
>>>>>=20
>>>>> 	return 0;
>>>>> }
>>>>> @@ -523,7 +523,7 @@ static int pblk_gc_reader_ts(void *data)
>>>>> 	}
>>>>>=20
>>>>> #ifdef CONFIG_NVM_PBLK_DEBUG
>>>>> -	pr_info("pblk: flushing gc pipeline, %d lines left\n",
>>>>> +	pblk_info(pblk, "flushing gc pipeline, %d lines left\n",
>>>>> 		atomic_read(&gc->pipeline_gc));
>>>>> #endif
>>>>>=20
>>>>> @@ -540,7 +540,7 @@ static int pblk_gc_reader_ts(void *data)
>>>>> static void pblk_gc_start(struct pblk *pblk)
>>>>> {
>>>>> 	pblk->gc.gc_active =3D 1;
>>>>> -	pr_debug("pblk: gc start\n");
>>>>> +	pblk_debug(pblk, "gc start\n");
>>>>> }
>>>>>=20
>>>>> void pblk_gc_should_start(struct pblk *pblk)
>>>>> @@ -605,14 +605,14 @@ int pblk_gc_init(struct pblk *pblk)
>>>>>=20
>>>>> 	gc->gc_ts =3D kthread_create(pblk_gc_ts, pblk, "pblk-gc-ts");
>>>>> 	if (IS_ERR(gc->gc_ts)) {
>>>>> -		pr_err("pblk: could not allocate GC main kthread\n");
>>>>> +		pblk_err(pblk, "could not allocate GC main kthread\n");
>>>>> 		return PTR_ERR(gc->gc_ts);
>>>>> 	}
>>>>>=20
>>>>> 	gc->gc_writer_ts =3D kthread_create(pblk_gc_writer_ts, pblk,
>>>>> 							=
"pblk-gc-writer-ts");
>>>>> 	if (IS_ERR(gc->gc_writer_ts)) {
>>>>> -		pr_err("pblk: could not allocate GC writer kthread\n");
>>>>> +		pblk_err(pblk, "could not allocate GC writer =
kthread\n");
>>>>> 		ret =3D PTR_ERR(gc->gc_writer_ts);
>>>>> 		goto fail_free_main_kthread;
>>>>> 	}
>>>>> @@ -620,7 +620,7 @@ int pblk_gc_init(struct pblk *pblk)
>>>>> 	gc->gc_reader_ts =3D kthread_create(pblk_gc_reader_ts, pblk,
>>>>> 							=
"pblk-gc-reader-ts");
>>>>> 	if (IS_ERR(gc->gc_reader_ts)) {
>>>>> -		pr_err("pblk: could not allocate GC reader kthread\n");
>>>>> +		pblk_err(pblk, "could not allocate GC reader =
kthread\n");
>>>>> 		ret =3D PTR_ERR(gc->gc_reader_ts);
>>>>> 		goto fail_free_writer_kthread;
>>>>> 	}
>>>>> @@ -641,7 +641,7 @@ int pblk_gc_init(struct pblk *pblk)
>>>>> 	gc->gc_line_reader_wq =3D =
alloc_workqueue("pblk-gc-line-reader-wq",
>>>>> 			WQ_MEM_RECLAIM | WQ_UNBOUND, =
PBLK_GC_MAX_READERS);
>>>>> 	if (!gc->gc_line_reader_wq) {
>>>>> -		pr_err("pblk: could not allocate GC line reader =
workqueue\n");
>>>>> +		pblk_err(pblk, "could not allocate GC line reader =
workqueue\n");
>>>>> 		ret =3D -ENOMEM;
>>>>> 		goto fail_free_reader_kthread;
>>>>> 	}
>>>>> @@ -650,7 +650,7 @@ int pblk_gc_init(struct pblk *pblk)
>>>>> 	gc->gc_reader_wq =3D alloc_workqueue("pblk-gc-line_wq",
>>>>> 					WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
>>>>> 	if (!gc->gc_reader_wq) {
>>>>> -		pr_err("pblk: could not allocate GC reader =
workqueue\n");
>>>>> +		pblk_err(pblk, "could not allocate GC reader =
workqueue\n");
>>>>> 		ret =3D -ENOMEM;
>>>>> 		goto fail_free_reader_line_wq;
>>>>> 	}
>>>>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>>>>> index aa2426403171..d87d38f063fa 100644
>>>>> --- a/drivers/lightnvm/pblk-init.c
>>>>> +++ b/drivers/lightnvm/pblk-init.c
>>>>> @@ -117,13 +117,13 @@ static int pblk_l2p_recover(struct pblk =
*pblk, bool factory_init)
>>>>> 	} else {
>>>>> 		line =3D pblk_recov_l2p(pblk);
>>>>> 		if (IS_ERR(line)) {
>>>>> -			pr_err("pblk: could not recover l2p table\n");
>>>>> +			pblk_err(pblk, "could not recover l2p table\n");
>>>>> 			return -EFAULT;
>>>>> 		}
>>>>> 	}
>>>>>=20
>>>>> #ifdef CONFIG_NVM_PBLK_DEBUG
>>>>> -	pr_info("pblk init: L2P CRC: %x\n", pblk_l2p_crc(pblk));
>>>>> +	pblk_info(pblk, "init: L2P CRC: %x\n", pblk_l2p_crc(pblk));
>>>>> #endif
>>>>>=20
>>>>> 	/* Free full lines directly as GC has not been started yet */
>>>>> @@ -166,7 +166,7 @@ static int pblk_l2p_init(struct pblk *pblk, =
bool factory_init)
>>>>> static void pblk_rwb_free(struct pblk *pblk)
>>>>> {
>>>>> 	if (pblk_rb_tear_down_check(&pblk->rwb))
>>>>> -		pr_err("pblk: write buffer error on tear down\n");
>>>>> +		pblk_err(pblk, "write buffer error on tear down\n");
>>>>>=20
>>>>> 	pblk_rb_data_free(&pblk->rwb);
>>>>> 	vfree(pblk_rb_entries_ref(&pblk->rwb));
>>>>> @@ -203,7 +203,8 @@ static int pblk_rwb_init(struct pblk *pblk)
>>>>> /* Minimum pages needed within a lun */
>>>>> #define ADDR_POOL_SIZE 64
>>>>>=20
>>>>> -static int pblk_set_addrf_12(struct nvm_geo *geo, struct =
nvm_addrf_12 *dst)
>>>>> +static int pblk_set_addrf_12(struct pblk *pblk, struct nvm_geo =
*geo,
>>>>> +			     struct nvm_addrf_12 *dst)
>>>>> {
>>>>> 	struct nvm_addrf_12 *src =3D (struct nvm_addrf_12 *)&geo->addrf;
>>>>> 	int power_len;
>>>>> @@ -211,14 +212,14 @@ static int pblk_set_addrf_12(struct nvm_geo =
*geo, struct nvm_addrf_12 *dst)
>>>>> 	/* Re-calculate channel and lun format to adapt to configuration =
*/
>>>>> 	power_len =3D get_count_order(geo->num_ch);
>>>>> 	if (1 << power_len !=3D geo->num_ch) {
>>>>> -		pr_err("pblk: supports only power-of-two channel =
config.\n");
>>>>> +		pblk_err(pblk, "supports only power-of-two channel =
config.\n");
>>>>> 		return -EINVAL;
>>>>> 	}
>>>>> 	dst->ch_len =3D power_len;
>>>>>=20
>>>>> 	power_len =3D get_count_order(geo->num_lun);
>>>>> 	if (1 << power_len !=3D geo->num_lun) {
>>>>> -		pr_err("pblk: supports only power-of-two LUN =
config.\n");
>>>>> +		pblk_err(pblk, "supports only power-of-two LUN =
config.\n");
>>>>> 		return -EINVAL;
>>>>> 	}
>>>>> 	dst->lun_len =3D power_len;
>>>>> @@ -285,18 +286,19 @@ static int pblk_set_addrf(struct pblk *pblk)
>>>>> 	case NVM_OCSSD_SPEC_12:
>>>>> 		div_u64_rem(geo->clba, pblk->min_write_pgs, &mod);
>>>>> 		if (mod) {
>>>>> -			pr_err("pblk: bad configuration of =
sectors/pages\n");
>>>>> +			pblk_err(pblk, "bad configuration of =
sectors/pages\n");
>>>>> 			return -EINVAL;
>>>>> 		}
>>>>>=20
>>>>> -		pblk->addrf_len =3D pblk_set_addrf_12(geo, (void =
*)&pblk->addrf);
>>>>> +		pblk->addrf_len =3D pblk_set_addrf_12(pblk, geo,
>>>>> +							(void =
*)&pblk->addrf);
>>>>> 		break;
>>>>> 	case NVM_OCSSD_SPEC_20:
>>>>> 		pblk->addrf_len =3D pblk_set_addrf_20(geo, (void =
*)&pblk->addrf,
>>>>> -								=
&pblk->uaddrf);
>>>>> +							&pblk->uaddrf);
>>>>> 		break;
>>>>> 	default:
>>>>> -		pr_err("pblk: OCSSD revision not supported (%d)\n",
>>>>> +		pblk_err(pblk, "OCSSD revision not supported (%d)\n",
>>>>> 								=
geo->version);
>>>>> 		return -EINVAL;
>>>>> 	}
>>>>> @@ -375,7 +377,7 @@ static int pblk_core_init(struct pblk *pblk)
>>>>> 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
>>>>>=20
>>>>> 	if (pblk->max_write_pgs > PBLK_MAX_REQ_ADDRS) {
>>>>> -		pr_err("pblk: vector list too big(%u > %u)\n",
>>>>> +		pblk_err(pblk, "vector list too big(%u > %u)\n",
>>>>> 				pblk->max_write_pgs, =
PBLK_MAX_REQ_ADDRS);
>>>>> 		return -EINVAL;
>>>>> 	}
>>>>> @@ -608,7 +610,7 @@ static int pblk_luns_init(struct pblk *pblk)
>>>>>=20
>>>>> 	/* TODO: Implement unbalanced LUN support */
>>>>> 	if (geo->num_lun < 0) {
>>>>> -		pr_err("pblk: unbalanced LUN config.\n");
>>>>> +		pblk_err(pblk, "unbalanced LUN config.\n");
>>>>> 		return -EINVAL;
>>>>> 	}
>>>>>=20
>>>>> @@ -1027,7 +1029,7 @@ static int pblk_line_meta_init(struct pblk =
*pblk)
>>>>> 					lm->emeta_sec[0], geo->clba);
>>>>>=20
>>>>> 	if (lm->min_blk_line > lm->blk_per_line) {
>>>>> -		pr_err("pblk: config. not supported. Min. LUN in =
line:%d\n",
>>>>> +		pblk_err(pblk, "config. not supported. Min. LUN in =
line:%d\n",
>>>>> 							=
lm->blk_per_line);
>>>>> 		return -EINVAL;
>>>>> 	}
>>>>> @@ -1079,7 +1081,7 @@ static int pblk_lines_init(struct pblk =
*pblk)
>>>>> 	}
>>>>>=20
>>>>> 	if (!nr_free_chks) {
>>>>> -		pr_err("pblk: too many bad blocks prevent for sane =
instance\n");
>>>>> +		pblk_err(pblk, "too many bad blocks prevent for sane =
instance\n");
>>>>> 		return -EINTR;
>>>>> 	}
>>>>>=20
>>>>> @@ -1109,7 +1111,7 @@ static int pblk_writer_init(struct pblk =
*pblk)
>>>>> 		int err =3D PTR_ERR(pblk->writer_ts);
>>>>>=20
>>>>> 		if (err !=3D -EINTR)
>>>>> -			pr_err("pblk: could not allocate writer kthread =
(%d)\n",
>>>>> +			pblk_err(pblk, "could not allocate writer =
kthread (%d)\n",
>>>>> 					err);
>>>>> 		return err;
>>>>> 	}
>>>>> @@ -1155,7 +1157,7 @@ static void pblk_tear_down(struct pblk =
*pblk, bool graceful)
>>>>> 	pblk_rb_sync_l2p(&pblk->rwb);
>>>>> 	pblk_rl_free(&pblk->rl);
>>>>>=20
>>>>> -	pr_debug("pblk: consistent tear down (graceful:%d)\n", =
graceful);
>>>>> +	pblk_debug(pblk, "consistent tear down (graceful:%d)\n", =
graceful);
>>>>> }
>>>>>=20
>>>>> static void pblk_exit(void *private, bool graceful)
>>>>> @@ -1167,7 +1169,7 @@ static void pblk_exit(void *private, bool =
graceful)
>>>>> 	pblk_tear_down(pblk, graceful);
>>>>>=20
>>>>> #ifdef CONFIG_NVM_PBLK_DEBUG
>>>>> -	pr_info("pblk exit: L2P CRC: %x\n", pblk_l2p_crc(pblk));
>>>>> +	pblk_info(pblk, "exit: L2P CRC: %x\n", pblk_l2p_crc(pblk));
>>>>> #endif
>>>>>=20
>>>>> 	pblk_free(pblk);
>>>>> @@ -1190,20 +1192,6 @@ static void *pblk_init(struct nvm_tgt_dev =
*dev, struct gendisk *tdisk,
>>>>> 	struct pblk *pblk;
>>>>> 	int ret;
>>>>>=20
>>>>> -	/* pblk supports 1.2 and 2.0 versions */
>>>>> -	if (!(geo->version =3D=3D NVM_OCSSD_SPEC_12 ||
>>>>> -					geo->version =3D=3D =
NVM_OCSSD_SPEC_20)) {
>>>>> -		pr_err("pblk: OCSSD version not supported (%u)\n",
>>>>> -							geo->version);
>>>>> -		return ERR_PTR(-EINVAL);
>>>>> -	}
>>>>> -
>>>>> -	if (geo->version =3D=3D NVM_OCSSD_SPEC_12 && geo->dom & =
NVM_RSP_L2P) {
>>>>> -		pr_err("pblk: host-side L2P table not supported. =
(%x)\n",
>>>>> -							geo->dom);
>>>>> -		return ERR_PTR(-EINVAL);
>>>>> -	}
>>>>> -
>>>>> 	pblk =3D kzalloc(sizeof(struct pblk), GFP_KERNEL);
>>>>> 	if (!pblk)
>>>>> 		return ERR_PTR(-ENOMEM);
>>>>> @@ -1213,6 +1201,19 @@ static void *pblk_init(struct nvm_tgt_dev =
*dev, struct gendisk *tdisk,
>>>>> 	pblk->state =3D PBLK_STATE_RUNNING;
>>>>> 	pblk->gc.gc_enabled =3D 0;
>>>>>=20
>>>>> +	if (!(geo->version =3D=3D NVM_OCSSD_SPEC_12 ||
>>>>> +					geo->version =3D=3D =
NVM_OCSSD_SPEC_20)) {
>>>>> +		pblk_err(pblk, "OCSSD version not supported (%u)\n",
>>>>> +							geo->version);
>>>>> +		return ERR_PTR(-EINVAL);
>>>>> +	}
>>>>> +
>>>>> +	if (geo->version =3D=3D NVM_OCSSD_SPEC_12 && geo->dom & =
NVM_RSP_L2P) {
>>>>> +		pblk_err(pblk, "host-side L2P table not supported. =
(%x)\n",
>>>>> +							geo->dom);
>>>>> +		return ERR_PTR(-EINVAL);
>>>>> +	}
>>>>> +
>>>> Why move the check down? At this point the instance is not even =
created,
>>>> so you can fail directly. In any case, here you should set ret and =
goto
>>>> fail to free pblk.
>>>=20
>>> pblk_err depends on the gendisk diskname, which is within the ->disk =
parameter.
>> I was suggesting to fail directly on tdisk - no need to allocate
>> pblk and then pblk->disk =3D tdisk to use a given error interface. If =
you
>> have a strong feeling about this, I'm ok with it, but then please =
free
>> struct pblk *pblk on the error path.
>=20
> I don't know if I have strong feelings about it. But it find it =
prettier to pass pblk, instead of pblk->disk to each of the error =
messages.
>=20
> Yep, free's are missing. I had them in a previous previous revision, =
but got lost on the way :)

Hehehe. Cool, so let's do it this way. Thanks!

Javier


--Apple-Mail=_297A22E8-7A06-41D7-BAC6-8937884114A0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAls2Fs4ACgkQIX4xUKFR
nnQBEQ//WOMZg2x3FoSVBbFbcc/vuvAvN/euXnRmN68tjOB6kRhXbm3cKrqUGBBH
+8T/zttfyCzdZ/9Jo4BzoDeV0rNdgPCZ7ga6AW9kZujQd5kLTvEl/hMGZstQCGml
pVyZ3XSfGEXFXA0XII4YjRULoHiXvMPQeDcKxRHaxe5ihNFQ6LzIzPPwax5jfRvj
kb3hU4e9B9JM3OKy0OHPuZCxHChPXXX2v2bHgR+IS3Drr/EB8NUeHDx4SUkxMOXu
8qQD3dnPoC/m6lOVNkIAkPUC48opJSc6n4FCufnTcLD2BUk4Rs6fOwS1iOaOQyKv
3VPKAbuY+CIPgPl3Eeb9XN3H070eH2/5RPiuPNavo/oH+8YtAf0npW+tEtiZtH38
STWXcuaWaEK/fQeQQwZ80CxLpK3F9lYlxWN88VJPngQjviD5P7Hp1HlkyK3cb8wa
zZd4WhJEWpu4EB9eQm6F/sKL+O8dhvuDSCj9GVTGzcEcOBrGCs+dbXLSR6sxM4iC
453ERirp8DO6iqYoV6y8ql/D+Wy9S5//32r3fJKk6NR0SvXnNkVClNeRKC5GmtOc
ZB4h9QtHZwxcO1yaHTv4JuCIecXqwutyM9TYOXuS326f3fXHQfuxyHjX6q1+bXcj
lB1IJ+7WQOY9RCQqVtZjB7STtH+OgVtRniJO5W/MU5ZuIB/xKp4=
=Pdig
-----END PGP SIGNATURE-----

--Apple-Mail=_297A22E8-7A06-41D7-BAC6-8937884114A0--
