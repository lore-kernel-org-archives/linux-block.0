Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B922C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D0D20815
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfCDMqS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:46:18 -0500
Received: from mga03.intel.com ([134.134.136.65]:32219 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbfCDMqS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Mar 2019 07:46:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 04:46:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,440,1544515200"; 
   d="scan'208";a="119452688"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.140.180]) ([10.237.140.180])
  by orsmga007.jf.intel.com with ESMTP; 04 Mar 2019 04:46:16 -0800
Subject: Re: [PATCH 07/13] lightnvm: pblk: Cleanly fail when there is not
 enough memory
To:     Hans Holmberg <hans@owltronix.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     Matias Bjorling <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-8-igor.j.konopko@intel.com>
 <02F6919F-62BE-4501-BD6E-406E32DB9ABB@javigon.com>
 <CANr-nt2Enyog9dyZHDJs0Jsge-0g1oQ5gpkYiZ=rw+QytNW68Q@mail.gmail.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <9c8199b7-921d-76d4-3419-d025a5e42cf4@intel.com>
Date:   Mon, 4 Mar 2019 13:46:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANr-nt2Enyog9dyZHDJs0Jsge-0g1oQ5gpkYiZ=rw+QytNW68Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 04.03.2019 10:24, Hans Holmberg wrote:
> Hi Igor,
> 
> I think you need to motivate (and document) why each of the new flags
> are needed.

Sure, will add such a description to v2 of the patch.
> 
> Thanks,
> Hans
> 
> On Mon, Mar 4, 2019 at 8:53 AM Javier González <javier@javigon.com> wrote:
>>
>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>>
>>> L2P table can be huge in many cases, since
>>> it typically requires 1GB of DRAM for 1TB
>>> of drive. When there is not enough memory
>>> available, OOM killer turns on and kills
>>> random processes, which can be very annoying
>>> for users. This patch changes the flag for
>>> L2P table allocation on order to handle this
>>> situation in more user friendly way
>>>
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> ---
>>> drivers/lightnvm/pblk-init.c | 9 +++++++--
>>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>>> index 8b643d0bffae..e553105b7ba1 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -164,9 +164,14 @@ static int pblk_l2p_init(struct pblk *pblk, bool factory_init)
>>>        int ret = 0;
>>>
>>>        map_size = pblk_trans_map_size(pblk);
>>> -     pblk->trans_map = vmalloc(map_size);
>>> -     if (!pblk->trans_map)
>>> +     pblk->trans_map = __vmalloc(map_size, GFP_KERNEL | __GFP_NOWARN
>>> +                                     | __GFP_RETRY_MAYFAIL | __GFP_HIGHMEM,
>>> +                                     PAGE_KERNEL);
>>> +     if (!pblk->trans_map) {
>>> +             pblk_err(pblk, "failed to allocate L2P (need %ld of memory)\n",
>>> +                             map_size);
>>>                return -ENOMEM;
>>> +     }
>>>
>>>        pblk_ppa_set_empty(&ppa);
>>>
>>> --
>>> 2.17.1
>>
>> Is there any extra consideration we should take when enabling high
>> memory for the L2P table? If not, looks good to me.
>>
>> Reviewed-by: Javier González <javier@javigon.com>
