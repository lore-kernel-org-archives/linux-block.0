Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B4DC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 13:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB2820857
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 13:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfCRNC7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:02:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:14490 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfCRNC7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 09:02:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 06:02:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,493,1544515200"; 
   d="scan'208";a="126380688"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.142.164]) ([10.237.142.164])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2019 06:02:57 -0700
Subject: Re: [PATCH 10/18] lightnvm: pblk: ensure that emeta is written
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-11-igor.j.konopko@intel.com>
 <6766e0ae-ec44-3ebd-0015-aeb7cb9029e5@lightnvm.io>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <5d8dc4e4-c1a4-88ea-9006-47c3c492ea2c@intel.com>
Date:   Mon, 18 Mar 2019 14:02:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <6766e0ae-ec44-3ebd-0015-aeb7cb9029e5@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 17.03.2019 20:44, Matias Bjørling wrote:
> On 3/14/19 9:04 AM, Igor Konopko wrote:
>> When we are trying to switch to the new line, we need to ensure that
>> emeta for n-2 line is already written. In other case we can end with
>> deadlock scenario, when the writer has no more requests to write and
>> thus there is no way to trigger emeta writes from writer thread. This
>> is a corner case scenario which occurs in a case of multiple writes
>> error and thus kind of early line close due to lack of line space.
>>
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> ---
>>   drivers/lightnvm/pblk-core.c  |  2 ++
>>   drivers/lightnvm/pblk-write.c | 24 ++++++++++++++++++++++++
>>   drivers/lightnvm/pblk.h       |  1 +
>>   3 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>> index 38e26fe..a683d1f 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -1001,6 +1001,7 @@ static void pblk_line_setup_metadata(struct 
>> pblk_line *line,
>>                        struct pblk_line_mgmt *l_mg,
>>                        struct pblk_line_meta *lm)
>>   {
>> +    struct pblk *pblk = container_of(l_mg, struct pblk, l_mg);
>>       int meta_line;
>>       lockdep_assert_held(&l_mg->free_lock);
>> @@ -1009,6 +1010,7 @@ static void pblk_line_setup_metadata(struct 
>> pblk_line *line,
>>       meta_line = find_first_zero_bit(&l_mg->meta_bitmap, 
>> PBLK_DATA_LINES);
>>       if (meta_line == PBLK_DATA_LINES) {
>>           spin_unlock(&l_mg->free_lock);
>> +        pblk_write_emeta_force(pblk);
>>           io_schedule();
>>           spin_lock(&l_mg->free_lock);
>>           goto retry_meta;
>> diff --git a/drivers/lightnvm/pblk-write.c 
>> b/drivers/lightnvm/pblk-write.c
>> index 4e63f9b..4fbb9b2 100644
>> --- a/drivers/lightnvm/pblk-write.c
>> +++ b/drivers/lightnvm/pblk-write.c
>> @@ -505,6 +505,30 @@ static struct pblk_line 
>> *pblk_should_submit_meta_io(struct pblk *pblk,
>>       return meta_line;
>>   }
>> +void pblk_write_emeta_force(struct pblk *pblk)
>> +{
>> +    struct pblk_line_meta *lm = &pblk->lm;
>> +    struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>> +    struct pblk_line *meta_line;
>> +
>> +    while (true) {
>> +        spin_lock(&l_mg->close_lock);
>> +        if (list_empty(&l_mg->emeta_list)) {
>> +            spin_unlock(&l_mg->close_lock);
>> +            break;
>> +        }
>> +        meta_line = list_first_entry(&l_mg->emeta_list,
>> +                        struct pblk_line, list);
>> +        if (meta_line->emeta->mem >= lm->emeta_len[0]) {
>> +            spin_unlock(&l_mg->close_lock);
>> +            io_schedule();
>> +            continue;
>> +        }
>> +        spin_unlock(&l_mg->close_lock);
>> +        pblk_submit_meta_io(pblk, meta_line);
>> +    }
>> +}
>> +
>>   static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
>>   {
>>       struct ppa_addr erase_ppa;
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index 0a85990..a42bbfb 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -877,6 +877,7 @@ int pblk_write_ts(void *data);
>>   void pblk_write_timer_fn(struct timer_list *t);
>>   void pblk_write_should_kick(struct pblk *pblk);
>>   void pblk_write_kick(struct pblk *pblk);
>> +void pblk_write_emeta_force(struct pblk *pblk);
>>   /*
>>    * pblk read path
>>
> 
> Hi Igor,
> 
> Is this an error that qemu can force pblk to expose? Can you provide a 
> specific example on what is needed to force the error?

So I hit this error on PBLKs with low number of LUNs and multiple write 
IO errors (should be reproducible with error injection). Then 
pblk_map_remaining() quickly mapped all the sectors in line and thus 
writer thread was not able to issue all the necessary emeta IO writes, 
so it stucks when trying to replace line to new one. So this is 
definitely an error/corner case scenario.
