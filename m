Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C98158862
	for <linux-block@vger.kernel.org>; Thu, 24 Oct 2024 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729752242; cv=none; b=TWnbpG+XtE+QgvuEsQeqmd+Xr0jO1gUQ7z8r1Ckhkmwe6WmGzpPOsKUnj+uDXLbauQ2UfFLwoqlnQ9w4saa73uzTbX9oJj5zf3BcAYsho5e5cCsVMyoCNYs823+VZnMuMxgHv87+fiMazOm8idJX47AZeR8P3gQ37YFkppFQIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729752242; c=relaxed/simple;
	bh=7qwxY+MjcwxNSeEVG+Jw2X+n5rwsZ26Qy/PSYiV69XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1ZbqgwD6Q4V6CPH17rkfYE3veFiqKL2Ha2j21+Q637WDgw4iWvqHZWzxikMPBeirGedNarjcagYscTBJBHZoI4IUEI+QQ3jjdD7cl+a3Dh6JTKG5p5dqMVo/mzX03sM818INYZe+xKq/uCBuwhAIiCzhPmlfP3wgavgXMdTbCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHgk7u8Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHgk7u8Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729752240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wZTcf9FaJs3vSECpIGbKVXH4nMxTQvdG2R4odgw5TYI=;
	b=QHgk7u8YRZZ9+bHjp9L0wsxVodN0oTCFQzmZPF0UX3HbA616hXBeRrAVnLJx8udU1yYNZH
	5IQIr4qvua3pAjoudqIDwkvonE43kc7LYAukxmmo4SeKbj7VxVGtr5r4DR7AhmEmAMQUwC
	VxRw5A5RsDHJH/j6x2Hcdr9nH2N1fJk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-67DGZ8xSN-S6Oxh1Q8U5Jw-1; Thu,
 24 Oct 2024 02:43:52 -0400
X-MC-Unique: 67DGZ8xSN-S6Oxh1Q8U5Jw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D595E19560B5;
	Thu, 24 Oct 2024 06:43:50 +0000 (UTC)
Received: from fedora (unknown [10.72.116.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D05B21956056;
	Thu, 24 Oct 2024 06:43:43 +0000 (UTC)
Date: Thu, 24 Oct 2024 14:43:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 2/3] nvme: core: switch to non_owner variant of
 start_freeze/unfreeze queue
Message-ID: <Zxnsmsunc9848hkK@fedora>
References: <20241023095438.3451156-1-ming.lei@redhat.com>
 <20241023095438.3451156-3-ming.lei@redhat.com>
 <20241023122115.GB28777@lst.de>
 <ZxmmPKFksWc5LLlc@fedora>
 <20241024050053.GA30659@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024050053.GA30659@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Oct 24, 2024 at 07:00:53AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 24, 2024 at 09:43:24AM +0800, Ming Lei wrote:
> > > so that it's clear why the non_owner version is used here.
> > 
> > There are one more such usage: 
> > 
> > - freeze in nvme_dev_disable()/apple_nvme_disable() from timeout work, but
> > unfreeze in nvme_reset_work()
> 
> Then add it to the comment :)

OK, also nvme_passthru_start() and nvme_passthru_end() are always
paired, so they are actually not non_owner use.


Thanks, 
Ming

