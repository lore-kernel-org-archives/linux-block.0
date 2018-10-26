Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37512 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbeJ0DYl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Oct 2018 23:24:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id c4-v6so2073506lja.4
        for <linux-block@vger.kernel.org>; Fri, 26 Oct 2018 11:46:32 -0700 (PDT)
Subject: Re: [PATCH v2] lightnvm: pblk: ignore the smeta oob area scan
To: hans@owltronix.com
Cc: zjwu@marvell.com, javier@cnexlabs.com, linux-block@vger.kernel.org,
        hongd@marvell.com, hans.holmberg@cnexlabs.com
References: <1540510706-32603-1-git-send-email-zjwu@marvell.com>
 <98c75976-6d6e-d4ae-01f8-2c3e92f752ee@lightnvm.io>
 <CANr-nt3YdEhRdvMD=MbXxKz0xj1z5BJ5GQa5p5zs0Bn2MNDvcw@mail.gmail.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <13bb3d8b-72f8-a101-d0d3-39fe60582c7a@lightnvm.io>
Date: Fri, 26 Oct 2018 20:46:28 +0200
MIME-Version: 1.0
In-Reply-To: <CANr-nt3YdEhRdvMD=MbXxKz0xj1z5BJ5GQa5p5zs0Bn2MNDvcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/26/2018 01:49 PM, Hans Holmberg wrote:
> Yes, please do.
> 
> Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> On Fri, Oct 26, 2018 at 10:08 AM Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 10/26/2018 01:38 AM, Zhoujie Wu wrote:
>>> The smeta area l2p mapping is empty, and actually the
>>> recovery procedure only need to restore data sector's l2p
>>> mapping. So ignore the smeta oob scan.
>>>
>>> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
>>> ---
>>> v2: Modified based on suggestion from Hans. The smeta may not start from
>>> paddr 0 if the first block is bad. Use pblk_line_smeta_start to calculate
>>> the smeta start address.
>>>
>>>    drivers/lightnvm/pblk-recovery.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>>> index 5740b75..0fbd30e 100644
>>> --- a/drivers/lightnvm/pblk-recovery.c
>>> +++ b/drivers/lightnvm/pblk-recovery.c
>>> @@ -334,6 +334,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>>>                               struct pblk_recov_alloc p)
>>>    {
>>>        struct nvm_tgt_dev *dev = pblk->dev;
>>> +     struct pblk_line_meta *lm = &pblk->lm;
>>>        struct nvm_geo *geo = &dev->geo;
>>>        struct ppa_addr *ppa_list;
>>>        struct pblk_sec_meta *meta_list;
>>> @@ -342,12 +343,12 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>>>        void *data;
>>>        dma_addr_t dma_ppa_list, dma_meta_list;
>>>        __le64 *lba_list;
>>> -     u64 paddr = 0;
>>> +     u64 paddr = pblk_line_smeta_start(pblk, line) + lm->smeta_sec;
>>>        bool padded = false;
>>>        int rq_ppas, rq_len;
>>>        int i, j;
>>>        int ret;
>>> -     u64 left_ppas = pblk_sec_in_open_line(pblk, line);
>>> +     u64 left_ppas = pblk_sec_in_open_line(pblk, line) - lm->smeta_sec;
>>>
>>>        if (pblk_line_wp_is_unbalanced(pblk, line))
>>>                pblk_warn(pblk, "recovering unbalanced line (%d)\n", line->id);
>>>
>>
>> Looks good to me. Hans, can I add your reviewed by?

Thanks. Applied for 4.21/5.1.
