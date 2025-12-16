Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8732EDD5F
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765880425; cv=none; b=XnaMppyuwijutYLepqCiotTJERJeOkcjWXtH0sZdPdAOVuZxvmIbcyNfSJnfIktg4eC2iEox7vNN538hn7fyVuePzu8qbS4/NLU+tTz/CiJ920VknAt4nwVhnrn6e6YcS7hckg99atlvHrAtuzhLooGGXjPK30jV8JMnT8zwOQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765880425; c=relaxed/simple;
	bh=pyCozNQdE9mDk2EYEF2rjO/+ZR3RghoIu54YiDjsXs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLF0UG366YFvV+gb5vGRVPftb0FifPnDCVDO7B09E2BpzAQubcjzL0/F0ELN6sci1r/xdYYEcRSMATNJxUlql0Oa7KjktZSn7UuVYA180qytH2U+aEWXCJ3/5Bj8+jzBfcLNSbbvcGfsDIvhYdgDAKPS1gF+3N5Kud57A2aGwr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxw8UR/2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxw8UR/2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765880423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ov9IWOhALcXH5ofxLW6tvdz1k6bgc6W7nUE5Ummv7oo=;
	b=bxw8UR/28w/lJqJ28CaF9xV1CPD9LVsJnBpdI1LUOjhEdZeID4MIDEM5c7Y9V0b8f+R8h+
	wTegX9NKOHwKyXDDZeM8uvC7jQuDonmoccIdFFTRKAe2gCIf5AFRY9KQ3z7wGRGjwbOXYK
	wlDQDTRpmQPjMmB82zSNUY1L50tS8bQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-X4GUo7-lM_qChwzrF_yRbw-1; Tue,
 16 Dec 2025 05:20:08 -0500
X-MC-Unique: X4GUo7-lM_qChwzrF_yRbw-1
X-Mimecast-MFC-AGG-ID: X4GUo7-lM_qChwzrF_yRbw_1765880407
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96CA41956050;
	Tue, 16 Dec 2025 10:20:07 +0000 (UTC)
Received: from fedora (unknown [10.72.116.190])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 717A21955F21;
	Tue, 16 Dec 2025 10:20:02 +0000 (UTC)
Date: Tue, 16 Dec 2025 18:19:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH v5 01/13] blk-wbt: factor out a helper wbt_set_lat()
Message-ID: <aUEyTqYFted1Lcb0@fedora>
References: <20251214101409.1723751-1-yukuai@fnnas.com>
 <20251214101409.1723751-2-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214101409.1723751-2-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sun, Dec 14, 2025 at 06:13:56PM +0800, Yu Kuai wrote:
> To move implementation details inside blk-wbt.c, prepare to fix possible
> deadlock to call wbt_init() while queue is frozen in the next patch.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

