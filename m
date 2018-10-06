Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:51428 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726505AbeJFILM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 6 Oct 2018 04:11:12 -0400
Message-ID: <5BB80B5E.7090804@marvell.com>
Date: Fri, 5 Oct 2018 18:09:50 -0700
From: Zhoujie Wu <zjwu@marvell.com>
MIME-Version: 1.0
To: =?UTF-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>
CC: <hongd@marvell.com>, <javier@cnexlabs.com>
Subject: Re: [EXT] Re: [PATCH v2] lightnvm: pblk: consider max hw sectors
 supported for max_write_pgs
References: <1538761161-6652-1-git-send-email-zjwu@marvell.com>
 <add40e9e-d35d-259a-5425-42268d1c0dfb@lightnvm.io>
In-Reply-To: <add40e9e-d35d-259a-5425-42268d1c0dfb@lightnvm.io>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 10/05/2018 06:01 PM, Matias Bjørling wrote:
> External Email
>
> ----------------------------------------------------------------------
> On 10/05/2018 07:39 PM, Zhoujie Wu wrote:
>> When do GC, the number of read/write sectors are determined
>> by max_write_pgs(see gc_rq preparation in pblk_gc_line_prepare_ws).
>>
>> Due to max_write_pgs doesn't consider max hw sectors
>> supported by nvme controller(128K), which leads to GC
>> tries to read 64 * 4K in one command, and see below error
>> caused by pblk_bio_map_addr in function pblk_submit_read_gc.
>>
>> [ 2923.005376] pblk: could not add page to bio
>> [ 2923.005377] pblk: could not allocate GC bio (18446744073709551604)
>>
>> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
>> ---
>> v2: Changed according to Javier's comments.
>> Remove unneccessary comment and move the definition of bqueue to
>> maintain ordering.
>>
>>   drivers/lightnvm/pblk-init.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>> index e357388..0ef9ac5 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -391,6 +391,7 @@ static void pblk_put_global_caches(void)
>>   static int pblk_core_init(struct pblk *pblk)
>>   {
>>       struct nvm_tgt_dev *dev = pblk->dev;
>> +    struct request_queue *bqueue = dev->q;
>>       struct nvm_geo *geo = &dev->geo;
>>       int ret, max_write_ppas;
>>   @@ -407,6 +408,8 @@ static int pblk_core_init(struct pblk *pblk)
>>       pblk->min_write_pgs = geo->ws_opt;
>>       max_write_ppas = pblk->min_write_pgs * geo->all_luns;
>>       pblk->max_write_pgs = min_t(int, max_write_ppas, NVM_MAX_VLBA);
>> +    pblk->max_write_pgs =  min_t(int, pblk->max_write_pgs,
>> +        queue_max_hw_sectors(bqueue) / (geo->csecs >> 9));
>>       pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
>>         pblk->pad_dist = kcalloc(pblk->min_write_pgs - 1, 
>> sizeof(atomic64_t),
>>
>
> Thanks Zhoujie. I've done the following update and applied it to 4.20. 
> Note that I also removed the bqueue.
Good for me, thanks a lot.
>
> -       pblk->max_write_pgs =  min_t(int, pblk->max_write_pgs,
> -               queue_max_hw_sectors(bqueue) / (geo->csecs >> 9));
> +       pblk->max_write_pgs = min_t(int, pblk->max_write_pgs,
> +               queue_max_hw_sectors(dev->q) / (geo->csecs >> 
> SECTOR_SHIFT));
>
> Javier, I've carried over your Reviewed-by, let me know if you want it 
> to be removed.
