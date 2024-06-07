Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F332D600;
	Fri,  7 Jun 2024 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717741869; cv=none; b=rqSQeHxCiO+zj64VZGMogre2fgcoaoRegnF3xfXWfwI14sqChntwd8U147cbAYIgd9ppnhtmNzp+5pbslQ6ZRn42u1ovCFmvLsr+EmVSX3QrZRTvhSpmYavwoGKksOnCayX5zDbZtIGgLU7Jo0g8beFIaiouiMHhSYmh1EMomdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717741869; c=relaxed/simple;
	bh=R/4sV2NH7010oXB5VJ/YwKEMXoOnygh4XZn0DtPUoEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSBL7OeKO4+TskkwKZuLWIk3VVNG+rkPvF5vYgRxEjavBVWSWhvK2vngpTNaR9QjHcjsUf3pn1s0neCgW0TulC/gm3a/7jvyzwt3W2/DLqZmqzcsVfSU7i4lBFQAMV9RX1QSl65y+2TwlY8OsswI4vTyj308XUgJRIYLlIJNmX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E9AF668B05; Fri,  7 Jun 2024 08:31:01 +0200 (CEST)
Date: Fri, 7 Jun 2024 08:31:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, Friedrich Weber <f.weber@proxmox.com>,
	axboe@kernel.dk, ming.lei@redhat.com, bvanassche@acm.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhouchengming@bytedance.com,
	Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: [PATCH] block: fix request.queuelist usage in flush
Message-ID: <20240607063101.GA5387@lst.de>
References: <20240604064745.808610-1-chengming.zhou@linux.dev> <c9d03ff7-27c5-4ebd-b3f6-5a90d96f35ba@proxmox.com> <1344640f-b22d-4791-aed4-68fc62fb6e36@linux.dev> <ec27da86-b84a-430b-98aa-9971f90c8c87@proxmox.com> <7193e02e-7347-48db-b1a0-67b44730480b@proxmox.com> <448721f2-8e0b-4c5a-9764-bde65a5ee981@linux.dev> <343166f4-ac11-4f0e-ad13-6dc14dbf573d@proxmox.com> <dea87c0a-1c36-4737-bea5-cb7fa273b724@linux.dev> <20240607045511.GB2857@lst.de> <2223bbb9-8bc8-4566-9c3f-ef6103422068@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2223bbb9-8bc8-4566-9c3f-ef6103422068@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 07, 2024 at 02:24:52PM +0800, Chengming Zhou wrote:
> Right, how about add WARN here to catch it? Or just set it to PREFLUSH?
> Not familiar with dm code, need help if we need to fix it in dm. :)

We'll need to fix dm first.  I'll take a look if I can reproduce it.
Let's kept the list_del_init fix in first, I hope I can allocate some
time to this soon.
