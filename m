Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778361;
	b=oyNwfJSxYhP+aMQEQRVCqaa/MddaLiKTo/H03Ii6rfwdZ/Iv3lNCH2Lv3UCFkVFTGO3p
	 idNz204QyS5TJZfr2l0O9l89VkNHm1Oj/gvuc+ITd4aiKkntAqnrq4iAn9apz4lTa+lPV
	 vRUpgZRv2lhZTdgqMGInqKbjFnrvttw294fxaxzglc3kLTm/PPbkjfwzQT2Hgl9ecCbDE
	 jMXbM7QeqCIQb76atCpVNj0day2I6MDdGbD0WCeBK5Umt4CzHJ/1IHd9UApTH/iDbiB2j
	 a3lLICbdOCj5E/RLgoE2KFwO2Vz7L0Bpsu9YpmbLVYNUN7E+aT33SYrgc456VWdcOWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778361;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=KJsQjtz5oT6PM9pXKEz3tHUWBZ19ymJyMqMLPOKPx7k=;
	b=Mj9EM4C2ck1DwJitOfShQ8s5bZzaKUVpQsLScpzBAtdP3IluPox6qzaKOqIt8CDIsYKw
	 k0UcECZLtmtwaJH0JU7hpFO2A0fY+VtwIDUYb2MCY3T9lzhLFKOWjcj+rFOrcm4Ov7QZf
	 WqRHAGJL9elRsqn3/VS/pF7X9nuwwuy20twbqkpUQqCdADIHmswVrDZkjfSYkh6+Tt97X
	 pVjr9oxnqYS7Ta9zfU4pibNCw6qBn/In/7M/1UqxFhEQxjbTW5+vb5jkwvlbQg1XJZMW2
	 WkC2jPkSvg54aFHYfJcWfYrzMGdT4eq7zsWBT/cakr99nfq+fDgB/e+9dd+YxT1+NfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34994606A326;
	Wed,  4 Nov 2026 07:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34994606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C959C68BEB; Wed,  4 Nov 2026 08:45:54 +0100 (CET)
Date: Wed, 4 Nov 2026 08:45:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <20261104074554.GA29620@lst.de>
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de> <20261103163748.qDpZjKj8@linutronix.de> <20261104071703.GC28939@lst.de> <20261104073710.kTUsM3JV@linutronix.de>
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
In-Reply-To: <20261104073710.kTUsM3JV@linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 04, 2026 at 08:37:10AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-11-04 08:17:03 [+0100], Christoph Hellwig wrote:
> > On Tue, Nov 03, 2026 at 05:37:48PM +0100, Sebastian Andrzej Siewior wrote:
> > > What about
> > > 	guard(rcu);
> > > 	for_each_cpu_and(cpu, cpu_online_mask, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)) {
> > > 		if (!cpu_is_isolated(cpu)
> > > 			break;
> > > 	}
> > > 
> > > this ends up with one less function call ;)
> > 
> > Please avoid this completely unreadable and unaditable guard crap.
> 
> If you/ block prefers to avoid guard() then fine. I usually get punched
> the other way around.
> 
> > How is anyone supposed to understand that above mess?
> 
> I can show you code where you start crying.

I don't cry easily, but I've basically given up trying to understand
or fix code infested too much by at and other CLASS/__cleanup magic
like the core VFS code, because my brain can't cope with it...

> Anyway. My main selling
> point was for_each_cpu_and().

I guess the advantage would be to reduce the iteration, so it's 
probably ok.  I don't find it particularly easier to read, and given
that this is a slow path it might not matter.

