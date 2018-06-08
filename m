Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:32813 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbeFHNSx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jun 2018 09:18:53 -0400
Received: by mail-lf0-f67.google.com with SMTP id y20-v6so20078990lfy.0
        for <linux-block@vger.kernel.org>; Fri, 08 Jun 2018 06:18:52 -0700 (PDT)
Subject: Re: [PATCH v2] lightnvm: pblk: handle case when mw_cunits equals to 0
To: Javier Gonzalez <javier@cnexlabs.com>,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "michal.sorn@intel.com" <michal.sorn@intel.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <1528388123-14193-1-git-send-email-marcin.dziegielewski@intel.com>
 <62454DF5-7E75-453B-ABCD-197B1B114A20@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <192fc0a1-6e02-4993-1308-c75b3197df35@lightnvm.io>
Date: Fri, 8 Jun 2018 15:18:50 +0200
MIME-Version: 1.0
In-Reply-To: <62454DF5-7E75-453B-ABCD-197B1B114A20@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/08/2018 02:37 PM, Javier Gonzalez wrote:
>> On 7 Jun 2018, at 18.15, Marcin Dziegielewski <marcin.dziegielewski@intel.com> wrote:
>>
>> Some devices can expose mw_cunits equal to 0, it can cause the creation of too small write buffer and cause performance to drop on write workloads.
>>
>> Additionally, write buffer size must cover openchannel write data requirements, such as WS_MIN and MW_CUNITS - it must be greater than or equal to the larger one multipled by number of luns. However, for the performance reason, we are using WS_OPT value to calculation instead of WS_MIN.
>>
>> Because the place where buffer size is calculated was changed, this patch also removes pgs_in_buffer filed in pblk structure.
> 
> Please keep 72 characters on the commit description.
> scripts/checkpatch.pl should report this.
> 
> Maybe Matias can format it when picking it up.
> 
>>
>> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> ---
>> drivers/lightnvm/pblk-init.c | 9 +++++----
>> drivers/lightnvm/pblk.h      | 3 ---
>> 2 files changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>> index a27b28d..2f94832 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -179,11 +179,14 @@ static int pblk_rwb_init(struct pblk *pblk)
>> 	struct pblk_rb_entry *entries;
>> 	unsigned long nr_entries, buffer_size;
>> 	unsigned int power_size, power_seg_sz;
>> +	int pgs_in_buffer;
>>
>> -	if (write_buffer_size && (write_buffer_size > pblk->pgs_in_buffer))
>> +	pgs_in_buffer = max(geo->mw_cunits, geo->ws_opt) * geo->all_luns;
>> +
>> +	if (write_buffer_size && (write_buffer_size > pgs_in_buffer))
>> 		buffer_size = write_buffer_size;
>> 	else
>> -		buffer_size = pblk->pgs_in_buffer;
>> +		buffer_size = pgs_in_buffer;
>>
>> 	nr_entries = pblk_rb_calculate_size(buffer_size);
>>
>> @@ -366,8 +369,6 @@ static int pblk_core_init(struct pblk *pblk)
>> 	atomic64_set(&pblk->nr_flush, 0);
>> 	pblk->nr_flush_rst = 0;
>>
>> -	pblk->pgs_in_buffer = geo->mw_cunits * geo->all_luns;
>> -
>> 	pblk->min_write_pgs = geo->ws_opt * (geo->csecs / PAGE_SIZE);
>> 	max_write_ppas = pblk->min_write_pgs * geo->all_luns;
>> 	pblk->max_write_pgs = min_t(int, max_write_ppas, NVM_MAX_VLBA);
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index 7fbdfdc..b62fc3e 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -608,9 +608,6 @@ struct pblk {
>>
>> 	int min_write_pgs; /* Minimum amount of pages required by controller */
>> 	int max_write_pgs; /* Maximum amount of pages supported by controller */
>> -	int pgs_in_buffer; /* Number of pages that need to be held in buffer to
>> -			    * guarantee successful reads.
>> -			    */
>>
>> 	sector_t capacity; /* Device capacity when bad blocks are subtracted */
>>
>> --
>> 1.8.3.1
> 
> Otherwise the patch looks good.
> 
> Reviewed-by: Javier González <javier@cnexlabs.com>
> 

Thanks. Applied for 4.19.
