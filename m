Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF6376E0
	for <linux-block@vger.kernel.org>; Thu, 28 Mar 2024 04:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711601908; cv=none; b=t8Px6XTGmrBfoJBeiJvjNoSE9Rak+rdQQOJV/LxdikzfNOiha7z5W2Dt6sHbD6OoEL6L+WhcHFnMCzOvoSHjz8A18ipoHi+O8qaCog0g930EMnfpZLj24Wr/m6OfmZwaBsf7EkhHLfoD7QcuGgrUSPk4YF4MSykD86cFVQx4IJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711601908; c=relaxed/simple;
	bh=OXUwYNsYyooFh5mkGCAbUkZ5NnDN0LKN069vAYu9/fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLg7PrLUnyB1bztydXE1LjrqZQj5JthdqhkUjdyLrlkOfo/45bfS+RfZX9jXb++WYfc1Nv82s/ulInv7yU6R1N2IA3/h4tppLJ+OtkoRZVDl1HsDjjnENFy8AjhRvCN62kXKG5scNIR/hG+auj6UGKqzzJVCjoK1YJGfdRjl20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 194C168B05; Thu, 28 Mar 2024 05:58:23 +0100 (CET)
Date: Thu, 28 Mar 2024 05:58:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH v2] block: Improve IOPS by removing the fairness code
Message-ID: <20240328045822.GA14655@lst.de>
References: <20240325221420.1468801-1-bvanassche@acm.org> <20240326062229.GA7554@lst.de> <30519ebe-d370-4dbf-8f08-c28fa960b794@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30519ebe-d370-4dbf-8f08-c28fa960b794@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 26, 2024 at 10:36:25AM -0700, Bart Van Assche wrote:
> * Create a first request queue with completion time 1 ms and queue
>   depth 64.
> * Create a second request queue with completion time 100 ms and that
>   shares the tag set of the first request queue.
> * Submit I/O to both request queues.
>
> If I run that test I see a queue depth of about 60 for the second
> request queue and a queue depth of about 4 for the first request queue.
> This shows that both request queues make sufficient progress. This is
> because of the fairness algorithms in the sbitmap code.

This information needs to go into the commit log.

