Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41506 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756476AbeFSIYe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jun 2018 04:24:34 -0400
Received: by mail-lf0-f67.google.com with SMTP id d24-v6so28781488lfa.8
        for <linux-block@vger.kernel.org>; Tue, 19 Jun 2018 01:24:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5F064E8B-56A2-45AD-BEA5-A5C115995D0C@cnexlabs.com>
References: <20180615222706.3801-1-igor.j.konopko@intel.com>
 <20180615222706.3801-6-igor.j.konopko@intel.com> <5977e8b8-223b-3d15-76df-82c827d6775a@lightnvm.io>
 <5F064E8B-56A2-45AD-BEA5-A5C115995D0C@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Date: Tue, 19 Jun 2018 10:24:32 +0200
Message-ID: <CAOA7RkNCgCu8p0DvT=T1gcwxPxJZu6BxSnZ+XC9MXWWi9MHdVQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] lightnvm: pblk: Disable interleaved metadata in pblk
To: Javier Gonzalez <javier@cnexlabs.com>
Cc: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "michal.sorn@intel.com" <michal.sorn@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jun 18, 2018 at 4:29 PM, Javier Gonzalez <javier@cnexlabs.com> wrot=
e:
>> On 16 Jun 2018, at 21.38, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>>
>> On 06/16/2018 12:27 AM, Igor Konopko wrote:
>>> Currently pblk and lightnvm does only check for size
>>> of OOB metadata and does not care wheather this meta
>>> is located in separate buffer or is interleaved with
>>> data in single buffer.
>>> In reality only the first scenario is supported, where
>>> second mode will break pblk functionality during any
>>> IO operation.
>>> The goal of this patch is to block creation of pblk
>>> devices in case of interleaved metadata
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> ---
>>>  drivers/lightnvm/pblk-init.c | 6 ++++++
>>>  drivers/nvme/host/lightnvm.c | 1 +
>>>  include/linux/lightnvm.h     | 1 +
>>>  3 files changed, 8 insertions(+)
>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.=
c
>>> index 5eb641da46ed..483a6d479e7d 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -1238,6 +1238,12 @@ static void *pblk_init(struct nvm_tgt_dev *dev, =
struct gendisk *tdisk,
>>>              return ERR_PTR(-EINVAL);
>>>      }
>>>  +   if (geo->ext) {
>>> +            pr_err("pblk: extended (interleaved) metadata in data buff=
er"
>>> +                    " not supported\n");
>>> +            return ERR_PTR(-EINVAL);
>>> +    }
>>> +
>>>      pblk =3D kzalloc(sizeof(struct pblk), GFP_KERNEL);
>>>      if (!pblk)
>>>              return ERR_PTR(-ENOMEM);
>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.=
c
>>> index 670478abc754..872ab854ccf5 100644
>>> --- a/drivers/nvme/host/lightnvm.c
>>> +++ b/drivers/nvme/host/lightnvm.c
>>> @@ -979,6 +979,7 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
>>>      geo->csecs =3D 1 << ns->lba_shift;
>>>      geo->sos =3D ns->ms;
>>> +    geo->ext =3D ns->ext;
>>>  }
>>>    int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
>>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>>> index 72a55d71917e..b13e64e2112f 100644
>>> --- a/include/linux/lightnvm.h
>>> +++ b/include/linux/lightnvm.h
>>> @@ -350,6 +350,7 @@ struct nvm_geo {
>>>      u32     clba;           /* sectors per chunk */
>>>      u16     csecs;          /* sector size */
>>>      u16     sos;            /* out-of-band area size */
>>> +    u16     ext;            /* metadata in extended data buffer */
>>>      /* device write constrains */
>>>      u32     ws_min;         /* minimum write size */
>>
>> I think bool type would be better here. Can it be placesd a bit down, ju=
st over the 1.2 stuff?
>>
>> Also, feel free to fix up the checkpatch stuff in patch 1 & 3 & 5.
>
> Apart from Matias' comments, it looks good to me.
>
> Traditionally, we have separated subsystem and target patches to make
> sure there is no coupling between pblk and lightnvm, but if Matias is ok
> with starting having patches covering all at once, then good for me too.
>

I often object when a patch can logically be split into two and should
be two distinct parts. In this case, it fits together.
