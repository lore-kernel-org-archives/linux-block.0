Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80542746A
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 00:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755045730; cv=none; b=sZc46EiwGWkC9SGZG6W2TouT0Uzl8ZcN6oleCC4vRag1rLs1VR5qwPHW9G3nXTtJoDfSXSODAXbLkqAzet9mohK/hlaWRJL78tGKX0aSRvPQkAMYemIH+Sc1JCQYnhrZSX0vulGm9zroX4Sjkl9tc6yY6yK5aFxZZ5x+jq5BDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755045730; c=relaxed/simple;
	bh=GXpi3N3O0M/G/4BsOlPxvL3xtLdCY8DywwgqosRXRwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWFivFyVHJInljd1lWb7C9nKAzYY1pouTtDryv6qAmAAKq28pnmKHR6gVJ+4xiQvFtyWE2SqeWPMElWmfmXeOmoBdlnoR0+l/NrWICI7dYSMxuer519aiIOCiZCAuo4qNOJNFKk/USVV1Bf9v1aJoCvnU5ZjwzsAHGoF80loaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCDUl2Bw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCDUl2Bw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755045727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PawZG/JlRR9XxpxWtLNSI+ORsMCVS4AlgAjYNNgDJx4=;
	b=XCDUl2BwmPpYi18MkdcbJ5z5YgrnznAY1lY6P+0N+B/tPma4qmoITNODcdcO1fRffIp/F/
	VgCTvE8qiNxwOZoxdLjBsDDKKRYJsrp/2sDkeHnJHiRVDSPoLVoyTHa2nzd40b2tAV3amm
	Mg639SYMOZmkUwkmVdIlTjRqpWCf8Ic=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-ZFhffxHwOX2un3Qzg_BNeQ-1; Tue,
 12 Aug 2025 20:42:04 -0400
X-MC-Unique: ZFhffxHwOX2un3Qzg_BNeQ-1
X-Mimecast-MFC-AGG-ID: ZFhffxHwOX2un3Qzg_BNeQ_1755045723
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CE491956048;
	Wed, 13 Aug 2025 00:42:03 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9172619560B5;
	Wed, 13 Aug 2025 00:41:58 +0000 (UTC)
Date: Wed, 13 Aug 2025 08:41:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, nilay@linux.ibm.com,
	Julian Sun <sunjunchao@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] block: restore default wbt enablement
Message-ID: <aJvfUVcsbxzsMB2m@fedora>
References: <20250812154257.57540-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812154257.57540-1-sunjunchao@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Aug 12, 2025 at 11:42:57PM +0800, Julian Sun wrote:
> The commit 245618f8e45f ("block: protect wbt_lat_usec using
> q->elevator_lock") protected wbt_enable_default() with
> q->elevator_lock; however, it also placed wbt_enable_default()
> before blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);, resulting
> in wbt failing to be enabled.
> 
> Moreover, the protection of wbt_enable_default() by q->elevator_lock
> was removed in commit 78c271344b6f ("block: move wbt_enable_default()
> out of queue freezing from sched ->exit()"), so we can directly fix
> this issue by placing wbt_enable_default() after
> blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);.
> 
> Additionally, this issue also causes the inability to read the
> wbt_lat_usec file, and the scenario is as follows:
> 
> root@q:/sys/block/sda/queue# cat wbt_lat_usec
> cat: wbt_lat_usec: Invalid argument
> 
> root@q:/data00/sjc/linux# ls /sys/kernel/debug/block/sda/rqos
> cannot access '/sys/kernel/debug/block/sda/rqos': No such file or directory
> 
> root@q:/data00/sjc/linux# find /sys -name wbt
> /sys/kernel/debug/tracing/events/wbt
> 
> After testing with this patch, wbt can be enabled normally.
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> Cc: stable@vger.kernel.org
> Fixes: 245618f8e45f ("block: protect wbt_lat_usec using q->elevator_lock")

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

