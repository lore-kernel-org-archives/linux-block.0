Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DA1242D86
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779520; cv=none; b=WxufVO6v/qdLMgF5dMsZl3RzpGAg24CmVpddbaLTzgk+D7CnMWAOHP+7fR/FGkZvGw4VVaOjLbDv86t3xX8vWFlWHyF4PgZH1vNfS2DQEaQI0UkqVVdyua7p92k4/cqJ1MRqJY6Sw7tCOleAUZpgc6dc4xoLKbya2ld9C2n7m7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779520; c=relaxed/simple;
	bh=jdz0o0urwZmUnHwveYOjjm4Yz4K6rXgJxGqwUPqvOK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AskvMLXArbnupkuMUPpsyg/zmytRvFIQQHi9AaUg5CCzDQ4bdl2/gSZ8hbtMWpY+9ittOgfwHXkneSyFlmpDI212A9MGXXVG7Tj8+TpSVAhnN7ZtaHcetKDh23EVNNhV9xeCEPByZiY3xtF+9Xf/L+kn1BtUnttx4SxxUrqHn6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMepUsvl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMepUsvl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767779517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LnSBrxLAnPXKZLwC7Spc0VLX8/60a4bqytd6sHe2c3w=;
	b=ZMepUsvlFKFWnUsuDLn3zC+KHSd32huJqOqPbDqOhky9eCkrERzzKhO1efbj+TlGn3WCIm
	BQM9XsMnEAFG7MW03tp3aXvgi88Wi29oVzSpmdZEV+4BjSaBOKijNERieXkHlpu4EAP3wP
	x7aYd/bZ2DO25K89M2rgnlHlh4sbWQY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-0_cQ5g-cPWycIUjONa7eGQ-1; Wed,
 07 Jan 2026 04:51:54 -0500
X-MC-Unique: 0_cQ5g-cPWycIUjONa7eGQ-1
X-Mimecast-MFC-AGG-ID: 0_cQ5g-cPWycIUjONa7eGQ_1767779513
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F60119560A3;
	Wed,  7 Jan 2026 09:51:53 +0000 (UTC)
Received: from fedora (unknown [10.72.116.199])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C21630002D5;
	Wed,  7 Jan 2026 09:51:49 +0000 (UTC)
Date: Wed, 7 Jan 2026 17:51:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH v7 07/16] blk-mq-debugfs: add missing debugfs_mutex in
 blk_mq_debugfs_register_hctxs()
Message-ID: <aV4ssM18Ro-UMGPX@fedora>
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-8-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231085126.205310-8-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Dec 31, 2025 at 04:51:17PM +0800, Yu Kuai wrote:
> In blk_mq_update_nr_hw_queues(), debugfs_mutex is not held while
> creating debugfs entries for hctxs. Hence add debugfs_mutex there,
> it's safe because queue is not frozen.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks, 
Ming

