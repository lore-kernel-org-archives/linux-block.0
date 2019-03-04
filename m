Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC70C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDBE206B8
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="f0G/pB35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfCDNZf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:25:35 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37274 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfCDNZf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 08:25:35 -0500
Received: by mail-ed1-f66.google.com with SMTP id m12so4232730edv.4
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 05:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iVPmjAHQohIMNbybzpSXwvQN/HNSDOK2g7hmfeBuu/w=;
        b=f0G/pB35NFbK6Q28j4SbhKmhkac3uGfb1jUJD9NLP+JLYNltOlQxPwwguWVlR0t0HU
         LVklX5nPtHWowZ4A1eE2aM/RXu25lkNVTwbsRP6B0JFQvhBgPgzA5MIRa2lwUma9GueW
         qyZtSqHsjXfHnmqfxX/IYZx0+eIbtmnHVhcBYN1pMHkzQP9W11+XXPZLmI0z5i1NRo2P
         l3TD2Ut3Ix6Aqud0xXBwfA+ReAILRZp6X4Jr/sVqXaYTTKX0nmuO6MvPr1MFi897cQVB
         MQ1ki2BV6NdQNcuUoktfchgoGfZOVxnxsFrbqq4w89bjieMaTSaonGCYQHzwEyP1jHCl
         EA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iVPmjAHQohIMNbybzpSXwvQN/HNSDOK2g7hmfeBuu/w=;
        b=LoO9QpcFGuQwwtQoq/qWYurU7rkzF+b1cBn1VkcwpPxeYzWlJXYPiGPh4LD/jchF8D
         TwBx2CvT9O5WjzjoofmBmwQM9actyTyDE5H2+DCoW2HVvaouAI4gybEMp/U5o8q3nb8o
         /4hKdhQ1rNyluMzyblpmvgX13teWkRlvOh2chJ77Av/fiZRnJLJyU5gHcZgSH2DjIRq+
         SGZTibdsRjzl9E1IIjnCp3BXbrkk8C7FDT9k1j1fAGSDITmViGj8PEpM1MV0Nk+rcRZo
         H37G4jgdbirs9CMxqQ/7O8oh4d5rak17pMGGCIlYRneFSjeZ5sX8cIUaP6qqvGYMOBMj
         DHJw==
X-Gm-Message-State: APjAAAWDFYV6ubf/uONLUjdU4Hoo5rN74NZavg9Xx+mPRHERoqJsKTMO
        UywnPmNfflgtI9kz4YR7EHiAXamsAHY=
X-Google-Smtp-Source: APXvYqy0eePDSMVTovSOITltTL2u3C0/OuDdhYF9Wh7GoQcSL952bQFiCa8V6rudAZkHRPpWQK/ZRQ==
X-Received: by 2002:a17:906:7711:: with SMTP id q17mr12764099ejm.174.1551705933034;
        Mon, 04 Mar 2019 05:25:33 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id z23sm2107573edz.50.2019.03.04.05.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:25:32 -0800 (PST)
Subject: Re: [PATCH 13/13] lightnvm: Inherit mdts from the parent nvme device
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Hans Holmberg <hans@owltronix.com>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
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
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <c6fbb977-bfde-d76d-cc4f-198a732d38d0@lightnvm.io>
Date:   Mon, 4 Mar 2019 14:25:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CDD16047-68EF-43EA-A33B-11279A4301E6@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/4/19 2:19 PM, Javier González wrote:
> 
>> On 4 Mar 2019, at 13.22, Hans Holmberg <hans@owltronix.com> wrote:
>>
>> On Mon, Mar 4, 2019 at 12:44 PM Javier González <javier@javigon.com> wrote:
>>>> On 4 Mar 2019, at 12.30, Hans Holmberg <hans@owltronix.com> wrote:
>>>>
>>>> On Mon, Mar 4, 2019 at 10:05 AM Javier González <javier@javigon.com> wrote:
>>>>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>>>>>
>>>>>> Current lightnvm and pblk implementation does not care
>>>>>> about NVMe max data transfer size, which can be smaller
>>>>>> than 64*K=256K. This patch fixes issues related to that.
>>>>
>>>> Could you describe *what* issues you are fixing?
>>>>
>>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>>>> ---
>>>>>> drivers/lightnvm/core.c      | 9 +++++++--
>>>>>> drivers/nvme/host/lightnvm.c | 1 +
>>>>>> include/linux/lightnvm.h     | 1 +
>>>>>> 3 files changed, 9 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>>>>>> index 5f82036fe322..c01f83b8fbaf 100644
>>>>>> --- a/drivers/lightnvm/core.c
>>>>>> +++ b/drivers/lightnvm/core.c
>>>>>> @@ -325,6 +325,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>>>>>>      struct nvm_target *t;
>>>>>>      struct nvm_tgt_dev *tgt_dev;
>>>>>>      void *targetdata;
>>>>>> +     unsigned int mdts;
>>>>>>      int ret;
>>>>>>
>>>>>>      switch (create->conf.type) {
>>>>>> @@ -412,8 +413,12 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>>>>>>      tdisk->private_data = targetdata;
>>>>>>      tqueue->queuedata = targetdata;
>>>>>>
>>>>>> -     blk_queue_max_hw_sectors(tqueue,
>>>>>> -                     (dev->geo.csecs >> 9) * NVM_MAX_VLBA);
>>>>>> +     mdts = (dev->geo.csecs >> 9) * NVM_MAX_VLBA;
>>>>>> +     if (dev->geo.mdts) {
>>>>>> +             mdts = min_t(u32, dev->geo.mdts,
>>>>>> +                             (dev->geo.csecs >> 9) * NVM_MAX_VLBA);
>>>>>> +     }
>>>>>> +     blk_queue_max_hw_sectors(tqueue, mdts);
>>>>>>
>>>>>>      set_capacity(tdisk, tt->capacity(targetdata));
>>>>>>      add_disk(tdisk);
>>>>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>>>>>> index b759c25c89c8..b88a39a3cbd1 100644
>>>>>> --- a/drivers/nvme/host/lightnvm.c
>>>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>>>> @@ -991,6 +991,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
>>>>>>      geo->csecs = 1 << ns->lba_shift;
>>>>>>      geo->sos = ns->ms;
>>>>>>      geo->ext = ns->ext;
>>>>>> +     geo->mdts = ns->ctrl->max_hw_sectors;
>>>>>>
>>>>>>      dev->q = q;
>>>>>>      memcpy(dev->name, disk_name, DISK_NAME_LEN);
>>>>>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>>>>>> index 5d865a5d5cdc..d3b02708e5f0 100644
>>>>>> --- a/include/linux/lightnvm.h
>>>>>> +++ b/include/linux/lightnvm.h
>>>>>> @@ -358,6 +358,7 @@ struct nvm_geo {
>>>>>>      u16     csecs;          /* sector size */
>>>>>>      u16     sos;            /* out-of-band area size */
>>>>>>      bool    ext;            /* metadata in extended data buffer */
>>>>>> +     u32     mdts;           /* Max data transfer size*/
>>>>>>
>>>>>>      /* device write constrains */
>>>>>>      u32     ws_min;         /* minimum write size */
>>>>>> --
>>>>>> 2.17.1
>>>>>
>>>>> I see where you are going with this and I partially agree, but none of
>>>>> the OCSSD specs define a way to define this parameter. Thus, adding this
>>>>> behavior taken from NVMe in Linux can break current implementations. Is
>>>>> this a real life problem for you? Or this is just for NVMe “correctness”?
>>>>>
>>>>> Javier
>>>>
>>>> Hmm.Looking into the 2.0 spec what it says about vector reads:
>>>>
>>>> (figure 28):"The number of Logical Blocks (NLB): This field indicates
>>>> the number of logical blocks to be read. This is a 0’s based value.
>>>> Maximum of 64 LBAs is supported."
>>>>
>>>> You got the max limit covered, and the spec  does not say anything
>>>> about the minimum number of LBAs to support.
>>>>
>>>> Matias: any thoughts on this?
>>>>
>>>> Javier: How would this patch break current implementations?
>>>
>>> Say an OCSSD controller that sets mdts to a value under 64 or does not
>>> set it at all (maybe garbage). Think you can get to one pretty quickly...
>>
>> So we cant make use of a perfectly good, standardized, parameter
>> because some hypothetical non-compliant device out there might not
>> provide a sane value?
> 
> The OCSSD standard has never used NVMe parameters, so there is no
> compliant / non-compliant. In fact, until we changed OCSSD 2.0 to
> get the sector and OOB sizes from the standard identify
> command, we used to have them in the geometry.

What the hell? Yes it has. The whole OCSSD spec is dependent on the NVMe 
spec. It is using many commands from the NVMe specification, which is 
not defined in the OCSSD specification.

The MDTS field should be respected in all case, similarly to how the 
block layer respects it. Since the lightnvm subsystem are hooking in on 
the side, this also be honoured by pblk (or the lightnvm subsystem 
should fix it up)

> 
> If you did not catch it in the first reference, this concern is explicitly
> related to OCSSD controllers already out there - some of which you
> should be caring about.
> 
> If we are to use this information in the future, I would advocate to
> first make changes in the spec and then in the code, not the other way
> around.
> 
>>
>>>> Igor: how does this patch fix the mdts restriction? There are no
>>>> checks on i.e. the gc read path that ensures that a lower limit than
>>>> NVM_MAX_VLBA is enforced.
>>>
>>> This is the other part where the implementation breaks.
>>
>> No, it just does not fix it.
> 
> It is broken in _this_ implementation.
> 
>>
>> over-and-out,
>> Hans
>>> Javier

