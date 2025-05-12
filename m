Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2482566DD
	for <linux-block@vger.kernel.org>; Mon, 12 May 2025 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747048417; cv=none; b=b99+LR/C00eZMyKO2+JD/zF7rlZPaz9JUPVJJ98BESM75gPuIUrLNhy+sLp9/DNQJtHDA/TpRrwyvBfaEA6Q/+QarYpr/3nJgnUqzjLET9Wyvwd0IZQ7NGiNV3qmqP7++rKmz9xNcCr6I3wSbZiLB6SaWgCooSkF76Ip4+jDbO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747048417; c=relaxed/simple;
	bh=q8OXQMWayF/gLukFoFBzkp1TbWTADvqLvCEVN2mgiDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJZWxsvAVEluJAGhzP5UCHvOB5yfGxiv32fACXrgLFlIF3X+q7CUKPuA9G/KRQ4IQ0mWxdJVDq3ujL63Qov6Ou8MP3iemc0+2OHjnBvbF50LbrFyS1/zl1tP+5Y7kYnXhZP9/EXfNqpTSb10pELWCxXP3/x+3zNfgsFxfips8BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JdOUs9wH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdOUs9wH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747048414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+yqPiJ39cg9MeL3Xm7OlCOotkffu6l5mMNBq3HTTi8=;
	b=JdOUs9wH+jxaDzlH/a4VN1i3SnMlWwNziZEGolNEbce1Nyk0Qb992vZ0o3DrLlqvnEPPLp
	5+exf/Aaj2+YV12pECv7jiYIevE8rj+4vsRQfWTRJYk8PKtt9GXVJ0G2et0It0IfsXsoJs
	+cMRL27bFz+BN7EMgujKZzsSnYvMsh0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-QucXImdAPqKcCCar4ybzfA-1; Mon,
 12 May 2025 07:13:33 -0400
X-MC-Unique: QucXImdAPqKcCCar4ybzfA-1
X-Mimecast-MFC-AGG-ID: QucXImdAPqKcCCar4ybzfA_1747048412
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24D4C19560B3;
	Mon, 12 May 2025 11:13:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.23])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AC211956095;
	Mon, 12 May 2025 11:13:27 +0000 (UTC)
Date: Mon, 12 May 2025 19:13:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	gjoyce@ibm.com
Subject: Re: [PATCH] block: unfreeze queue if realloc tag set fails during
 nr_hw_queues update
Message-ID: <aCHX0vbWXbFbOgGt@fedora>
References: <20250512092952.135887-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512092952.135887-1-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, May 12, 2025 at 02:43:38PM +0530, Nilay Shroff wrote:
> In __blk_mq_update_nr_hw_queues(), the current sequence involves:
> 
> 1. unregistering sysfs/debugfs attributes
> 2. freeze the queue
> 3. reallocating the tag set
> 4. updating the queue map
> 5. reallocating hardware contexts
> 6. updating the elevator (which unfreeze the queue again)
> 7. re-register sysfs/debugfs attributes
> 
> If tag set reallocation fails at step 3, the function skips steps 4–6
> and proceeds directly to step 7, re-registering the sysfs/debugfs
> attributes without unfreezing the queue first. This is incorrect and
> can lead to a system hang or lockdep splat, as the queue remains frozen
> and is never properly unfrozen.
> 
> This patch addresses the issue by explicitly unfreezing the queue before
> re-registering the sysfs/debugfs attributes in the event of a tag set
> reallocation failure.
> 
> Fixes: 9dc7a882ce96 ("block: move hctx debugfs/sysfs registering out of freezing queue")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  block/blk-mq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4f79a9808fd1..cbc9a9f97a31 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -5002,8 +5002,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  	list_for_each_entry(q, &set->tag_list, tag_set_list)
>  		blk_mq_freeze_queue_nomemsave(q);
>  
> -	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
> +	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0) {
> +		list_for_each_entry(q, &set->tag_list, tag_set_list)
> +			blk_mq_unfreeze_queue_nomemrestore(q);
>  		goto reregister;

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

