Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F25C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 12:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6097120857
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 12:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfCRMup (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:50:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:55866 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfCRMup (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 08:50:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 05:50:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,493,1544515200"; 
   d="scan'208";a="126378073"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.142.164]) ([10.237.142.164])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2019 05:50:44 -0700
Subject: Re: [PATCH 04/18] lightnvm: pblk: OOB recovery for closed chunks fix
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-5-igor.j.konopko@intel.com>
 <F7A12A66-ADBD-4B24-9FD0-B02031E2FACB@javigon.com>
 <5d997ae1-ec1f-6a78-6a93-f15fab542859@lightnvm.io>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <88dc0cd0-d863-3129-3cae-5d6e133820cf@intel.com>
Date:   Mon, 18 Mar 2019 13:50:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <5d997ae1-ec1f-6a78-6a93-f15fab542859@lightnvm.io>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 17.03.2019 20:24, Matias Bjørling wrote:
> On 3/16/19 3:43 PM, Javier González wrote:
>>> On 14 Mar 2019, at 09.04, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>>
>>> In case of OOB recovery, when some of the chunks are in closed state,
>>> we are calculating number of written sectors in line incorrectly,
>>> because we are always counting chunk WP, which for closed chunks
>>> does not longer reflects written sectors in particular chunks. This
>>> patch for such a chunks takes clba field instead.
>>>
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> ---
>>> drivers/lightnvm/pblk-recovery.c | 8 +++++++-
>>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/lightnvm/pblk-recovery.c 
>>> b/drivers/lightnvm/pblk-recovery.c
>>> index 83b467b..bcd3633 100644
>>> --- a/drivers/lightnvm/pblk-recovery.c
>>> +++ b/drivers/lightnvm/pblk-recovery.c
>>> @@ -101,6 +101,8 @@ static void pblk_update_line_wp(struct pblk 
>>> *pblk, struct pblk_line *line,
>>>
>>> static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line 
>>> *line)
>>> {
>>> +    struct nvm_tgt_dev *dev = pblk->dev;
>>> +    struct nvm_geo *geo = &dev->geo;
>>>     struct pblk_line_meta *lm = &pblk->lm;
>>>     int nr_bb = bitmap_weight(line->blk_bitmap, lm->blk_per_line);
>>>     u64 written_secs = 0;
>>> @@ -113,7 +115,11 @@ static u64 pblk_sec_in_open_line(struct pblk 
>>> *pblk, struct pblk_line *line)
>>>         if (chunk->state & NVM_CHK_ST_OFFLINE)
>>>             continue;
>>>
>>> -        written_secs += chunk->wp;
>>> +        if (chunk->state & NVM_CHK_ST_OPEN)
>>> +            written_secs += chunk->wp;
>>> +        else if (chunk->state & NVM_CHK_ST_CLOSED)
>>> +            written_secs += geo->clba;
>>> +
>>>         valid_chunks++;
>>>     }
>>>
>>> -- 
>>> 2.9.5
>>
>> Mmmm. The change is correct, but can you develop on why the WP does not
>> reflect the written sectors in a closed chunk? As I understand it, the
>> WP reflects the last written sector; if it happens to be WP == clba, then
>> the chunk state machine transitions to closed, but the WP remains
>> untouched. It is only when we reset the chunk that the WP comes back to
>> 0. Am I missing something?
>>
> 
> I agree with Javier. In OCSSD, the write pointer shall always be valid.

So based on OCSSD 2.0 spec "If WP = SLBA + NLB, the chunk is closed" 
(also on "Figure 5: Chunk State Diagram in spec": WP = SLBA + NLB for 
closed chunk), my understanding it that the WP is not valid for that 
particular use case, since in written_secs we want to obtain NLB field 
(relative within chunk, without starting LBA value). So that's why I 
used fixed CLBA here, since it WP pointer for closed chunk is absolute 
value instead of relative one.
Did I misunderstood sth in the spec?
