Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2B61F1313
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731247; cv=none; b=O3wNL47z/SWM9V9izFDik0k36PrXCeKj+bbkiKo9SnzMfCC4CQXf5bXSjpZocVBqJsMrgq2DAoJjXNDZ3nc1HUuqE/CCjOZw1WKsYwCqt9vDNdovfDzn2cs8zOKmluKXSr3KKZAscae+u1C9QVOwLOeU9L2+xhuuB06OM8y2UrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731247; c=relaxed/simple;
	bh=GChKHPUD4lIUnkS4BP3/Vtv97vAHT3cE1Sfhw8a4vqQ=;
	h=Subject:Message-ID:Date:MIME-Version:To:References:From:
	 In-Reply-To:Content-Type; b=LiE7DUnIAWBAKdgPZAvHCDwGBd+u24jIXBEUlBnY9DU+eVedmKPctjtonTQ0YpZ2iL2mBrYhUR8tHCRYEo09/lRTmai9U1qTXdxvnX/8zSWpIVYZNgZxBZlwZ66lLptcsLu/ERz0MZjrFBCNBw4TA2auQxmYpuHHPkI1JWT5WJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=FekdOiKe; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="FekdOiKe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749731246; x=1781267246;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=iBoH7knE64sL9YIQXKLk6PzXEZKHm8dZK0Q4dAaaOfo=;
  b=FekdOiKe6knPw5g7aemlLbCmQOe+LvWGPceD3IolZ/KimdseXp4irfH5
   Lv9S7Y/YRHV60ZNnwkBN+BWzuYRktH319PSxMCG5rggHltgLJEtZosZUZ
   p5ex1/D/4dGlGsYZc1HememGNH2ot7ZbUP4n5e9CA/A58xqT3H1UVrlNn
   iYzTbT6OMWi47ku2v+1ny+DBpPNRKFfvmW6hJ43cDAgeVuY3kRN8WH+uh
   QgjvcvRC+ULskHh+306bpURhYB4pVJgc/swBUH4ECekku+8bsdqlQK365
   YsmPxDCGid9FoRJY6eVJOKb62aM0tROUBkeztX9khAVBrQvK1GtoZ1CKH
   w==;
X-IronPort-AV: E=Sophos;i="6.16,230,1744070400"; 
   d="scan'208";a="29861418"
Subject: Re: [PATCH] block: use plug request list tail for one-shot backmerge attempt
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 12:27:20 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:3413]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.15.83:2525] with esmtp (Farcaster)
 id a94923e8-317f-4933-b757-eadb945ca431; Thu, 12 Jun 2025 12:27:18 +0000 (UTC)
X-Farcaster-Flow-ID: a94923e8-317f-4933-b757-eadb945ca431
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 12 Jun 2025 12:27:17 +0000
Received: from [10.95.108.147] (10.95.108.147) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 12 Jun 2025 12:27:12 +0000
Message-ID: <8a364c26-ff85-42d5-8b0a-17301e8deaa8@amazon.com>
Date: Thu, 12 Jun 2025 13:27:12 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
References: <4856d1fc-543d-4622-9872-6ca66e8e7352@kernel.dk>
 <82020a7f-adbc-4b3e-8edd-99aba5172510@amazon.com>
 <f4ed489d-af31-4ca0-bfc1-a340034c61f5@kernel.dk>
Content-Language: en-US
From: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
In-Reply-To: <f4ed489d-af31-4ca0-bfc1-a340034c61f5@kernel.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D003EUA002.ant.amazon.com (10.252.50.206) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

On 11/06/2025 18:53, Jens Axboe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On 6/11/25 10:55 AM, Mohamed Abuelfotoh, Hazem wrote:
>> On 11/06/2025 15:53, Jens Axboe wrote:
>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>
>>>
>>>
>>> Previously, the block layer stored the requests in the plug list in
>>> LIFO order. For this reason, blk_attempt_plug_merge() would check
>>> just the head entry for a back merge attempt, and abort after that
>>> unless requests for multiple queues existed in the plug list. If more
>>> than one request is present in the plug list, this makes the one-shot
>>> back merging less useful than before, as it'll always fail to find a
>>> quick merge candidate.
>>>
>>> Use the tail entry for the one-shot merge attempt, which is the last
>>> added request in the list. If that fails, abort immediately unless
>>> there are multiple queues available. If multiple queues are available,
>>> then scan the list. Ideally the latter scan would be a backwards scan
>>> of the list, but as it currently stands, the plug list is singly linked
>>> and hence this isn't easily feasible.
>>>
>>> Cc: stable@vger.kernel.org
>>> Link: https://lore.kernel.org/linux-block/20250611121626.7252-1-abuehaze@amazon.com/
>>> Reported-by: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
>>> Fixes: e70c301faece ("block: don't reorder requests in blk_add_rq_to_plug")
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> ---
>>>
>>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>>> index 3af1d284add5..70d704615be5 100644
>>> --- a/block/blk-merge.c
>>> +++ b/block/blk-merge.c
>>> @@ -998,20 +998,20 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
>>>           if (!plug || rq_list_empty(&plug->mq_list))
>>>                   return false;
>>>
>>> -       rq_list_for_each(&plug->mq_list, rq) {
>>> -               if (rq->q == q) {
>>> -                       if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
>>> -                           BIO_MERGE_OK)
>>> -                               return true;
>>> -                       break;
>>> -               }
>>> +       rq = plug->mq_list.tail;
>>> +       if (rq->q == q)
>>> +               return blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
>>> +                       BIO_MERGE_OK;
>>> +       else if (!plug->multiple_queues)
>>> +               return false;
>>>
>>> -               /*
>>> -                * Only keep iterating plug list for merges if we have multiple
>>> -                * queues
>>> -                */
>>> -               if (!plug->multiple_queues)
>>> -                       break;
>>> +       rq_list_for_each(&plug->mq_list, rq) {
>>> +               if (rq->q != q)
>>> +                       continue;
>>> +               if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
>>> +                   BIO_MERGE_OK)
>>> +                       return true;
>>> +               break;
>>>           }
>>>           return false;
>>>    }
>>>
>>> --
>>> Jens Axboe
>>>
>>
>> Thanks for posting this fix, I can confirm that this patch mitigated
>> the regression reported in [1], my only concern is the impact when we
>> have multiple queues available as you explained in the commit message.
>> Given that reverting e70c301faece ("block: don't reorder requests in
>> blk_add_rq_to_plug") will break zoned storage support and the plug
>> list is singly linked, I don't think we have a better solution here.
> 
> Yes we can't revert it, and honestly I would not want to even if that
> was an option. If the multi-queue case is particularly important, you
> could just do something ala the below - keep scanning until you a merge
> _could_ have happened but didn't. Ideally we'd want to iterate the plug
> list backwards and then we could keep the same single shot logic, where
> you only attempt one request that has a matching queue. And obviously we
> could just doubly link the requests, there's space in the request
> linkage code to do that. But that'd add overhead in general, I think
> it's better to shove a bit of that overhead to the multi-queue case.

Thanks, I got your point, I will test the impact on raid0 aggregated 
disks and will report the numbers with this proposed patch. During my 
debugging I actually tried to iterate the list from head to tail looking 
for the perfect request to merge and although that improved the bio 
merge success rate, it actually dropped the fio randwrite B.W by about 
66% compared to the baseline performance without reverting e70c301faece 
("block: don't reorder requests in blk_add_rq_to_plug") and that's 
likely because of the overhead of iterating the whole plug list to look 
for the perfect request to merge with.

> 
> I suspect the below would do the trick, however.
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 70d704615be5..4313301f131c 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -1008,6 +1008,8 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
>          rq_list_for_each(&plug->mq_list, rq) {
>                  if (rq->q != q)
>                          continue;
> +               if (blk_try_merge(rq, bio) == ELEVATOR_NO_MERGE)
> +                       continue;
I think this should be break? it's not clear to me why would you need to 
continue scanning the list if blk_try_merge() returns ELEVATOR_NO_MERGE 
here?
>                  if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
>                      BIO_MERGE_OK)
>                          return true;
> 
> --
> Jens Axboe

