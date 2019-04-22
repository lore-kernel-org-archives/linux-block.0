Return-Path: <SRS0=Rcoh=SY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72639C10F11
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 15:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C18020656
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 15:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfDVPLi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:11:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:41408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726132AbfDVPLi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Apr 2019 11:11:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F435AD7B;
        Mon, 22 Apr 2019 15:11:36 +0000 (UTC)
Subject: Re: [RFC PATCH v2 01/16] bcache: move definition of 'int ret' out of
 macro read_bucket()
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-2-colyli@suse.de>
 <SN6PR04MB45273AEF543F22F2443B83B486210@SN6PR04MB4527.namprd04.prod.outlook.com>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <a39ed6a2-1c9c-8a1a-41f4-60ab3e62074c@suse.de>
Date:   Mon, 22 Apr 2019 23:11:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <SN6PR04MB45273AEF543F22F2443B83B486210@SN6PR04MB4527.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/4/22 1:47 上午, Chaitanya Kulkarni wrote:
> May be we should make this as an inline function instead of macro ?
> Reason being:-
> 1. It is not a simple substitution.
> 2. It has multiple function calls.
> 3. With this patch it is now dependent on local variable declared
>     outside of macro.
> 
> Any thoughts ?
> 

Hi Chaitanya,

I agree with you. There are some symbol names shared with "caller" of
read_bucket(), so it is not very simple change to change the macro into
an inline function. At this moment I will keep the change as simple as
possible, and later I will think of change this macro into an inline
routine.

Thanks.

Coly Li


> 
> On 04/19/2019 11:24 AM, Coly Li wrote:
>> 'int ret' is defined as a local variable inside macro read_bucket().
>> Since this macro is called multiple times, and following patches will
>> use a 'int ret' variable in bch_journal_read(), this patch moves
>> definition of 'int ret' from macro read_bucket() to range of function
>> bch_journal_read().
>>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> ---
>>   drivers/md/bcache/journal.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
>> index b2fd412715b1..6e18057d1d82 100644
>> --- a/drivers/md/bcache/journal.c
>> +++ b/drivers/md/bcache/journal.c
>> @@ -147,7 +147,7 @@ int bch_journal_read(struct cache_set *c, struct list_head *list)
>>   {
>>   #define read_bucket(b)							\
>>   	({								\
>> -		int ret = journal_read_bucket(ca, list, b);		\
>> +		ret = journal_read_bucket(ca, list, b);			\
>>   		__set_bit(b, bitmap);					\
>>   		if (ret < 0)						\
>>   			return ret;					\
>> @@ -156,6 +156,7 @@ int bch_journal_read(struct cache_set *c, struct list_head *list)
>>
>>   	struct cache *ca;
>>   	unsigned int iter;
>> +	int ret = 0;
>>
>>   	for_each_cache(ca, c, iter) {
>>   		struct journal_device *ja = &ca->journal;
>> @@ -267,7 +268,7 @@ int bch_journal_read(struct cache_set *c, struct list_head *list)
>>   					    struct journal_replay,
>>   					    list)->j.seq;
>>
>> -	return 0;
>> +	return ret;
>>   #undef read_bucket
>>   }
>>
>>
> 


-- 

Coly Li
