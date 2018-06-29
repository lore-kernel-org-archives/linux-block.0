Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43633 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755309AbeF2LWv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jun 2018 07:22:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id h2-v6so3784779ljb.10
        for <linux-block@vger.kernel.org>; Fri, 29 Jun 2018 04:22:50 -0700 (PDT)
Subject: Re: [PATCH v2] lightnvm: pblk: expose generic disk name on pr_* msgs
To: javier@cnexlabs.com
Cc: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180628134305.26910-1-mb@lightnvm.io>
 <72C0D646-DD42-4DE9-877B-27A028A0C7DA@cnexlabs.com>
 <0a83d2bd-c41b-4ecc-5ee8-f1e7e6aae30c@lightnvm.io>
 <D0B243BC-41B7-47D6-9440-E8F8033E449A@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <0f4d0bae-a30e-72fb-113f-68a967b793a8@lightnvm.io>
Date: Fri, 29 Jun 2018 13:22:47 +0200
MIME-Version: 1.0
In-Reply-To: <D0B243BC-41B7-47D6-9440-E8F8033E449A@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/29/2018 01:07 PM, Javier Gonzalez wrote:
>> On 29 Jun 2018, at 12.59, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 06/29/2018 11:36 AM, Javier Gonzalez wrote:
>>>> On 28 Jun 2018, at 15.43, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>
>>>> The error messages in pblk does not say which pblk instance that
>>>> a message occurred from. Update each error message to reflect the
>>>> instance it belongs to, and also prefix it with pblk, so we know
>>>> the message comes from the pblk module.
>>>>
>>>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>>> This could be a good moment to make error reporting mroe consistent.
>>> Some times we used "could not ..." and others "failed to ...".
>>
>> Agree. This should properly be another patch, such that it does not
>> pollute the raw conversion.
>>
> 
> Cool.
> 
>>> There is also an unnecessary error for a memory allocation (see
>>> checkpatch).
>>
>> That is intentional since I wanted to keep the existing wording.
>> Although, I also looked at it, and kind of came to the conclusion that
>> it was put there for a reason (since exports more than a no memory
>> message).
>>
> 
> Ok. We can have a separate patch to make this better, as mentioned
> below.
> 
>>> See below.
>>>> ---
>>>>
>>>> Forgot to test with NVM_PBLK_DEBUG on. Fixed up the broken code.
>>>> ---
>>>> drivers/lightnvm/pblk-core.c     | 51 +++++++++++++-------------
>>>> drivers/lightnvm/pblk-gc.c       | 32 ++++++++---------
>>>> drivers/lightnvm/pblk-init.c     | 78 ++++++++++++++++++++--------------------
>>>> drivers/lightnvm/pblk-rb.c       |  8 ++---
>>>> drivers/lightnvm/pblk-read.c     | 25 ++++++-------
>>>> drivers/lightnvm/pblk-recovery.c | 44 +++++++++++------------
>>>> drivers/lightnvm/pblk-sysfs.c    |  5 ++-
>>>> drivers/lightnvm/pblk-write.c    | 21 +++++------
>>>> drivers/lightnvm/pblk.h          | 29 ++++++++++-----
>>>> 9 files changed, 153 insertions(+), 140 deletions(-)
>>>>
>>>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>>>> index 66ab1036f2fb..b829460fe827 100644
>>>> --- a/drivers/lightnvm/pblk-core.c
>>>> +++ b/drivers/lightnvm/pblk-core.c
>>>> @@ -35,7 +35,7 @@ static void pblk_line_mark_bb(struct work_struct *work)
>>>> 		line = &pblk->lines[pblk_ppa_to_line(*ppa)];
>>>> 		pos = pblk_ppa_to_pos(&dev->geo, *ppa);
>>>>
>>>> -		pr_err("pblk: failed to mark bb, line:%d, pos:%d\n",
>>>> +		pblk_err(pblk, "failed to mark bb, line:%d, pos:%d\n",
>>>> 				line->id, pos);
>>>> 	}
>>>>
>>>> @@ -51,12 +51,12 @@ static void pblk_mark_bb(struct pblk *pblk, struct pblk_line *line,
>>>> 	struct ppa_addr *ppa;
>>>> 	int pos = pblk_ppa_to_pos(geo, ppa_addr);
>>>>
>>>> -	pr_debug("pblk: erase failed: line:%d, pos:%d\n", line->id, pos);
>>>> +	pblk_debug(pblk, "erase failed: line:%d, pos:%d\n", line->id, pos);
>>>> 	atomic_long_inc(&pblk->erase_failed);
>>>>
>>>> 	atomic_dec(&line->blk_in_line);
>>>> 	if (test_and_set_bit(pos, line->blk_bitmap))
>>>> -		pr_err("pblk: attempted to erase bb: line:%d, pos:%d\n",
>>>> +		pblk_err(pblk, "attempted to erase bb: line:%d, pos:%d\n",
>>>> 							line->id, pos);
>>>>
>>>> 	/* Not necessary to mark bad blocks on 2.0 spec. */
>>>> @@ -274,7 +274,7 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
>>>> 		pool = &pblk->e_rq_pool;
>>>> 		break;
>>>> 	default:
>>>> -		pr_err("pblk: trying to free unknown rqd type\n");
>>>> +		pblk_err(pblk, "trying to free unknown rqd type\n");
>>>> 		return;
>>>> 	}
>>>>
>>>> @@ -310,7 +310,7 @@ int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t flags,
>>>>
>>>> 		ret = bio_add_pc_page(q, bio, page, PBLK_EXPOSED_PAGE_SIZE, 0);
>>>> 		if (ret != PBLK_EXPOSED_PAGE_SIZE) {
>>>> -			pr_err("pblk: could not add page to bio\n");
>>>> +			pblk_err(pblk, "could not add page to bio\n");
>>>> 			mempool_free(page, &pblk->page_bio_pool);
>>>> 			goto err;
>>>> 		}
>>>> @@ -410,7 +410,7 @@ struct list_head *pblk_line_gc_list(struct pblk *pblk, struct pblk_line *line)
>>>> 		line->state = PBLK_LINESTATE_CORRUPT;
>>>> 		line->gc_group = PBLK_LINEGC_NONE;
>>>> 		move_list =  &l_mg->corrupt_list;
>>>> -		pr_err("pblk: corrupted vsc for line %d, vsc:%d (%d/%d/%d)\n",
>>>> +		pblk_err(pblk, "corrupted vsc for line %d, vsc:%d (%d/%d/%d)\n",
>>>> 						line->id, vsc,
>>>> 						line->sec_in_line,
>>>> 						lm->high_thrs, lm->mid_thrs);
>>>> @@ -452,7 +452,7 @@ void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd)
>>>> 		atomic_long_inc(&pblk->read_failed);
>>>> 		break;
>>>> 	default:
>>>> -		pr_err("pblk: unknown read error:%d\n", rqd->error);
>>>> +		pblk_err(pblk, "unknown read error:%d\n", rqd->error);
>>>> 	}
>>>> #ifdef CONFIG_NVM_PBLK_DEBUG
>>>> 	pblk_print_failed_rqd(pblk, rqd, rqd->error);
>>>> @@ -517,7 +517,7 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
>>>> 	for (i = 0; i < nr_secs; i++) {
>>>> 		page = vmalloc_to_page(kaddr);
>>>> 		if (!page) {
>>>> -			pr_err("pblk: could not map vmalloc bio\n");
>>>> +			pblk_err(pblk, "could not map vmalloc bio\n");
>>>> 			bio_put(bio);
>>>> 			bio = ERR_PTR(-ENOMEM);
>>>> 			goto out;
>>>> @@ -525,7 +525,7 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
>>>>
>>>> 		ret = bio_add_pc_page(dev->q, bio, page, PAGE_SIZE, 0);
>>>> 		if (ret != PAGE_SIZE) {
>>>> -			pr_err("pblk: could not add page to bio\n");
>>>> +			pblk_err(pblk, "could not add page to bio\n");
>>>> 			bio_put(bio);
>>>> 			bio = ERR_PTR(-ENOMEM);
>>>> 			goto out;
>>>> @@ -711,7 +711,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
>>>> 			while (test_bit(pos, line->blk_bitmap)) {
>>>> 				paddr += min;
>>>> 				if (pblk_boundary_paddr_checks(pblk, paddr)) {
>>>> -					pr_err("pblk: corrupt emeta line:%d\n",
>>>> +					pblk_err(pblk, "corrupt emeta line:%d\n",
>>>> 								line->id);
>>>> 					bio_put(bio);
>>>> 					ret = -EINTR;
>>>> @@ -723,7 +723,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
>>>> 			}
>>>>
>>>> 			if (pblk_boundary_paddr_checks(pblk, paddr + min)) {
>>>> -				pr_err("pblk: corrupt emeta line:%d\n",
>>>> +				pblk_err(pblk, "corrupt emeta line:%d\n",
>>>> 								line->id);
>>>> 				bio_put(bio);
>>>> 				ret = -EINTR;
>>>> @@ -738,7 +738,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
>>>>
>>>> 	ret = pblk_submit_io_sync(pblk, &rqd);
>>>> 	if (ret) {
>>>> -		pr_err("pblk: emeta I/O submission failed: %d\n", ret);
>>>> +		pblk_err(pblk, "emeta I/O submission failed: %d\n", ret);
>>>> 		bio_put(bio);
>>>> 		goto free_rqd_dma;
>>>> 	}
>>>> @@ -843,7 +843,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
>>>> 	 */
>>>> 	ret = pblk_submit_io_sync(pblk, &rqd);
>>>> 	if (ret) {
>>>> -		pr_err("pblk: smeta I/O submission failed: %d\n", ret);
>>>> +		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
>>>> 		bio_put(bio);
>>>> 		goto free_ppa_list;
>>>> 	}
>>>> @@ -905,7 +905,7 @@ static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
>>>> 		struct nvm_tgt_dev *dev = pblk->dev;
>>>> 		struct nvm_geo *geo = &dev->geo;
>>>>
>>>> -		pr_err("pblk: could not sync erase line:%d,blk:%d\n",
>>>> +		pblk_err(pblk, "could not sync erase line:%d,blk:%d\n",
>>>> 					pblk_ppa_to_line(ppa),
>>>> 					pblk_ppa_to_pos(geo, ppa));
>>>>
>>>> @@ -945,7 +945,7 @@ int pblk_line_erase(struct pblk *pblk, struct pblk_line *line)
>>>>
>>>> 		ret = pblk_blk_erase_sync(pblk, ppa);
>>>> 		if (ret) {
>>>> -			pr_err("pblk: failed to erase line %d\n", line->id);
>>>> +			pblk_err(pblk, "failed to erase line %d\n", line->id);
>>>> 			return ret;
>>>> 		}
>>>> 	} while (1);
>>>> @@ -1012,7 +1012,7 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
>>>> 		list_add_tail(&line->list, &l_mg->bad_list);
>>>> 		spin_unlock(&l_mg->free_lock);
>>>>
>>>> -		pr_debug("pblk: line %d is bad\n", line->id);
>>>> +		pblk_debug(pblk, "line %d is bad\n", line->id);
>>>>
>>>> 		return 0;
>>>> 	}
>>>> @@ -1122,7 +1122,7 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
>>>> 	line->cur_sec = off + lm->smeta_sec;
>>>>
>>>> 	if (init && pblk_line_submit_smeta_io(pblk, line, off, PBLK_WRITE)) {
>>>> -		pr_debug("pblk: line smeta I/O failed. Retry\n");
>>>> +		pblk_debug(pblk, "line smeta I/O failed. Retry\n");
>>>> 		return 0;
>>>> 	}
>>>>
>>>> @@ -1154,7 +1154,7 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
>>>> 		spin_unlock(&line->lock);
>>>>
>>>> 		list_add_tail(&line->list, &l_mg->bad_list);
>>>> -		pr_err("pblk: unexpected line %d is bad\n", line->id);
>>>> +		pblk_err(pblk, "unexpected line %d is bad\n", line->id);
>>>>
>>>> 		return 0;
>>>> 	}
>>>> @@ -1299,7 +1299,7 @@ struct pblk_line *pblk_line_get(struct pblk *pblk)
>>>>
>>>> retry:
>>>> 	if (list_empty(&l_mg->free_list)) {
>>>> -		pr_err("pblk: no free lines\n");
>>>> +		pblk_err(pblk, "no free lines\n");
>>>> 		return NULL;
>>>> 	}
>>>>
>>>> @@ -1315,7 +1315,7 @@ struct pblk_line *pblk_line_get(struct pblk *pblk)
>>>>
>>>> 		list_add_tail(&line->list, &l_mg->bad_list);
>>>>
>>>> -		pr_debug("pblk: line %d is bad\n", line->id);
>>>> +		pblk_debug(pblk, "line %d is bad\n", line->id);
>>>> 		goto retry;
>>>> 	}
>>>>
>>>> @@ -1329,7 +1329,7 @@ struct pblk_line *pblk_line_get(struct pblk *pblk)
>>>> 			list_add(&line->list, &l_mg->corrupt_list);
>>>> 			goto retry;
>>>> 		default:
>>>> -			pr_err("pblk: failed to prepare line %d\n", line->id);
>>>> +			pblk_err(pblk, "failed to prepare line %d\n", line->id);
>>>> 			list_add(&line->list, &l_mg->free_list);
>>>> 			l_mg->nr_free_lines++;
>>>> 			return NULL;
>>>> @@ -1477,7 +1477,7 @@ static void pblk_line_close_meta_sync(struct pblk *pblk)
>>>>
>>>> 			ret = pblk_submit_meta_io(pblk, line);
>>>> 			if (ret) {
>>>> -				pr_err("pblk: sync meta line %d failed (%d)\n",
>>>> +				pblk_err(pblk, "sync meta line %d failed (%d)\n",
>>>> 							line->id, ret);
>>>> 				return;
>>>> 			}
>>>> @@ -1507,7 +1507,7 @@ void __pblk_pipeline_flush(struct pblk *pblk)
>>>>
>>>> 	ret = pblk_recov_pad(pblk);
>>>> 	if (ret) {
>>>> -		pr_err("pblk: could not close data on teardown(%d)\n", ret);
>>>> +		pblk_err(pblk, "could not close data on teardown(%d)\n", ret);
>>>> 		return;
>>>> 	}
>>>>
>>>> @@ -1687,7 +1687,7 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
>>>> 		struct nvm_tgt_dev *dev = pblk->dev;
>>>> 		struct nvm_geo *geo = &dev->geo;
>>>>
>>>> -		pr_err("pblk: could not async erase line:%d,blk:%d\n",
>>>> +		pblk_err(pblk, "could not async erase line:%d,blk:%d\n",
>>>> 					pblk_ppa_to_line(ppa),
>>>> 					pblk_ppa_to_pos(geo, ppa));
>>>> 	}
>>>> @@ -1866,7 +1866,8 @@ static void __pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list,
>>>>
>>>> 	ret = down_timeout(&rlun->wr_sem, msecs_to_jiffies(30000));
>>>> 	if (ret == -ETIME || ret == -EINTR)
>>>> -		pr_err("pblk: taking lun semaphore timed out: err %d\n", -ret);
>>>> +		pblk_err(pblk, "taking lun semaphore timed out: err %d\n",
>>>> +				-ret);
>>>> }
>>>>
>>>> void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas)
>>>> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
>>>> index ec56f581397b..93e06b613b6b 100644
>>>> --- a/drivers/lightnvm/pblk-gc.c
>>>> +++ b/drivers/lightnvm/pblk-gc.c
>>>> @@ -90,7 +90,7 @@ static void pblk_gc_line_ws(struct work_struct *work)
>>>>
>>>> 	gc_rq->data = vmalloc(gc_rq->nr_secs * geo->csecs);
>>>> 	if (!gc_rq->data) {
>>>> -		pr_err("pblk: could not GC line:%d (%d/%d)\n",
>>>> +		pblk_err(pblk, "could not GC line:%d (%d/%d)\n",
>>>> 					line->id, *line->vsc, gc_rq->nr_secs);
>>> No need for this check. Maybe you can move the error to the out: tag and
>>> report the same as when pblk_submit_read_gc() fails.
>>>> goto out;
>>>> 	}
>>>> @@ -98,7 +98,7 @@ static void pblk_gc_line_ws(struct work_struct *work)
>>>> 	/* Read from GC victim block */
>>>> 	ret = pblk_submit_read_gc(pblk, gc_rq);
>>>> 	if (ret) {
>>>> -		pr_err("pblk: failed GC read in line:%d (err:%d)\n",
>>>> +		pblk_err(pblk, "failed GC read in line:%d (err:%d)\n",
>>>> 								line->id, ret);
>>>> 		goto out;
>>>> 	}
>>>> @@ -146,7 +146,7 @@ static __le64 *get_lba_list_from_emeta(struct pblk *pblk,
>>>>
>>>> 	ret = pblk_line_read_emeta(pblk, line, emeta_buf);
>>>> 	if (ret) {
>>>> -		pr_err("pblk: line %d read emeta failed (%d)\n",
>>>> +		pblk_err(pblk, "line %d read emeta failed (%d)\n",
>>>> 				line->id, ret);
>>>> 		pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
>>>> 		return NULL;
>>>> @@ -160,7 +160,7 @@ static __le64 *get_lba_list_from_emeta(struct pblk *pblk,
>>>>
>>>> 	ret = pblk_recov_check_emeta(pblk, emeta_buf);
>>>> 	if (ret) {
>>>> -		pr_err("pblk: inconsistent emeta (line %d)\n",
>>>> +		pblk_err(pblk, "inconsistent emeta (line %d)\n",
>>>> 				line->id);
>>>> 		pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
>>>> 		return NULL;
>>>> @@ -201,7 +201,7 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
>>>> 	} else {
>>>> 		lba_list = get_lba_list_from_emeta(pblk, line);
>>>> 		if (!lba_list) {
>>>> -			pr_err("pblk: could not interpret emeta (line %d)\n",
>>>> +			pblk_err(pblk, "could not interpret emeta (line %d)\n",
>>>> 					line->id);
>>>> 			goto fail_free_invalid_bitmap;
>>>> 		}
>>>> @@ -213,7 +213,7 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
>>>> 	spin_unlock(&line->lock);
>>>>
>>>> 	if (sec_left < 0) {
>>>> -		pr_err("pblk: corrupted GC line (%d)\n", line->id);
>>>> +		pblk_err(pblk, "corrupted GC line (%d)\n", line->id);
>>>> 		goto fail_free_lba_list;
>>>> 	}
>>>>
>>>> @@ -289,7 +289,7 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
>>>> 	kref_put(&line->ref, pblk_line_put);
>>>> 	atomic_dec(&gc->read_inflight_gc);
>>>>
>>>> -	pr_err("pblk: Failed to GC line %d\n", line->id);
>>>> +	pblk_err(pblk, "failed to GC line %d\n", line->id);
>>>> }
>>>>
>>>> static int pblk_gc_line(struct pblk *pblk, struct pblk_line *line)
>>>> @@ -297,7 +297,7 @@ static int pblk_gc_line(struct pblk *pblk, struct pblk_line *line)
>>>> 	struct pblk_gc *gc = &pblk->gc;
>>>> 	struct pblk_line_ws *line_ws;
>>>>
>>>> -	pr_debug("pblk: line '%d' being reclaimed for GC\n", line->id);
>>>> +	pblk_debug(pblk, "line '%d' being reclaimed for GC\n", line->id);
>>>>
>>>> 	line_ws = kmalloc(sizeof(struct pblk_line_ws), GFP_KERNEL);
>>>> 	if (!line_ws)
>>>> @@ -351,7 +351,7 @@ static int pblk_gc_read(struct pblk *pblk)
>>>> 	pblk_gc_kick(pblk);
>>>>
>>>> 	if (pblk_gc_line(pblk, line))
>>>> -		pr_err("pblk: failed to GC line %d\n", line->id);
>>>> +		pblk_err(pblk, "failed to GC line %d\n", line->id);
>>>>
>>>> 	return 0;
>>>> }
>>>> @@ -523,7 +523,7 @@ static int pblk_gc_reader_ts(void *data)
>>>> 	}
>>>>
>>>> #ifdef CONFIG_NVM_PBLK_DEBUG
>>>> -	pr_info("pblk: flushing gc pipeline, %d lines left\n",
>>>> +	pblk_info(pblk, "flushing gc pipeline, %d lines left\n",
>>>> 		atomic_read(&gc->pipeline_gc));
>>>> #endif
>>>>
>>>> @@ -540,7 +540,7 @@ static int pblk_gc_reader_ts(void *data)
>>>> static void pblk_gc_start(struct pblk *pblk)
>>>> {
>>>> 	pblk->gc.gc_active = 1;
>>>> -	pr_debug("pblk: gc start\n");
>>>> +	pblk_debug(pblk, "gc start\n");
>>>> }
>>>>
>>>> void pblk_gc_should_start(struct pblk *pblk)
>>>> @@ -605,14 +605,14 @@ int pblk_gc_init(struct pblk *pblk)
>>>>
>>>> 	gc->gc_ts = kthread_create(pblk_gc_ts, pblk, "pblk-gc-ts");
>>>> 	if (IS_ERR(gc->gc_ts)) {
>>>> -		pr_err("pblk: could not allocate GC main kthread\n");
>>>> +		pblk_err(pblk, "could not allocate GC main kthread\n");
>>>> 		return PTR_ERR(gc->gc_ts);
>>>> 	}
>>>>
>>>> 	gc->gc_writer_ts = kthread_create(pblk_gc_writer_ts, pblk,
>>>> 							"pblk-gc-writer-ts");
>>>> 	if (IS_ERR(gc->gc_writer_ts)) {
>>>> -		pr_err("pblk: could not allocate GC writer kthread\n");
>>>> +		pblk_err(pblk, "could not allocate GC writer kthread\n");
>>>> 		ret = PTR_ERR(gc->gc_writer_ts);
>>>> 		goto fail_free_main_kthread;
>>>> 	}
>>>> @@ -620,7 +620,7 @@ int pblk_gc_init(struct pblk *pblk)
>>>> 	gc->gc_reader_ts = kthread_create(pblk_gc_reader_ts, pblk,
>>>> 							"pblk-gc-reader-ts");
>>>> 	if (IS_ERR(gc->gc_reader_ts)) {
>>>> -		pr_err("pblk: could not allocate GC reader kthread\n");
>>>> +		pblk_err(pblk, "could not allocate GC reader kthread\n");
>>>> 		ret = PTR_ERR(gc->gc_reader_ts);
>>>> 		goto fail_free_writer_kthread;
>>>> 	}
>>>> @@ -641,7 +641,7 @@ int pblk_gc_init(struct pblk *pblk)
>>>> 	gc->gc_line_reader_wq = alloc_workqueue("pblk-gc-line-reader-wq",
>>>> 			WQ_MEM_RECLAIM | WQ_UNBOUND, PBLK_GC_MAX_READERS);
>>>> 	if (!gc->gc_line_reader_wq) {
>>>> -		pr_err("pblk: could not allocate GC line reader workqueue\n");
>>>> +		pblk_err(pblk, "could not allocate GC line reader workqueue\n");
>>>> 		ret = -ENOMEM;
>>>> 		goto fail_free_reader_kthread;
>>>> 	}
>>>> @@ -650,7 +650,7 @@ int pblk_gc_init(struct pblk *pblk)
>>>> 	gc->gc_reader_wq = alloc_workqueue("pblk-gc-line_wq",
>>>> 					WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
>>>> 	if (!gc->gc_reader_wq) {
>>>> -		pr_err("pblk: could not allocate GC reader workqueue\n");
>>>> +		pblk_err(pblk, "could not allocate GC reader workqueue\n");
>>>> 		ret = -ENOMEM;
>>>> 		goto fail_free_reader_line_wq;
>>>> 	}
>>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>>>> index aa2426403171..d87d38f063fa 100644
>>>> --- a/drivers/lightnvm/pblk-init.c
>>>> +++ b/drivers/lightnvm/pblk-init.c
>>>> @@ -117,13 +117,13 @@ static int pblk_l2p_recover(struct pblk *pblk, bool factory_init)
>>>> 	} else {
>>>> 		line = pblk_recov_l2p(pblk);
>>>> 		if (IS_ERR(line)) {
>>>> -			pr_err("pblk: could not recover l2p table\n");
>>>> +			pblk_err(pblk, "could not recover l2p table\n");
>>>> 			return -EFAULT;
>>>> 		}
>>>> 	}
>>>>
>>>> #ifdef CONFIG_NVM_PBLK_DEBUG
>>>> -	pr_info("pblk init: L2P CRC: %x\n", pblk_l2p_crc(pblk));
>>>> +	pblk_info(pblk, "init: L2P CRC: %x\n", pblk_l2p_crc(pblk));
>>>> #endif
>>>>
>>>> 	/* Free full lines directly as GC has not been started yet */
>>>> @@ -166,7 +166,7 @@ static int pblk_l2p_init(struct pblk *pblk, bool factory_init)
>>>> static void pblk_rwb_free(struct pblk *pblk)
>>>> {
>>>> 	if (pblk_rb_tear_down_check(&pblk->rwb))
>>>> -		pr_err("pblk: write buffer error on tear down\n");
>>>> +		pblk_err(pblk, "write buffer error on tear down\n");
>>>>
>>>> 	pblk_rb_data_free(&pblk->rwb);
>>>> 	vfree(pblk_rb_entries_ref(&pblk->rwb));
>>>> @@ -203,7 +203,8 @@ static int pblk_rwb_init(struct pblk *pblk)
>>>> /* Minimum pages needed within a lun */
>>>> #define ADDR_POOL_SIZE 64
>>>>
>>>> -static int pblk_set_addrf_12(struct nvm_geo *geo, struct nvm_addrf_12 *dst)
>>>> +static int pblk_set_addrf_12(struct pblk *pblk, struct nvm_geo *geo,
>>>> +			     struct nvm_addrf_12 *dst)
>>>> {
>>>> 	struct nvm_addrf_12 *src = (struct nvm_addrf_12 *)&geo->addrf;
>>>> 	int power_len;
>>>> @@ -211,14 +212,14 @@ static int pblk_set_addrf_12(struct nvm_geo *geo, struct nvm_addrf_12 *dst)
>>>> 	/* Re-calculate channel and lun format to adapt to configuration */
>>>> 	power_len = get_count_order(geo->num_ch);
>>>> 	if (1 << power_len != geo->num_ch) {
>>>> -		pr_err("pblk: supports only power-of-two channel config.\n");
>>>> +		pblk_err(pblk, "supports only power-of-two channel config.\n");
>>>> 		return -EINVAL;
>>>> 	}
>>>> 	dst->ch_len = power_len;
>>>>
>>>> 	power_len = get_count_order(geo->num_lun);
>>>> 	if (1 << power_len != geo->num_lun) {
>>>> -		pr_err("pblk: supports only power-of-two LUN config.\n");
>>>> +		pblk_err(pblk, "supports only power-of-two LUN config.\n");
>>>> 		return -EINVAL;
>>>> 	}
>>>> 	dst->lun_len = power_len;
>>>> @@ -285,18 +286,19 @@ static int pblk_set_addrf(struct pblk *pblk)
>>>> 	case NVM_OCSSD_SPEC_12:
>>>> 		div_u64_rem(geo->clba, pblk->min_write_pgs, &mod);
>>>> 		if (mod) {
>>>> -			pr_err("pblk: bad configuration of sectors/pages\n");
>>>> +			pblk_err(pblk, "bad configuration of sectors/pages\n");
>>>> 			return -EINVAL;
>>>> 		}
>>>>
>>>> -		pblk->addrf_len = pblk_set_addrf_12(geo, (void *)&pblk->addrf);
>>>> +		pblk->addrf_len = pblk_set_addrf_12(pblk, geo,
>>>> +							(void *)&pblk->addrf);
>>>> 		break;
>>>> 	case NVM_OCSSD_SPEC_20:
>>>> 		pblk->addrf_len = pblk_set_addrf_20(geo, (void *)&pblk->addrf,
>>>> -								&pblk->uaddrf);
>>>> +							&pblk->uaddrf);
>>>> 		break;
>>>> 	default:
>>>> -		pr_err("pblk: OCSSD revision not supported (%d)\n",
>>>> +		pblk_err(pblk, "OCSSD revision not supported (%d)\n",
>>>> 								geo->version);
>>>> 		return -EINVAL;
>>>> 	}
>>>> @@ -375,7 +377,7 @@ static int pblk_core_init(struct pblk *pblk)
>>>> 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
>>>>
>>>> 	if (pblk->max_write_pgs > PBLK_MAX_REQ_ADDRS) {
>>>> -		pr_err("pblk: vector list too big(%u > %u)\n",
>>>> +		pblk_err(pblk, "vector list too big(%u > %u)\n",
>>>> 				pblk->max_write_pgs, PBLK_MAX_REQ_ADDRS);
>>>> 		return -EINVAL;
>>>> 	}
>>>> @@ -608,7 +610,7 @@ static int pblk_luns_init(struct pblk *pblk)
>>>>
>>>> 	/* TODO: Implement unbalanced LUN support */
>>>> 	if (geo->num_lun < 0) {
>>>> -		pr_err("pblk: unbalanced LUN config.\n");
>>>> +		pblk_err(pblk, "unbalanced LUN config.\n");
>>>> 		return -EINVAL;
>>>> 	}
>>>>
>>>> @@ -1027,7 +1029,7 @@ static int pblk_line_meta_init(struct pblk *pblk)
>>>> 					lm->emeta_sec[0], geo->clba);
>>>>
>>>> 	if (lm->min_blk_line > lm->blk_per_line) {
>>>> -		pr_err("pblk: config. not supported. Min. LUN in line:%d\n",
>>>> +		pblk_err(pblk, "config. not supported. Min. LUN in line:%d\n",
>>>> 							lm->blk_per_line);
>>>> 		return -EINVAL;
>>>> 	}
>>>> @@ -1079,7 +1081,7 @@ static int pblk_lines_init(struct pblk *pblk)
>>>> 	}
>>>>
>>>> 	if (!nr_free_chks) {
>>>> -		pr_err("pblk: too many bad blocks prevent for sane instance\n");
>>>> +		pblk_err(pblk, "too many bad blocks prevent for sane instance\n");
>>>> 		return -EINTR;
>>>> 	}
>>>>
>>>> @@ -1109,7 +1111,7 @@ static int pblk_writer_init(struct pblk *pblk)
>>>> 		int err = PTR_ERR(pblk->writer_ts);
>>>>
>>>> 		if (err != -EINTR)
>>>> -			pr_err("pblk: could not allocate writer kthread (%d)\n",
>>>> +			pblk_err(pblk, "could not allocate writer kthread (%d)\n",
>>>> 					err);
>>>> 		return err;
>>>> 	}
>>>> @@ -1155,7 +1157,7 @@ static void pblk_tear_down(struct pblk *pblk, bool graceful)
>>>> 	pblk_rb_sync_l2p(&pblk->rwb);
>>>> 	pblk_rl_free(&pblk->rl);
>>>>
>>>> -	pr_debug("pblk: consistent tear down (graceful:%d)\n", graceful);
>>>> +	pblk_debug(pblk, "consistent tear down (graceful:%d)\n", graceful);
>>>> }
>>>>
>>>> static void pblk_exit(void *private, bool graceful)
>>>> @@ -1167,7 +1169,7 @@ static void pblk_exit(void *private, bool graceful)
>>>> 	pblk_tear_down(pblk, graceful);
>>>>
>>>> #ifdef CONFIG_NVM_PBLK_DEBUG
>>>> -	pr_info("pblk exit: L2P CRC: %x\n", pblk_l2p_crc(pblk));
>>>> +	pblk_info(pblk, "exit: L2P CRC: %x\n", pblk_l2p_crc(pblk));
>>>> #endif
>>>>
>>>> 	pblk_free(pblk);
>>>> @@ -1190,20 +1192,6 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>>>> 	struct pblk *pblk;
>>>> 	int ret;
>>>>
>>>> -	/* pblk supports 1.2 and 2.0 versions */
>>>> -	if (!(geo->version == NVM_OCSSD_SPEC_12 ||
>>>> -					geo->version == NVM_OCSSD_SPEC_20)) {
>>>> -		pr_err("pblk: OCSSD version not supported (%u)\n",
>>>> -							geo->version);
>>>> -		return ERR_PTR(-EINVAL);
>>>> -	}
>>>> -
>>>> -	if (geo->version == NVM_OCSSD_SPEC_12 && geo->dom & NVM_RSP_L2P) {
>>>> -		pr_err("pblk: host-side L2P table not supported. (%x)\n",
>>>> -							geo->dom);
>>>> -		return ERR_PTR(-EINVAL);
>>>> -	}
>>>> -
>>>> 	pblk = kzalloc(sizeof(struct pblk), GFP_KERNEL);
>>>> 	if (!pblk)
>>>> 		return ERR_PTR(-ENOMEM);
>>>> @@ -1213,6 +1201,19 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>>>> 	pblk->state = PBLK_STATE_RUNNING;
>>>> 	pblk->gc.gc_enabled = 0;
>>>>
>>>> +	if (!(geo->version == NVM_OCSSD_SPEC_12 ||
>>>> +					geo->version == NVM_OCSSD_SPEC_20)) {
>>>> +		pblk_err(pblk, "OCSSD version not supported (%u)\n",
>>>> +							geo->version);
>>>> +		return ERR_PTR(-EINVAL);
>>>> +	}
>>>> +
>>>> +	if (geo->version == NVM_OCSSD_SPEC_12 && geo->dom & NVM_RSP_L2P) {
>>>> +		pblk_err(pblk, "host-side L2P table not supported. (%x)\n",
>>>> +							geo->dom);
>>>> +		return ERR_PTR(-EINVAL);
>>>> +	}
>>>> +
>>> Why move the check down? At this point the instance is not even created,
>>> so you can fail directly. In any case, here you should set ret and goto
>>> fail to free pblk.
>>
>> pblk_err depends on the gendisk diskname, which is within the ->disk parameter.
> 
> I was suggesting to fail directly on tdisk - no need to allocate
> pblk and then pblk->disk = tdisk to use a given error interface. If you
> have a strong feeling about this, I'm ok with it, but then please free
> struct pblk *pblk on the error path.
> 
> 

I don't know if I have strong feelings about it. But it find it prettier 
to pass pblk, instead of pblk->disk to each of the error messages.

Yep, free's are missing. I had them in a previous previous revision, but 
got lost on the way :)
