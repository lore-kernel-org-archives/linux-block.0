Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B5188906
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732699891; cv=none; b=rQe5JZ3T1Z1aF1y2mU3ChbQXBryr5vyEWnOTzCgBOtFmpZybteYvCtixR7oCjlLv8ec0iv4LFc3qkZHPNNq1tkVlP1ifZAL7MPNF9iQHbx4QT3pZ8gCErszQrR63F0A2ZWqiNFbQD6Qo6oHqkdbgvIQs2ul4WXg20bXTTcMmVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732699891; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBMp3dEniorhZ0Z5unolLfjN9vDZzW3vkowc0Ykrro+vz9xrTR4kBsqn3VxXp8ffgqwW3vdsD58PbjTTPSVXvH68tTIAH0WdFNy5XdDBGmqfZVPq13nu5H9CSGtLdfjQA+iJ7t0UQ7u1KYL5VJ5lXI8/xR03xjWngWAw2XGTgcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B238268BFE; Wed, 27 Nov 2024 10:31:18 +0100 (CET)
Date: Wed, 27 Nov 2024 10:31:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hare@suse.de, hch@lst.de,
	martin.petersen@oracle.com
Subject: Re: [PATCH] block: Don't allow an atomic write be truncated in
 blkdev_write_iter()
Message-ID: <20241127093118.GA29104@lst.de>
References: <20241127092318.632790-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127092318.632790-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

