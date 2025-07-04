Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE39189F43;
	Fri,  4 Jul 2025 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637986; cv=none; b=KO1HjPdZ0JB2HdZCzgnTmurf1/QpcCiKsGLPw51mTueWnX/BK4NXUimMChGbKt2PqXONIw48ycGppLSGFbWhtuasKak/ERiEcBSOLWe5uVa6vzBht6otzYpYKHXWn0SzxMs9Hqgne+gOM/dtnAy2m76M0wqn6WE9KJwoJKkdG4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637986; c=relaxed/simple;
	bh=bvUt5RBrPgm3NXhrDrR2/hHVU1sK8NPSyzsYpuA4wkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TazKl0N2oSFh1DYIgAdRybyTNo7n6JiTh9+cgMPd0OkHvKMm3eo9SY1rUKAFWfZA9pX2r6Etp1341NNEiK/g7R46nlyQDJArdYc3kJti+br6gXWOtFWZMzP4G8CoNT2X3IebtLhiGM7jEa28sxnh+PbnvMxI0K49E4kr84uxNLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=pL+NgX/K; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="pL+NgX/K"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bYb5m6fJSz9tK9;
	Fri,  4 Jul 2025 16:06:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1751637981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7DYCDCCOoVVXT9pyOQhiwPUPgRm+oA4KD4grxIaOPOQ=;
	b=pL+NgX/KXlyeAZEcTLhWWmzb2iGUOpZwlxpsvBsUhj2MseNSTqbgo81M9uv/COQCqdtHxw
	3WUo55KXEIF3MgCFBPcz5PDJH662JYTt/axSFs6/5zKxs2Cm69BNEj2enTOz04DQp1gGgF
	LzHXFKIH3EkY3ycEhS+Z4cOSawXqXu21qs2+wsCeruODpD0itZFUVOVjODurA7DQBTNPJv
	+GTTdUhP4+0XZ/jhGwjmuXnjbnpW08/fpkGHmJDqPBYgG+OGqPGvNGtJgN+gTfTHCIdr09
	8nWxpINfFjPKnlaXFUUYQolcaIhKF6g1GOMobi0s2pB0jxavBTYawsZrW3ZXJg==
Message-ID: <17f53f72-9fd9-4cf0-b925-8ca3e9b02792@pankajraghav.com>
Date: Fri, 4 Jul 2025 16:06:15 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] block: reject bs > ps block devices when THP is
 disabled
To: Matthew Wilcox <willy@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, mcgrof@kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, hch@lst.de,
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>
References: <20250704095036.293568-1-kernel@pankajraghav.com>
 <aGfNXbQ5ExO95Uf8@casper.infradead.org>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <aGfNXbQ5ExO95Uf8@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4bYb5m6fJSz9tK9


On 7/4/25 14:47, Matthew Wilcox wrote:
> On Fri, Jul 04, 2025 at 11:50:36AM +0200, Pankaj Raghav (Samsung) wrote:
>> Changes since v1:
>> - Use mapping_max_folio_size_supported() instead of doing a ifdef with
>>   CONFIG_THP
> 
> why?  v1 looked better to me

Oh really? I am fine with anything but I thought this looks better instead
having an ifdef.

--
Pankaj
