Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84CFC10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D36E2077C
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfDWHKE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:10:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:60746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725937AbfDWHKD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:10:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DE197AC4F;
        Tue, 23 Apr 2019 07:10:01 +0000 (UTC)
Subject: Re: [RFC PATCH v2 06/16] bcache: add failure check to run_cache_set()
 for journal replay
To:     Hannes Reinecke <hare@suse.de>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-7-colyli@suse.de>
 <e9d7f597-05f5-be5b-1a08-9d80673ad13f@suse.de>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <32915024-c1a2-d0bb-c7b2-92fd52b96ab4@suse.de>
Date:   Tue, 23 Apr 2019 15:09:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e9d7f597-05f5-be5b-1a08-9d80673ad13f@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/4/23 3:02 下午, Hannes Reinecke wrote:
> On 4/19/19 6:04 PM, Coly Li wrote:
>> Currently run_cache_set() has no return value, if there is failure in
>> bch_journal_replay(), the caller of run_cache_set() has no idea about
>> such failure and just continue to execute following code after
>> run_cache_set().  The internal failure is triggered inside
>> bch_journal_replay() and being handled in async way. This behavior is
>> inefficient, while failure handling inside bch_journal_replay(), cache
>> register code is still running to start the cache set. Registering and
>> unregistering code running as same time may introduce some rare race
>> condition, and make the code to be more hard to be understood.
>>
>> This patch adds return value to run_cache_set(), and returns -EIO if
>> bch_journal_rreplay() fails. Then caller of run_cache_set() may detect
>> such failure and stop registering code flow immedidately inside
>> register_cache_set().
>>
>> If journal replay fails, run_cache_set() can report error immediately
>> to register_cache_set(). This patch makes the failure handling for
>> bch_journal_replay() be in synchronized way, easier to understand and
>> debug, and avoid poetential race condition for register-and-unregister
>> in same time.
>>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> ---
>>   drivers/md/bcache/super.c | 17 ++++++++++++-----
>>   1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>> index a697a3a923cd..036bffad0bfe 100644
>> --- a/drivers/md/bcache/super.c
>> +++ b/drivers/md/bcache/super.c
>> @@ -1775,7 +1775,7 @@ struct cache_set *bch_cache_set_alloc(struct
>> cache_sb *sb)
>>       return NULL;
>>   }
>>   -static void run_cache_set(struct cache_set *c)
>> +static int run_cache_set(struct cache_set *c)
>>   {
>>       const char *err = "cannot allocate memory";
>>       struct cached_dev *dc, *t;
>> @@ -1869,7 +1869,9 @@ static void run_cache_set(struct cache_set *c)
>>           if (j->version < BCACHE_JSET_VERSION_UUID)
>>               __uuid_write(c);
>>   -        bch_journal_replay(c, &journal);
>> +        err = "bcache: replay journal failed";
>> +        if (bch_journal_replay(c, &journal))
>> +            goto err;
>>       } else {
>>           pr_notice("invalidating existing data");
>>   @@ -1937,11 +1939,13 @@ static void run_cache_set(struct cache_set *c)
>>       flash_devs_run(c);
>>         set_bit(CACHE_SET_RUNNING, &c->flags);
>> -    return;
>> +    return 0;
>>   err:
>>       closure_sync(&cl);
>>       /* XXX: test this, it's broken */
>>       bch_cache_set_error(c, "%s", err);
>> +
>> +    return -EIO;
>>   }
>>   
> Shouldn't you differentiate between -EIO if the journal replay failed
> and -ENOMEM?

Hi Hannes,

Currently I just return an error code to caller to indicate something
wrong, a more specific error code should be more informative. Let me
think how to do it.

Thanks.

-- 

Coly Li
