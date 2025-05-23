Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D628368C;
	Fri, 23 May 2025 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747988582; cv=none; b=HDm0Jysh0Ru42PqVbHv9RzOpQp5/z8ixG6m9CjDRYy/igO+XJch9p9zhtcm/KuHRWigXNWSM45WA1P5wvOE+YOtwR5vpNQmh/dZW75M5PVV4zYxwDHjgSUdfdmq90c95VzO2eSNR4jzHuaqnTvJIs0hkuGgmwMplgY9i7kbhxl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747988582; c=relaxed/simple;
	bh=XjW4guZt3KlYsztLYMJ7Xjv9Lx3A7/m12hvnpFVpW8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXIuMCiDMoNMSWuhh6w8u4RQvPG1UyyBmZ4iq6+VCuHR+2auFWeAx4lttQ1/Usebohu/sBKD+eP8Y5qZMxUKqaN/4H5uP+FALI0/rSrUJZSwNBZAftpEVoQ89DYzI2Mg13h2Q72wSZ36OSPryuM5q7DmIk+2PI5XsTfErcHs6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2D46468C4E; Fri, 23 May 2025 10:22:55 +0200 (CEST)
Date: Fri, 23 May 2025 10:22:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] block: Fix a deadlock related freezing zoned storage
 devices
Message-ID: <20250523082254.GB15587@lst.de>
References: <20250522171405.3239141-1-bvanassche@acm.org> <b1ea4120-e16a-47c8-b10c-ff6c9d5feb69@kernel.dk> <3cd139d0-5fe0-4ce1-b7a7-36da4fad6eff@kernel.org> <7fd56f2c-a769-4e9e-8168-6896b647087a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fd56f2c-a769-4e9e-8168-6896b647087a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 23, 2025 at 10:20:35AM +0200, Damien Le Moal wrote:
> 
> Looking into this deeper, the regular mq path actually likely has the same issue
> since it will call blk_queue_enter() if we do not have a cached request. So this
> solution is only partial and not good enough. We need something else.

The bio_zone_write_plugging case in blk_mq_submit_bio always
reused the existing queue reference.
