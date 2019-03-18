Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25D1C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 13:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C018220811
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 13:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfCRNWf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:22:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:15589 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfCRNWf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 09:22:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 06:22:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="126386780"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.142.164]) ([10.237.142.164])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2019 06:22:32 -0700
Subject: Re: [PATCH 14/18] lightnvm: pblk: GC error handling
To:     Hans Holmberg <hans@owltronix.com>
Cc:     Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-15-igor.j.konopko@intel.com>
 <CANr-nt2XeD=xrvRt5xoiJpzN1SB54KCp5gbOJ-dm9_LRx4Dh3w@mail.gmail.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <c97739cf-df61-f6d4-7735-78e5743d0c1f@intel.com>
Date:   Mon, 18 Mar 2019 14:22:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CANr-nt2XeD=xrvRt5xoiJpzN1SB54KCp5gbOJ-dm9_LRx4Dh3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 18.03.2019 13:14, Hans Holmberg wrote:
> On Thu, Mar 14, 2019 at 5:09 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>>
>> Currently when there is an IO error (or similar) on GC read path, pblk
>> still moves this line to free state, what leads to data mismatch issue.
>>
>> This patch adds a handling for such an error - after that changes this
>> line will be returned to closed state so it can be still in use
>> for reading - at least we will be able to return error status to user
>> when user tries to read such a data.
>>
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> ---
>>   drivers/lightnvm/pblk-core.c | 8 ++++++++
>>   drivers/lightnvm/pblk-gc.c   | 5 ++---
>>   drivers/lightnvm/pblk-read.c | 1 -
>>   drivers/lightnvm/pblk.h      | 2 ++
>>   4 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>> index 4d5cd99..6817f8f 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -1786,6 +1786,14 @@ static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
>>
>>          spin_lock(&line->lock);
>>          WARN_ON(line->state != PBLK_LINESTATE_GC);
>> +       if (line->w_err_gc->has_gc_err) {
>> +               spin_unlock(&line->lock);
>> +               pblk_err(pblk, "line %d had errors during GC\n", line->id);
>> +               pblk_put_line_back(pblk, line);
>> +               line->w_err_gc->has_gc_err = 0;
> 
> In a real bummer corner case, the line might have had a write error as well
> (line->w_err_gc->has_write_err == true)
> 
> In that case we need to inform the rate limiter:
> pblk_rl_werr_line_out(&pblk->rl);

Is that needed or rather preferred?

I'm not clearing w_err_gc->has_write_err value in that case (and thus 
not informing the rate limiter), so the line will go back to exactly the 
same state as before GC (still with write error marked).

> 
>> +               return;
>> +       }
>> +
>>          line->state = PBLK_LINESTATE_FREE;
>>          trace_pblk_line_state(pblk_disk_name(pblk), line->id,
>>                                          line->state);
>> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
>> index e23b192..63ee205 100644
>> --- a/drivers/lightnvm/pblk-gc.c
>> +++ b/drivers/lightnvm/pblk-gc.c
>> @@ -59,7 +59,7 @@ static void pblk_gc_writer_kick(struct pblk_gc *gc)
>>          wake_up_process(gc->gc_writer_ts);
>>   }
>>
>> -static void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
>> +void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
>>   {
>>          struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>>          struct list_head *move_list;
>> @@ -98,8 +98,7 @@ static void pblk_gc_line_ws(struct work_struct *work)
>>          /* Read from GC victim block */
>>          ret = pblk_submit_read_gc(pblk, gc_rq);
>>          if (ret) {
>> -               pblk_err(pblk, "failed GC read in line:%d (err:%d)\n",
>> -                                                               line->id, ret);
>> +               line->w_err_gc->has_gc_err = 1;
>>                  goto out;
>>          }
>>
>> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
>> index 54422a2..6a77c24 100644
>> --- a/drivers/lightnvm/pblk-read.c
>> +++ b/drivers/lightnvm/pblk-read.c
>> @@ -475,7 +475,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
>>
>>          if (pblk_submit_io_sync(pblk, &rqd)) {
>>                  ret = -EIO;
>> -               pblk_err(pblk, "GC read request failed\n");
>>                  goto err_free_bio;
>>          }
>>
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index 5d1040a..52002f5 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -427,6 +427,7 @@ struct pblk_smeta {
>>
>>   struct pblk_w_err_gc {
>>          int has_write_err;
>> +       int has_gc_err;
>>          __le64 *lba_list;
>>   };
>>
>> @@ -909,6 +910,7 @@ void pblk_gc_free_full_lines(struct pblk *pblk);
>>   void pblk_gc_sysfs_state_show(struct pblk *pblk, int *gc_enabled,
>>                                int *gc_active);
>>   int pblk_gc_sysfs_force(struct pblk *pblk, int force);
>> +void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line);
>>
>>   /*
>>    * pblk rate limiter
>> --
>> 2.9.5
>>
