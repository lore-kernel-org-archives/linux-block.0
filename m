Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C612E5B;
	Wed, 21 May 2025 05:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747806807; cv=none; b=r7B4bB1HMSZs0LAzc4ytbmb8tfgNSBzGTM8uWbQ9GoooMqoz8FNgV93FZkWQSQHZ2TtK+XDrH9s2Gu5xWgaWLzUR1LvlPDuDXZGA8xmw+br0vsK3DUokCG7UynHeWnHI1a/KstMDpnHZfcarWi3qwMbdTwhiz8JKS9Ht8ccteRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747806807; c=relaxed/simple;
	bh=3Inn45X6/1PgKY79R/pFHZyROoduVb1/T++y7WxeTM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGGV7ycjyhw2O0gsFIwY+cVPLUuil27+f13TelWxKnKpZhRiGHa8A5pFsHJr6hGmPgI5plc88GGIz0bSOCoLR7rIEhcMepghE0IPmxtQ5IzDbhEdcU2/W4DeF24yCKPPgAMyc3ML8VNYyqh8rh3N7o7XYBTtSH6Iq0N68Rqbma4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 04C4168D17; Wed, 21 May 2025 07:53:20 +0200 (CEST)
Date: Wed, 21 May 2025 07:53:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
Message-ID: <20250521055319.GA3109@lst.de>
References: <20250514202937.2058598-1-bvanassche@acm.org> <20250514202937.2058598-2-bvanassche@acm.org> <20250516044754.GA12964@lst.de> <47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org> <20250520135624.GA8472@lst.de> <d28b6138-7618-4092-8e05-66be2625ecd9@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d28b6138-7618-4092-8e05-66be2625ecd9@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 20, 2025 at 11:09:15AM -0700, Bart Van Assche wrote:
> If the sequential write bios are split by the device mapper, sorting
> bios in the block layer is not necessary. Christoph and Damien, do you
> agree to replace the bio sorting code in my previous email with the
> patch below?

No.  First please create a reproducer for your issue using null_blk
or scsi_debug, otherwise we have no way to understand what is going
on here, and will regress in the future.

Second should very much be able to fix the splitting in dm to place
the bios in the right order.  As mentioned before I have a theory
of how to do it, but we really need a proper reproducer to test this
and then to write it up to blktests first.

