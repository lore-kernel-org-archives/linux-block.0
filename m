Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC5A28DB57
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626036; cv=none; b=V8Q5yHNqszMQyVtqgI4sWl+0+lHQvAMdBD6I/VponNvupJ+JQ8sKf2gcF5q5lZtDTLXPSjgL/X9OYJbQ9Mbj0zjs2DcvrUcs0AkwrgkRp87cVCMsA354szTmTUaF7laXxBkvcilOfxgOQJOxOJJ9tAY64LArAVeVg319VTl/3Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626036; c=relaxed/simple;
	bh=g2zDVKZ2nKe/WJSftLzG4/D2fvK/Gzb3fW65/VpRJg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bM7qflwxJHLQQX8ohQjw9MqtCx0cXJDJ87Vu3siQpCbrpxaEGQ54xLIyrCBY0752Y/XNrVQ4Dwdf8UpWdERb8GyuuZkqSARpOqedNyUgl6FD5TXmdY2MtCBx/zeswv/4DQEESSHJJ2/Jq7EW6F8NXUlGUXRXEd08LBy7cV9+2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7572E68B05; Wed,  7 May 2025 15:53:49 +0200 (CEST)
Date: Wed, 7 May 2025 15:53:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] block: move queue quiesce into elevator_change()
Message-ID: <20250507135349.GA1019@lst.de>
References: <20250507120406.3028670-1-ming.lei@redhat.com> <20250507120406.3028670-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507120406.3028670-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 07, 2025 at 08:04:02PM +0800, Ming Lei wrote:
> blk_mq_freeze_queue() can't be called on quiesced queue, otherwise it may
> never return if there is any queued requests.
> 
> Fix it by moving queue quiesce int elevator_change() by adding one flag to
> 'struct elv_change_ctx' for controlling this behavior.

Why do we even need to quiesce the queue here, and not anywhere else?

