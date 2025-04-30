Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FEA254848
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022200; cv=none; b=lxsEVGVwTF7rrWJFCpDCI2pfSN2x+YPPMFyzXEgSOaUwtpZr31NLR/+wfSzLt41B+gOW525GSh8zDQRn7dojA1FZUUIxoydl3I19cqOBMxZvinKbTY8pT8EudGTPccb7fUVhLDuYazCGH1k/OC0eEiUT4jxDFdZmLnv9Nmnhj5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022200; c=relaxed/simple;
	bh=7hEpwdFQ+l0Jin1V268bYWvguzhvRY4l66GNpuEr/ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfvEhv94Xkwol+t/X2126mIqiZUNMKq6WFZpJb5wtYjisIdLv2wHkeYq4N6F86x5TIYE6wAqnZR13vXqpUubhJvRu8Ey0ziXU+yz17hjQQtwhwq7dhXxQtJFQLS57CIiw24Yx71Lh+hnAqLX3CRBTTD/QWsOJ+qEn4ozAo0YWiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5494867373; Wed, 30 Apr 2025 16:09:54 +0200 (CEST)
Date: Wed, 30 Apr 2025 16:09:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V4 08/24] block: don't allow to switch elevator if
 updating nr_hw_queues is in-progress
Message-ID: <20250430140954.GB6702@lst.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com> <20250430043529.1950194-9-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430043529.1950194-9-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 30, 2025 at 12:35:10PM +0800, Ming Lei wrote:
> Take the nested variant for avoiding the following false positive
> splat[1], and this way is correct because:
> 
> - the read lock in elv_iosched_store() is not overlapped with the read lock
> in adding/deleting disk:
> 
> - storing to kobject attribute is only available after the kobject is added
> and before it is deleted

This needs to go into a code comment, as all nested locking should be
documented.

