Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEFE35EB84
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 03:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746501506; cv=none; b=rAsMeqZHTQ4ImNgBAkcVby9Ny9+cEPxBYID7gLB9CXZPxi0EfQz1v2rFiLS1m3em/jdWgxOnFV7gR+keKzQM4h21sLGiB/3Qc79jQkjP2YW5Kg9aycYmGfdyyy91KkRknKfd5S4TvJRyLlZGnYrdtv4riCnXH+pL/mLAZgUoNfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746501506; c=relaxed/simple;
	bh=hRLVacyamiMBXkbrXkozw5cwrH3nRoNQATSfeWPw/rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdUOJiIgehU0s7bBMkzh/s/Bg8QxfkwY64KiqusskSKbYaMz9t5T0arjx4MF5Tm359DpSDCKXOno1iLEWEqLUfMfoaURw0lhNbxeIT7Bp4MfER4NtPkP8POkoahmGIuhkEnrLJjyK97RBNQs94BPPWnHov8tVbDoP0BNpKeaMyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6imc79O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6imc79O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746501502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sch28xP6WEwnIvUBxG3RgJ58EIQ3AtVfphEVYn+3Nl4=;
	b=d6imc79OlXHYPfsLOEjrVtuypqWD57mqeIVkRt92TCtlyRdSkZBQgeeCk3BhG4tKUfJ8JX
	WoSOO6Q0HjJvxAdidbQAOe4C6RNyxNGKFYnSxP6VbAIUpW1NtkKU1ScM0NH1RBSuuV+A8b
	Qrl5Jxv8b6Rextlfo73Y+pFYYM47DaA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-nA-B1ofkMX2faPg98ufcOw-1; Mon,
 05 May 2025 23:18:18 -0400
X-MC-Unique: nA-B1ofkMX2faPg98ufcOw-1
X-Mimecast-MFC-AGG-ID: nA-B1ofkMX2faPg98ufcOw_1746501496
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8EC7180048E;
	Tue,  6 May 2025 03:18:15 +0000 (UTC)
Received: from fedora (unknown [10.72.116.13])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44F2A19560A3;
	Tue,  6 May 2025 03:18:02 +0000 (UTC)
Date: Tue, 6 May 2025 11:17:58 +0800
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
Subject: Re: [PATCH v6 0/9] blk: honor isolcpus configuration
Message-ID: <aBl_Zn7aHbUTmPSE@fedora>
References: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Apr 24, 2025 at 08:19:39PM +0200, Daniel Wagner wrote:
> I've added back the isolcpus io_queue agrument. This avoids any semantic
> changes of managed_irq.

IMO, this is correct thing to do.

> I don't like it but I haven't found a
> better way to deal with it. Ming clearly stated managed_irq should not
> change.

Precisely, we can't cause io hang and break existing managed_irq applications,
especially you know there isn't kernel solution for it, same for v5, v6 or
whatever.

I will look at v6 this week.

Thanks, 
Ming

