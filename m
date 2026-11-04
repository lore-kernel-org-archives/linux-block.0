Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776631;
	b=X+wRZMKeL/9gAVl6cHWKYOSsgyUEUFaIEAAftvEo1RO0+0P7VgRpxafIijd0VDfmG7MV
	 FTYtoKd0a8GGM3iWqG6pQ5kXalFBOlqK9myseVJjvztgH9nfNTOWA0LtZw9iQnMO8k65P
	 2GjaCS6RV96eiDDfibnsh7v+bngHMclWbfzcQ6cKfhFDHPIvBKXR4ZkatNrub0ztmWwy/
	 p6tNRHoguCJsmdKSv0E+fL5NsGhpO9znXCh7iSXh1k24smB41ialKiX433qUMj8bJ44GV
	 ZZxWwaGjBG8JCw/TSDufRxtseFGUzcZgHYtTwtcvAAL8RasPVn2P0bkJcK90RJIKIrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776631;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=CQTCeZqbhnIGeurfVoO3U6+eh5QntykGwlsWYRX83A0=;
	b=I0RMpeq9p2WdK6GsE3pC8IDB1vA2jsbNVh3P+AL+R7kKw49fiSN6pon3V/dI45lUPv8T
	 XbzaZxWBChqWuoF+eRiyoAi2AMA0p8kPQ5PnTu3TnJi6jHL9C1WUjrSCl7RhCiIbvWGNU
	 Ywx1afY2P2ZKM3gmCx9ZSrj9mTYG0oZyV91LVmno3eg1EdL8qvPw+uwEoOp3F2nc0rluN
	 js17JOjm5F9+3vgutGBSXVPa5ZG/hJecCMICyXg/2U+Q0ttLH38DUsdWD6V4f3UkL9e73
	 sSeA08cIA4Sp/B4V7agsGeYfA/3eQmbbGEWvT5CqOe0EYCQsg0XQ+jI1+1cYsoh7RCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F080606D832;
	Wed,  4 Nov 2026 07:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F080606D832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8613B68BFE; Wed,  4 Nov 2026 08:17:03 +0100 (CET)
Date: Wed, 4 Nov 2026 08:17:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
	Surabhi Gogte <sgogte@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: use a housekeeping CPU for passthrough
 requests on isolated hctxs
Message-ID: <20261104071703.GC28939@lst.de>
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de> <20261103163748.qDpZjKj8@linutronix.de>
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
In-Reply-To: <20261103163748.qDpZjKj8@linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 03, 2026 at 05:37:48PM +0100, Sebastian Andrzej Siewior wrote:
> What about
> 	guard(rcu);
> 	for_each_cpu_and(cpu, cpu_online_mask, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)) {
> 		if (!cpu_is_isolated(cpu)
> 			break;
> 	}
> 
> this ends up with one less function call ;)

Please avoid this completely unreadable and unaditable guard crap.

How is anyone supposed to understand that above mess?

