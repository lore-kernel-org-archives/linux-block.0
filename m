Return-Path: <SRS0=e+pS=DI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D150C4727C
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 10:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C342176B
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 10:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbgJAKGI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Oct 2020 06:06:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:35072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731131AbgJAKGI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Oct 2020 06:06:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00D0AAC55;
        Thu,  1 Oct 2020 10:06:06 +0000 (UTC)
To:     Vicente Bergas <vicencb@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
References: <20201001071824.24995-1-colyli@suse.de>
 <CAAMcf8Ao8Go7GdB2XFXAHsWrcxb0VqtDRpHReOGTsjegq2XP0Q@mail.gmail.com>
 <ebd42dfe-d39c-5c13-bbd9-1c6463d73ff0@intel.com>
 <CAAMcf8AXUx8UwJvGyBaSvuMaN8u0i1CTbz=WvC+snvLBe=mtLQ@mail.gmail.com>
From:   Coly Li <colyli@suse.de>
Autocrypt: addr=colyli@suse.de; keydata=
 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
Subject: Re: [PATCH v3] mmc: core: don't set limits.discard_granularity as 0
Message-ID: <86352b66-204e-0979-d060-70e953256e6b@suse.de>
Date:   Thu, 1 Oct 2020 18:06:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAAMcf8AXUx8UwJvGyBaSvuMaN8u0i1CTbz=WvC+snvLBe=mtLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/10/1 17:27, Vicente Bergas wrote:
> On Thu, Oct 1, 2020 at 11:07 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 1/10/20 11:38 am, Vicente Bergas wrote:
>>> On Thu, Oct 1, 2020 at 9:18 AM Coly Li <colyli@suse.de> wrote:
>>>>
>>>> In mmc_queue_setup_discard() the mmc driver queue's discard_granularity
>>>> might be set as 0 (when card->pref_erase > max_discard) while the mmc
>>>> device still declares to support discard operation. This is buggy and
>>>> triggered the following kernel warning message,
>>>>
>>>> WARNING: CPU: 0 PID: 135 at __blkdev_issue_discard+0x200/0x294
>>>> CPU: 0 PID: 135 Comm: f2fs_discard-17 Not tainted 5.9.0-rc6 #1
>>>> Hardware name: Google Kevin (DT)
>>>> pstate: 00000005 (nzcv daif -PAN -UAO BTYPE=--)
>>>> pc : __blkdev_issue_discard+0x200/0x294
>>>> lr : __blkdev_issue_discard+0x54/0x294
>>>> sp : ffff800011dd3b10
>>>> x29: ffff800011dd3b10 x28: 0000000000000000 x27: ffff800011dd3cc4 x26: ffff800011dd3e18 x25: 000000000004e69b x24: 0000000000000c40 x23: ffff0000f1deaaf0 x22: ffff0000f2849200 x21: 00000000002734d8 x20: 0000000000000008 x19: 0000000000000000 x18: 0000000000000000 x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000 x14: 0000000000000394 x13: 0000000000000000 x12: 0000000000000000 x11: 0000000000000000 x10: 00000000000008b0 x9 : ffff800011dd3cb0 x8 : 000000000004e69b x7 : 0000000000000000 x6 : ffff0000f1926400 x5 : ffff0000f1940800 x4 : 0000000000000000 x3 : 0000000000000c40 x2 : 0000000000000008 x1 : 00000000002734d8 x0 : 0000000000000000 Call trace:
>>>> __blkdev_issue_discard+0x200/0x294
>>>> __submit_discard_cmd+0x128/0x374
>>>> __issue_discard_cmd_orderly+0x188/0x244
>>>> __issue_discard_cmd+0x2e8/0x33c
>>>> issue_discard_thread+0xe8/0x2f0
>>>> kthread+0x11c/0x120
>>>> ret_from_fork+0x10/0x1c
>>>> ---[ end trace e4c8023d33dfe77a ]---
>>>>
>>>> This patch fixes the issue by setting discard_granularity as SECTOR_SIZE
>>>> instead of 0 when (card->pref_erase > max_discard) is true. Now no more
>>>> complain from __blkdev_issue_discard() for the improper value of discard
>>>> granularity.
>>>>
>>>> This issue is exposed after commit b35fd7422c2f ("block: check queue's
>>>> limits.discard_granularity in __blkdev_issue_discard()"), a "Fixes:" tag
>>>> is also added for the commit to make sure people won't miss this patch
>>>> after applying the change of __blkdev_issue_discard().
>>>>
>>>> Fixes: e056a1b5b67b ("mmc: queue: let host controllers specify maximum discard timeout")
>>>> Fixes: b35fd7422c2f ("block: check queue's limits.discard_granularity in __blkdev_issue_discard()").
>>>> Reported-by: Vicente Bergas <vicencb@gmail.com>
>>>
>>> Hi Coly, Adrian,
>>> would you like me to reply with a tested-by?
>>> before testing it: what are the chances of losing data?
>>
>> Very low I would hope, but that is no reason not to have backups :-)
> 
> I do have backup, it is for the hassle of reinstalling the OS and
> restoring the backup.
> I'll test it later, maybe today.
> 
>>> Regards,
>>>   Vicente.
>>>
>>>> Signed-off-by: Coly Li <colyli@suse.de>
>>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>>> ---
>>>> Changelog,
>>>> v3, add Fixes tag for both commits.
>>>> v2, change commit id of the Fixes tag.
>>>> v1, initial version.
>>>>
>>>>  drivers/mmc/core/queue.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
>>>> index 6c022ef0f84d..350d0cc4ee62 100644
>>>> --- a/drivers/mmc/core/queue.c
>>>> +++ b/drivers/mmc/core/queue.c
>>>> @@ -190,7 +190,7 @@ static void mmc_queue_setup_discard(struct request_queue *q,
>>>>         q->limits.discard_granularity = card->pref_erase << 9;
>>>>         /* granularity must not be greater than max. discard */
> 
> Just out of curiosity, wouldn't it be more performant something like:
> q->limits.discard_granularity = minimum(card->pref_erase, max_discard) << 9;
> or is just that SECTOR_SIZE is a number guaranteed to work?
> 

The discard_granularity is a hint for the minimal acceptable length of
the discard request. The discard request might be accepted by device
when the discard request covers a discard_granularity range. The
discard_granularity rage is the minimum available discard request
length, it is a LBA range which starts on discard_granularity aligned
LBA, and length is discard_granularity.

Therefore setting discard_granularity to SECTOR_SIZE won't hurt discard
performance, the discard bio split does not depend on it. It is a hint
for a minimal acceptable length of discard request.

Coly Li




