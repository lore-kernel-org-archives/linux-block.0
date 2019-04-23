Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D5DC10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C3E206BA
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfDWHHv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:07:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:60452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfDWHHu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:07:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9250AC4F;
        Tue, 23 Apr 2019 07:07:48 +0000 (UTC)
Subject: Re: [RFC PATCH v2 04/16] bcache: fix journal deadlock during jouranl
 replay
To:     Hannes Reinecke <hare@suse.de>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-5-colyli@suse.de>
 <bde96118-9d47-2d5e-bc59-a04260b700f5@suse.de>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <40022d4f-9277-ec79-9cda-2773c57dcceb@suse.de>
Date:   Tue, 23 Apr 2019 15:07:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bde96118-9d47-2d5e-bc59-a04260b700f5@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/4/23 2:59 下午, Hannes Reinecke wrote:
> On 4/19/19 6:04 PM, Coly Li wrote:
>> A deadlock of bcache jouranling may happen during journal replay. Such
>> deadlock happens when,
>> - Journal space is totally full (no any free blocks) and system crashes
>>    or reboots.
>> - After reboot, the first journal entry handled by jouranl replay causes
>>    btree split and jouranl_meta() is called to write an empty jset to
>>    journal space.
>> - There is no journal space to write and journal_reclaim() fails to get
>>    any available bucket because this is the first replayed journal entry
>>    to be blocked.
>> Then the whole cache set is blocked from running.
>>
>> This patch is an effort to fix such journal replay deadlock in a simpler
>> way,
>> - Add a bool varialbe 'in_replay' in struct journal, set it to true when
>>    journal replay starts, and set it to false when journal replay
>>    completed. in_replay is initialized to be false.
>> - Reserve 6 sectors in journal bucket, do not use them in normal bcache
>>    runtime. These sectors are only permitted to use during journal
>>    replay (when c->jouranl.in_replay is true)
>>
>> Then in normal bcache runtime, journal space won't be totally full and
>> there are 6 sectors are always reserved for journal replay time. After
>> system reboots, if bch_btree_insert() in bch_journal_replay() causes
>> btree split and bch_journal_beta() gets called to require 1 sector
>> from journal buckets to write an empty jset, there are enough reserved
>> space to serve.
>>
>> The reason to reserve 6 sectors is, we should choose a number that won't
>> fix into a bucket size. If the reserved space happens to be a whole
>> bucket, more logic has to be added in journal_replay() to handle
>> journal.blocks_free with reserved spaces in journal replay time. This is
>> why 6 sectors is choosed, it is 3KB and won't be any proper block size
>> or bucket size.
>>
>> The bcache btree node size is quite large, so btree node split won't be
>> a frequent event. And when btree node split happens, new added key will
>> be insert directly into uppper level or neighbor nodes and won't go into
>> journal again, only bch_journal_meta() is called to write jset metadata
>> which occupies 1 block in journal space. If blocksize is set to 4K size,
>> reserve 6 sectors indeed is 2 blocks, so there can be two continuously
>> btree splitting happen during journal replay, this is very very rare in
>> practice. As default blocksize is set to sector size, that equals to
>> 6 blocks reserved. Contiously splitting the btree for 6 times in journal
>> replay is almost impossible, so the reserved space seems to be enough
>> in my humble opinion.
>>
>> If in future the reserved space turns out to be not enough, let's extend
>> it then.
>>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> ---
>>   drivers/md/bcache/journal.c | 100
>> ++++++++++++++++++++++++++++++++++++++++----
>>   drivers/md/bcache/journal.h |   4 ++
>>   2 files changed, 97 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
>> index a6deb16c15c8..c60a702f53a9 100644
>> --- a/drivers/md/bcache/journal.c
>> +++ b/drivers/md/bcache/journal.c
>> @@ -415,6 +415,8 @@ int bch_journal_replay(struct cache_set *s, struct
>> list_head *list)
>>       uint64_t start = i->j.last_seq, end = i->j.seq, n = start;
>>       struct keylist keylist;
>>   +    s->journal.in_replay = true;
>> +
>>       list_for_each_entry(i, list, list) {
>>           BUG_ON(i->pin && atomic_read(i->pin) != 1);
>>   @@ -448,6 +450,7 @@ int bch_journal_replay(struct cache_set *s,
>> struct list_head *list)
>>       pr_info("journal replay done, %i keys in %i entries, seq %llu",
>>           keys, entries, end);
>>   err:
>> +    s->journal.in_replay = false;
>>       while (!list_empty(list)) {
>>           i = list_first_entry(list, struct journal_replay, list);
>>           list_del(&i->list);
> 
> What about locking here?
> Doesn't 'in_replay' need to be guarded by a spinlock or something?

Hi Hannes,

s->journal.in_replay is only set in start up time, where the code is
sequentially executed, so it is sure on concurrent access to
s->journal.in_replay. After the cache runs, s->journal.in_replay is
always false, there is no concurrent access neither.

It is only used to tell the journal code that now it is in journal reply
and the journal-replay-reserved slots can be used. The set and check
sequence is in explicit linear order.

I will add code comments for s->journal.in_replay to make it more clear.

Thanks.

-- 

Coly Li
