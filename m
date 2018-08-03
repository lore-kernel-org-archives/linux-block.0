Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41284 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731083AbeHCQAn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Aug 2018 12:00:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17-v6so5031180ljy.8
        for <linux-block@vger.kernel.org>; Fri, 03 Aug 2018 07:04:12 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: combine 1.2 and 2.0 command flags
To: javier@cnexlabs.com
Cc: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180802162058.9800-1-mb@lightnvm.io>
 <537156D9-0CE0-4B8F-B8E3-32B291529EE4@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f3340b04-57c1-01c3-1797-a4ee4929420d@lightnvm.io>
Date: Fri, 3 Aug 2018 16:04:09 +0200
MIME-Version: 1.0
In-Reply-To: <537156D9-0CE0-4B8F-B8E3-32B291529EE4@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/03/2018 03:35 PM, Javier Gonzalez wrote:
>> On 2 Aug 2018, at 18.20, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> Avoid targets open-code the nvm_rq command flag for version 1.2 and
>> 2.0. The core should have this responsibility.
>>
>> When moved into core, the flags parameter can be distilled into
>> access hint, scrambling, and program/erase suspend. Replace the
>> access hint with a "is_seq" parameter, and let the rest be
>> dependent on the command opcode, which is trivial to detect and
>> set.
>>
>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>> ---
>> drivers/lightnvm/core.c          | 20 ++++++++++++++++++++
>> drivers/lightnvm/pblk-core.c     | 13 ++++---------
>> drivers/lightnvm/pblk-read.c     |  8 +-------
>> drivers/lightnvm/pblk-recovery.c | 14 ++++----------
>> drivers/lightnvm/pblk-write.c    |  2 +-
>> drivers/lightnvm/pblk.h          | 38 --------------------------------------
>> include/linux/lightnvm.h         |  2 ++
>> 7 files changed, 32 insertions(+), 65 deletions(-)
>>
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index 60aa7bc5a630..68553c7ae937 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -752,6 +752,24 @@ int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
>> }
>> EXPORT_SYMBOL(nvm_set_tgt_bb_tbl);
>>
>> +static int nvm_set_flags(struct nvm_geo *geo, struct nvm_rq *rqd)
>> +{
>> +	int flags = 0;
>> +
>> +	if (geo->version == NVM_OCSSD_SPEC_20)
>> +		return 0;
>> +
>> +	if (rqd->is_seq)
>> +		flags |= geo->pln_mode >> 1;
>> +
>> +	if (rqd->opcode == NVM_OP_PREAD)
>> +		flags |= (NVM_IO_SCRAMBLE_ENABLE | NVM_IO_SUSPEND);
>> +	else if (rqd->opcode == NVM_OP_PWRITE)
>> +		flags |= NVM_IO_SCRAMBLE_ENABLE;
>> +
>> +	return flags;
>> +}
>> +
>> int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
>> {
>> 	struct nvm_dev *dev = tgt_dev->parent;
>> @@ -763,6 +781,7 @@ int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
>> 	nvm_rq_tgt_to_dev(tgt_dev, rqd);
>>
>> 	rqd->dev = tgt_dev;
>> +	rqd->flags = nvm_set_flags(&tgt_dev->geo, rqd);
>>
>> 	/* In case of error, fail with right address format */
>> 	ret = dev->ops->submit_io(dev, rqd);
>> @@ -783,6 +802,7 @@ int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
>> 	nvm_rq_tgt_to_dev(tgt_dev, rqd);
>>
>> 	rqd->dev = tgt_dev;
>> +	rqd->flags = nvm_set_flags(&tgt_dev->geo, rqd);
>>
>> 	/* In case of error, fail with right address format */
>> 	ret = dev->ops->submit_io_sync(dev, rqd);
>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>> index 00984b486fea..72acf2f6dbd6 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -688,7 +688,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
>> 	if (dir == PBLK_WRITE) {
>> 		struct pblk_sec_meta *meta_list = rqd.meta_list;
>>
>> -		rqd.flags = pblk_set_progr_mode(pblk, PBLK_WRITE);
>> +		rqd.is_seq = 1;
>> 		for (i = 0; i < rqd.nr_ppas; ) {
>> 			spin_lock(&line->lock);
>> 			paddr = __pblk_alloc_page(pblk, line, min);
>> @@ -703,11 +703,9 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
>> 		for (i = 0; i < rqd.nr_ppas; ) {
>> 			struct ppa_addr ppa = addr_to_gen_ppa(pblk, paddr, id);
>> 			int pos = pblk_ppa_to_pos(geo, ppa);
>> -			int read_type = PBLK_READ_RANDOM;
>>
>> 			if (pblk_io_aligned(pblk, rq_ppas))
>> -				read_type = PBLK_READ_SEQUENTIAL;
>> -			rqd.flags = pblk_set_read_mode(pblk, read_type);
>> +				rqd.is_seq = 1;
>>
>> 			while (test_bit(pos, line->blk_bitmap)) {
>> 				paddr += min;
>> @@ -787,17 +785,14 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
>> 	__le64 *lba_list = NULL;
>> 	int i, ret;
>> 	int cmd_op, bio_op;
>> -	int flags;
>>
>> 	if (dir == PBLK_WRITE) {
>> 		bio_op = REQ_OP_WRITE;
>> 		cmd_op = NVM_OP_PWRITE;
>> -		flags = pblk_set_progr_mode(pblk, PBLK_WRITE);
>> 		lba_list = emeta_to_lbas(pblk, line->emeta->buf);
>> 	} else if (dir == PBLK_READ_RECOV || dir == PBLK_READ) {
>> 		bio_op = REQ_OP_READ;
>> 		cmd_op = NVM_OP_PREAD;
>> -		flags = pblk_set_read_mode(pblk, PBLK_READ_SEQUENTIAL);
>> 	} else
>> 		return -EINVAL;
>>
>> @@ -822,7 +817,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
>>
>> 	rqd.bio = bio;
>> 	rqd.opcode = cmd_op;
>> -	rqd.flags = flags;
>> +	rqd.is_seq = 1;
>> 	rqd.nr_ppas = lm->smeta_sec;
>>
>> 	for (i = 0; i < lm->smeta_sec; i++, paddr++) {
>> @@ -885,7 +880,7 @@ static void pblk_setup_e_rq(struct pblk *pblk, struct nvm_rq *rqd,
>> 	rqd->opcode = NVM_OP_ERASE;
>> 	rqd->ppa_addr = ppa;
>> 	rqd->nr_ppas = 1;
>> -	rqd->flags = pblk_set_progr_mode(pblk, PBLK_ERASE);
>> +	rqd->is_seq = 1;
>> 	rqd->bio = NULL;
>> }
>>
>> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
>> index 26d414ae25b6..48739f6c0417 100644
>> --- a/drivers/lightnvm/pblk-read.c
>> +++ b/drivers/lightnvm/pblk-read.c
>> @@ -93,9 +93,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
>> 	}
>>
>> 	if (pblk_io_aligned(pblk, nr_secs))
>> -		rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_SEQUENTIAL);
>> -	else
>> -		rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
>> +		rqd->is_seq = 1;
>>
>> #ifdef CONFIG_NVM_PBLK_DEBUG
>> 	atomic_long_add(nr_secs, &pblk->inflight_reads);
>> @@ -344,7 +342,6 @@ static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
>>
>> 	rqd->bio = new_bio;
>> 	rqd->nr_ppas = nr_holes;
>> -	rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
>>
>> 	pr_ctx->ppa_ptr = NULL;
>> 	pr_ctx->orig_bio = bio;
>> @@ -438,8 +435,6 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
>> 	} else {
>> 		rqd->ppa_addr = ppa;
>> 	}
>> -
>> -	rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
>> }
>>
>> int pblk_submit_read(struct pblk *pblk, struct bio *bio)
>> @@ -662,7 +657,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
>>
>> 	rqd.opcode = NVM_OP_PREAD;
>> 	rqd.nr_ppas = gc_rq->secs_to_gc;
>> -	rqd.flags = pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
>> 	rqd.bio = bio;
>>
>> 	if (pblk_submit_io_sync(pblk, &rqd)) {
>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>> index e232e47e1353..cf629ab016ba 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -159,9 +159,7 @@ static int pblk_recov_read_oob(struct pblk *pblk, struct pblk_line *line,
>> 	rqd->dma_meta_list = dma_meta_list;
>>
>> 	if (pblk_io_aligned(pblk, rq_ppas))
>> -		rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_SEQUENTIAL);
>> -	else
>> -		rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
>> +		rqd->is_seq = 1;
>>
>> 	for (i = 0; i < rqd->nr_ppas; ) {
>> 		struct ppa_addr ppa;
>> @@ -302,7 +300,7 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
>>
>> 	rqd->bio = bio;
>> 	rqd->opcode = NVM_OP_PWRITE;
>> -	rqd->flags = pblk_set_progr_mode(pblk, PBLK_WRITE);
>> +	rqd->is_seq = 1;
>> 	rqd->meta_list = meta_list;
>> 	rqd->nr_ppas = rq_ppas;
>> 	rqd->ppa_list = ppa_list;
>> @@ -436,9 +434,7 @@ static int pblk_recov_scan_all_oob(struct pblk *pblk, struct pblk_line *line,
>> 	rqd->dma_meta_list = dma_meta_list;
>>
>> 	if (pblk_io_aligned(pblk, rq_ppas))
>> -		rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_SEQUENTIAL);
>> -	else
>> -		rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
>> +		rqd->is_seq = 1;
>>
>> 	for (i = 0; i < rqd->nr_ppas; ) {
>> 		struct ppa_addr ppa;
>> @@ -567,9 +563,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>> 	rqd->dma_meta_list = dma_meta_list;
>>
>> 	if (pblk_io_aligned(pblk, rq_ppas))
>> -		rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_SEQUENTIAL);
>> -	else
>> -		rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
>> +		rqd->is_seq = 1;
>>
>> 	for (i = 0; i < rqd->nr_ppas; ) {
>> 		struct ppa_addr ppa;
>> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
>> index ee774a86cf1e..508c63701eda 100644
>> --- a/drivers/lightnvm/pblk-write.c
>> +++ b/drivers/lightnvm/pblk-write.c
>> @@ -302,7 +302,7 @@ static int pblk_alloc_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
>> 	/* Setup write request */
>> 	rqd->opcode = NVM_OP_PWRITE;
>> 	rqd->nr_ppas = nr_secs;
>> -	rqd->flags = pblk_set_progr_mode(pblk, PBLK_WRITE);
>> +	rqd->is_seq = 1;
>> 	rqd->private = pblk;
>> 	rqd->end_io = end_io;
>>
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index 4760af7b6499..48b3035df3c4 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -1255,44 +1255,6 @@ static inline u32 pblk_calc_emeta_crc(struct pblk *pblk,
>> 	return crc;
>> }
>>
>> -static inline int pblk_set_progr_mode(struct pblk *pblk, int type)
>> -{
>> -	struct nvm_tgt_dev *dev = pblk->dev;
>> -	struct nvm_geo *geo = &dev->geo;
>> -	int flags;
>> -
>> -	if (geo->version == NVM_OCSSD_SPEC_20)
>> -		return 0;
>> -
>> -	flags = geo->pln_mode >> 1;
>> -
>> -	if (type == PBLK_WRITE)
>> -		flags |= NVM_IO_SCRAMBLE_ENABLE;
>> -
>> -	return flags;
>> -}
>> -
>> -enum {
>> -	PBLK_READ_RANDOM	= 0,
>> -	PBLK_READ_SEQUENTIAL	= 1,
>> -};
>> -
>> -static inline int pblk_set_read_mode(struct pblk *pblk, int type)
>> -{
>> -	struct nvm_tgt_dev *dev = pblk->dev;
>> -	struct nvm_geo *geo = &dev->geo;
>> -	int flags;
>> -
>> -	if (geo->version == NVM_OCSSD_SPEC_20)
>> -		return 0;
>> -
>> -	flags = NVM_IO_SUSPEND | NVM_IO_SCRAMBLE_ENABLE;
>> -	if (type == PBLK_READ_SEQUENTIAL)
>> -		flags |= geo->pln_mode >> 1;
>> -
>> -	return flags;
>> -}
>> -
>> static inline int pblk_io_aligned(struct pblk *pblk, int nr_secs)
>> {
>> 	return !(nr_secs % pblk->min_write_pgs);
>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>> index e9e0d1c7eaf5..8acc2fe277d6 100644
>> --- a/include/linux/lightnvm.h
>> +++ b/include/linux/lightnvm.h
>> @@ -305,6 +305,8 @@ struct nvm_rq {
>> 	u64 ppa_status; /* ppa media status */
>> 	int error;
>>
>> +	int is_seq; /* Sequential hint flag. 1.2 only */
>> +
>> 	void *private;
>> };
>>
>> --
>> 2.11.0
> 
> Looks good to me. If you pick up [1], please note that you will need to
> transform it too.
> 
> [1] lightnvm: pblk: recover chunk state on 1.2 devices
> 

Ok. If you don't mind, we can look at this after the write pointer fix 
and 1.2/2.0 consolidation of chunk metadata has gone in.
