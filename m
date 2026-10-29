Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793277881;
	b=efrVDtbtYicW9o+RzAzHAQ4tQ1iZ5Oh08xxQxXJeSUfb3WqLl3+EBuO5txdcJz1TV46g
	 YOawN6NYJtY9xPsSaiLTFkkwFKkVrnYiCBGs2JJbqzlhdzAgjbkLGS4D7Y6OWps7erlY2
	 zeYb//b/XS0N8KXAXSiqRfhnL0SHKumWEaoRo57LsMv7StjXItdiaKPtuib8fe7cuBa1w
	 jD0P5fC4TuSZRcbcv+op7JY+zT/+/S0ud5zMI6KCzbdeQUnFbMZ6ZrD9u+tVCp9i4wmAB
	 WbdwfLKjzhkRN8O0iDLmodDyNpFvbVd0rmtJWzyeHiFtgi1g7eO3gYBxtlV3hWsKG1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277881;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=794w4lFWEr7B3RFfv7N0QsebLMhutIZjh0p8ph3GhCU=;
	b=MqY4EEOllRrnw+wFHRMJZmh6AjMID8HXHK8yRrZn8U/4FgduInVyvgGOY4Mo9sqwgKuN
	 XV3A6q7PoJlcswhnAO5ALdTujhzcEcEict/ZxPNJcUcq5VyWv9AueD3+3VQSGadl+R2UF
	 bWP6NcsT4LLRpWfusq/35TkctG+xyrGxaO99dEf0ZXG1Rp/hm+F4AVEuhIg5mEkLxQi++
	 SPcOMVJuNilAKPvpZTDINX6t/KSKxRhS71oHkfAx1zdT5QRt+Qt+DNbqewNYA2mRs1BZn
	 JlMJF0EB8Gi/gT74VXC6yLFgguz2gD+XU9BJb38BkcjIw+ciXP4wHdomhGnyVVf5prw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=etXLoMMN;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6C606A324
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 12:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BE6C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=etXLoMMN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=794w4lFWEr7B3RFfv7N0QsebLMhutIZjh0p8ph3GhCU=; b=etXLoMMNCngnkYgJW+VUz3VWro
	Q+zDmZWJdL9ww2Mav7tmpU7PEjyI+WUe/oclF+3aRtegIHJURnFQRq6AffaYyGtMZehozF/k8QvEJ
	gxSx7BryNoyMvx2RjZhL0h+uhS48dVn6O9aaoBk8bMOqOc0iv/Y52z/fGITMIjb1vNPboRfogQd2H
	qFU6gtnK7ZjgOSQjiyKzAzuuPkdPBPzZ5ao5nIf0lvQMI+QzJ9I89YjyBxB89brrvsJuMXvJgg+0z
	alvuhlztM42LC0jQSGicq8yG12LvwKy9X8rxB/9TxEUgkcaIba7hDBJXJ1FTTJXWeLWgkrhyKyYc5
	yWnzm7uQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPUl-00000009EWM-2t54;
	Thu, 29 Oct 2026 12:44:39 +0000
Date: Thu, 29 Oct 2026 05:44:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 07/98] block: keep zone write plugs with plugged BIOs
 alive
Message-ID: <auM_t8oQvXbv08E6@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-8-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028164415.1262013-8-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 28, 2026 at 10:41:10AM -0600, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> The issuer of a plugged zone write hears about the completion in
> bio_endio(), before blk_zone_write_plug_finish_request() unplugs the
> zone, and may reset the zone and write it again in between.

How are supposed to a zone reset and a write in the short race
window?

> Since commit
> 836efd35c472 that revives the plug the reset marked dead, with the new
> BIO on the list and wp_offset still 0. The unplug of the first write
> then sees an empty zone and marks the plug dead again, BIO and all. Once
> that BIO is done the plug is freed and the write pointer offset is lost.
> 
> Only remove the plug of an empty zone when no BIO is left on it.

I'm not sure this is the correct thing to do.  It would seem more
sensible to make the blk-mq path match the bio-based one and
call into the write plug machinery before finishing the last bio
in a request.

