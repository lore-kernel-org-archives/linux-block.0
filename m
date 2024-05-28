Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1653116F91C;
	Tue, 28 May 2024 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907264; cv=none; b=JIqICD5LkFJcYODOsy/OxCm4YGgX9JhQH8jhBvMTVb1W6b2DkU8VKWV6/BWQlGnSzxX2X6lDlQQpdwE1COdyBg4JE7QLTQ8RvBoGi9haIKliP6X7gldvrlVEgfbnNH9jFoHgu4x//VwjWi2M6aRPAl+o3WOTD4eIMm8LrhybijQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907264; c=relaxed/simple;
	bh=cuLqncdG/XMEaY3Cchc8AQ4a+xQfAx4RpxNNbTBua5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlaFJ1f3pCd9awpG9yEaC4ekMX1yTCrZVE5UjDiYGbA83dHktiP4SH3If72eIwNB65dzidgKO8cKawh+Ti7hspe2Du0PL/nMA4tbFIug2IrQPdvrxG0OZBpu104cdNA0/7hDIHJVMmVx7BdWY2B9rrUEJvlvGBSZsrc7SNhOlgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9D324441F2;
	Tue, 28 May 2024 16:40:58 +0200 (CEST)
Message-ID: <acc28f2c-0e72-409d-bb61-791ef62ddfd4@proxmox.com>
Date: Tue, 28 May 2024 16:40:57 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] blk-flush: reuse rq queuelist in flush state
 machine
To: Chengming Zhou <chengming.zhou@linux.dev>, axboe@kernel.dk,
 ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20230717040058.3993930-1-chengming.zhou@linux.dev>
 <20230717040058.3993930-5-chengming.zhou@linux.dev>
 <14b89dfb-505c-49f7-aebb-01c54451db40@proxmox.com>
 <984f1f77-288c-441a-a649-5f320249b576@linux.dev>
 <4d799672-378b-42b1-896b-38df2c5e9c84@proxmox.com>
 <0783d367-4608-4b16-9b88-6eaf5d5706eb@linux.dev>
 <8b1400e6-b35e-486b-8ea0-de76270267c0@linux.dev>
 <87f495c2-7504-4d22-b355-608b13c456cd@linux.dev>
 <cb0fab18-ba27-420f-ace3-b099c74398c6@proxmox.com>
 <09be2bc6-d16a-4740-908a-f157dcd97ca8@linux.dev>
Content-Language: en-US
From: Friedrich Weber <f.weber@proxmox.com>
In-Reply-To: <09be2bc6-d16a-4740-908a-f157dcd97ca8@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/05/2024 11:09, Chengming Zhou wrote:
> On 2024/5/28 16:42, Friedrich Weber wrote:
>> Hope I did this correctly. With this, the reproducer triggered a BUG
>> pretty quickly, see [0]. If I can provide anything else, just let me know.
> 
> Thanks for your patience, it's correct. Then how about this fix?
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d98654869615..b2ec5c4c738f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -485,6 +485,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
>         if (data->nr_tags > 1) {
>                 rq = __blk_mq_alloc_requests_batch(data);
>                 if (rq) {
> +                       INIT_LIST_HEAD(&rq->queuelist);
>                         blk_mq_rq_time_init(rq, alloc_time_ns);
>                         return rq;
>                 }
> 

Nice, seems like with this patch applied on top of 6.9, the reproducer
does not trigger crashes anymore for me! Thanks!

To verify that the reproducer hits the new INIT_LIST_HEAD, I added debug
prints before/after:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4da581f13273..75186bb0d9c9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -485,7 +485,9 @@ static struct request
*__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
        if (data->nr_tags > 1) {
                rq = __blk_mq_alloc_requests_batch(data);
                if (rq) {
+                       pr_warn("before init: list: %p next: %p prev:
%p\n", &rq->queuelist, rq->queuelist.next, rq->queuelist.prev);
                        INIT_LIST_HEAD(&rq->queuelist);
+                       pr_warn("after init: list: %p next: %p prev:
%p\n", &rq->queuelist, rq->queuelist.next, rq->queuelist.prev);
                        blk_mq_rq_time_init(rq, alloc_time_ns);
                        return rq;
                }

And indeed, I see quite some printouts where rq->queuelist.next differs
before/after the request, e.g.

May 28 16:31:25 reproflushfull kernel: before init: list:
000000001e0a144f next: 00000000aaa2e372 prev: 000000001e0a144f
May 28 16:31:25 reproflushfull kernel: after init: list:
000000001e0a144f next: 000000001e0a144f prev: 000000001e0a144f
May 28 16:31:26 reproflushfull kernel: before init: list:
000000001e0a144f next: 00000000aaa2e372 prev: 000000001e0a144f
May 28 16:31:26 reproflushfull kernel: after init: list:
000000001e0a144f next: 000000001e0a144f prev: 000000001e0a144f

I know very little about the block layer, but if I understand the commit
message of the original 81ada09cc25e correctly, it's expected that
queuelist needs to be reinitialized at some places. I'm just a little
confused to see the same pointer 00000000aaa2e372 in two subsequent
"before init" printouts for the same queuelist 000000001e0a144f. Is this
expected too?

Also, just out of interest: Can you estimate whether this issue is
specific to software RAID setups, or could similar NULL pointer
dereferences also happen in setups without software RAID?

Best wishes,

Friedrich

