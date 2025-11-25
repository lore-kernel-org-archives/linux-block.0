Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F88813B293;
	Tue, 25 Nov 2025 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070218; cv=none; b=oGZ3D9CLwphedn5tDm/9nR6e9KT4H3gxTu87EgqGCPkwR6/25TMG/rXioLNFzSQkEsjfrTdykqFKJWBiQdMaF6MPIPENEtVxslBButFATNGJkndHLbS/3SYE07eM+HijgXj7+/4XvOtGLzdo6FHgwPHcMPS5WEqr/JQxjDnYqns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070218; c=relaxed/simple;
	bh=PA6q4jExRYoV42xW6SK2Css5rDz07tyaC2bIYYki7rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upbAZCbsOqvUBQDDO39i9GVBMK/ioa58IsJ6az311g9r0obM9XMYrlHjkhQvzoed2qWM8CU1RXyjBa/d265tn7hEiof/NZj/CFfbl8ElXueQ4fJez+BUaoC6KSYs1NKrkDsVSvTjeiJhq/SAq0GIYvfxiq5mCtkzQ0t9Gwc4yos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F304368B05; Tue, 25 Nov 2025 12:30:09 +0100 (CET)
Date: Tue, 25 Nov 2025 12:30:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"hare@suse.de" <hare@suse.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>,
	"wagi@kernel.org" <wagi@kernel.org>,
	"mpatocka@redhat.com" <mpatocka@redhat.com>,
	"yukuai3@huawei.com" <yukuai3@huawei.com>,
	"xni@redhat.com" <xni@redhat.com>,
	"linan122@huawei.com" <linan122@huawei.com>,
	"bmarzins@redhat.com" <bmarzins@redhat.com>,
	"john.g.garry@oracle.com" <john.g.garry@oracle.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"ncardwell@google.com" <ncardwell@google.com>,
	"kuniyu@google.com" <kuniyu@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC blktests fix PATCH] tcp: use GFP_ATOMIC in tcp_disconnect
Message-ID: <20251125113009.GA22874@lst.de>
References: <20251125061142.18094-1-ckulkarnilinux@gmail.com> <aSVMXYCiEGpETx-X@infradead.org> <ea2958c9-4571-4169-8060-6456892e6b15@nvidia.com> <0caa9d00-3f69-4ade-b93b-eea307fe6f72@linux.ibm.com> <20251125112111.GA22545@lst.de> <234bab6c-6d31-4c93-8a69-5b3687ba9b85@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <234bab6c-6d31-4c93-8a69-5b3687ba9b85@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 25, 2025 at 04:58:32PM +0530, Nilay Shroff wrote:
> >From git history, I see that was added to avoid memory reclaim  to avoid
> possible circular locking dependency. This commit 83e1226b0ee2 ("nvme-tcp:
> fix possible circular locking when deleting a controller under memory
> pressure") adds it.

I suspect this was intended to be noio, and we should just switch to
that.

