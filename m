Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AABC10F00
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 12:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F5F20863
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 12:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfCRM6e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:58:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:21648 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfCRM6e (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 08:58:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 05:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,493,1544515200"; 
   d="scan'208";a="126379342"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.142.164]) ([10.237.142.164])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2019 05:58:31 -0700
Subject: Re: [PATCH 07/18] lightnvm: pblk: wait for inflight IOs in recovery
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-8-igor.j.konopko@intel.com>
 <00eb866a-d2aa-437b-e580-3b0649e657ce@lightnvm.io>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <71256d83-aa2f-e812-5688-c46818335ec6@intel.com>
Date:   Mon, 18 Mar 2019 13:58:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <00eb866a-d2aa-437b-e580-3b0649e657ce@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 17.03.2019 20:33, Matias Bjørling wrote:
> On 3/14/19 9:04 AM, Igor Konopko wrote:
>> This patch changes the behaviour of recovery padding in order to
>> support a case, when some IOs were already submitted to the drive and
>> some next one are not submitted due to error returned.
>>
>> Currently in case of errors we simply exit the pad function without
>> waiting for inflight IOs, which leads to panic on inflight IOs
>> completion.
>>
>> After the changes we always wait for all the inflight IOs before
>> exiting the function.
>>
>> Also, since NVMe has an internal timeout per IO, there is no need to
>> introduce additonal one here.
>>
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> ---
>>   drivers/lightnvm/pblk-recovery.c | 32 +++++++++++++-------------------
>>   1 file changed, 13 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-recovery.c 
>> b/drivers/lightnvm/pblk-recovery.c
>> index ba1691d..73d5ead 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -200,7 +200,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, 
>> struct pblk_line *line,
>>       rq_ppas = pblk_calc_secs(pblk, left_ppas, 0, false);
>>       if (rq_ppas < pblk->min_write_pgs) {
>>           pblk_err(pblk, "corrupted pad line %d\n", line->id);
>> -        goto fail_free_pad;
>> +        goto fail_complete;
>>       }
>>       rq_len = rq_ppas * geo->csecs;
>> @@ -209,7 +209,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, 
>> struct pblk_line *line,
>>                           PBLK_VMALLOC_META, GFP_KERNEL);
>>       if (IS_ERR(bio)) {
>>           ret = PTR_ERR(bio);
>> -        goto fail_free_pad;
>> +        goto fail_complete;
>>       }
>>       bio->bi_iter.bi_sector = 0; /* internal bio */
>> @@ -218,8 +218,11 @@ static int pblk_recov_pad_line(struct pblk *pblk, 
>> struct pblk_line *line,
>>       rqd = pblk_alloc_rqd(pblk, PBLK_WRITE_INT);
>>       ret = pblk_alloc_rqd_meta(pblk, rqd);
>> -    if (ret)
>> -        goto fail_free_rqd;
>> +    if (ret) {
>> +        pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
>> +        bio_put(bio);
>> +        goto fail_complete;
>> +    }
>>       rqd->bio = bio;
>>       rqd->opcode = NVM_OP_PWRITE;
>> @@ -266,7 +269,10 @@ static int pblk_recov_pad_line(struct pblk *pblk, 
>> struct pblk_line *line,
>>       if (ret) {
>>           pblk_err(pblk, "I/O submission failed: %d\n", ret);
>>           pblk_up_chunk(pblk, rqd->ppa_list[0]);
>> -        goto fail_free_rqd;
>> +        kref_put(&pad_rq->ref, pblk_recov_complete);
>> +        pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
>> +        bio_put(bio);
>> +        goto fail_complete;
>>       }
>>       left_line_ppas -= rq_ppas;
>> @@ -274,13 +280,9 @@ static int pblk_recov_pad_line(struct pblk *pblk, 
>> struct pblk_line *line,
>>       if (left_ppas && left_line_ppas)
>>           goto next_pad_rq;
>> +fail_complete:
>>       kref_put(&pad_rq->ref, pblk_recov_complete);
>> -
>> -    if (!wait_for_completion_io_timeout(&pad_rq->wait,
>> -                msecs_to_jiffies(PBLK_COMMAND_TIMEOUT_MS))) {
>> -        pblk_err(pblk, "pad write timed out\n");
>> -        ret = -ETIME;
>> -    }
>> +    wait_for_completion(&pad_rq->wait);
>>       if (!pblk_line_is_full(line))
>>           pblk_err(pblk, "corrupted padded line: %d\n", line->id);
>> @@ -289,14 +291,6 @@ static int pblk_recov_pad_line(struct pblk *pblk, 
>> struct pblk_line *line,
>>   free_rq:
>>       kfree(pad_rq);
>>       return ret;
>> -
>> -fail_free_rqd:
>> -    pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
>> -    bio_put(bio);
>> -fail_free_pad:
>> -    kfree(pad_rq);
>> -    vfree(data);
>> -    return ret;
>>   }
>>   static int pblk_pad_distance(struct pblk *pblk, struct pblk_line *line)
>>
> 
> Hi Igor,
> 
> Can you split this patch in two. One that removes the 
> wait_for_completion_io_timeout (and constant), and another that makes 
> sure it waits until all inflight IOs are completed?
> 

Sure, will split this into two patches for v2.
> 
