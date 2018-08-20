Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41895 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeHTPmo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Aug 2018 11:42:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id v22-v6so10752524lfe.8
        for <linux-block@vger.kernel.org>; Mon, 20 Aug 2018 05:27:17 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: refactor put line fn on read completion
To: hlitz@ucsc.edu
Cc: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180820114320.3764-1-mb@lightnvm.io>
 <CAJbgVnWe0b03gvO2815rGeB=J4NOEst9FSPf_vyJ3iUSgBuQnw@mail.gmail.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <8cbf9dd9-a982-a73c-23ed-d18c0e0ad3ad@lightnvm.io>
Date: Mon, 20 Aug 2018 14:27:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAJbgVnWe0b03gvO2815rGeB=J4NOEst9FSPf_vyJ3iUSgBuQnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/20/2018 02:22 PM, Heiner Litz wrote:
> Consider removing the "_read", make it non-static and move the function to
> pblk-core.c as the function isn't read specific.
> 
> On Mon, Aug 20, 2018 at 1:43 PM Matias Bjørling <mb@lightnvm.io> wrote:
> 
>> The read completion path uses the put_line variable to decide whether
>> the reference on a line should be released. The function name used for
>> that is pblk_read_put_rqd_kref, which could lead one to believe that it
>> is the rqd that is releasing the reference, while it is the line
>> reference that is put.
>>
>> Rename and also split the function in two to account for either rqd or
>> single ppa callers.
>>
>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>> ---
>>   drivers/lightnvm/pblk-read.c | 23 +++++++++++++----------
>>   1 file changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
>> index cd2f61eed6a0..16858eaf694a 100644
>> --- a/drivers/lightnvm/pblk-read.c
>> +++ b/drivers/lightnvm/pblk-read.c
>> @@ -165,20 +165,23 @@ static void pblk_read_check_rand(struct pblk *pblk,
>> struct nvm_rq *rqd,
>>          WARN_ONCE(j != rqd->nr_ppas, "pblk: corrupted random request\n");
>>   }
>>
>> -static void pblk_read_put_rqd_kref(struct pblk *pblk, struct nvm_rq *rqd)
>> +static void __pblk_read_put_line(struct pblk *pblk, struct ppa_addr ppa)
>>   {
>> -       struct ppa_addr *ppa_list;
>> -       int i;
>> -
>> -       ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
>> -
>> -       for (i = 0; i < rqd->nr_ppas; i++) {
>> -               struct ppa_addr ppa = ppa_list[i];
>>                  struct pblk_line *line;
>>
>>                  line = &pblk->lines[pblk_ppa_to_line(ppa)];
>>                  kref_put(&line->ref, pblk_line_put_wq);
>> -       }
>> +}
>> +
>> +static void pblk_read_put_line(struct pblk *pblk, struct nvm_rq *rqd)
>> +{
>> +       struct ppa_addr *ppa_list;
>> +       int i;
>> +
>> +       ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
>> +
>> +       for (i = 0; i < rqd->nr_ppas; i++)
>> +               __pblk_read_put_line(pblk, ppa_list[i]);
>>   }
>>
>>   static void pblk_end_user_read(struct bio *bio)
>> @@ -208,7 +211,7 @@ static void __pblk_end_io_read(struct pblk *pblk,
>> struct nvm_rq *rqd,
>>                  bio_put(int_bio);
>>
>>          if (put_line)
>> -               pblk_read_put_rqd_kref(pblk, rqd);
>> +               pblk_read_put_line(pblk, rqd);
>>
>>   #ifdef CONFIG_NVM_PBLK_DEBUG
>>          atomic_long_add(rqd->nr_ppas, &pblk->sync_reads);
>> --
>> 2.11.0
>>
>>
> 

Thanks Heiner. I'll send a v2.
