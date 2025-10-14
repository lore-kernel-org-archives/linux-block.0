Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9EF21D3E4
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429751; cv=none; b=ayy4mPvUEvBpC3yLLqoGdu/j4okk92SNmPgSAzO7MYs0fW1I3sop462UUoYMYqfNi3oWRa2KUrgfKjTgxkvj+zpz9ZiyjPisMY1HJODFAssxs81iWj4j80mc174WxfxvVYkpMn8fp6jJ7XWAQo0PuR7OGUgTGTLKWB0diE8G2LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429751; c=relaxed/simple;
	bh=T3VM9+nJOucKbcAUNaLY7AnPZybT97dyUiiCrlM3Of4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9PRVYZE1jLjIRuFPF7A1pY+OjIKovehbZ0JohvaehISgAKsTEsDGoOSghhioosdxahLrjbZLsSuuVmci67Jj+2i34+Yfce2NxLM/5dFgYDwAbxNXo4HxUUTDfKT1zQcABeVVrWdFGEnp32NGXd9kkZ9id1JLwt1uuJhf6x3MoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=an0bYcPf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="an0bYcPf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760429748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CRy/NLeLP/eFxKeQw3E8oGP9HZl94Z/4n7yWShfTFEg=;
	b=an0bYcPfwRtScSLw0IDieIlOGzTTdLSn20j6C7Q8LU0Yh8f/3Gq2sVFlfXkYudER2xW9Vd
	+3QU4sQVBNVvbOu6wen6QuMuq2OIuB6wphGBiMstJtGBsJJdBCGjNpLi1QqViOBAh6w+2s
	rA3/6dFjTMxhmmjdUTMFNXf3OnWIGdc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-a295BwRoPSuqjrnzznlUcw-1; Tue,
 14 Oct 2025 04:15:44 -0400
X-MC-Unique: a295BwRoPSuqjrnzznlUcw-1
X-Mimecast-MFC-AGG-ID: a295BwRoPSuqjrnzznlUcw_1760429742
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 716781800577;
	Tue, 14 Oct 2025 08:15:42 +0000 (UTC)
Received: from fedora (unknown [10.72.120.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AFEB1955F21;
	Tue, 14 Oct 2025 08:15:34 +0000 (UTC)
Date: Tue, 14 Oct 2025 16:15:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai3@huawei.com>
Cc: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com,
	axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: Re: [PATCH 4/4] blk-mq-debugfs: make blk_mq_debugfs_register_rqos()
 static
Message-ID: <aO4GoVOqVBh1RMw-@fedora>
References: <20251014022149.947800-1-yukuai3@huawei.com>
 <20251014022149.947800-5-yukuai3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014022149.947800-5-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Oct 14, 2025 at 10:21:49AM +0800, Yu Kuai wrote:
> Because it's only used inside blk-mq-debugfs.c now.

If it is true, why do you export it in 2nd patch?

Thanks, 
Ming

