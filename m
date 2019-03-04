Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB49C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7910520835
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfCDMw5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:52:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:8136 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfCDMw4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Mar 2019 07:52:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 04:52:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,440,1544515200"; 
   d="scan'208";a="119453655"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.140.180]) ([10.237.140.180])
  by orsmga007.jf.intel.com with ESMTP; 04 Mar 2019 04:52:54 -0800
Subject: Re: [PATCH 09/13] lightnvm: pblk: Kick writer for flush requests
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     Matias Bjorling <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-10-igor.j.konopko@intel.com>
 <453C3B14-BF3A-4463-9137-326C458AB851@javigon.com>
 <CANr-nt0QgTH1mJmwz+gseXKv+qidkrscXPmhZyUounOw-eRyHA@mail.gmail.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <40ab2046-878e-e3a7-2e9d-b43761aa538b@intel.com>
Date:   Mon, 4 Mar 2019 13:52:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANr-nt0QgTH1mJmwz+gseXKv+qidkrscXPmhZyUounOw-eRyHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 04.03.2019 10:39, Hans Holmberg wrote:
> On Mon, Mar 4, 2019 at 9:08 AM Javier González <javier@javigon.com> wrote:
>>
>>
>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>>
>>> In case when there is no enough sector available in rwb
>>> and there is flush request send we should kick write thread
>>> which is not a case in current implementation. This patch
>>> fixes that issue.
>>>
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> ---
>>> drivers/lightnvm/pblk-core.c | 3 ++-
>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>>> index 78b1eea4ab67..f48f2e77f770 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -375,8 +375,9 @@ void pblk_write_timer_fn(struct timer_list *t)
>>> void pblk_write_should_kick(struct pblk *pblk)
>>> {
>>>        unsigned int secs_avail = pblk_rb_read_count(&pblk->rwb);
>>> +     unsigned int secs_to_flush = pblk_rb_flush_point_count(&pblk->rwb);
>>>
>>> -     if (secs_avail >= pblk->min_write_pgs_data)
>>> +     if (secs_avail >= pblk->min_write_pgs_data || secs_to_flush)
>>>                pblk_write_kick(pblk);
>>> }
>>>
>>> --
>>> 2.17.1
>>
>> We already kick the write thread in case of REQ_PREFLUSH in
>> pblk_write_cache(), so no need to kick again.
> 
> Yeah, I thought i fixed this issue in:
> 
> cc9c9a00b10e ("lightnvm: pblk: kick writer on new flush points")
> 
> That commit brought down the test time of some of the xfs sync tests
> with a factor of 20 or so.
> 
> Igor: Have you seen any case of delayed syncs?

I didn't noticed that in the code. My mistake. So definitely my commit 
does not make a sense and we can just forget about that one.

> 
>>
>> Javier
