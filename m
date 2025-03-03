Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B449720F09D
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011222; cv=none; b=flomBOG4nrzYeaPxFJLYa90mUKjJpAj74Rv8JMikp1QE6V/QIVuPQT0AFsYE/Mjc/D7XGlw7PJaiJqPPI0aeDWnY3JY9cZdCS9gUOI+FDgJLKUmvHZiwDcgeilfw3HkE6tzFQtHr6K7q+2XJR3Mky6kVQqLL5E9Vurg8pPNlXYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011222; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlQZUDk4aHDoYTm4eWqzqQ78wLI7tDaT4BTSZ/XdcuArIGd5CPiWZcZor6jqCKZAJJiUDcZqpKfwHKTOMJXEeeXvRPiASUO33sWYXPZsUleqFtSsaWx6Flb9Th+odXL0x+omdqOZ5mRd1o0dqHiTq9N1RVOVAsT4VjHK6N1VQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1281168CFE; Mon,  3 Mar 2025 15:13:37 +0100 (CET)
Date: Mon, 3 Mar 2025 15:13:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
	hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv5 5/7] block: protect nr_requests update using
 q->elevator_lock
Message-ID: <20250303141336.GC16268@lst.de>
References: <20250226124006.1593985-1-nilay@linux.ibm.com> <20250226124006.1593985-6-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226124006.1593985-6-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

