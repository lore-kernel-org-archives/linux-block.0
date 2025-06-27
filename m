Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37AC2F1FEA
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751008719; cv=none; b=mep+pyz2RjfIpMi2G9yPlLJ7iKvBxCMu4HqeeznragL7ALUcbOck+W5Bz0yCofPzEtlM4ThLbGJ2ADUBijX20P0fxAgUGa2H7t5OPXw9OlmbUvALrkW3L9AHU7LyuR8Q8eYqb/04WBxfYBZkQeCTAsRzRHQbeJuhqhMTM2cjalg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751008719; c=relaxed/simple;
	bh=51J4kC+4Vn0RikllcQjI9Hze+TgijtipPb88dz3sXlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIXS206iJj7BbSzH4yUJqSFljd7lifiX5ILeVd06MqXegoKCQTNU92FBRNoJraMwN+8HuCI76LKjplDxzcDlcHWAodlc5UJ75hTtDFXC0AoRouyHsPnG7St3VLCzJXO4hL9qp3+QNaRplRDJO/PFl46hpES/mtEv7oha8UAdHWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2541868AFE; Fri, 27 Jun 2025 09:18:34 +0200 (CEST)
Date: Fri, 27 Jun 2025 09:18:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Reduce the scope of a variable in
 __blk_mq_update_nr_hw_queues()
Message-ID: <20250627071833.GA1103@lst.de>
References: <20250626212201.2271832-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626212201.2271832-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 26, 2025 at 02:22:01PM -0700, Bart Van Assche wrote:
> Improve code readability by reducing the scope of the variable 'i'.
> 
> This patch fixes the following W=2 compiler warning:
> 
> block/blk-mq.c:5037:8: error: declaration shadows a local variable [-Werror,-Wshadow]
>  5037 |                         int i = prev_nr_hw_queues;
>       |                             ^
> block/blk-mq.c:4999:6: note: previous declaration is here
>  4999 |         int i;

If we want to fix this renaming one variable is much better.

But Nilay is currently active with major changes to this area, let's
delay cosmetic fixes until that has landed.

