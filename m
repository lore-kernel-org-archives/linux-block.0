Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36765 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbeI3CY5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Sep 2018 22:24:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id b7-v6so6511554pfo.3
        for <linux-block@vger.kernel.org>; Sat, 29 Sep 2018 12:55:15 -0700 (PDT)
Subject: Re: [PATCH -next] lightnvm: pblk: fix error handling of
 pblk_lines_init()
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        weiyongjun1@huawei.com
Cc: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1537941384-25324-1-git-send-email-weiyongjun1@huawei.com>
 <CANr-nt2AugGYaifCj7dbeZ+3b4A8JyxKjZZeQQ7yhXbnJVGhDQ@mail.gmail.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <570f0994-eb27-24f6-740a-62e3cc00dc90@lightnvm.io>
Date: Sat, 29 Sep 2018 21:55:12 +0200
MIME-Version: 1.0
In-Reply-To: <CANr-nt2AugGYaifCj7dbeZ+3b4A8JyxKjZZeQQ7yhXbnJVGhDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 9/26/18 8:29 AM, Hans Holmberg wrote:
> On Wed, Sep 26, 2018 at 7:47 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>>
>> In the too many bad blocks error handling case, we should release all
>> the alloced resources instead direct return, otherwise it will cause
>> memory leak.
>>
>> Fixes: 2deeefc02dff ("lightnvm: pblk: fail gracefully on line alloc. failure")
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>> ---
>>   drivers/lightnvm/pblk-init.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>> index 537e98f..a26f4e6 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -1083,7 +1083,8 @@ static int pblk_lines_init(struct pblk *pblk)
>>
>>          if (!nr_free_chks) {
>>                  pblk_err(pblk, "too many bad blocks prevent for sane instance\n");
>> -               return -EINTR;
>> +               ret = -EINTR;
>> +               goto fail_free_lines;
>>          }
>>
>>          pblk_set_provision(pblk, nr_free_chks);
>>
> 
> Looks good to me.
> 
> Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 

Thanks. Applied for 4.20.
