Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6D31581E5
	for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 03:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740627121; cv=none; b=OI+3idpZfcZH1xcCIxa9DsoY7X/ImQKK8i9Q1yngorjfI7nW/OImaJzx6782lUc1D4kWFMn+pUfTtZAX3mLRbg1C+rEpBD4B5I7Qj+fqR+hNTrWaDVrchkpcYDHsPAf/tstEAimqLhSJwA2ZUprwM94ZERujvPdEQfqcK0w4ERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740627121; c=relaxed/simple;
	bh=fTScCDMZsIr3NOKBahSdpL0aleNU7+p3uwrdQRHlwKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeUilz6CTEicD/mNi5Q3u82Jobd5kpB4uBYTwBUUEY8ax365PX/L1ka510aTj3F9suxtYls5zsdq4Z7bpgjylwX0fMbenn8YzAHRPNsJN4nfXav8mr9IljfYmrg0THtcQ/slNYjNqrazeETD9G6YUovEhivabAH+vN0RvZ2PQ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MOE1H96n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOE1H96n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740627118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XWZbFLUXctS8QgaPNkd0/QVXF+TKqIHKH1rcU3Crlzk=;
	b=MOE1H96nE9SVvbxjpy5w3c8RHuRcr3+QhXICb+xC3QZ9B9mpqD08EdmkmXqfEe3mzjh+VE
	raxJ7vETtCO5XRftvni6lT6XWtzpZVbym6uHILZQmZMc2JKtbxDfRdp3NX9Lt1yaR3eBYS
	4ZURkOh576xQtkPTxrsoaH1t8ku3MWM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-3-WaajeZNqaT7C069YPtTQ-1; Wed,
 26 Feb 2025 22:31:55 -0500
X-MC-Unique: 3-WaajeZNqaT7C069YPtTQ-1
X-Mimecast-MFC-AGG-ID: 3-WaajeZNqaT7C069YPtTQ_1740627114
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2CBB196E078;
	Thu, 27 Feb 2025 03:31:53 +0000 (UTC)
Received: from fedora (unknown [10.72.120.23])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 099DC19560AE;
	Thu, 27 Feb 2025 03:31:45 +0000 (UTC)
Date: Thu, 27 Feb 2025 11:31:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Paul Bunyan <pbunyan@redhat.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH V5] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z7_cm0GHco5LCFVy@fedora>
References: <20250225022141.2154581-1-ming.lei@redhat.com>
 <253b6cf9-6f17-4a9f-afd8-27204b1e6093@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253b6cf9-6f17-4a9f-afd8-27204b1e6093@acm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Feb 26, 2025 at 09:38:36AM -0800, Bart Van Assche wrote:
> On 2/24/25 6:21 PM, Ming Lei wrote:
> > diff --git a/block/blk.h b/block/blk.h
> > index 90fa5f28ccab..9cf9a0099416 100644
> > --- a/block/blk.h
> > +++ b/block/blk.h
> > @@ -14,6 +14,7 @@
> >   struct elevator_type;
> >   #define	BLK_DEV_MAX_SECTORS	(LLONG_MAX >> 9)
> > +#define	BLK_MIN_SEGMENT_SIZE	4096
> >   /* Max future timer expiry for timeouts */
> >   #define BLK_MAX_TIMEOUT		(5 * HZ)
> 
> Hi Ming,
> 
> Would you agree with reducing BLK_MIN_SEGMENT_SIZE further, e.g. to 2048
> or 1024? Although I'm not aware of any storage devices that need this

We never take < 4096 as min segment size, I'd rather not relax it for
avoiding any potential regression.

But if any kind of real device requires it, we may re-consider to relax
it more.

> change, this change would make it possible to test the new code paths
> introduced by this patch on systems with a 4 KiB page size. I wrote
> blktests tests for the new code paths before I posted my patch series
> "Support limits below the page size"
> (https://lore.kernel.org/linux-block/20230612203314.17820-1-bvanassche@acm.org/).
> The last two patches of that patch series are still needed to run these
> blktests tests.

Indeed, I guess you will re-send the two, and I am glad to review after it is
posed out.



thanks,
Ming

