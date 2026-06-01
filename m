Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30123438AA
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299286; cv=none; b=g8s6cbvja/Q4CDQd+V8NIhrVmthpoyEMWjHKjsUrTmvWbyGmTqW4Xs4EKeF4F1WbLTFeT3TKN6erg3PVeME+JbccVixmP7b5T0pBb2FW8Dh3PF41HfDgxN7R+JEWbv+rH880j9zb2knQIVuNTcl3p75apLgHXOmHMUafHmyqgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299286; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsFaW5FSntGd3VxsvtR7cmx7foUsyICfHWKClVl+YH2luxHy8sg0RkzVnOndJRNX4GFZEmmYefexJeoBELy9j59gb+q5Z7070E1htGUJNyeWQj7B+F1hD0wAZdLkrk7unSu8YVGTsUFRt2vxzz7HQxb3/PKVunkz8ZUC21Oq1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3EE6E68BEB; Mon,  1 Jun 2026 09:34:43 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:34:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v5 11/12] block/mq-deadline: Make the lock context
 annotations compatible with Clang
Message-ID: <20260601073442.GG7799@lst.de>
References: <cover.1779997063.git.bvanassche@acm.org> <be44a8b8ed93792d33b07de74c971d1a8a5703f8.1779997063.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be44a8b8ed93792d33b07de74c971d1a8a5703f8.1779997063.git.bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

