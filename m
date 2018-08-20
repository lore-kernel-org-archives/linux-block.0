Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36784 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeHTRwv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Aug 2018 13:52:51 -0400
Received: by mail-ua1-f68.google.com with SMTP id c12-v6so9851038uan.3
        for <linux-block@vger.kernel.org>; Mon, 20 Aug 2018 07:36:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d03ed26c-cb06-d9b7-e7ee-d0b78316641a@lightnvm.io>
References: <20180820121217.11393-1-mb@lightnvm.io> <DA2F1D94-23DC-4739-9056-351992D972EE@cnexlabs.com>
 <d03ed26c-cb06-d9b7-e7ee-d0b78316641a@lightnvm.io>
From: Hans Holmberg <hans@owltronix.com>
Date: Mon, 20 Aug 2018 16:36:55 +0200
Message-ID: <CANr-nt0_3WxmG7=8XDjkii_1KrpX1XHk2N5P3fSSCgYdF-TGJA@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: introduce nvm_rq_to_ppa_list
To: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc: Javier Gonzalez <javier@cnexlabs.com>, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        Hans Holmberg <hans.holmberg@cnexlabs.com>, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Will do. i'll squash your patch with my two. Your commit message is
better, so i hope you don't mind me using it :)

All the best,
Hans

On Mon, Aug 20, 2018 at 2:46 PM, Matias Bj=C3=B8rling <mb@lightnvm.io> wrot=
e:
> On 08/20/2018 02:38 PM, Javier Gonzalez wrote:
>>>
>>> On 20 Aug 2018, at 14.12, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>>>
>>> There is a number of places in the lightnvm subsystem where the user
>>> iterates over the ppa list. Before iterating, the user must know if it
>>> is a single or multiple LBAs due to vector commands using either the
>>> nvm_rq ->ppa_addr or ->ppa_list fields on command submission, which
>>> leads to open-coding the if/else statement.
>>>
>>> Instead of having multiple if/else's, move it into a function that can
>>> be called by its users.
>>>
>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>> ---
>>> drivers/lightnvm/pblk-read.c  | 4 +---
>>> drivers/lightnvm/pblk-write.c | 5 +----
>>> drivers/lightnvm/pblk.h       | 4 +---
>>> include/linux/lightnvm.h      | 5 +++++
>>> 4 files changed, 8 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.=
c
>>> index f275c7e5abe4..696d3a9c9cf0 100644
>>> --- a/drivers/lightnvm/pblk-read.c
>>> +++ b/drivers/lightnvm/pblk-read.c
>>> @@ -175,11 +175,9 @@ static void __pblk_read_put_line(struct pblk *pblk=
,
>>> struct ppa_addr ppa)
>>>
>>> static void pblk_read_put_line(struct pblk *pblk, struct nvm_rq *rqd)
>>> {
>>> -       struct ppa_addr *ppa_list;
>>> +       struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
>>>         int i;
>>>
>>> -       ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_add=
r;
>>> -
>>>         for (i =3D 0; i < rqd->nr_ppas; i++)
>>>                 __pblk_read_put_line(pblk, ppa_list[i]);
>>> }
>>> diff --git a/drivers/lightnvm/pblk-write.c
>>> b/drivers/lightnvm/pblk-write.c
>>> index df99c45778d4..a92450ec7698 100644
>>> --- a/drivers/lightnvm/pblk-write.c
>>> +++ b/drivers/lightnvm/pblk-write.c
>>> @@ -212,10 +212,7 @@ static void pblk_submit_rec(struct work_struct
>>> *work)
>>>
>>>         pblk_log_write_err(pblk, rqd);
>>>
>>> -       if (rqd->nr_ppas =3D=3D 1)
>>> -               ppa_list =3D &rqd->ppa_addr;
>>> -       else
>>> -               ppa_list =3D rqd->ppa_list;
>>> +       ppa_list =3D nvm_rq_to_ppa_list(rqd);
>>>
>>>         pblk_map_remaining(pblk, ppa_list);
>>>         pblk_queue_resubmit(pblk, c_ctx);
>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>> index 64ae0c7ed3bb..bda098c7cc3b 100644
>>> --- a/drivers/lightnvm/pblk.h
>>> +++ b/drivers/lightnvm/pblk.h
>>> @@ -1335,9 +1335,7 @@ static inline int pblk_boundary_ppa_checks(struct
>>> nvm_tgt_dev *tgt_dev,
>>> static inline int pblk_check_io(struct pblk *pblk, struct nvm_rq *rqd)
>>> {
>>>         struct nvm_tgt_dev *dev =3D pblk->dev;
>>> -       struct ppa_addr *ppa_list;
>>> -
>>> -       ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_add=
r;
>>> +       struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
>>>
>>>         if (pblk_boundary_ppa_checks(dev, ppa_list, rqd->nr_ppas)) {
>>>                 WARN_ON(1);
>>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>>> index 0106984400bc..1497e275f90f 100644
>>> --- a/include/linux/lightnvm.h
>>> +++ b/include/linux/lightnvm.h
>>> @@ -487,6 +487,11 @@ static inline struct ppa_addr
>>> dev_to_generic_addr(struct nvm_dev *dev,
>>>         return l;
>>> }
>>>
>>> +static inline struct ppa_addr *nvm_rq_to_ppa_list(struct nvm_rq *rqd)
>>> +{
>>> +       return (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
>>> +}
>>> +
>>> typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bi=
o
>>> *);
>>> typedef sector_t (nvm_tgt_capacity_fn)(void *);
>>> typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
>>> --
>>> 2.11.0
>>
>>
>> Hans made a similar patch some time ago. There are a number of places
>> where you want to use this helper too, also outside of pblk. You can
>> look at it here [1]
>>
>> [1] https://github.com/OpenChannelSSD/linux/commits/for-4.20/pblk
>>
>>     fdd88185bfed
>>     17609afb2db9
>>
>> Javier
>>
>
> I like Hans' better. Hans, could you please merge my patch with yours? I
> prefer the nvm_rq_to_ppa_list naming, rqdata -> rqd, and if short-hand.
>
