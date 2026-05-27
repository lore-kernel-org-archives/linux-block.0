Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A642E718F;
	Wed, 27 May 2026 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866677; cv=none; b=qSzM99MsTL/7WHsn8e3IZdC0ooklQeB5uMdKQYQyQ+s4Dkk0ChtLYsmqiDFZku28aW0B1deULG0FG677IFGllXo8n0YZ7RQt5548/QyEQKJ0gD6Otp+JSm02c1YEKoaaR7Q2qIM1+hhbBC2jvUd8wA/og5K0EzSWAwEY0/TZdSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866677; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJQsES+iXIN8+6fAp3XPvpEZrX3E+sVuKxB6NE0zO5n6ZXQApNS4Efhr+wAT7x0GHnL3M35DnysTli6TZx/bSBbhNEdZp7Rr0ip8sn2k8xZAKi6sral+nYilOa2Zf+B4hbTgZEm9LL2of2sJ/+wna4zXXVHOH9vvRmtAhaEd+xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 475AF68BEB; Wed, 27 May 2026 09:24:33 +0200 (CEST)
Date: Wed, 27 May 2026 09:24:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Cunlong Li <shenxiaogll@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] zram: drop unused bio parameter from write
 helpers
Message-ID: <20260527072433.GB17856@lst.de>
References: <20260527-zram-v2-0-2fb84b054b5c@gmail.com> <20260527-zram-v2-2-2fb84b054b5c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-zram-v2-2-2fb84b054b5c@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

