Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB39C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 06:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE50320651
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 06:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfEAGnR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 02:43:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:53460 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfEAGnR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 May 2019 02:43:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3C802AF01;
        Wed,  1 May 2019 06:43:15 +0000 (UTC)
Subject: Re: [PATCH] bcache: remove redundant LIST_HEAD(journal) from
 run_cache_set()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        juha.aatrokoski@aalto.fi, shhuiw@foxmail.com
References: <20190430140225.21642-1-colyli@suse.de>
 <0ded62e9-6135-6da1-312d-1ceb6160c93b@suse.de>
 <54478019-5427-266e-42c2-0d606c6e5ec3@kernel.dk>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <b9036b88-9bd9-a96b-a7ed-96bd45708267@suse.de>
Date:   Wed, 1 May 2019 14:43:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <54478019-5427-266e-42c2-0d606c6e5ec3@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/4/30 10:20 下午, Jens Axboe wrote:
> On 4/30/19 8:05 AM, Coly Li wrote:
>> On 2019/4/30 10:02 下午, Coly Li wrote:
>>> Commit 95f18c9d1310 ("bcache: avoid potential memleak of list of
>>> journal_replay(s) in the CACHE_SYNC branch of run_cache_set") forgets
>>> to remove the original define of LIST_HEAD(journal), which makes
>>> the change no take effect. This patch removes redundant variable
>>> LIST_HEAD(journal) from run_cache_set(), to make Shenghui's fix
>>> working.
>>>
>>> Reported-by: Juha Aatrokoski <juha.aatrokoski@aalto.fi>
>>> Cc: Shenghui Wang <shhuiw@foxmail.com>
>>> Signed-off-by: Coly Li <colyli@suse.de>
>>> ---
>>>  drivers/md/bcache/super.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>>> index 0ffe9acee9d8..1b63ac876169 100644
>>> --- a/drivers/md/bcache/super.c
>>> +++ b/drivers/md/bcache/super.c
>>> @@ -1800,7 +1800,6 @@ static int run_cache_set(struct cache_set *c)
>>>  	set_gc_sectors(c);
>>>  
>>>  	if (CACHE_SYNC(&c->sb)) {
>>> -		LIST_HEAD(journal);
>>>  		struct bkey *k;
>>>  		struct jset *j;
>>>  
>>>
>>
>> Hi Jens,
>>
>> Please take this fix for the Linux v5.2 bcache series. It fixes a
>> problem from
>> [PATCH 18/18] bcache: avoid potential memleak of list of
>> journal_replay(s) in the CACHE_SYNC branch of run_cache_set
>> which is already in your for-next branch.
>>
>> Thanks to Juha for cache this bug, and thank you in advance for taking
>> care of this.
> 
> Applied, but please add Fixes: lines patches like that, it's not enough
> to simply mention it in the commit message.
> 

I just re-send a V2 patch with adding the Fixes: line, thanks for taking
care of this.

-- 

Coly Li
