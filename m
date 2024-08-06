Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7D71D61B8
	for <linux-block@vger.kernel.org>; Tue,  6 Aug 2024 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955780; cv=none; b=MJkTdBnIROJ+J4gdJOmlZXakipD27Oen9zKkQGU1ED3U9DXO+RB6bRQF1g1+8VTRjfQwvhnv9wR2I5WGHukX++1++7W++tTi+hnntSFfWVF3fzOUGbR3Y6J/z1pbojKqtJH4TU0EwUMMbGVrV3VxrK0QcCIiwl/4jUnguNRHx9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955780; c=relaxed/simple;
	bh=mnKji4X1IF1oWVxStSjRy7i5+pY/OgANqpsjHYhRrbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pspOnk7ajJ+tWM9d1dRRGh8XmY7jM+gtBDVYpsEpNXTfsINs3/RfATRQBwIIiUzATSqjNNqr1C6l8fT/6fusVn58UCiZWrjbdgFIYJSeRBZ+xwN0bAr+1yDcfpp5VKlC4Ac2QLeQ0+mn51zMZsHjO+0t4MLV5oIyUWSE/lihFvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHSEk4LR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHSEk4LR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722955777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zzoZal/wdbh0kOVIOHjUz7WBhOwU4qtFbcRSNDHu/8=;
	b=CHSEk4LR2DuynT8/YgMyBhsL9cNQUyk2tPkmQ761uzNFZ3LpAAT9h2ZxB4x0CqyACyHRpW
	6LgI6+Zch4gADMWYS7NAO7EZv08RwwNFULyL+KyPnScnCHuqyx6nZIAY6MzfqZjK+/J9lN
	EfQKuBkV/03thfWZSLfvHZYugglEDcQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-91ca1en1NQOnYP0mtFQOcg-1; Tue,
 06 Aug 2024 10:49:33 -0400
X-MC-Unique: 91ca1en1NQOnYP0mtFQOcg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59D391944AB4;
	Tue,  6 Aug 2024 14:49:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A129F1955F40;
	Tue,  6 Aug 2024 14:48:02 +0000 (UTC)
Date: Tue, 6 Aug 2024 22:47:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Jonathan Corbet <corbet@lwn.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, virtualization@lists.linux.dev,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 14/15] lib/group_cpus.c: honor housekeeping config
 when grouping CPUs
Message-ID: <ZrI3nOim6Aw9S3H0@fedora>
References: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de>
 <20240806-isolcpus-io-queues-v3-14-da0eecfeaf8b@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806-isolcpus-io-queues-v3-14-da0eecfeaf8b@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Aug 06, 2024 at 02:06:46PM +0200, Daniel Wagner wrote:
> group_cpus_evenly distributes all present CPUs into groups. This ignores
> the isolcpus configuration and assigns isolated CPUs into the groups.
> 
> Make group_cpus_evenly aware of isolcpus configuration and use the
> housekeeping CPU mask as base for distributing the available CPUs into
> groups.
> 
> Fixes: 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed interrupts")

This patch fixes nothing on commit 11ea68f553e2, please remove the above
Fixes tag.


Thanks,
Ming

