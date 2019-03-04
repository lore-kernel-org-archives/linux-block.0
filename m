Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177BCC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 14:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CE5206BA
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 14:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="gb19Mct0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfCDO6I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:58:08 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44653 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfCDO6I (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 09:58:08 -0500
Received: by mail-ed1-f68.google.com with SMTP id b20so4472207edw.11
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 06:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZwWHYEpDqiDXeRRZhYwP719Gvx2bQZcfLsD/oiK/GrM=;
        b=gb19Mct0g4o/b4iNI1uB9fBfsTdKN79aLu8cX1+/yO0ZgLlblNfAut7yny8kn+7FoB
         BrxLoarVA6jIJuj6b28F31DJR6VqCtfBYePrBy6ZAuujMQVzcl+Ne6bbjwn7vIDkfehH
         UuLKOA2tM80XWy2ca4eAb5lLNjenNYBCGSh2PaE8kEB7Chc8/+U4C9YWmvi7UTNbyvF7
         zUd+aa2ByRLAHrT60LX1zB04fdWBQK2/RSlXcdW7+mEXxPjZZwa/f7llKB/s4EPjqjgR
         cgqhNRzDoxsLcYV0C3t2/NZV7WetusmR9i539yTmbyfcIK1OCJEblxNmPOWxaWCiJ9ib
         j81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZwWHYEpDqiDXeRRZhYwP719Gvx2bQZcfLsD/oiK/GrM=;
        b=HJXMn25xb+IrHiY8bzMpK+J2tnuk3+mvclZ+YybETiJ/BhZdaC5EviiHJE+QYixmz/
         DqvLqROA2asz/D/nPq/dl1QxIxAlMDddzYObCvvMRuAZHkm6af4YwJIwrQaY96s6xvRE
         NKu6ltDcN7vONa8nqZyq5+8BQy1m9ObNQlWNeVTU1fXCH2BCFSWu/Ovf8SrcOwVHjtkF
         66Rn3AqRcjJGtF0hb41+ZlC94+eiYrJZFVF0GyQaZf9sWQAruROETLnUKycNRXIWp/uM
         LkPrtJ5EvAQQf7lHN9ExvwvW3gV2TT6qbbGClsiX5Tq2NSWAIzoJqB/pNcuSTT57SAD0
         f1UA==
X-Gm-Message-State: APjAAAVc6S6AX8rFUaDfAHE1zzUizi8LMjzdtWW7rE+1Z9HTOkkmPj3G
        PtJky1uWH4/5fPvWG30IfTDoeQ==
X-Google-Smtp-Source: APXvYqySeZJBYn8dQAteQkZQW16rr7qG43qI5ZrD5Y1o0A+mhyBcCD65WFyLT1yHaIVl7PXm3N1YCw==
X-Received: by 2002:a50:f709:: with SMTP id g9mr15077456edn.118.1551711485937;
        Mon, 04 Mar 2019 06:58:05 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id c50sm2155207edc.81.2019.03.04.06.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 06:58:04 -0800 (PST)
Subject: Re: [PATCH 13/13] lightnvm: Inherit mdts from the parent nvme device
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     Hans Holmberg <hans@owltronix.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Simon Andreas Frimann Lund <slund@cnexlabs.com>,
        Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-14-igor.j.konopko@intel.com>
 <2776B2AC-19D2-4E38-94AD-E158E3E60A37@javigon.com>
 <CANr-nt2dNY8EgeJ7qAutfVEuyose_8_j9w6WkO-mER-Ao6oXOg@mail.gmail.com>
 <54D42A19-96EE-4370-B957-A474BB912530@javigon.com>
 <CANr-nt1zQWf8XkQaesyFO+wTLULdEAvATvYjYFiDXbc_vifKGQ@mail.gmail.com>
 <CDD16047-68EF-43EA-A33B-11279A4301E6@javigon.com>
 <c6fbb977-bfde-d76d-cc4f-198a732d38d0@lightnvm.io>
 <EA36DDD6-5A3D-4F5C-9B18-53E266EB676F@javigon.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <d527f81c-69a6-7b97-d258-2acb18fbc95d@lightnvm.io>
Date:   Mon, 4 Mar 2019 15:58:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <EA36DDD6-5A3D-4F5C-9B18-53E266EB676F@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/4/19 2:44 PM, Javier González wrote:
> 
>> On 4 Mar 2019, at 14.25, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 3/4/19 2:19 PM, Javier González wrote:
>>>> On 4 Mar 2019, at 13.22, Hans Holmberg <hans@owltronix.com> wrote:
>>>>
>>>> On Mon, Mar 4, 2019 at 12:44 PM Javier González <javier@javigon.com> wrote:
>>>>>> On 4 Mar 2019, at 12.30, Hans Holmberg <hans@owltronix.com> wrote:
>>>>>>
>>>>>> On Mon, Mar 4, 2019 at 10:05 AM Javier González <javier@javigon.com> wrote:
>>>>>>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>>>>>>>
>>>>>>>> Current lightnvm and pblk implementation does not care
>>>>>>>> about NVMe max data transfer size, which can be smaller
>>>>>>>> than 64*K=256K. This patch fixes issues related to that.
>>>>>>
>>>>>> Could you describe *what* issues you are fixing?
>>>>>>
>>>>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>>>>>> ---
>>>>>>>> drivers/lightnvm/core.c      | 9 +++++++--
>>>>>>>> drivers/nvme/host/lightnvm.c | 1 +
>>>>>>>> include/linux/lightnvm.h     | 1 +
>>>>>>>> 3 files changed, 9 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>>>>>>>> index 5f82036fe322..c01f83b8fbaf 100644
>>>>>>>> --- a/drivers/lightnvm/core.c
>>>>>>>> +++ b/drivers/lightnvm/core.c
>>>>>>>> @@ -325,6 +325,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>>>>>>>>      struct nvm_target *t;
>>>>>>>>      struct nvm_tgt_dev *tgt_dev;
>>>>>>>>      void *targetdata;
>>>>>>>> +     unsigned int mdts;
>>>>>>>>      int ret;
>>>>>>>>
>>>>>>>>      switch (create->conf.type) {
>>>>>>>> @@ -412,8 +413,12 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>>>>>>>>      tdisk->private_data = targetdata;
>>>>>>>>      tqueue->queuedata = targetdata;
>>>>>>>>
>>>>>>>> -     blk_queue_max_hw_sectors(tqueue,
>>>>>>>> -                     (dev->geo.csecs >> 9) * NVM_MAX_VLBA);
>>>>>>>> +     mdts = (dev->geo.csecs >> 9) * NVM_MAX_VLBA;
>>>>>>>> +     if (dev->geo.mdts) {
>>>>>>>> +             mdts = min_t(u32, dev->geo.mdts,
>>>>>>>> +                             (dev->geo.csecs >> 9) * NVM_MAX_VLBA);
>>>>>>>> +     }
>>>>>>>> +     blk_queue_max_hw_sectors(tqueue, mdts);
>>>>>>>>
>>>>>>>>      set_capacity(tdisk, tt->capacity(targetdata));
>>>>>>>>      add_disk(tdisk);
>>>>>>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>>>>>>>> index b759c25c89c8..b88a39a3cbd1 100644
>>>>>>>> --- a/drivers/nvme/host/lightnvm.c
>>>>>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>>>>>> @@ -991,6 +991,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
>>>>>>>>      geo->csecs = 1 << ns->lba_shift;
>>>>>>>>      geo->sos = ns->ms;
>>>>>>>>      geo->ext = ns->ext;
>>>>>>>> +     geo->mdts = ns->ctrl->max_hw_sectors;
>>>>>>>>
>>>>>>>>      dev->q = q;
>>>>>>>>      memcpy(dev->name, disk_name, DISK_NAME_LEN);
>>>>>>>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>>>>>>>> index 5d865a5d5cdc..d3b02708e5f0 100644
>>>>>>>> --- a/include/linux/lightnvm.h
>>>>>>>> +++ b/include/linux/lightnvm.h
>>>>>>>> @@ -358,6 +358,7 @@ struct nvm_geo {
>>>>>>>>      u16     csecs;          /* sector size */
>>>>>>>>      u16     sos;            /* out-of-band area size */
>>>>>>>>      bool    ext;            /* metadata in extended data buffer */
>>>>>>>> +     u32     mdts;           /* Max data transfer size*/
>>>>>>>>
>>>>>>>>      /* device write constrains */
>>>>>>>>      u32     ws_min;         /* minimum write size */
>>>>>>>> --
>>>>>>>> 2.17.1
>>>>>>>
>>>>>>> I see where you are going with this and I partially agree, but none of
>>>>>>> the OCSSD specs define a way to define this parameter. Thus, adding this
>>>>>>> behavior taken from NVMe in Linux can break current implementations. Is
>>>>>>> this a real life problem for you? Or this is just for NVMe “correctness”?
>>>>>>>
>>>>>>> Javier
>>>>>>
>>>>>> Hmm.Looking into the 2.0 spec what it says about vector reads:
>>>>>>
>>>>>> (figure 28):"The number of Logical Blocks (NLB): This field indicates
>>>>>> the number of logical blocks to be read. This is a 0’s based value.
>>>>>> Maximum of 64 LBAs is supported."
>>>>>>
>>>>>> You got the max limit covered, and the spec  does not say anything
>>>>>> about the minimum number of LBAs to support.
>>>>>>
>>>>>> Matias: any thoughts on this?
>>>>>>
>>>>>> Javier: How would this patch break current implementations?
>>>>>
>>>>> Say an OCSSD controller that sets mdts to a value under 64 or does not
>>>>> set it at all (maybe garbage). Think you can get to one pretty quickly...
>>>>
>>>> So we cant make use of a perfectly good, standardized, parameter
>>>> because some hypothetical non-compliant device out there might not
>>>> provide a sane value?
>>> The OCSSD standard has never used NVMe parameters, so there is no
>>> compliant / non-compliant. In fact, until we changed OCSSD 2.0 to
>>> get the sector and OOB sizes from the standard identify
>>> command, we used to have them in the geometry.
>>
>> What the hell? Yes it has. The whole OCSSD spec is dependent on the
>> NVMe spec. It is using many commands from the NVMe specification,
>> which is not defined in the OCSSD specification.
>>
> 
> First, lower the tone. >
> Second, no, it has not and never has, starting with all the write
> constrains, continuing with the vector commands, etc.  > You cannot choose
> what you want to be compliant with and what you do not. OCSSD uses the
> NVMe protocol but it is self sufficient with its geometry for all the
> read / write / erase paths - it even depends on different PCIe class
> codes to be identified… 

No. It does not.

To do this in the way the rest of the spec is
> defined, we either add a filed to the geometry or explicitly mention
> that MDTS is used, as we do with the sector and metadata sizes.
> 
> Third, as a maintainer of this subsystem you should care about devices
> in the field that might break due to such a change (supported by the
> company you work for or not) - even if you can argue whether the change
> is compliant or not.

Same as Hans. If you worry about me doing my job, you need not to.

> 
> And Hans, as a representative of a company that has such devices out
> there, you should care too.
> 
> What if we add a quirk in the feature bits for this so that newer
> devices can implement this and older devices can still function?
> 
>> The MDTS field should be respected in all case, similarly to how the
>> block layer respects it. Since the lightnvm subsystem are hooking in
>> on the side, this also be honoured by pblk (or the lightnvm subsystem
>> should fix it up)
>>
> 
> This said, pblk does not care which value you give, it uses what the
> subsystem tells it - this is not arguing for this change not to be
> implemented.
> 
> The only thing we should care about if implementing this is removing the
> constant defining 64 ppas and making allocations dynamic in the partial
> read and GC paths.
> 
> Javier
> 

