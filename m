Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776658;
	b=q/Wla2+ia8e6uww1lXme0OvCeET4x/hE2Rxd7cC4EZ1ag0kfu1XFsyx5HBkCFAJPgUhC
	 tjRh9dbq1hdU2exuqnEgvuhTOz13DndH/tfaiPaWWyxxz3AnzN9VG5gmqAGkwOetamuF5
	 Sv58OCn7wPMpWvm3DFSATp5WH0eilz8X4GW+W5oTnsdtYsvCUfnJHz/MTzEx2MY+cx46C
	 UOWFaQgahLlHhSW6RXUkC0iNtzWn/RSRg7nsp2XDw5rrFVybvkHJhcWeV5096SNENaUS9
	 cTMf0lZ5IWBVcQ8ewX4S9ZDvHqkpre1FmSkNL7iTRcC7+Rlu66ZgFssPRqlcWh30/Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776658;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=FJJzg/LnnmT+QruiWGNJiGUDb82o5kKQ/1s3RDmxk4nP6zJDNrLhPqLU1vv67u00RvZr
	 iUX1w47L7ar87qGzS3npfDbN2HMdOrQxdJ5HBw7N8e9J2mr/eiEe7JAQSXQsoxWeo/LZJ
	 rzmYMPNzEwVs7Tp3y4FV1dvBhV+GYhCQFzorXdoMsd3qmdOMfaEwXJRdh7yyilzZxhMbs
	 JbU4sXNPnbLNrVD0c5wiyNwP5qlm7UWRiBAUt3YAV2lwUEai5XAr6BkTn7HtKcMEAJFER
	 ds6ybkIXUIZJdOSsvxiXTQ0SHOihMglia/Wl7kJgJw3AvD5liox1Xt7wOvCF1Bf9mPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E75F606A326;
	Wed,  4 Nov 2026 07:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E75F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0AFCD68BEB; Wed,  4 Nov 2026 08:17:34 +0100 (CET)
Date: Wed, 4 Nov 2026 08:17:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>,
	Surabhi Gogte <sgogte@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: use a housekeeping CPU for passthrough
 requests on isolated hctxs
Message-ID: <20261104071733.GD28939@lst.de>
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

