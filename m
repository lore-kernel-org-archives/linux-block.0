Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38752 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbeHCOvr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Aug 2018 10:51:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id p6-v6so4876908ljc.5
        for <linux-block@vger.kernel.org>; Fri, 03 Aug 2018 05:55:33 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: remove unnecessary drive version check
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
To: javier@cnexlabs.com
Cc: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180802205841.22039-1-mb@lightnvm.io>
 <4382FFAE-0602-4A16-8120-E930141606ED@cnexlabs.com>
 <130c689a-723f-a32a-96e3-a7a59ff6b7b8@lightnvm.io>
Message-ID: <ef8cd1ac-623b-96ed-1a7f-3e390fcc51d5@lightnvm.io>
Date: Fri, 3 Aug 2018 14:55:30 +0200
MIME-Version: 1.0
In-Reply-To: <130c689a-723f-a32a-96e3-a7a59ff6b7b8@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/03/2018 02:39 PM, Matias Bjørling wrote:
> On 08/03/2018 02:18 PM, Javier Gonzalez wrote:
>>> On 2 Aug 2018, at 22.58, Matias Bjørling <mb@lightnvm.io> wrote:
>>>
>>> The nvme driver checks for 1.2 and 2.0 compatibility. If an unsupported
>>> version is reported, the device will not be initialized.
>>>
>>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>>> ---
>>> drivers/lightnvm/pblk-init.c | 8 --------
>>> 1 file changed, 8 deletions(-)
>>>
>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>>> index 537e98f2b24a..e9e2fedff387 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -1202,14 +1202,6 @@ static void *pblk_init(struct nvm_tgt_dev 
>>> *dev, struct gendisk *tdisk,
>>>     pblk->state = PBLK_STATE_RUNNING;
>>>     pblk->gc.gc_enabled = 0;
>>>
>>> -    if (!(geo->version == NVM_OCSSD_SPEC_12 ||
>>> -                    geo->version == NVM_OCSSD_SPEC_20)) {
>>> -        pblk_err(pblk, "OCSSD version not supported (%u)\n",
>>> -                            geo->version);
>>> -        kfree(pblk);
>>> -        return ERR_PTR(-EINVAL);
>>> -    }
>>> -
>>>     if (geo->version == NVM_OCSSD_SPEC_12 && geo->dom & NVM_RSP_L2P) {
>>>         pblk_err(pblk, "host-side L2P table not supported. (%x)\n",
>>>                             geo->dom);
>>> -- 
>>> 2.11.0
>>
>> The same comment goes for this patch. pblk does support 2.0 and 1.2
>> today, but it is not guaranteed it will support a new revision straight
>> away. So I think that a check wither here or through the .capabilities I
>> proposed on the other patch is necessary.
>>
> 
> Works for me. I'll send another patch that enables pblk target to tell 
> which version it supports.

On second thought. The idea is that pblk will not have to think about 
1.2/2.0. The core will expose a general address format, etc., such that 
pblk doesn't have to be complicated by that.

I am working on the various pieces and moving them to core. The patch 
may have gone out a bit early. I will send this again when the 1.2/2.0 
conversions have been applied.
