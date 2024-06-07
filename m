Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABCB1384A9;
	Fri,  7 Jun 2024 04:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717736117; cv=none; b=K72/S65SxOfjugEOgpBcMDUUJSg6qqihaV9Ew53SeVC9KqAueysw76nBztNqxgx6D/opf3leO9loRTpevA1cV922KgmN/sUouT0mjhCUxLO+yr31g3WYfbcWs42S/sK7niIkyS8YDoCHsR64YBgJ3gVwEoHr1I57+fbGQ9uQCno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717736117; c=relaxed/simple;
	bh=gz8RtzH8A5MfFuxMeNTqL/qDlRxxZbKZrIKvW418tR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG0o2b6dPuMoh7rmwrlhc36Eq6/skcq6/2XxoyVcwoADvaIsw2VA7uEFCBLYfwFVR8bpdYyCzvgb0SlFlznloC3MEmfNZRHNWA/NwIIkvs7J9+RcRe2w1o1MZtBHBrZb8JKhW/WOCKbyoGH9NHYZxQ3Z11Xh3Q6r5Ku17L8KrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A0E0168B05; Fri,  7 Jun 2024 06:55:11 +0200 (CEST)
Date: Fri, 7 Jun 2024 06:55:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Friedrich Weber <f.weber@proxmox.com>, axboe@kernel.dk,
	ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhouchengming@bytedance.com,
	Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: [PATCH] block: fix request.queuelist usage in flush
Message-ID: <20240607045511.GB2857@lst.de>
References: <20240604064745.808610-1-chengming.zhou@linux.dev> <c9d03ff7-27c5-4ebd-b3f6-5a90d96f35ba@proxmox.com> <1344640f-b22d-4791-aed4-68fc62fb6e36@linux.dev> <ec27da86-b84a-430b-98aa-9971f90c8c87@proxmox.com> <7193e02e-7347-48db-b1a0-67b44730480b@proxmox.com> <448721f2-8e0b-4c5a-9764-bde65a5ee981@linux.dev> <343166f4-ac11-4f0e-ad13-6dc14dbf573d@proxmox.com> <dea87c0a-1c36-4737-bea5-cb7fa273b724@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dea87c0a-1c36-4737-bea5-cb7fa273b724@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 07, 2024 at 10:37:58AM +0800, Chengming Zhou wrote:
> Yeah, right, it seems LVM may create this special request that only has
> PREFLUSH | POSTFLUSH without any DATA, goes into the flush state machine.
> Then, cause the request double list_add_tail() without list_del_init().
> I don't know the reason behind it, but well, it's allowable in the current
> flush code.

PREFLUSH | POSTFLUSH is a weird invalid format.  We'll need to fix this
in dm, and probably also catch it in the block layer submission path.

