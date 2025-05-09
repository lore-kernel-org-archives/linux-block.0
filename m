Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D213632B
	for <linux-block@vger.kernel.org>; Fri,  9 May 2025 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746755279; cv=none; b=qSMyg+w3fWxCBg3pCZ4+HiFU3nQh6Wp2PVwYPCncvYNN8sibMQc7+0PGVdmGQzKGp5d6aGvFrqWXtk4LAfod6/qu1UU4qLKk3N8kwy7MboEzdZTU27uciMr4QKr3gVQt5i9c3cdl/FW0aZEFSvGEKxT+0m+yB2ykPhqvCeT0pIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746755279; c=relaxed/simple;
	bh=wQLJy9Qh5QOD9K8pmPnScaOgCjMtssjlSOcdbdhHXNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvKKMq/jH+m55dx4juotNWYtnuuj7ct5bFCLywvKo/kCDhd6GW4Sp6Tu6DTUTL/PrnueJIKbtiZaHEoqRnFduvfNcaxlI0iPH6RrGmdp5Ess5mvFpZlotzzpDOlpGtHsAHHWHt4A/4lVPV7w4CAvz6vqGtBOoClSB/cErAA+CSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eajq+VnR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eajq+VnR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746755276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpLET85xvvawA9Cb+7wJCp6SaHgcQvrJdv4KKKiwq+c=;
	b=Eajq+VnRHQKpuZsrXFndhOTrSpK3K5q4w8CLFq7FuHN2uEEmZU7riKublI4cQnbkNAMriD
	ZcPGaUZNB+OsRrs7Pkb5YBaygE9Ty+eYFouf2TMsJN2XF3qichTtpBI/Xu0a7mL/c1cxvy
	nCfnWRr9EqzGomOBjK7sQN2GCQ5n6/Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-bDcLcTtrM-2ea5CWOlKyag-1; Thu,
 08 May 2025 21:47:54 -0400
X-MC-Unique: bDcLcTtrM-2ea5CWOlKyag-1
X-Mimecast-MFC-AGG-ID: bDcLcTtrM-2ea5CWOlKyag_1746755269
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE6AB1956087;
	Fri,  9 May 2025 01:47:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.120])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E5601956055;
	Fri,  9 May 2025 01:47:35 +0000 (UTC)
Date: Fri, 9 May 2025 09:47:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, storagedev@microchip.com,
	virtualization@lists.linux.dev,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v6 3/9] nvme-pci: use block layer helpers to calculate
 num of queues
Message-ID: <aB1eswAv6Tz2WDpc@fedora>
References: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
 <20250424-isolcpus-io-queues-v6-3-9a53a870ca1f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-isolcpus-io-queues-v6-3-9a53a870ca1f@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Apr 24, 2025 at 08:19:42PM +0200, Daniel Wagner wrote:
> Multiqueue devices should only allocate queues for the housekeeping CPUs
> when isolcpus=io_queue is set. This avoids that the isolated CPUs get
> disturbed with OS workload.

The commit log needs to be updated:

- io_queue isn't introduced yet

- this patch can only reduce nr_hw_queues, and queue mapping isn't changed
yet, so nothing to do with

 "This avoids that the isolated CPUs get disturbed with OS workload"


Thanks, 
Ming

