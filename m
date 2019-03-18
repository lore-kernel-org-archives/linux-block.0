Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA96C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 13:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EF920850
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 13:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfCRNMQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:12:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:7470 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfCRNMQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 09:12:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 06:12:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="126383882"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.142.164]) ([10.237.142.164])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2019 06:12:14 -0700
Subject: Re: [PATCH 13/18] lightnvm: pblk: store multiple copies of smeta
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-14-igor.j.konopko@intel.com>
 <672CA871-E146-45D9-9B8F-384A929EC933@javigon.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <f914fc48-28f1-45f3-942d-58f6397f6359@intel.com>
Date:   Mon, 18 Mar 2019 14:12:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <672CA871-E146-45D9-9B8F-384A929EC933@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 18.03.2019 08:33, Javier González wrote:
>> On 14 Mar 2019, at 17.04, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>
>> Currently there is only one copy of emeta stored per line in pblk. This
>                                                             ^^^^^^
> smeta?

Sure, typo.

> 
>> is risky, because in case of read error on such a chunk, we are losing
>> all the data from whole line, what leads to silent data corruption.
>>
>> This patch changes this behaviour and stores 2 copies of smeta (but
>> can be easily increased with kernel parameter to different value) in
>> order to provide higher reliability by storing mirrored copies of
>> smeta struct and providing possibility to failover to another copy of
>> that struct in case of read error. Such an approach ensures that copies
>> of that critical structures will be stored on different dies and thus
>> predicted UBER is multiple times higher
>>
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> ---
>> drivers/lightnvm/pblk-core.c     | 125 ++++++++++++++++++++++++++++++++-------
>> drivers/lightnvm/pblk-init.c     |  23 +++++--
>> drivers/lightnvm/pblk-recovery.c |   2 +-
>> drivers/lightnvm/pblk.h          |   1 +
>> 4 files changed, 123 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>> index a683d1f..4d5cd99 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -720,13 +720,14 @@ u64 pblk_line_smeta_start(struct pblk *pblk, struct pblk_line *line)
>> 	return bit * geo->ws_opt;
>> }
>>
>> -int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
>> +static int pblk_line_smeta_read_copy(struct pblk *pblk,
>> +				     struct pblk_line *line, u64 paddr)
>> {
>> 	struct nvm_tgt_dev *dev = pblk->dev;
>> +	struct nvm_geo *geo = &dev->geo;
>> 	struct pblk_line_meta *lm = &pblk->lm;
>> 	struct bio *bio;
>> 	struct nvm_rq rqd;
>> -	u64 paddr = pblk_line_smeta_start(pblk, line);
>> 	int i, ret;
>>
>> 	memset(&rqd, 0, sizeof(struct nvm_rq));
>> @@ -735,7 +736,8 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
>> 	if (ret)
>> 		return ret;
>>
>> -	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
>> +	bio = bio_map_kern(dev->q, line->smeta,
>> +			   lm->smeta_len / lm->smeta_copies, GFP_KERNEL);
>> 	if (IS_ERR(bio)) {
>> 		ret = PTR_ERR(bio);
>> 		goto clear_rqd;
>> @@ -746,11 +748,23 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
>>
>> 	rqd.bio = bio;
>> 	rqd.opcode = NVM_OP_PREAD;
>> -	rqd.nr_ppas = lm->smeta_sec;
>> +	rqd.nr_ppas = lm->smeta_sec / lm->smeta_copies;
>> 	rqd.is_seq = 1;
>>
>> -	for (i = 0; i < lm->smeta_sec; i++, paddr++)
>> -		rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
>> +	for (i = 0; i < rqd.nr_ppas; i++, paddr++) {
>> +		struct ppa_addr ppa = addr_to_gen_ppa(pblk, paddr, line->id);
>> +		int pos = pblk_ppa_to_pos(geo, ppa);
>> +
>> +		while (test_bit(pos, line->blk_bitmap)) {
>> +			paddr += pblk->min_write_pgs;
>> +			ppa = addr_to_gen_ppa(pblk, paddr, line->id);
>> +			pos = pblk_ppa_to_pos(geo, ppa);
>> +		}
>> +
>> +		rqd.ppa_list[i] = ppa;
>> +		pblk_get_meta(pblk, rqd.meta_list, i)->lba =
>> +				  cpu_to_le64(ADDR_EMPTY);
>> +	}
>>
>> 	ret = pblk_submit_io_sync(pblk, &rqd);
>> 	if (ret) {
>> @@ -771,16 +785,63 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
>> 	return ret;
>> }
>>
>> -static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
>> -				 u64 paddr)
>> +int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
>> +{
>> +	struct pblk_line_meta *lm = &pblk->lm;
>> +	int i, ret = 0, smeta_sec = lm->smeta_sec / lm->smeta_copies;
>> +	u64 paddr = pblk_line_smeta_start(pblk, line);
>> +
>> +	for (i = 0; i < lm->smeta_copies; i++) {
>> +		ret = pblk_line_smeta_read_copy(pblk, line,
>> +						paddr + (i * smeta_sec));
>> +		if (!ret) {
>> +			/*
>> +			 * Just one successfully read copy of smeta is
>> +			 * enough for us for recovery, don't need to
>> +			 * read another one.
>> +			 */
>> +			return ret;
>> +		}
>> +	}
>> +	return ret;
>> +}
>> +
>> +static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line)
>> {
>> 	struct nvm_tgt_dev *dev = pblk->dev;
>> +	struct nvm_geo *geo = &dev->geo;
>> 	struct pblk_line_meta *lm = &pblk->lm;
>> 	struct bio *bio;
>> 	struct nvm_rq rqd;
>> 	__le64 *lba_list = emeta_to_lbas(pblk, line->emeta->buf);
>> 	__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
>> -	int i, ret;
>> +	u64 paddr = 0;
>> +	int smeta_cpy_len = lm->smeta_len / lm->smeta_copies;
>> +	int smeta_cpy_sec = lm->smeta_sec / lm->smeta_copies;
>> +	int i, ret, rq_writes;
>> +
>> +	/*
>> +	 * Check if we can write all the smeta copies with
>> +	 * a single write command.
>> +	 * If yes -> copy smeta sector into multiple copies
>> +	 * in buffer to write.
>> +	 * If no -> issue writes one by one using the same
>> +	 * buffer space.
>> +	 * Only if all the copies are written correctly
>> +	 * we are treating this line as valid for proper
>> +	 * UBER reliability.
>> +	 */
>> +	if (lm->smeta_sec > pblk->max_write_pgs) {
>> +		rq_writes = lm->smeta_copies;
>> +	} else {
>> +		rq_writes = 1;
>> +		for (i = 1; i < lm->smeta_copies; i++) {
>> +			memcpy(line->smeta + i * smeta_cpy_len,
>> +			       line->smeta, smeta_cpy_len);
>> +		}
>> +		smeta_cpy_len = lm->smeta_len;
>> +		smeta_cpy_sec = lm->smeta_sec;
>> +	}
> 
> smeta writes are synchronous, so you can just populate 2 entries in the
> vector command. This will help you minimizing the BW spikes with storing
> multiple copies. When doing this, you can remove the comment too.
> 
> In fact, smeta’s length is calculated so that it takes whole writable
> pages to avoid mixing it with user data, so with this logic you will
> always send 1 commands per smeta copy.

Generally in most of the cases it is true (and we will fall into the 
second case), but there is a case when max_write_pgs == ws_opt, so then 
we need to submit two IOs and my intention was to cover it in the first 
case.

> 
>>
>> 	memset(&rqd, 0, sizeof(struct nvm_rq));
>>
>> @@ -788,7 +849,8 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
>> 	if (ret)
>> 		return ret;
>>
>> -	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
>> +next_rq:
>> +	bio = bio_map_kern(dev->q, line->smeta, smeta_cpy_len, GFP_KERNEL);
>> 	if (IS_ERR(bio)) {
>> 		ret = PTR_ERR(bio);
>> 		goto clear_rqd;
>> @@ -799,15 +861,23 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
>>
>> 	rqd.bio = bio;
>> 	rqd.opcode = NVM_OP_PWRITE;
>> -	rqd.nr_ppas = lm->smeta_sec;
>> +	rqd.nr_ppas = smeta_cpy_sec;
>> 	rqd.is_seq = 1;
>>
>> -	for (i = 0; i < lm->smeta_sec; i++, paddr++) {
>> -		struct pblk_sec_meta *meta = pblk_get_meta(pblk,
>> -							   rqd.meta_list, i);
>> +	for (i = 0; i < rqd.nr_ppas; i++, paddr++) {
>> +		void *meta_list = rqd.meta_list;
>> +		struct ppa_addr ppa = addr_to_gen_ppa(pblk, paddr, line->id);
>> +		int pos = pblk_ppa_to_pos(geo, ppa);
>> +
>> +		while (test_bit(pos, line->blk_bitmap)) {
>> +			paddr += pblk->min_write_pgs;
>> +			ppa = addr_to_gen_ppa(pblk, paddr, line->id);
>> +			pos = pblk_ppa_to_pos(geo, ppa);
>> +		}
>>
>> -		rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
>> -		meta->lba = lba_list[paddr] = addr_empty;
>> +		rqd.ppa_list[i] = ppa;
>> +		pblk_get_meta(pblk, meta_list, i)->lba = addr_empty;
>> +		lba_list[paddr] = addr_empty;
>> 	}
>>
>> 	ret = pblk_submit_io_sync_sem(pblk, &rqd);
>> @@ -822,8 +892,13 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
>> 	if (rqd.error) {
>> 		pblk_log_write_err(pblk, &rqd);
>> 		ret = -EIO;
>> +		goto clear_rqd;
>> 	}
>>
>> +	rq_writes--;
>> +	if (rq_writes > 0)
>> +		goto next_rq;
>> +
>> clear_rqd:
>> 	pblk_free_rqd_meta(pblk, &rqd);
>> 	return ret;
>> @@ -1149,7 +1224,7 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
>> 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>> 	u64 off;
>> 	int bit = -1;
>> -	int emeta_secs;
>> +	int emeta_secs, smeta_secs;
>>
>> 	line->sec_in_line = lm->sec_per_line;
>>
>> @@ -1165,13 +1240,19 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
>> 	}
>>
>> 	/* Mark smeta metadata sectors as bad sectors */
>> -	bit = find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
>> -	off = bit * geo->ws_opt;
>> -	bitmap_set(line->map_bitmap, off, lm->smeta_sec);
>> +	smeta_secs = lm->smeta_sec;
>> +	bit = -1;
>> +	while (smeta_secs) {
>> +		bit = find_next_zero_bit(line->blk_bitmap, lm->blk_per_line,
>> +					bit + 1);
>> +		off = bit * geo->ws_opt;
>> +		bitmap_set(line->map_bitmap, off, geo->ws_opt);
>> +		line->cur_sec = off + geo->ws_opt;
>> +		smeta_secs -= geo->ws_opt;
>> +	}
> 
> The idea with lm->smeta_sec was to abstract the sectors used for smeta
> from ws_opt, as this could change in the future.
> 
> What do you think about leaving lm->smeta_sec as the sectors needed for
> each copy of smeta and then used the lm->smeta_copies to calculate the
> total? (This is done in pblk_line_meta_init(), not here). This way, you
> can keep the code here without using ws_opt.

Sure, can change that.

> 
>> 	line->sec_in_line -= lm->smeta_sec;
>> -	line->cur_sec = off + lm->smeta_sec;
>>
>> -	if (init && pblk_line_smeta_write(pblk, line, off)) {
>> +	if (init && pblk_line_smeta_write(pblk, line)) {
>> 		pblk_debug(pblk, "line smeta I/O failed. Retry\n");
>> 		return 0;
>> 	}
>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>> index b7845f6..e771df6 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -27,6 +27,11 @@ static unsigned int write_buffer_size;
>> module_param(write_buffer_size, uint, 0644);
>> MODULE_PARM_DESC(write_buffer_size, "number of entries in a write buffer");
>>
>> +static unsigned int smeta_copies = 2;
> 
> Can we default to 1?
> 

Sure

>> […]
> 
