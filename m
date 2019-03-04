Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADAAC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89842075B
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfCDNEz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:04:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:10759 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfCDNEz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Mar 2019 08:04:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 05:04:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,440,1544515200"; 
   d="scan'208";a="119456546"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.140.180]) ([10.237.140.180])
  by orsmga007.jf.intel.com with ESMTP; 04 Mar 2019 05:04:52 -0800
Subject: Re: [PATCH 13/13] lightnvm: Inherit mdts from the parent nvme device
To:     Hans Holmberg <hans@owltronix.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
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
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <3d053281-ef87-66e3-3433-de4c18884326@intel.com>
Date:   Mon, 4 Mar 2019 14:04:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANr-nt1zQWf8XkQaesyFO+wTLULdEAvATvYjYFiDXbc_vifKGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 04.03.2019 13:22, Hans Holmberg wrote:
> On Mon, Mar 4, 2019 at 12:44 PM Javier González <javier@javigon.com> wrote:
>>
>>
>>
>>> On 4 Mar 2019, at 12.30, Hans Holmberg <hans@owltronix.com> wrote:
>>>
>>> On Mon, Mar 4, 2019 at 10:05 AM Javier González <javier@javigon.com> wrote:
>>>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>>>>
>>>>> Current lightnvm and pblk implementation does not care
>>>>> about NVMe max data transfer size, which can be smaller
>>>>> than 64*K=256K. This patch fixes issues related to that.
>>>
>>> Could you describe *what* issues you are fixing?

I'm fixing the issue related to controllers which NVMe max data transfer 
size is lower that 256K (for example 128K, which happens for existing 
NVMe controllers and NVMe spec compliant). Such a controllers are not 
able to handle command which contains 64 PPAs, since the the size of 
DMAed buffer will be above the capabilities of such a controller.

>>>
>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>>> ---
>>>>> drivers/lightnvm/core.c      | 9 +++++++--
>>>>> drivers/nvme/host/lightnvm.c | 1 +
>>>>> include/linux/lightnvm.h     | 1 +
>>>>> 3 files changed, 9 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>>>>> index 5f82036fe322..c01f83b8fbaf 100644
>>>>> --- a/drivers/lightnvm/core.c
>>>>> +++ b/drivers/lightnvm/core.c
>>>>> @@ -325,6 +325,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>>>>>       struct nvm_target *t;
>>>>>       struct nvm_tgt_dev *tgt_dev;
>>>>>       void *targetdata;
>>>>> +     unsigned int mdts;
>>>>>       int ret;
>>>>>
>>>>>       switch (create->conf.type) {
>>>>> @@ -412,8 +413,12 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>>>>>       tdisk->private_data = targetdata;
>>>>>       tqueue->queuedata = targetdata;
>>>>>
>>>>> -     blk_queue_max_hw_sectors(tqueue,
>>>>> -                     (dev->geo.csecs >> 9) * NVM_MAX_VLBA);
>>>>> +     mdts = (dev->geo.csecs >> 9) * NVM_MAX_VLBA;
>>>>> +     if (dev->geo.mdts) {
>>>>> +             mdts = min_t(u32, dev->geo.mdts,
>>>>> +                             (dev->geo.csecs >> 9) * NVM_MAX_VLBA);
>>>>> +     }
>>>>> +     blk_queue_max_hw_sectors(tqueue, mdts);
>>>>>
>>>>>       set_capacity(tdisk, tt->capacity(targetdata));
>>>>>       add_disk(tdisk);
>>>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>>>>> index b759c25c89c8..b88a39a3cbd1 100644
>>>>> --- a/drivers/nvme/host/lightnvm.c
>>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>>> @@ -991,6 +991,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
>>>>>       geo->csecs = 1 << ns->lba_shift;
>>>>>       geo->sos = ns->ms;
>>>>>       geo->ext = ns->ext;
>>>>> +     geo->mdts = ns->ctrl->max_hw_sectors;
>>>>>
>>>>>       dev->q = q;
>>>>>       memcpy(dev->name, disk_name, DISK_NAME_LEN);
>>>>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>>>>> index 5d865a5d5cdc..d3b02708e5f0 100644
>>>>> --- a/include/linux/lightnvm.h
>>>>> +++ b/include/linux/lightnvm.h
>>>>> @@ -358,6 +358,7 @@ struct nvm_geo {
>>>>>       u16     csecs;          /* sector size */
>>>>>       u16     sos;            /* out-of-band area size */
>>>>>       bool    ext;            /* metadata in extended data buffer */
>>>>> +     u32     mdts;           /* Max data transfer size*/
>>>>>
>>>>>       /* device write constrains */
>>>>>       u32     ws_min;         /* minimum write size */
>>>>> --
>>>>> 2.17.1
>>>>
>>>> I see where you are going with this and I partially agree, but none of
>>>> the OCSSD specs define a way to define this parameter. Thus, adding this
>>>> behavior taken from NVMe in Linux can break current implementations. Is
>>>> this a real life problem for you? Or this is just for NVMe “correctness”?
>>>>
>>>> Javier
>>>
>>> Hmm.Looking into the 2.0 spec what it says about vector reads:
>>>
>>> (figure 28):"The number of Logical Blocks (NLB): This field indicates
>>> the number of logical blocks to be read. This is a 0’s based value.
>>> Maximum of 64 LBAs is supported."
>>>
>>> You got the max limit covered, and the spec  does not say anything
>>> about the minimum number of LBAs to support.
>>>
>>> Matias: any thoughts on this?
>>>
>>> Javier: How would this patch break current implementations?
>>
>> Say an OCSSD controller that sets mdts to a value under 64 or does not
>> set it at all (maybe garbage). Think you can get to one pretty quickly...
> 
> So we cant make use of a perfectly good, standardized, parameter
> because some hypothetical non-compliant device out there might not
> provide a sane value?
> 
>>
>>>
>>> Igor: how does this patch fix the mdts restriction? There are no
>>> checks on i.e. the gc read path that ensures that a lower limit than
>>> NVM_MAX_VLBA is enforced.
>>
>> This is the other part where the implementation breaks.
> 
> No, it just does not fix it.
> 
> over-and-out,
> Hans

IO requests issued from both garbage collector and writer thread are 
upper limiter by pblk->max_write_pgs variable. This variable is 
calculated based on queue_max_hw_sectors() already in pblk.

User reads on the other hand are splitted by block layer based on 
queue_max_hw_sectors() too.

Is there any other path which I'm missing, which will still tries to 
issue IOs with higher IO size? Or am I missing sth else in my logic?

>>
>> Javier
