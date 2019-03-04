Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D227CC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9519B20835
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="i6iCab5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfCDNSR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:18:17 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35441 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfCDNSQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 08:18:16 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so4218565edp.2
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 05:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5sdrdZopHvymYO3YFfmZyl2rZxqaUycGblCnGq5HMQk=;
        b=i6iCab5rhNA8FQ8tHKg/hIlwSPxhtcpzvtRY3Hja//KF5LBBabCyDP9YrOytGp8gF9
         FEyV0+jPWP79rI48lVwjKFdNjmKpK7mqgKX8+sT4w3GnYuAimTdBY8HpAi6bq5koSNNL
         KV+fF0+va1+SUWEZprsVfAK+pfj2Lxa+usZkRxZ7C5YO3oSpszhZFi3woLM6f62DoSsS
         x/rCjF1DjJ4Kb+/Sf4YdkDtzPhtf9HmZ/xUmryqnBtG8lWF5tuFj18Tr2Ty1HbONOyKl
         0PsIOK/oZxgruZktEfdPUo758OMOQo4T4JIH9uSndwXRyPB/fiWpTJDrJzCQXshqo1Vy
         t4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5sdrdZopHvymYO3YFfmZyl2rZxqaUycGblCnGq5HMQk=;
        b=NZe3OEVGgPYE1vdslh/DPAsSbgbWTlyNf6Z9ooVqTjUwdcqI672zPu3L9FvigQmdOz
         pxM+lG8ANB/Hs7gYsSSYwOIT7np/xPH3x8vvkx/0A1GDs+0VqFjVQY0ur74QjPD4vT42
         EubAPj9Cig27Pdx/eyDm2AILdftOb4K2a9wQxxTC2sFmCEG7544toGqoHha937Zbcx0M
         NxhEY5+HTyoGyOeFGt1lyBMn4BMqFLXmCJ4Chc1D0kE6eC4a8LrF+pNijHXZh8kTTHv7
         ewXzvJirIgubvXWNQOW+sHhciNpM8OdjRWmrjN7SNx21LYzgBp+edZIpgv/zraZJZg6R
         rQtw==
X-Gm-Message-State: APjAAAUQNk99Hmp9E2vpPEBjmD9Fpg1EwSuzhWuIyNyB3kNkXkEE3NCR
        0FGtzxbtuGfV4yCgOruaorWe03Va8Mo=
X-Google-Smtp-Source: APXvYqztzKi63BbnwLrXQoz52renSj9fgSpHib1QyGUQNaJmspkJeU/ldJPP+zGw2QMxHQB97qAqMA==
X-Received: by 2002:a17:906:a18:: with SMTP id w24mr12679920ejf.94.1551705493992;
        Mon, 04 Mar 2019 05:18:13 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id bq6sm1182779ejb.16.2019.03.04.05.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:18:13 -0800 (PST)
Subject: Re: [PATCH 12/13] lightnvm: pblk: close opened chunks
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
Cc:     Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-13-igor.j.konopko@intel.com>
 <C2286529-B0FE-4DFE-8CD1-5BB6591549A4@javigon.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5917a585-9c31-929d-68cb-32b6be1f7235@lightnvm.io>
Date:   Mon, 4 Mar 2019 14:18:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <C2286529-B0FE-4DFE-8CD1-5BB6591549A4@javigon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/4/19 9:27 AM, Javier González wrote:
>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>
>> When we creating pblk instance with factory
>> flag, there is a possibility that some chunks
>> are in open state, which does not allow to
>> issue erase request to them directly. Such a
>> chunk should be filled with some empty data in
>> order to achieve close state. Without that we
>> are risking that some erase operation will be
>> rejected by the drive due to inproper chunk
>> state.
>>
>> This patch implements closing chunk logic in pblk
>> for that case, when creating instance with factory
>> flag in order to fix that issue
>>
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> ---
>> drivers/lightnvm/pblk-core.c | 114 +++++++++++++++++++++++++++++++++++
>> drivers/lightnvm/pblk-init.c |  14 ++++-
>> drivers/lightnvm/pblk.h      |   2 +
>> 3 files changed, 128 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>> index fa4dc05608ff..d3c45393f093 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -161,6 +161,120 @@ struct nvm_chk_meta *pblk_chunk_get_off(struct pblk *pblk,
>> 	return meta + ch_off + lun_off + chk_off;
>> }
>>
>> +static void pblk_close_chunk(struct pblk *pblk, struct ppa_addr ppa, int count)
>> +{
>> +	struct nvm_tgt_dev *dev = pblk->dev;
>> +	struct nvm_geo *geo = &dev->geo;
>> +	struct bio *bio;
>> +	struct ppa_addr *ppa_list;
>> +	struct nvm_rq rqd;
>> +	void *meta_list, *data;
>> +	dma_addr_t dma_meta_list, dma_ppa_list;
>> +	int i, rq_ppas, rq_len, ret;
>> +
>> +	meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL, &dma_meta_list);
>> +	if (!meta_list)
>> +		return;
>> +
>> +	ppa_list = meta_list + pblk_dma_meta_size(pblk);
>> +	dma_ppa_list = dma_meta_list + pblk_dma_meta_size(pblk);
>> +
>> +	rq_ppas = pblk_calc_secs(pblk, count, 0, false);
>> +	if (!rq_ppas)
>> +		rq_ppas = pblk->min_write_pgs;
>> +	rq_len = rq_ppas * geo->csecs;
>> +
>> +	data = kzalloc(rq_len, GFP_KERNEL);
>> +	if (!data)
>> +		goto free_meta_list;
>> +
>> +	memset(&rqd, 0, sizeof(struct nvm_rq));
>> +	rqd.opcode = NVM_OP_PWRITE;
>> +	rqd.nr_ppas = rq_ppas;
>> +	rqd.meta_list = meta_list;
>> +	rqd.ppa_list = ppa_list;
>> +	rqd.dma_ppa_list = dma_ppa_list;
>> +	rqd.dma_meta_list = dma_meta_list;
>> +
>> +next_rq:
>> +	bio = bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
>> +	if (IS_ERR(bio))
>> +		goto out_next;
>> +
>> +	bio->bi_iter.bi_sector = 0; /* artificial bio */
>> +	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
>> +
>> +	rqd.bio = bio;
>> +	for (i = 0; i < rqd.nr_ppas; i++) {
>> +		rqd.ppa_list[i] = ppa;
>> +		rqd.ppa_list[i].m.sec += i;
>> +		pblk_get_meta(pblk, meta_list, i)->lba =
>> +					cpu_to_le64(ADDR_EMPTY);
>> +	}
>> +
>> +	ret = nvm_submit_io_sync(dev, &rqd);
>> +	if (ret) {
>> +		bio_put(bio);
>> +		goto out_next;
>> +	}
>> +
>> +	if (rqd.error)
>> +		goto free_data;
>> +
>> +out_next:
>> +	count -= rqd.nr_ppas;
>> +	ppa.m.sec += rqd.nr_ppas;
>> +	if (count > 0)
>> +		goto next_rq;
>> +
>> +free_data:
>> +	kfree(data);
>> +free_meta_list:
>> +	nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
>> +}
>> +
>> +void pblk_close_opened_chunks(struct pblk *pblk, struct nvm_chk_meta *meta)
>> +{
>> +	struct nvm_tgt_dev *dev = pblk->dev;
>> +	struct nvm_geo *geo = &dev->geo;
>> +	struct nvm_chk_meta *chunk_meta;
>> +	struct ppa_addr ppa;
>> +	int i, j, k, count;
>> +
>> +	for (i = 0; i < geo->num_chk; i++) {
>> +		for (j = 0; j < geo->num_lun; j++) {
>> +			for (k = 0; k < geo->num_ch; k++) {
>> +				ppa.ppa = 0;
>> +				ppa.m.grp = k;
>> +				ppa.m.pu = j;
>> +				ppa.m.chk = i;
>> +
>> +				chunk_meta = pblk_chunk_get_off(pblk,
>> +								meta, ppa);
>> +				if (chunk_meta->state == NVM_CHK_ST_OPEN) {
>> +					ppa.m.sec = chunk_meta->wp;
>> +					count = geo->clba - chunk_meta->wp;
>> +					pblk_close_chunk(pblk, ppa, count);
>> +				}
>> +			}
>> +		}
>> +	}
>> +}
>> +
>> +bool pblk_are_opened_chunks(struct pblk *pblk, struct nvm_chk_meta *meta)
>> +{
>> +	struct nvm_tgt_dev *dev = pblk->dev;
>> +	struct nvm_geo *geo = &dev->geo;
>> +	int i;
>> +
>> +	for (i = 0; i < geo->all_luns; i++) {
>> +		if (meta[i].state == NVM_CHK_ST_OPEN)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> void __pblk_map_invalidate(struct pblk *pblk, struct pblk_line *line,
>> 			   u64 paddr)
>> {
>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>> index 9913a4514eb6..83abe6960b46 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -1028,13 +1028,14 @@ static int pblk_line_meta_init(struct pblk *pblk)
>> 	return 0;
>> }
>>
>> -static int pblk_lines_init(struct pblk *pblk)
>> +static int pblk_lines_init(struct pblk *pblk, bool factory_init)
>> {
>> 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>> 	struct pblk_line *line;
>> 	void *chunk_meta;
>> 	int nr_free_chks = 0;
>> 	int i, ret;
>> +	bool retry = false;
>>
>> 	ret = pblk_line_meta_init(pblk);
>> 	if (ret)
>> @@ -1048,12 +1049,21 @@ static int pblk_lines_init(struct pblk *pblk)
>> 	if (ret)
>> 		goto fail_free_meta;
>>
>> +get_chunk_meta:
>> 	chunk_meta = pblk_get_chunk_meta(pblk);
>> 	if (IS_ERR(chunk_meta)) {
>> 		ret = PTR_ERR(chunk_meta);
>> 		goto fail_free_luns;
>> 	}
>>
>> +	if (factory_init && !retry &&
>> +	    pblk_are_opened_chunks(pblk, chunk_meta)) {
>> +		pblk_close_opened_chunks(pblk, chunk_meta);
>> +		retry = true;
>> +		vfree(chunk_meta);
>> +		goto get_chunk_meta;
>> +	}
>> +
>> 	pblk->lines = kcalloc(l_mg->nr_lines, sizeof(struct pblk_line),
>> 								GFP_KERNEL);
>> 	if (!pblk->lines) {
>> @@ -1244,7 +1254,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>> 		goto fail;
>> 	}
>>
>> -	ret = pblk_lines_init(pblk);
>> +	ret = pblk_lines_init(pblk, flags & NVM_TARGET_FACTORY);
>> 	if (ret) {
>> 		pblk_err(pblk, "could not initialize lines\n");
>> 		goto fail_free_core;
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index b266563508e6..b248642c4dfb 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -793,6 +793,8 @@ struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk);
>> struct nvm_chk_meta *pblk_chunk_get_off(struct pblk *pblk,
>> 					      struct nvm_chk_meta *lp,
>> 					      struct ppa_addr ppa);
>> +void pblk_close_opened_chunks(struct pblk *pblk, struct nvm_chk_meta *_meta);
>> +bool pblk_are_opened_chunks(struct pblk *pblk, struct nvm_chk_meta *_meta);
>> void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
>> void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
>> int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
>> --
>> 2.17.1
> 
> I know that the OCSSD 2.0 spec does not allow to transition from open to
> free, but to me this is a spec bug as there is no underlying issue in
> reading an open block. Note that all controllers I know support this,
> and the upcoming Denali spec. fixes this too.

The issue is not whether the chunk can be read. It is that going from 
Open -> Empty -> Open causes an erase on some implementations, and 
causes the media to wear out prematurely.
