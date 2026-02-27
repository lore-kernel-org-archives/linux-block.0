Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB33D902F
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772184240; cv=none; b=JSp4YgOaTCKzLVLTqHjAEKQGsT0jBvLm9kdyowao69N2aahIIryFIqLI0hlwKOET5NdL+CrWCoyTR9HJRTFDQAlzd+GL7Q2SMIgMvdeIpJisa54skzZYKoVO98XfuVTTE7IxjRLLqvqPOYUL4FxV6QqmX87d/v8LRQwKtpKvOOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772184240; c=relaxed/simple;
	bh=54DkYwMJf9M6ceyra+uG+DA5ci4v6shGcLarHIyFg44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7lHsPBaM/2VlCtueL42xS6by7t+jMX8T9sYcKMyHG1FYXdBs1JCrSOcputs3gwZuoF19Jmyl2MrRwc8G4uu4Jv4XDBhFGBntp59ALDUn/nhyvNLVgXicPOaqDYQA2/OdYBJXPxwzX2v3SiiZZC8anUeo9fQtmpBKPFORriyF7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQwx8QEL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQwx8QEL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772184237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ahYWbUe0DXVnmog0OWvwx1sBk5tywROJKEZUGn5BcUM=;
	b=DQwx8QEL9CEsxVVQBMGGSY+JtgSN/d+d5i15IKJeFb6zfybUxqZ6k1HKuiW3lnvFDMmWBy
	xhj1iOeB1OVpp2HzMkKzUcCN6ZDzRhNLFH36YbkrIuIBCNV3qDTwlKrA1SARblSmoO3jYS
	SxJYCETGtnBe0h2LEYtZP8V25+ZANYE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-oMJTYj7_MOuMKnVxUWadnA-1; Fri,
 27 Feb 2026 04:23:53 -0500
X-MC-Unique: oMJTYj7_MOuMKnVxUWadnA-1
X-Mimecast-MFC-AGG-ID: oMJTYj7_MOuMKnVxUWadnA_1772184232
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E3A6195608D;
	Fri, 27 Feb 2026 09:23:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.93])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5CD91800666;
	Fri, 27 Feb 2026 09:23:45 +0000 (UTC)
Date: Fri, 27 Feb 2026 17:23:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Harry Yoo <harry.yoo@oracle.com>, Hao Li <hao.li@linux.dev>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <aaFinIsCmitHSP_c@fedora>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <5cf75a95-4bb9-48e5-af94-ef8ec02dcd4d@suse.cz>
 <724310c2-46a2-4410-8a5d-c69dcc8de35d@kernel.org>
 <aZ7BbosIr2FvZFAe@fedora>
 <c6a01f7e-c6eb-454b-9b9e-734526dd659d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6a01f7e-c6eb-454b-9b9e-734526dd659d@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Feb 26, 2026 at 07:02:11PM +0100, Vlastimil Babka (SUSE) wrote:
> On 2/25/26 10:31, Ming Lei wrote:
> > Hi Vlastimil,
> > 
> > On Wed, Feb 25, 2026 at 09:45:03AM +0100, Vlastimil Babka (SUSE) wrote:
> >> On 2/24/26 21:27, Vlastimil Babka wrote:
> >> > 
> >> > It made sense to me not to refill sheaves when we can't reclaim, but I
> >> > didn't anticipate this interaction with mempools. We could change them
> >> > but there might be others using a similar pattern. Maybe it would be for
> >> > the best to just drop that heuristic from __pcs_replace_empty_main()
> >> > (but carefully as some deadlock avoidance depends on it, we might need
> >> > to e.g. replace it with gfpflags_allow_spinning()). I'll send a patch
> >> > tomorrow to test this theory, unless someone beats me to it (feel free to).
> >> Could you try this then, please? Thanks!
> > 
> > Thanks for working on this issue!
> > 
> > Unfortunately the patch doesn't make a difference on IOPS in the perf test,
> > follows the collected perf profile on linus tree(basically 7.0-rc1 with your patch):
> 
> what about this patch in addition to the previous one? Thanks.

With the two patches, IOPS increases to 22M from 13M, but still much less than
36M which is obtained in v6.19-rc5, and slab-sheave PR follows v6.19-rc5.

Also alloc_slowpath can't be observed any more.

Follows perf profile with the two patches:


-    8.30%     0.19%  io_uring         [kernel.kallsyms]               [k] mempool_alloc_noprof
   - 8.11% mempool_alloc_noprof
      - 7.64% kmem_cache_alloc_noprof
         - 6.15% __pcs_replace_empty_main
            - 5.96% refill_sheaf
               + 5.95% refill_objects
+    8.06%     0.44%  io_uring         [kernel.kallsyms]               [k] kmem_cache_alloc_noprof
+    7.44%     0.00%  kublk            [ublk_drv]                      [k] 0xffffffffc140c71b
+    6.63%     0.03%  kublk            [kernel.kallsyms]               [k] __io_run_local_work
+    6.19%     0.05%  io_uring         [kernel.kallsyms]               [k] __pcs_replace_empty_main
-    5.97%     0.01%  io_uring         [kernel.kallsyms]               [k] refill_sheaf
   - 5.96% refill_sheaf
      - 5.95% refill_objects
         - 4.87% __refill_objects_any
            - 4.76% __refill_objects_node
                 0.72% __slab_free
         - 1.00% allocate_slab
            - 0.80% __alloc_frozen_pages_noprof
               - 0.79% get_page_from_freelist
                  + 0.72% post_alloc_hook
+    5.96%     0.02%  io_uring         [kernel.kallsyms]               [k] refill_objects


thanks,
Ming

