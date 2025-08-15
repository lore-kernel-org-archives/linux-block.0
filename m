Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F3A1F03EF
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755269294; cv=none; b=GM+eSLRfuM0+QD+ykOqN26v6U+Bna2PAvDafRepTbW7EHrhmGWo3BiR7twbTTzBWeCK3mkIJ8VbgVcmWBYZc/1AgshPMHlhChM0thtqUlNLPs8ho5YMZBVA8CCglsONfcFvleGiZG9PjlYD9paLb5DXnFQdA/arg8Bew2u/8ylU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755269294; c=relaxed/simple;
	bh=6p3tH5dyDYB5dW9LDS2LWwvBo8AewBArfanZDC9eIx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lx3TuB+ITgMwlwBzfBytqUSXnGKQsLffX55MSMS7fROYTZkVf+m1jDC1u2rbBT4ewqTdGsI2xqD1AbFfFfWzRs3Y9Scd2+oJX1gkZbVTRv2j1i5HX0/k9l9BPkshCzBAnyHK+o+/TWbdHeijTyQXxp1lr2goxP0JXzlRhPT/Uec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehRxM/WU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehRxM/WU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755269291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0lsi7uNi+Pjd1zai/fmB5p40xmZGFkcZlTsakj032U=;
	b=ehRxM/WUp209Nr0OdoS+8c8Db+5bjviPq9/2h1GoPGV80miySrMMSXTXy9IL7B3eAGtCYt
	kpRBkiyj4R10/p9erXOLd0TVJY8egH+TeoJdWFzrsmT75n21a86lw7+adhXLpkGwVztf8e
	PBsFKNmrq4ch8zxVT4H0UjYsF5mA/wM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-GSw4hUj6M9W3qPpdmb6ZOQ-1; Fri,
 15 Aug 2025 10:48:07 -0400
X-MC-Unique: GSw4hUj6M9W3qPpdmb6ZOQ-1
X-Mimecast-MFC-AGG-ID: GSw4hUj6M9W3qPpdmb6ZOQ_1755269285
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22526180035F;
	Fri, 15 Aug 2025 14:48:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.16])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A17541955E89;
	Fri, 15 Aug 2025 14:47:56 +0000 (UTC)
Date: Fri, 15 Aug 2025 22:47:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, hare@suse.de, nilay@linux.ibm.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: Re: [PATCH 04/10] blk-mq: serialize updating nr_requests with
 update_nr_hwq_lock
Message-ID: <aJ9IkylydqSNZqwC@fedora>
References: <20250815080216.410665-1-yukuai1@huaweicloud.com>
 <20250815080216.410665-5-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815080216.410665-5-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Aug 15, 2025 at 04:02:10PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> request_queue->nr_requests can be changed by:
> 
> a) switching elevator by update nr_hw_queues
> b) switching elevator by elevator sysfs attribute
> c) configue queue sysfs attribute nr_requests

 ->elevator_lock is grabbed for updating ->nr_requests except for queue
initialization, so what is the real problem you are trying to solve?


Thanks,
Ming

