Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363682F39D4
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943865; cv=none; b=AEknAKqjeTIrpa6J6MiQHhuatrpU8lZjPGcUm51KHwzK/pCuSjpspQWkNdiWOZC+ymHQPfaG8r+UsOjBEcZv45tyWEDIg3x+pO6tWOxlZIlwrVPJSTo1uUlmfGTLHS+BlINHzL6lWGTH0nArWvMQsC0TioxhpZuiAZ62L2ilDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943865; c=relaxed/simple;
	bh=vBmKHO/FghLO4V3rQpAJXuDmPMhRsYzKN0bRiyWa3k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOgl5/kEK6u3mphCtDNEgiyCf4UkYAWqnzXi11uzrladxhYZn5GcrXInzMd83AFWzkCSUyUuQ1zTd7hX+w4FCvn/4p30T00Hv3ztWdf5iYVJNVmasKYa02rsybF5JvqRt0e4qALcQef7bGpxajYT9WEf2b1VRhR2T0Z7mAWUnm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fce1yt/U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fce1yt/U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762943863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z52u503M6rJ4cx7TG3l/tE5leapd1xwBzRigi8cdxwk=;
	b=Fce1yt/UiI12MZOfk2qJxvPjnvLs53xQVy3Um4jcyZ2t7IqzzXUhKrUQKTBeAFdgcfX4jz
	WkF+66cfA15MysHspbDqGRh8hBP7cC3RG++MWh6uu5nvKuJscihr5aJ/DG3UPE9V2adPRi
	XxIL4j+rWDjPzW3FcZw47KvyzfMuVSQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-M9vKxCzUMiGZFfUaPQQouw-1; Wed,
 12 Nov 2025 05:37:42 -0500
X-MC-Unique: M9vKxCzUMiGZFfUaPQQouw-1
X-Mimecast-MFC-AGG-ID: M9vKxCzUMiGZFfUaPQQouw_1762943860
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FE5B1954B00;
	Wed, 12 Nov 2025 10:37:40 +0000 (UTC)
Received: from fedora (unknown [10.72.116.179])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8CB71955F1A;
	Wed, 12 Nov 2025 10:37:33 +0000 (UTC)
Date: Wed, 12 Nov 2025 18:37:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	yi.zhang@redhat.com, czhong@redhat.com, yukuai@fnnas.com,
	gjoyce@ibm.com
Subject: Re: [PATCHv5 2/5] block: move elevator tags into struct
 elevator_resources
Message-ID: <aRRjaCbc-Vcd1iqY@fedora>
References: <20251112052848.1433256-1-nilay@linux.ibm.com>
 <20251112052848.1433256-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112052848.1433256-3-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Nov 12, 2025 at 10:56:03AM +0530, Nilay Shroff wrote:
> This patch introduces a new structure, struct elevator_resources, to
> group together all elevator-related resources that share the same
> lifetime. As a first step, this change moves the elevator tag pointer
> from struct elv_change_ctx into the new struct elevator_resources.
> 
> Additionally, rename blk_mq_alloc_sched_tags_batch() and
> blk_mq_free_sched_tags_batch() to blk_mq_alloc_sched_res_batch() and
> blk_mq_free_sched_res_batch(), respectively. Introduce two new wrapper
> helpers, blk_mq_alloc_sched_res() and blk_mq_free_sched_res(), around
> blk_mq_alloc_sched_tags() and blk_mq_free_sched_tags().
> 
> These changes pave the way for consolidating the allocation and freeing
> of elevator-specific resources into common helper functions. This
> refactoring improves encapsulation and prepares the code for future
> extensions, allowing additional elevator-specific data to be added to
> struct elevator_resources without cluttering struct elv_change_ctx.
> 
> Subsequent patches will extend struct elevator_resources to include
> other elevator-related data.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

