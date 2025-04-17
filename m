Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E5E19DF75
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 02:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744857296; cv=none; b=MHiJz3Q5/kVbB9LNcmSe7aZlQBwQzUZD63aR8wPKLmmyhgDyprt834fm4xnU43TBT6s+SPqZ3L9ta3AlRnMRHzr4+qcXMTPaE1sqdhO5Qf+3PhIy52MY5WlQyNK+i2kBsdsdnxTo+u/YIQtqNElm+2gQGBNn45Yu+9zK/n1zq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744857296; c=relaxed/simple;
	bh=X7HvDZl2+FHdPyMNMyxH82P1e141BwUbSTy6TCCxx3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkHIL73u3xGqd4toQbA7kI+vcyrTQNYvU217ADPRwu3eTsI19c0v8ljd4/tbBBHtR/3tXP/JZPw8TC6U/SmS1v4Nfbhwpi3r3/Y9sBW0R8SZJmgjT1dv8xpbQV+S6ZJM9zBjz5mlzGkF3rPCQfl3Pc0SZuiCIz5wKKTF1SC/tcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ull4izG5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ull4izG5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744857294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZKbyHc0Cl+oVOTotourtqo+isdQB2ExSoV5izW7iCw=;
	b=Ull4izG5HMAKCBfAyLZ0JclmDvKjbgyz+HadTCYENa9Pmj1kcIwrEJ//ewq/zcXq3UOgPW
	9G3qtc+KQ76pxvhu7mu5kpcAg0+mZoHVoxNXl/4cK69Z6KR2ebZQICTmX1Z8CsCgX6asq5
	eU7rZU/jVKXGCOPm5uPyUnBJEFFsEp4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-IK7gYm2dPKWLInR4Mf0B_w-1; Wed,
 16 Apr 2025 22:34:50 -0400
X-MC-Unique: IK7gYm2dPKWLInR4Mf0B_w-1
X-Mimecast-MFC-AGG-ID: IK7gYm2dPKWLInR4Mf0B_w_1744857289
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA76519560BD;
	Thu, 17 Apr 2025 02:34:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.90])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF9ED19560A3;
	Thu, 17 Apr 2025 02:34:44 +0000 (UTC)
Date: Thu, 17 Apr 2025 10:34:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, yangerkun@huawei.com,
	yukuai3@huawei.com, tj@kernel.org
Subject: Re: [PATCH 2/3] blk-throttle: Delete unnecessary carryover-related
 fields from throtl_grp
Message-ID: <aABovTv568BjFng5@fedora>
References: <20250417015033.512940-1-wozizhi@huawei.com>
 <20250417015033.512940-3-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417015033.512940-3-wozizhi@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Apr 17, 2025 at 09:50:32AM +0800, Zizhi Wo wrote:
> We no longer need carryover_[bytes/ios] in tg, so it is removed. The
> related comments about carryover in tg are also merged into
> [bytes/io]_disp, and modify other related comments.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

