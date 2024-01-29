Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E404481A8
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706508963; cv=none; b=XOizHgTZu1YTeGqc0zgYuMzpir2G2MIwmTiOtYyMQrmEfmD+4tnAthkOJyNgC0QMQrIzRl4n8/Z0+WpbIToZR5R0TDTo/ZSQE0kPa/9SK7PTyMMvEdWjYSZ3l0piUavpk9Xk0t2vZP2NNKAD/i1mTsqnjI6z816/54bhVEwmzhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706508963; c=relaxed/simple;
	bh=ieuFyRk0AzIW931GqByvWNx31HIOL29T6r74fJkxttA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJTXJ/MN/bxWTlGOKZWlHjooUcsqiW1sGRy8vzWZcBbOTj/QW2cG42NEIQz7gK5rnZ9XIgvEwMXVrm7Ts6CoYH2/7PidsCFFmbqnTaHGGNusdJUg0OkK1ErJIV3kDd890I47bV0Nz+7ga/dLesrxT3gho9MUxoGLzcjx4LdDKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8584968B05; Mon, 29 Jan 2024 07:15:54 +0100 (CET)
Date: Mon, 29 Jan 2024 07:15:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 01/14] block: move max_{open,active}_zones to struct
 queue_limits
Message-ID: <20240129061553.GA19581@lst.de>
References: <20240128165813.3213508-1-hch@lst.de> <20240128165813.3213508-2-hch@lst.de> <a0d499e7-ec2d-44f8-9b13-b1ef857e4c14@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0d499e7-ec2d-44f8-9b13-b1ef857e4c14@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jan 28, 2024 at 03:32:32PM -0800, Bart Van Assche wrote:
>> @@ -307,6 +305,8 @@ struct queue_limits {
>>   	unsigned char		discard_misaligned;
>>   	unsigned char		raid_partial_stripes_expensive;
>>   	bool			zoned;
>> +	unsigned int		max_open_zones;
>> +	unsigned int		max_active_zones;
>
> Not all struct queue_limits instances are associated with a gendisk. Do we need
> a way to separate the limits that apply to all request queues from the limits
> that only apply to disks in struct queue_limits, e.g. a comment that separates
> the two?

I've actually been thinking about that for a while.  It does sound like
a good idea but I wonder how practical it is.  But that is on the table
for after we've sorted out the basic API problems, as that makes
splitting it much easier if we do that eventually.

