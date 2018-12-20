Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96302C43444
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 18:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55302218E2
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 18:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="llfHHM/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbeLTSVG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:21:06 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:35096 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388778AbeLTSVF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 13:21:05 -0500
Received: by mail-io1-f48.google.com with SMTP id o13so204036ioh.2
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 10:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=eUmZYHNjmKxVoW3Kab0wmjdzknD9n9Wryv8unPFlM/0=;
        b=llfHHM/ZIx2c2YyllJdoAK1oQ7wFZENk9gm99aYigP67vXHe2gsPholrLiSZfIWjLR
         3LZeEu+GtfOgyOku9GuUKQIJqUkEvhXtsvOpfocQrOnfsyvW2JNwaUhRWOr6U3HZQzSX
         JqTNsSVjJroj5jQTH8IyLcFE57ax1e/EZpwF1ugk6xqu0PX/BYeKpeMjNotuBoRIhpnM
         aUrSq9KVx9bhB5wvCWQRN1+omg5Y6k3P+PMzZLboZRK15e2pnQ7sfdnUNN4uz5nWfb8Q
         ZotFMMh5dyHmed7m1v/mFOETSFcX0KVo1lrAPlpQ3bBMKh5CUOga2CNyivs2GgCiZSXM
         eoeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eUmZYHNjmKxVoW3Kab0wmjdzknD9n9Wryv8unPFlM/0=;
        b=ob0LIM48j3oIP4RW6vgnCKmP9Q/pBrebCPsdRxGpwqUk0BifCajjKIDNP2U2fFm4vN
         4s52n8OK37f3EH588fHeMLENIRppkXgjcC3OYQJchUvrvkbvM0/Znwn2KR2kqv9Hcwf3
         RcoLlrVVooWDV8u+FhhenmNE847Z7jv47r4B13s0NgODIp0UoUcw2nr8rLiHkhwK39Yk
         RHHCQNIB2VlyNF92x/9yPJ+Luc9XamsmAusN3d8IHAy8zN/laWUYHNX78MG7R7x53160
         rcmDmCTbxAd+hqxLUpiVxS+9Zz+XaDY4Bq7omyiHVlFdoIQJ3p9J0rJcYMZU3BpvW5xB
         TRPg==
X-Gm-Message-State: AA+aEWYu4jkzLSyhzEvD+JBGTSfElphjwVO8MFyVUAWyK9E0c+r8Xs1W
        02KjhqcsISDS87Ir3rIWYkRZsBowa8wD7A==
X-Google-Smtp-Source: AFSGD/UGFczjlvtuMWke6XsVM4P13HQlKjQyGSSUXiOaAnPFcfiI02S3BN6nDqgDsziqKkDt5k8tCA==
X-Received: by 2002:a5e:a911:: with SMTP id c17mr20243063iod.127.1545330063932;
        Thu, 20 Dec 2018 10:21:03 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y8sm5028452ita.5.2018.12.20.10.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 10:21:03 -0800 (PST)
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
To:     Bart Van Assche <bvanassche@acm.org>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1545261885.185366.488.camel@acm.org>
 <74c0280c-e557-ad03-cd75-98dd6d868da3@kernel.dk>
 <1545265001.185366.496.camel@acm.org>
 <1ca5cd37-87ce-8cff-6cb4-1fdb29bd4da2@kernel.dk>
 <0560802f-efc0-e9ec-99f7-4bdbdbc234f8@oracle.com>
 <c078750c-ff6b-4939-281b-7556d31dc74d@kernel.dk>
 <fe9dfe60-3cfc-9cfa-56c3-1365cbe8ec53@oracle.com>
 <a45c9931-ce8b-0ac8-f304-412c6042eff9@kernel.dk>
 <372d2960-ff0c-1135-28f9-23eea8670463@oracle.com>
 <ccf50ee5-ff34-39a0-d7eb-3853fee55a4c@kernel.dk>
 <6ae35005-7ba9-91e1-f315-d128f410c12c@kernel.dk>
 <1545328865.185366.508.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bd78b521-d0d4-22ec-ff7f-2d70709ca742@kernel.dk>
Date:   Thu, 20 Dec 2018 11:21:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545328865.185366.508.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/18 11:01 AM, Bart Van Assche wrote:
> On Thu, 2018-12-20 at 06:07 -0700, Jens Axboe wrote:
>> On 12/20/18 6:02 AM, Jens Axboe wrote:
>>>> I'm afraid this cannot work.
>>>>
>>>> The 'tags' here could be the hctx->sched_tags, but what we need to
>>>> clear is hctx->tags->rqs[].
>>>
>>> You are right, of course, a bit too quick on the trigger. This one
>>> should work better, and also avoids that silly quadratic loop. I don't
>>> think we need the tag == -1 check, but probably best to be safe.
>>
>> Sent out the wrong one, here it is. Bart, if you can reproduce, can you
>> give it a whirl?
>>
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 2de972857496..fc04bb648f18 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2025,7 +2025,7 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>>  {
>>  	struct page *page;
>>  
>> -	if (tags->rqs && set->ops->exit_request) {
>> +	if (tags->rqs) {
>>  		int i;
>>  
>>  		for (i = 0; i < tags->nr_tags; i++) {
>> @@ -2033,8 +2033,14 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>>  
>>  			if (!rq)
>>  				continue;
>> -			set->ops->exit_request(set, rq, hctx_idx);
>> +			if (set->ops->exit_request)
>> +				set->ops->exit_request(set, rq, hctx_idx);
>>  			tags->static_rqs[i] = NULL;
>> +
>> +			if (rq->tag == -1)
>> +				continue;
>> +			if (set->tags[hctx_idx]->rqs[rq->tag] == rq)
>> +				set->tags[hctx_idx]->rqs[rq->tag] = NULL;
>>  		}
>>  	}
>>  
>> @@ -2113,6 +2119,7 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
>>  			return ret;
>>  	}
>>  
>> +	rq->tag = -1;
>>  	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
>>  	return 0;
>>  }
> 
> Hi Jens,
> 
> Are you sure this is sufficient?

No, I don't think it is.

> My understanding is that
> blk_mq_queue_tag_busy_iter() iterates over all tags in the tag set. So if the
> request queue on which part_in_flight() is called and the request queue for
> which blk_mq_free_rqs() is called share their tag set then part_in_flight()
> and blk_mq_free_rqs() can run concurrently. That can cause ugly race
> conditions. Do you think it would be a good idea to modify the inflight
> accounting code such that it only considers the requests of a single request
> queue instead of all requests for a given tag set?

That would of course solve it, the question is how to do it. One option
would be to have ->rqs[] be:

struct rq_entry {
	struct request_queue *q;
	struct request *rq;
};

instead of just a request, since then you could check the queue without
having to dereference the request. The current race is inherent in that
we set ->rqs[] AFTER having acquired the tag, so there's a window where
you could find a stale entry. That's not normally an issue since
requests are persistent, but for shared tag maps and queues disappearing
it can pose a problem.


-- 
Jens Axboe

