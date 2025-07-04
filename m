Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7C2360;
	Fri,  4 Jul 2025 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637920; cv=none; b=ZANZEMe4Pr0g+nPXDNwmRXZly6v1npL63sJN9+Kpy//QkxPtiQkZZCCrA/FM33VKyOuklChPEvz1B0PVsS+VobJ4Ig3QpksFLHMFdsM0dfEL4FEZdshotyVknhPDiTlPkczIskLMf1WQDXnpD3Rh9+/nrvzdJRyt8zEkvQl/Roc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637920; c=relaxed/simple;
	bh=raNLNwEQzdPuJ1w8Jief/AX2ggS4mJBnSAHW/GkocrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvoM49EcbcOG2b6et6eKoINNMDvzhfN9n8hKfLmXHZhdhHBbByUvyOMqnD13Pr2zHEN1gON2jThsNTQLSLdOvICPx0JHUn/sc3RuQFsIpN1KgLEEe74KsB45i1IzVWRJzadLEtL+ZkkkJ/T+InkwaYpStjMMef3p+N6jxWlURAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=GfFLz3Tx; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="GfFLz3Tx"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bYb4P3StJz9sTZ;
	Fri,  4 Jul 2025 16:05:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1751637909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLuXp7lB20JYT8y9pzOwm0YYE7YBcFIo5+HmXt0CEXg=;
	b=GfFLz3TxUlGrFkE0JZSUKQTi7Mc0jOqA+uJG7SAM3fcRQPVBn6q4oqRWhySSTLZnL0809/
	Xfc/rKraMF3aROnEVq6xZH04UTuyF0UKnYYenw4qMyAAOooGSpzlzgJCxY8VadeSKRY6Ex
	vSIx9Z60jIEua7urC6VVemcu3NlEpFGEbsuz7r55jZTaZPsdFhuCm8TSurNuJmpSV0OQ3G
	szRjC5LPmwyJHje6Acw0Bz+QFwoyaGoGOJ6uB3tN1H6p+MEYf/eFbMhdUGLsPDyvYFkn2b
	S6E0d6TSyXt+IidMkhnqcpifRgX9mJD2h4Shqz70pNx+i9pxPIlxCEfdpaODsg==
Message-ID: <93888462-4aeb-4cce-bcce-2ffb82db1857@pankajraghav.com>
Date: Fri, 4 Jul 2025 16:05:00 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] block: reject bs > ps block devices when THP is disabled
To: Matthew Wilcox <willy@infradead.org>, Pankaj Raghav <p.raghav@samsung.com>
Cc: Hannes Reinecke <hare@suse.de>, mcgrof@kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com, hch@lst.de,
 Christian Brauner <brauner@kernel.org>
References: <20250704092134.289491-1-p.raghav@samsung.com>
 <aGfNKGBz9lhuK1AF@casper.infradead.org>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <aGfNKGBz9lhuK1AF@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 14:46, Matthew Wilcox wrote:
> On Fri, Jul 04, 2025 at 11:21:34AM +0200, Pankaj Raghav wrote:
>> As large folio support depends on THP, only allow bs > ps block devices
>> if THP is enabled.
> 
> I mean, it's a quick fix, so sure.  But really we should remove that
> dependency.  Particularly for bs>PS as there's no need for any of the
> splitting code.

Ok, I didn't know that. Let's add this as a stop gap and I will take a look so
that we can remove this dependency.

Thanks.

--
Pankaj

