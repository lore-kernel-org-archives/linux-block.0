Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36117 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbeBFKzl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Feb 2018 05:55:41 -0500
Received: by mail-lf0-f65.google.com with SMTP id t79so2103283lfe.3
        for <linux-block@vger.kernel.org>; Tue, 06 Feb 2018 02:55:40 -0800 (PST)
Subject: Re: [PATCH 4/5] lightnvm: pblk: add padding distribution sysfs
 attribute
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
Cc: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1517364411-22386-1-git-send-email-javier@cnexlabs.com>
 <1517364411-22386-4-git-send-email-javier@cnexlabs.com>
 <bf06b0c0-b188-68ba-737b-f42d33c0d5dc@lightnvm.io>
 <CANr-nt1+=ikX6XUh3FKG_vgcBWzVkzdrWei82YRdHPTVPpxwuw@mail.gmail.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <3aaf482e-0f4f-9001-8df1-1ccd2004ce02@lightnvm.io>
Date: Tue, 6 Feb 2018 11:50:27 +0100
MIME-Version: 1.0
In-Reply-To: <CANr-nt1+=ikX6XUh3FKG_vgcBWzVkzdrWei82YRdHPTVPpxwuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/06/2018 10:27 AM, Hans Holmberg wrote:
> Hi Matias,
> 
> On Wed, Jan 31, 2018 at 9:44 AM, Matias Bjørling <mb@lightnvm.io> wrote:
>> On 01/31/2018 03:06 AM, Javier González wrote:
>>>
>>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>>
>>> When pblk receives a sync, all data up to that point in the write buffer
>>> must be comitted to persistent storage, and as flash memory comes with a
>>> minimal write size there is a significant cost involved both in terms
>>> of time for completing the sync and in terms of write amplification
>>> padded sectors for filling up to the minimal write size.
>>>
>>> In order to get a better understanding of the costs involved for syncs,
>>> Add a sysfs attribute to pblk: padded_dist, showing a normalized
>>> distribution of sectors padded. In order to facilitate measurements of
>>> specific workloads during the lifetime of the pblk instance, the
>>> distribution can be reset by writing 0 to the attribute.
>>>
>>> Do this by introducing counters for each possible padding:
>>> {0..(minimal write size - 1)} and calculate the normalized distribution
>>> when showing the attribute.
>>>
>>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>> Signed-off-by: Javier González <javier@cnexlabs.com>
>>> ---
>>>    drivers/lightnvm/pblk-init.c  | 16 ++++++++--
>>>    drivers/lightnvm/pblk-rb.c    | 15 +++++-----
>>>    drivers/lightnvm/pblk-sysfs.c | 68
>>> +++++++++++++++++++++++++++++++++++++++++++
>>>    drivers/lightnvm/pblk.h       |  6 +++-
>>>    4 files changed, 95 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>>> index 7eedc5daebc8..a5e3510c0f38 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -921,6 +921,7 @@ static void pblk_free(struct pblk *pblk)
>>>    {
>>>          pblk_luns_free(pblk);
>>>          pblk_lines_free(pblk);
>>> +       kfree(pblk->pad_dist);
>>>          pblk_line_meta_free(pblk);
>>>          pblk_core_free(pblk);
>>>          pblk_l2p_free(pblk);
>>> @@ -998,11 +999,13 @@ static void *pblk_init(struct nvm_tgt_dev *dev,
>>> struct gendisk *tdisk,
>>>          pblk->pad_rst_wa = 0;
>>>          pblk->gc_rst_wa = 0;
>>>    +     atomic_long_set(&pblk->nr_flush, 0);
>>> +       pblk->nr_flush_rst = 0;
>>> +
>>>    #ifdef CONFIG_NVM_DEBUG
>>>          atomic_long_set(&pblk->inflight_writes, 0);
>>>          atomic_long_set(&pblk->padded_writes, 0);
>>>          atomic_long_set(&pblk->padded_wb, 0);
>>> -       atomic_long_set(&pblk->nr_flush, 0);
>>>          atomic_long_set(&pblk->req_writes, 0);
>>>          atomic_long_set(&pblk->sub_writes, 0);
>>>          atomic_long_set(&pblk->sync_writes, 0);
>>> @@ -1034,10 +1037,17 @@ static void *pblk_init(struct nvm_tgt_dev *dev,
>>> struct gendisk *tdisk,
>>>                  goto fail_free_luns;
>>>          }
>>>    +     pblk->pad_dist = kzalloc((pblk->min_write_pgs - 1) *
>>> sizeof(atomic64_t),
>>> +                                GFP_KERNEL);
>>> +       if (!pblk->pad_dist) {
>>> +               ret = -ENOMEM;
>>> +               goto fail_free_line_meta;
>>> +       }
>>> +
>>>          ret = pblk_core_init(pblk);
>>>          if (ret) {
>>>                  pr_err("pblk: could not initialize core\n");
>>> -               goto fail_free_line_meta;
>>> +               goto fail_free_pad_dist;
>>>          }
>>>          ret = pblk_l2p_init(pblk);
>>> @@ -1097,6 +1107,8 @@ static void *pblk_init(struct nvm_tgt_dev *dev,
>>> struct gendisk *tdisk,
>>>          pblk_l2p_free(pblk);
>>>    fail_free_core:
>>>          pblk_core_free(pblk);
>>> +fail_free_pad_dist:
>>> +       kfree(pblk->pad_dist);
>>>    fail_free_line_meta:
>>>          pblk_line_meta_free(pblk);
>>>    fail_free_luns:
>>> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
>>> index 7044b5599cc4..264372d7b537 100644
>>> --- a/drivers/lightnvm/pblk-rb.c
>>> +++ b/drivers/lightnvm/pblk-rb.c
>>> @@ -437,9 +437,7 @@ static int pblk_rb_may_write_flush(struct pblk_rb *rb,
>>> unsigned int nr_entries,
>>>          if (bio->bi_opf & REQ_PREFLUSH) {
>>>                  struct pblk *pblk = container_of(rb, struct pblk, rwb);
>>>    -#ifdef CONFIG_NVM_DEBUG
>>>                  atomic_long_inc(&pblk->nr_flush);
>>> -#endif
>>>                  if (pblk_rb_flush_point_set(&pblk->rwb, bio, mem))
>>>                          *io_ret = NVM_IO_OK;
>>>          }
>>> @@ -620,14 +618,17 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb *rb,
>>> struct nvm_rq *rqd,
>>>                          pr_err("pblk: could not pad page in write bio\n");
>>>                          return NVM_IO_ERR;
>>>                  }
>>> +
>>> +               if (pad < pblk->min_write_pgs)
>>> +                       atomic64_inc(&pblk->pad_dist[pad - 1]);
>>> +               else
>>> +                       pr_warn("pblk: padding more than min. sectors\n");
>>
>>
>> Curious, when would this happen? Would it be an implementation error or
>> something a user did wrong?
> 
> This would be an implementation error - and this check is just a
> safeguard to make sure we won't go out of bounds when updating the
> statistics.
> 

Ah, does it make sense to have such defensive programming, when the 
value is never persisted? An 64 bit integer is quite large, and if only 
used for workloads for a single instance, it would practically never 
trigger, and if it did, do one care?

<snip>

>>
>> Looks good to me. Let me know if you want to send a new patch, or if I may
>> make the change when I pick it up.
> 
> Thanks for the review, i saw that you already reworked the patch a bit
> on your core branch.
> However, i found a build issue when building for i386, so i'll fix
> that and submit a V2(that includes your update)

Ok. I assume this is the kbuild mail I asked about a couple of days ago. 
I'll wait for v2.
