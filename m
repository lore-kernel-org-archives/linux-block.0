Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299E11EB5E1;
	Tue, 25 Nov 2025 06:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764052075; cv=none; b=Adivh1QZkzpYE9HUiut4+UO7v6yZ4nKYuYLEHko3+jrYQr3dJWj0t4RZAO7IRCNzx7i+ffBDYbaFAe58xlqQStiTch1cejhN2XAzFkwx3iA2UmvllKv+v+uYoncbi2kQhf3VXyeWUjH1KyT1T/8jr1M8SeppxEAgltk3bffy+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764052075; c=relaxed/simple;
	bh=vg+723AT+F9V+nofvRgONAE2TMnTjFK/s4MnVxWOoQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GENikTY2+GxLs2qNRGpg46bSWQpbpjkWRNWZP32VOZCHfTzhmyY05ijp55DPUvY0lGZq5e/3rGTa9KdQuNzwzre9o+Mq6fgbq09Oj6UTbVKlXRwPVhNU/b/9Bem8lrb9mVttj9us2yYhSmE5g/4eM06bMML0b3CWIMUm8JEGt2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eimM/5SD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eimM/5SD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vg+723AT+F9V+nofvRgONAE2TMnTjFK/s4MnVxWOoQk=; b=eimM/5SDLDWvZ5ahui/ecOV0eE
	toS7F3eH3xGW3rP4KrIFhPupIy41xgf8cGdPFjd2RUQWiFB8cE5P6pFknwCsEstYPT9g0IleFqslU
	Y8yOQJ+FegvR/HYQZlBfmOvz720XBPoQgQjZzbF39dQ4uzRVoZJ5VNpXzY/FYA/sZBrdncToJiMAY
	+x1pSkj41Lv1DqpYlmLuKFxG5OyF7DMWlKD3taT+ut+WdFNjKNBkVqQhrjkCe/5Yx0hLEJHWE3pfe
	JYkB+Yc6UNMaGHakN1eSIwe6vUEibRa4KJZSq/SFz1cOWFBWrYUG8EkuI4n0DRH7+2WplEoGk8NUr
	F4CWyq0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNmWb-0000000Cp6S-2lJ5;
	Tue, 25 Nov 2025 06:27:41 +0000
Date: Mon, 24 Nov 2025 22:27:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
	axboe@kernel.dk, dlemoal@kernel.org, wagi@kernel.org,
	mpatocka@redhat.com, yukuai3@huawei.com, xni@redhat.com,
	linan122@huawei.com, bmarzins@redhat.com, john.g.garry@oracle.com,
	edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [RFC blktests fix PATCH] tcp: use GFP_ATOMIC in tcp_disconnect
Message-ID: <aSVMXYCiEGpETx-X@infradead.org>
References: <20251125061142.18094-1-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125061142.18094-1-ckulkarnilinux@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I don't think GFP_ATOMIC is right here, you want GFP_NOIO.

And just use the scope API so that you don't have to pass a gfp_t
several layers down.

