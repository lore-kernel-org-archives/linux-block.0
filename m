Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924BDC43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 16:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD492070B
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 16:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfC2QMq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:12:46 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:45974 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfC2QMp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 12:12:45 -0400
Received: from tux.wizards.de (pD9EBF050.dip0.t-ipconnect.de [217.235.240.80])
        by mail02.iobjects.de (Postfix) with ESMTPSA id B475A4164E66;
        Fri, 29 Mar 2019 17:12:43 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 63FC1F01604;
        Fri, 29 Mar 2019 17:12:43 +0100 (CET)
Subject: Re: [PATCH] block/bfq: fix ifdef for CONFIG_BFQ_GROUP_IOSCHED=y
To:     Jens Axboe <axboe@kernel.dk>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
References: <155386807826.3190.16175453392005064129.stgit@buzz>
 <c40b8d4a-c504-fdf4-0b96-64aaeb167435@applied-asynchrony.com>
 <5234a971-2b6a-47b1-0071-8f3bd07d9fc3@kernel.dk>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <cf0dc6b2-6ecf-c895-6c21-8746700bdae4@applied-asynchrony.com>
Date:   Fri, 29 Mar 2019 17:12:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5234a971-2b6a-47b1-0071-8f3bd07d9fc3@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/19 4:58 PM, Jens Axboe wrote:
> On 3/29/19 9:56 AM, Holger Hoffstätte wrote:
>> On 3/29/19 3:01 PM, Konstantin Khlebnikov wrote:
>>> Replace BFQ_GROUP_IOSCHED_ENABLED with CONFIG_BFQ_GROUP_IOSCHED.
>>> Code under these ifdefs never worked, something might be broken.
>>>
>>> Fixes: 0471559c2fbd ("block, bfq: add/remove entity weights correctly")
>>> Fixes: 73d58118498b ("block, bfq: consider also ioprio classes in symmetry detection")
>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>> ---
>>>    block/bfq-iosched.c |    2 +-
>>>    block/bfq-wf2q.c    |    2 +-
>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>> index 4c592496a16a..fac188dd78fa 100644
>>> --- a/block/bfq-iosched.c
>>> +++ b/block/bfq-iosched.c
>>> @@ -674,7 +674,7 @@ static bool bfq_symmetric_scenario(struct bfq_data *bfqd)
>>>    	 * at least two nodes.
>>>    	 */
>>>    	return !(varied_queue_weights || multiple_classes_busy
>>> -#ifdef BFQ_GROUP_IOSCHED_ENABLED
>>> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>>    	       || bfqd->num_groups_with_pending_reqs > 0
>>>    #endif
>>>    		);
>>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>>> index 63311d1ff1ed..a11bef75483d 100644
>>> --- a/block/bfq-wf2q.c
>>> +++ b/block/bfq-wf2q.c
>>> @@ -1012,7 +1012,7 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
>>>    		entity->on_st = true;
>>>    	}
>>>    
>>> -#ifdef BFQ_GROUP_IOSCHED_ENABLED
>>> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>>    	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
>>>    		struct bfq_group *bfqg =
>>>    			container_of(entity, struct bfq_group, entity);
>>>
>>>
>>
>> Good catch! I run without group scheduling and therefore didn't notice these
>> stray defines earlier. For 5.1 it should merge cleanly; adding this on top of
>> the pending 5.2 BFQ patches required a small context fixup in hunk #1 due to
>> "block, bfq: do not idle for lowest-weight queues".
> 
> I'm hesitant to apply this, since the group scheduling stuff has obviously never
> been tested.

This is simply a regression in 5.1 caused by 73d58118498b - nothing else,
and as such this fix needs to go into 5.1 as well. I'm sure Paolo will agree.
What you so ominously  call "the group scheduling stuff" has been there and
shipping in mainline since day 1 of the BFQ merge, and it works fine in 5.0.

cheers
Holger
