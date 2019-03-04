Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9459DC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F31A20830
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfCDMji (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:39:38 -0500
Received: from mga03.intel.com ([134.134.136.65]:31826 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbfCDMji (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Mar 2019 07:39:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 04:39:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,440,1544515200"; 
   d="scan'208";a="119451792"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.140.180]) ([10.237.140.180])
  by orsmga007.jf.intel.com with ESMTP; 04 Mar 2019 04:39:36 -0800
Subject: Re: [PATCH 04/13] lightnvm: pblk: Rollback in gc read
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     Matias Bjorling <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-5-igor.j.konopko@intel.com>
 <2DABC388-6D60-4253-9DD0-5FD2FDEED619@javigon.com>
 <CANr-nt2U760+wpF_KvY2vSAqt9eSnynUsisoTAADjhj12BYJEg@mail.gmail.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <e7517ee3-8310-f513-e0f8-6d2c5b19e868@intel.com>
Date:   Mon, 4 Mar 2019 13:39:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANr-nt2U760+wpF_KvY2vSAqt9eSnynUsisoTAADjhj12BYJEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 04.03.2019 09:44, Hans Holmberg wrote:
> Did you ever see this in the wild?
> The only time pblk_gc_line returns an error is if
> kmalloc(sizeof(struct pblk_line_ws), GFP_KERNEL); fails, and then
> we're in real trouble :)

I never saw this in real life, but still probably good to have a 
"proper" handling - since we already have "some" handling.

> 
> Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> On Mon, Mar 4, 2019 at 8:38 AM Javier González <javier@javigon.com> wrote:
>>
>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>>
>>> Currently in case of error returned by pblk_gc_line
>>> to pblk_gc_read we leave current line unassigned
>>> from all the lists. This patch fixes that issue.
>>>
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> ---
>>> drivers/lightnvm/pblk-gc.c | 7 ++++++-
>>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
>>> index 511ed0d5333c..533da6ea3e15 100644
>>> --- a/drivers/lightnvm/pblk-gc.c
>>> +++ b/drivers/lightnvm/pblk-gc.c
>>> @@ -361,8 +361,13 @@ static int pblk_gc_read(struct pblk *pblk)
>>>
>>>        pblk_gc_kick(pblk);
>>>
>>> -     if (pblk_gc_line(pblk, line))
>>> +     if (pblk_gc_line(pblk, line)) {
>>>                pblk_err(pblk, "failed to GC line %d\n", line->id);
>>> +             /* rollback */
>>> +             spin_lock(&gc->r_lock);
>>> +             list_add_tail(&line->list, &gc->r_list);
>>> +             spin_unlock(&gc->r_lock);
>>> +     }
>>>
>>>        return 0;
>>> }
>>> --
>>> 2.17.1
>>
>> Looks good to me.
>>
>> Reviewed-by: Javier González <javier@javigon.com>
