Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1429260DE3
	for <linux-block@vger.kernel.org>; Wed, 14 Feb 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931561; cv=none; b=g6WKY2o8AEcmv+/m6ESEn11wQyUZBaGtsW4zRMG+Gu2FEN0sj+fo5r1QdkGjOy2fRvUYPtESWPz8HOXZmvpHcLSFn/k5++g0wEwQyzeMLZrZJWxNwX5VAdyV537d6tOHmDdfKbwG4ANRYEqvW34dLVQbeP3Y/JB8Q/uBIdCGkgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931561; c=relaxed/simple;
	bh=CGxh9lMH8+gLYkFk1tj3jMba67i/ikoxs6SkJrGi04U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEMEki8omGDo/DRbhRJAPEJ+Q+C9CxfZE+ZF6brM2yRaEwWTuNeAtF2YbfsK+nrilMpSzMV3k791AOILV7aZDPk2GQryHCOEQG2IO61pJ1bioaqIJQanj1oyiMMGIltiZxm9niz9IBldT1APjlT2mpoPx3BPYjzwucgGnJxtmzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Atd/3hGN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Atd/3hGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB78C433F1;
	Wed, 14 Feb 2024 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707931560;
	bh=CGxh9lMH8+gLYkFk1tj3jMba67i/ikoxs6SkJrGi04U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Atd/3hGNTcHOVTApxn4oq8YHp6ilnTZK0q7L79tWtPFj50YoPtwrzsaICeWQE6ybG
	 qzT8ngbH7kvRFuHM1AlT6EekwpB956zxIYfXu15qr3ww9IFi4aYTP8kQEVf9lOc6qm
	 4kvDIexdEFO5G9QkL586prots5SItAkzlTNiLjnwJZCS8dMmOXbq4J7FtvugGg1fWx
	 F0uTHk7DeSa0FY3mtrIhtSozcIyV5Ap8WEt/qIW1DorCIXVGEuwy5YzPe3D+ysjbJT
	 kXV7Qz3luyeks4Hd0wTi7sNUkXSC/+tcyna6RLoGx7aRn0aFtTvR7XKx8ze35LmdCE
	 5aPCj93Q1tZcg==
Date: Wed, 14 Feb 2024 10:25:57 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] null_blk: remove the bio based I/O path
Message-ID: <Zcz3pd3A09dJScHH@kbusch-mbp>
References: <20240214095501.1883819-1-hch@lst.de>
 <20240214095501.1883819-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214095501.1883819-2-hch@lst.de>

On Wed, Feb 14, 2024 at 10:54:57AM +0100, Christoph Hellwig wrote:
> @@ -2036,11 +1813,15 @@ static int null_validate_conf(struct nullb_device *dev)
>  		pr_err("legacy IO path is no longer available\n");
>  		return -EINVAL;
>  	}
> +	if (dev->queue_mode == NULL_Q_BIO) {
> +		pr_err("BIO-based IO path is no longer available, using blk-mq instead.\n");
> +		dev->queue_mode = NULL_Q_MQ;
> +	}

Seems pointless to keep dev->queue_mode around if only one value is
valid.

Instead of checking the param here once per device, could we do it just
once for the module in null_set_queue_mode()?

---
@@ -134,7 +134,7 @@ static int null_param_store_val(const char *str, int *val, int min, int max)

 static int null_set_queue_mode(const char *str, const struct kernel_param *kp)
 {
-	return null_param_store_val(str, &g_queue_mode, NULL_Q_BIO, NULL_Q_MQ);
+	return null_param_store_val(str, &g_queue_mode, NULL_Q_MQ, NULL_Q_MQ);
 }

 static const struct kernel_param_ops null_queue_mode_param_ops = {
--
