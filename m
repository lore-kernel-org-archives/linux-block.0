Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBB91CEAAA
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035003; cv=none; b=Oj2x3eTwZBS14RYJxoBz/7Erxt1Q+UjOBYDQWqLKmGCnLGfz8bStmq//a+wlk1XNcVbAHjDrgyYrGGavTEWgci7Dms4vICtQPuE+0rWDZVuk2oapLdbIRtCX1HCokJQaQDYZNXQrh1VkNJJzbp3I/Rphi2rrS73d4rosFPTpjGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035003; c=relaxed/simple;
	bh=ISS9VthcmwZO9D/pwCfGaiIHqpaoRJqB/fpXuakHuKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxa6BNOZAWByeWAsizgISZ6eZ0gbL1VpnCBvf6booLq4KzJZMMAtCST2847PnsS+CDRZH7D1KbwQiJg6gMQ76WJxXHuwEfkaez2/uXCo0fZMz0LZ9yUEcjgu3X8m1dms9oYEKFtjBLDy92MWN5nhv7tRRMQFHLt46cyilBvHwNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2131868D8D; Tue, 19 Nov 2024 17:49:58 +0100 (CET)
Date: Tue, 19 Nov 2024 17:49:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: don't bother checking the data direction
 for merges
Message-ID: <20241119164957.GA17438@lst.de>
References: <20241119161157.1328171-1-hch@lst.de> <20241119161157.1328171-2-hch@lst.de> <427189c2-dff8-4af8-a805-31d78019cc7b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427189c2-dff8-4af8-a805-31d78019cc7b@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 19, 2024 at 04:48:15PM +0000, John Garry wrote:
> I tried to check what is meant by "already started", but that comment 
> pre-dates git. And even the code from then does not make it obvious, but I 
> don't want to check further, so:

Back in the bad old days there was a separare prep_fn callback into
the driver to prepare a request while it was still on the scheduler
lists, and that then set a started flag.   In other words the comment
is long obsolete.

