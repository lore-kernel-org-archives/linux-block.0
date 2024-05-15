Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF1D57CA1
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715784415; cv=none; b=F9HEj3PMnQw3Pi54gzG6lnqXdelnAlcyOOYEmRzFPR971XvhkT+DGdRtrlzPGzFjtCtWb/KPBYokQ5TNaJEvYPSRBHhBFKRzICytCWz2sQpu8QJEC3Li+UdR7fOOTOwG+634s/mqb9TZdFlNY5CbgiO71sG2keog7hNLGzqnmdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715784415; c=relaxed/simple;
	bh=vB/r2E9PY4UgETQH9vPghPD71V8UshZLDF+Y5hwnhiY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=COJKzeZlzi5Hss9mc3rU2/yjsAJ7qj8SQUsrwC8Ul81X2wqwLS+S7UzGgqMXJy1ux8xwOdW0vAkDUyNog8Zs9fAS0A/FPvNbqco+XEeY8Hj3cVdbFcTxSVJyRFE29895SQ+kItdx/+DstQg3zo7X1iMuuspESs+SfXU5X75ZWsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+ekJ/Mr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+ekJ/Mr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715784412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5+zsN4jJI7ZDKtAhvwQrO2TvqdYZZ5r36mN+xSmrlw=;
	b=F+ekJ/MrMVcNjFYuk5l5hRb8SrsYCD9PNTWMvq5sji0K768T8jj+DAZFMhSESP8E5/+IoL
	3Xfan5BPyj443Jga35+sqolvsxrl/MbPCRXRB/LQnidBYPfpoQuMV2tOozWo1nzduje4R2
	av6qNHUjfHN0Mplhb4cMQ1gb9uxxnQw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-VwfnsvBUNc6xF7IKinfXvg-1; Wed,
 15 May 2024 10:46:49 -0400
X-MC-Unique: VwfnsvBUNc6xF7IKinfXvg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AE4738157BA;
	Wed, 15 May 2024 14:46:49 +0000 (UTC)
Received: from [10.22.33.50] (unknown [10.22.33.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E83C640C6CB6;
	Wed, 15 May 2024 14:46:48 +0000 (UTC)
Message-ID: <a8330e4a-5ffe-4e37-9398-a37f9ae29f0c@redhat.com>
Date: Wed, 15 May 2024 10:46:48 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] blk-cgroup: fix list corruption from reorder of WRITE
 ->lqueued
From: Waiman Long <longman@redhat.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>
References: <20240515013157.443672-1-ming.lei@redhat.com>
 <20240515013157.443672-3-ming.lei@redhat.com>
 <2a0cae15-e9d9-4524-a0db-f665b1832db4@redhat.com>
Content-Language: en-US
In-Reply-To: <2a0cae15-e9d9-4524-a0db-f665b1832db4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 5/15/24 10:09, Waiman Long wrote:
>
> On 5/14/24 21:31, Ming Lei wrote:
>> __blkcg_rstat_flush() can be run anytime, especially when 
>> blk_cgroup_bio_start
>> is being executed.
>>
>> If WRITE of `->lqueued` is re-ordered with READ of 'bisc->lnode.next' in
>> the loop of __blkcg_rstat_flush(), `next_bisc` can be assigned with one
>> stat instance being added in blk_cgroup_bio_start(), then the local
>> list in __blkcg_rstat_flush() could be corrupted.
>>
>> Fix the issue by adding one barrier.
>>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Waiman Long <longman@redhat.com>
>> Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> ---
>>   block/blk-cgroup.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index 86752b1652b5..b36ba1d40ba1 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -1036,6 +1036,16 @@ static void __blkcg_rstat_flush(struct blkcg 
>> *blkcg, int cpu)
>>           struct blkg_iostat cur;
>>           unsigned int seq;
>>   +        /*
>> +         * Order assignment of `next_bisc` from `bisc->lnode.next` in
>> +         * llist_for_each_entry_safe and clearing `bisc->lqueued` for
>> +         * avoiding to assign `next_bisc` with new next pointer added
>> +         * in blk_cgroup_bio_start() in case of re-ordering.
>> +         *
>> +         * The pair barrier is implied in llist_add() in 
>> blk_cgroup_bio_start().
>> +         */
>> +        smp_mb();
>> +
>>           WRITE_ONCE(bisc->lqueued, false);
>
> I believe replacing WRITE_ONCE() by smp_store_release() and the 
> READ_ONCE() in blk_cgroup_bio_start() by smp_load_acquire() should 
> provide enough barrier to prevent unexpected reordering as the 
> subsequent u64_stats_fetch_begin() will also provide a read barrier 
> for subsequent read.

We can also use a smp_acquire__after_ctrl_dep() after the READ_ONCE() in 
blk_cgroup_bio_start() instead of a full smp_load_acquire() to optimize 
it a bit more.

Cheers,
Longman

