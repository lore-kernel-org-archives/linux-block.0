Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF0C83A14
	for <linux-block@vger.kernel.org>; Tue, 28 Jan 2025 05:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738043404; cv=none; b=hJgnOwqGjBVd89kYPhdpM3V3QMF52hxeb8AOYP20t05gbP8BH0u3Gl7urAxaiFpKBpusi57IW+a2qNL0UXYT21I1Kf2IRiQ4HcJ0nwDPM0QnIWPkBR+lcxHx0AloPRthQYZfs80qWE8Z5U0gD1HPnqd+Gnro/VR0unJoo/X1A28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738043404; c=relaxed/simple;
	bh=XiMXejmuya2H6/UQXHvoqd0/7DFTPhe43R9qqxKT1ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdvQqNGfdAvDy0c5T1qN+B2cznH5oVhU6czLXWHERS4/rcVJVsMdfM7sN69YyOdAIQfewzUwRFmQLQJ8Tmxwcky5LA1Kgobg6IWXzmBt43W62D/nPCmEuSfEfD4yhB+no99vRbwk79JSxfyQU46x75FTYOV8vbhqbkwFXWb/eSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 600F668D05; Tue, 28 Jan 2025 06:49:57 +0100 (CET)
Date: Tue, 28 Jan 2025 06:49:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [RFC PATCHv2 2/2] block: fix nr_hw_queue update racing with
 disk addition/removal
Message-ID: <20250128054957.GB19976@lst.de>
References: <20250123174124.24554-1-nilay@linux.ibm.com> <20250123174124.24554-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123174124.24554-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 23, 2025 at 11:10:24PM +0530, Nilay Shroff wrote:
>  
> +	mutex_lock(&q->tag_set->tag_list_lock);
> +
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		ret = blk_mq_register_hctx(hctx);
> -		if (ret)
> +		if (ret) {
> +			mutex_unlock(&q->tag_set->tag_list_lock);
>  			goto unreg;
> +		}
>  	}
>  
> +	mutex_unlock(&q->tag_set->tag_list_lock);
>  
>  out:
>  	return ret;
>  
>  unreg:
> +	mutex_lock(&q->tag_set->tag_list_lock);
> +

No real need for a unlock/lock cycle here I think.  Also as something
that is really just a nitpick, I love to keep the locks for the critical
sections close to the code they're protecting.  e.g. format this as:

	if (ret < 0)
		return ret;

	mutex_lock(&q->tag_set->tag_list_lock);
	queue_for_each_hw_ctx(q, hctx, i) {
		ret = blk_mq_register_hctx(hctx);
		if (ret)
			goto out_unregister;
	}
	mutex_unlock(&q->tag_set->tag_list_lock);
 	return 0

out_unregister:
	queue_for_each_hw_ctx(q, hctx, j) {
 		if (j < i)
			blk_mq_unregister_hctx(hctx);
	}
	mutex_unlock(&q->tag_set->tag_list_lock);

...

(and similar for blk_mq_sysfs_unregister).

I assume you did run this through blktests and xfstests with lockdep
enabled to catch if we created some new lock ordering problems?
I can't think of any right now, but it's good to validate that.

