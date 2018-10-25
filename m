Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:36426 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727377AbeJZHrL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Oct 2018 03:47:11 -0400
Message-ID: <5BD24DDC.6070608@marvell.com>
Date: Thu, 25 Oct 2018 16:12:28 -0700
From: Zhoujie Wu <zjwu@marvell.com>
MIME-Version: 1.0
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
CC: Matias Bjorling <mb@lightnvm.io>,
        Javier Gonzalez <javier@cnexlabs.com>,
        <linux-block@vger.kernel.org>, <hongd@marvell.com>
Subject: Re: [EXT] Re: [PATCH] lightnvm: pblk: ignore the smeta oob area scan
References: <1540428404-30196-1-git-send-email-zjwu@marvell.com>
 <CANr-nt2bHSPhpRprvYcb1L-rhPFri0Cm2YBWdV+6AHe1Mk3mMw@mail.gmail.com>
In-Reply-To: <CANr-nt2bHSPhpRprvYcb1L-rhPFri0Cm2YBWdV+6AHe1Mk3mMw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 10/25/2018 04:16 AM, Hans Holmberg wrote:
> External Email
>
> ----------------------------------------------------------------------
> On Thu, Oct 25, 2018 at 2:44 AM Zhoujie Wu <zjwu@marvell.com> wrote:
>> The smeta area l2p mapping is empty, and actually the
>> recovery procedure only need to restore data sector's l2p
>> mapping. So ignore the smeta oob scan.
>>
>> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
>> ---
>>   drivers/lightnvm/pblk-recovery.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>> index 5740b75..30f2616 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -334,6 +334,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>>                                 struct pblk_recov_alloc p)
>>   {
>>          struct nvm_tgt_dev *dev = pblk->dev;
>> +       struct pblk_line_meta *lm = &pblk->lm;
>>          struct nvm_geo *geo = &dev->geo;
>>          struct ppa_addr *ppa_list;
>>          struct pblk_sec_meta *meta_list;
>> @@ -342,12 +343,12 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>>          void *data;
>>          dma_addr_t dma_ppa_list, dma_meta_list;
>>          __le64 *lba_list;
>> -       u64 paddr = 0;
>> +       u64 paddr = lm->smeta_sec;
> Smeta is not guaranteed to start at paddr 0 - it will be placed in the
> first non-bad chunk (in stripe order).
> If the first chunk in the line is bad, smeta will be read and
> lm->smeta_sec sectors will be lost.
>
> You can use pblk_line_smeta_start to calculate the start address of smeta.
>
> / Hans
Good point, I will submit v2 patch based on your suggestion. This 
reminds me the similar issue in function pblk_line_wp_is_unbalanced.
current 4.20 branch implementation, this function will check if all 
other blks' wp larger than blk0's wp, if larger, consider this line as 
unbalanced.
If blk0 is bad blk, the wp could be 0, this line will anyway consider as 
unbalance line and report a warning.  Looks like this also has to be fixed?

>>          bool padded = false;
>>          int rq_ppas, rq_len;
>>          int i, j;
>>          int ret;
>> -       u64 left_ppas = pblk_sec_in_open_line(pblk, line);
>> +       u64 left_ppas = pblk_sec_in_open_line(pblk, line) - lm->smeta_sec;
>>
>>          if (pblk_line_wp_is_unbalanced(pblk, line))
>>                  pblk_warn(pblk, "recovering unbalanced line (%d)\n", line->id);
>> --
>> 1.9.1
>>
