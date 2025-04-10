Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC121F873E
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295248; cv=none; b=l0BJKKORH5rHqAyq6cebenn5i7Vqk1J4xgfEIJJpmmTmpoT2+k+ZeD+0HygPMxiueOhSnhizoNTB1LdYrt5jANMKi451rjUn7QntQxMlYeNC6K1gBf/L1Na7LeAs9or8BO2tqWRul5VJFDfLtL2START7XMo7700OBSVDv13to4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295248; c=relaxed/simple;
	bh=sMYh8TodBTejG/d1NCRlZ6JrPHkSH/Xi4mNG7jJfFNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2fFvUCd6g309Lf0YVN3GyYXF5fKR/tLltLpyEQSOODYgUM6XGSPn37hQQZDsED0Medfk09BgWx22J93plpIp5k1JW6cmGm81hYDLm1R9DLDGBJskKjHrPa644BvqzsGT4ymRgOXrNH16cLxOkJndG0VOpuj8qYqw93PxR00eSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B985B68B05; Thu, 10 Apr 2025 16:27:20 +0200 (CEST)
Date: Thu, 10 Apr 2025 16:27:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/15] block: move sched debugfs register into
 elvevator_register_queue
Message-ID: <20250410142720.GB10701@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com> <20250410133029.2487054-4-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410133029.2487054-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  	lockdep_assert_held(&q->elevator_lock);
>  
> +	if (test_bit(ELEVATOR_FLAG_REGISTERED, &e->flags))
> +		return 0;
> +

This looks unrelate to the rest of the patch, and I also don't understand
why it's needed as the callers of elv_register_queue don't change.

The rest of the patch looks good to me.

