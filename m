Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45236C64E8A
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 06:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB8C622203
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 06:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgLBG3k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 01:29:40 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:41816 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgLBG3j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 01:29:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UHIaoW8_1606890515;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UHIaoW8_1606890515)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Dec 2020 14:28:36 +0800
Subject: Re: dm: use gcd() to fix chunk_sectors limit stacking
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, joseph.qi@linux.alibaba.com,
        linux-block@vger.kernel.org
References: <20201201160709.31748-1-snitzer@redhat.com>
 <20201202033855.60882-1-jefflexu@linux.alibaba.com>
 <20201202033855.60882-2-jefflexu@linux.alibaba.com>
 <feb19a02-5ece-505f-e905-86dc84cdb204@linux.alibaba.com>
 <20201202050343.GA20535@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <265e6542-cecf-0b62-4c03-2b053cafcee9@linux.alibaba.com>
Date:   Wed, 2 Dec 2020 14:28:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202050343.GA20535@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/2/20 1:03 PM, Mike Snitzer wrote:
> What you've done here is fairly chaotic/disruptive:
> 1) you emailed a patch out that isn't needed or ideal, I dealt already
>    staged a DM fix in linux-next for 5.10-rcX, see:
>    https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.10-rcX&id=f28de262ddf09b635095bdeaf0e07ff507b3c41b

Fine. I indeed didn't follow linux-dm.git. Sorry it's my fault.

> 2) you replied to your patch and started referencing snippets of this
>    other patch's header (now staged for 5.10-rcX via Jens' block tree):
>    https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.10&id=7e7986f9d3ba69a7375a41080a1f8c8012cb0923
>    - why not reply to _that_ patch in response something stated in it?

I just want to send in one email, which seems obviously improper.

> 3) you started telling me, and others on these lists, why you think I
>    used lcm_not_zero().
>    - reality is I wanted gcd() behavior, I just didn't reason through
>      the math to know it.. it was a stupid oversight on my part.  Not
>      designed with precision.
> 4) Why not check with me before you craft a patch like others reported
>    the problem to you? I know it logical to follow the chain of
>    implications based on one commit and see where else there might be
>    gaps but... it is strange to just pickup someone else's work like
>    that.
> 
> All just _seems_ weird and overdone. This isn't the kind of help I
> need. That said, I _do_ appreciate you looking at making blk IO polling
> work with bio-based (and DM's bio splitting in particular), but the
> lack of importance you put on DM's splitting below makes me concerned.
> 
Though I have noticed this series discussion yesterday, I didn't read it
thoroughly until today. When I noticed there may be one remained issue
(I know it is not now), the patch, that is commit 22ada802ede8 has been
adopt by Jens, so I send out a patch. If there's no Jens' reply, I will
just reply under your mail. That's it. I have to admit that I get
excited when I realized that I could send a patch. But it seems improper
and more likely a misunderstanding. I apologize if I did wrong.


> On Tue, Dec 01 2020 at 10:57pm -0500,
> JeffleXu <jefflexu@linux.alibaba.com> wrote:
> 
>> Actually in terms of this issue, I think the dilemma here is that,
>> @chunk_sectors of dm device is mainly from two source.
>>
>> One is that from the underlying devices, which is calculated into one
>> composed one in blk_stack_limits().
>>
>>> commit 22ada802ede8 ("block: use lcm_not_zero() when stacking
>>> chunk_sectors") broke chunk_sectors limit stacking. chunk_sectors must
>>> reflect the most limited of all devices in the IO stack.
>>>
>>> Otherwise malformed IO may result. E.g.: prior to this fix,
>>> ->chunk_sectors = lcm_not_zero(8, 128) would result in
>>> blk_max_size_offset() splitting IO at 128 sectors rather than the
>>> required more restrictive 8 sectors.
>>
>> For this part, technically I can't agree that 'chunk_sectors must
>> reflect the most limited of all devices in the IO stack'. Even if the dm
>> device advertises chunk_sectors of 128K when the limits of two
>> underlying devices are 8K and 128K, and thus splitting is not done in dm
>> device phase, the underlying devices will split by themselves.
> 
> DM targets themselves _do_ require their own splitting.  You cannot just
> assume all IO that passes through DM targets doesn't need to be properly
> sized on entry.  Sure underlying devices will do their own splitting,
> but those splits are based on their requirements.  DM targets have their
> own IO size limits too.  Each layer needs to enforce and respect the
> constraints of its layer while also factoring in those of the underlying
> devices.
> 
Got it. Thanks.


>>> @@ -547,7 +547,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>>>  
>>>  	t->io_min = max(t->io_min, b->io_min);
>>>  	t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
>>> -	t->chunk_sectors = lcm_not_zero(t->chunk_sectors, b->chunk_sectors);
>>> +
>>> +	/* Set non-power-of-2 compatible chunk_sectors boundary */
>>> +	if (b->chunk_sectors)
>>> +		t->chunk_sectors = gcd(t->chunk_sectors, b->chunk_sectors);
>>
>> This may introduces a regression.
> 
> Regression relative to what?  5.10 was the regression point.  The commit
> header you pasted into your reply clearly conveys that commit
> 22ada802ede8 caused the regression.  It makes no sense to try to create
> some other regression point.  You cannot have both from a single commit
> in the most recent Linux 5.10 release.
> 
> And so I have no idea why you think that restoring DM's _required_
> splitting constraints is somehow a regression.

I mistakenly missed that all these changes are introduced in v5.10.
Sorry for that.

> 
>> Suppose the @chunk_sectors limits of
>> two underlying devices are 8K and 128K, then @chunk_sectors of dm device
>> is 8K after the fix. So even when a 128K sized bio is actually
>> redirecting to the underlying device with 128K @chunk_sectors limit,
>> this 128K sized bio will actually split into 16 split bios, each 8K
>> sized。Obviously it is excessive split. And I think this is actually why
>> lcm_not_zero(a, b) is used originally.
> 
> No.  Not excessive splitting, required splitting.  And as I explained in
> point 2) above, avoiding "excessive splits" isn't why lcm_not_zero() was
> improperly used to stack chunk_sectors.

This is indeed a difference between 5.9 and 5.10. In 5.10 there may be
more small split bios, since a smaller chunk_sectors is applied for the
underlying device with larger chunk_sectors (that is, the underlying
device with 128K chunk_sectors). I can not say that more small split
bios will cause worse performance since I have not tested it.


> 
> Some DM targets really do require the IO be split on specific boundaries
> -- however inconvenient for the underlying layers that DM splitting
> might be.
> 


>> The other one source is dm device itself. DM device can set @max_io_len
>> through ->io_hint(), and then set @chunk_sectors from @max_io_len.
> 
> ti->max_io_len should always be set in the DM target's .ctr
> 
Yes I misremember it.

> DM core takes care of applying max_io_len to chunk_sectors since 5.10,
> you should know that given your patch is meant to fix commit
> 882ec4e609c1
> 
> And for 5.11 I've staged a change to have it impose max_io_len in terms
> of ->max_sectors too, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.11&id=41dcb8f21a86edbe409b2bef9bb1df4cb9d66858
> 
Thanks.

> One thing I clearly need to do moving forward is: always post my changes
> to dm-devel; just so someone like yourself can follow along via email
> client.  I just assumed others who care about DM changes also track the
> linux-dm.git tree's branches.  Clearly not the best assumption or
> practice on my part.

I used Linus' tree as my code base, which seems improper...

> 
>> This part is actually where 'chunk_sectors must reflect the most limited
>> of all devices in the IO stack' is true, and we have to apply the most
>> strict limitation here. This is actually what the following patch does.
> 
> There is a very consistent and deliberate way that device limits must be
> handled, sometimes I too have missteps but that doesn't change the fact
> that there is a deliberate evenness to how limits are stacked.
> blk_stack_limits() needs to be the authority on how these limits stack
> up.  So all DM's limits stacking wraps calls to it.  My fix, shared in
> point 1) above, restores that design pattern by _not_ having DM
> duplicate a subset of how blk_stack_limits() does its stacking.
> 
> Mike


-- 
Thanks,
Jeffle
