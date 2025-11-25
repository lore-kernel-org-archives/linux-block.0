Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62233148CC;
	Tue, 25 Nov 2025 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764068924; cv=none; b=CvWejNb3Rww75blezDUgup5lfIeXXH9bIukSkuAXmtDQMVDhM4Emw3zVrEedXTg0I8HZEdLYAcBgxFr7EI2jQN+4ScDJk6WjMjfgq7XndqOTAdvrHigfDZvsfcrZBCPQU84pLjG/SWIJvuGTx+5YEekbAdGyuBdqt44s4xG155U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764068924; c=relaxed/simple;
	bh=mnWsJRtsit8l+N2bvO4h2qSdtW3RMQ+5m+IJsAYTWUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lElpsRn41OpriwTk//xqEEPnl6mtJnXPTRFoBGQUbsRZPijYQL8x9rx+elduFCDR+2gavM16aLcPmBnxO20Ieryj5TPGpXispZhEfbMqy1GaEPi/dUbuoU11O1IghXUwH+haZKrihyAJ+Oz4oktw2n0dGNMIWayha368TRVEjMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2D3DF68B05; Tue, 25 Nov 2025 12:08:37 +0100 (CET)
Date: Tue, 25 Nov 2025 12:08:37 +0100
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
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
Message-ID: <20251125110836.GA22313@lst.de>
References: <20251125061142.18094-1-ckulkarnilinux@gmail.com> <aSVMXYCiEGpETx-X@infradead.org> <ea2958c9-4571-4169-8060-6456892e6b15@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea2958c9-4571-4169-8060-6456892e6b15@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 25, 2025 at 07:28:45AM +0000, Chaitanya Kulkarni wrote:
> are you saying something like this ?

Yes, something like this.  I wonder if there's a way to avoid the nested
flag saving, though.

