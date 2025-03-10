Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EDE28EA
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605365; cv=none; b=EitLbNkcCclRQg2kIEMoTbc7WlVcaMxY+l7UbQLa1MknwrThvDymOaBSxFS45E1F9LQhwN9KnyFFACqHfxF0Ad5+mOv1N+jXRPmqU3cG1EI7Z4rh83Llx40s9vxOmELLtzOtPrEL49RK3GjwyvmQeJ0kzFbxp7veF4hEUemOVjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605365; c=relaxed/simple;
	bh=79mkcjY4B0YyCKt/FNwnEIEuznX3ICbMQ2Arl7DS3+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUAp+4jownnXlPOV98aW/ALX1yFHOXb+M5KhF7VRggxCW0CqHu6UmpgzI+SgxanZCaBQbv3wGfzG5P4awVOSklCaNXJULjp58epge0E7scTznQgkfi57qcjmPMTBmZKDiN2fsL+q8y/xRKT8LJUNPuRNFSVEDJmCeg5XmgdDjw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vACbGrjg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vACbGrjg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ac92hY6FRoS7VKnFS5DkCcDP+ztI8Nn2UzOVEEt7Rl8=; b=vACbGrjgIy4urzv0MpYSfGWmZY
	2vlBqtWxN8hjVm+nMZS26XFXyVxdCE+d6w2K8Z6qBFIqM05AF+B/eV2dHT37VgA5p3seUMBD0iK3H
	GYyWX8V2jOXoU1Gf47v2KRV4UCpk2Ukx7UQ6cwQL1DcqC5GrSZ50QjOTqijF5WmS+JJssfYRMrU/c
	U2dbhzaKSFVklmc7ISrY4ru/r21C+7htciKDa1aHw7qAtx3ISQxatFG/x3OCadtq1wcwWUaVNySSo
	Tld42F8lFIaQSWGohnKKNruGiaNP+w3F/JUmnMYFjnP+dSCB+nDHd16SDU9ZgGjkcS/EaDA9bjHWh
	c3SIW0lQ==;
Received: from [80.149.170.9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trb71-00000002Oog-3zRo;
	Mon, 10 Mar 2025 11:16:02 +0000
Date: Mon, 10 Mar 2025 12:15:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [RESEND PATCH 5/5] loop: add module parameter of 'nr_hw_queues'
Message-ID: <Z87J4IqflP_L_Vcf@infradead.org>
References: <20250308162312.1640828-1-ming.lei@redhat.com>
 <20250308162312.1640828-6-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308162312.1640828-6-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Mar 09, 2025 at 12:23:09AM +0800, Ming Lei wrote:
> Add module parameter of 'nr_hw_queues' so that loop can support MQ,
> which may reduce contention in case of too many io jobs.

More details, please.  Also a module parameter is a really bad
interface - this needs to be per-device and have a good default.

