Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395E22BE7C3
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943976; cv=none; b=PU9JKt6JiiDkvqW/YEy/6DoP8IbC4QWqQk61tUTOiXzADYowb1QeLoGbhqXvo+Qk5koEnDIZbFUNBrXGvMS9BC1/MLGaJ+6vkH3PsD9h+8VR7SEMOzIy4cNfiNmBfHs19c+Pcul1t2HDv8VCIvrE5J+aQVkr4Q7yr8WJZGRvgTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943976; c=relaxed/simple;
	bh=UYkpwjiDVS55Ne0xJv8IIj2vPnjSfILsf9rZCBhuZyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aq8O2FFLSfuodXXIuMrPZBidn+h03kakRN5WDQVYcZdfBeOW8xO0nYpbT1KUBRX0yoknUtLghUJGrQvj3xh/t+YtXbqfsM+r+nCu6hOHc2wfSqUZVSPHPaIqU1NpBkuPY/0IJ4Ff3fPEzCswORsza9eSl6HK+Cr4lw28TTMkv64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+qyfN6q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+qyfN6q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762943974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4bpjml5vggsTAIZ+6TjQc733OESkeIDCVfILaiqcG4=;
	b=B+qyfN6qZKmskS8mZTyfUCGGFFOHnjeXrHpUSrHdM/Y3hBICgKQIz9j1cNjtdAuHHBoYkq
	lzaWEZrebgRlkX7HpAWQJyUcEp+fc9BM15AYQJWg5phbiHe8oxgUjuCwjIzgw4Kk4WFlIo
	FZuWGVTVr6n7Y3MOal1bcOgbgFYkrcg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-n-zYlnwmOxmXLcJU2EmFFg-1; Wed,
 12 Nov 2025 05:39:14 -0500
X-MC-Unique: n-zYlnwmOxmXLcJU2EmFFg-1
X-Mimecast-MFC-AGG-ID: n-zYlnwmOxmXLcJU2EmFFg_1762943950
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B91A19560A1;
	Wed, 12 Nov 2025 10:39:10 +0000 (UTC)
Received: from fedora (unknown [10.72.116.179])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C423196FC8B;
	Wed, 12 Nov 2025 10:39:04 +0000 (UTC)
Date: Wed, 12 Nov 2025 18:38:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	yi.zhang@redhat.com, czhong@redhat.com, yukuai@fnnas.com,
	gjoyce@ibm.com
Subject: Re: [PATCHv5 4/5] block: use {alloc|free}_sched data methods
Message-ID: <aRRjwlUDXDHdv2C8@fedora>
References: <20251112052848.1433256-1-nilay@linux.ibm.com>
 <20251112052848.1433256-5-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112052848.1433256-5-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Nov 12, 2025 at 10:56:05AM +0530, Nilay Shroff wrote:
> The previous patch introduced ->alloc_sched_data and
> ->free_sched_data methods. This patch builds upon that
> by now using these methods during elevator switch and
> nr_hw_queue update.
> 
> It's also ensured that scheduler-specific data is
> allocated and freed through the new callbacks outside
> of the ->freeze_lock and ->elevator_lock locking contexts,
> thereby preventing any dependency on pcpu_alloc_mutex.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

