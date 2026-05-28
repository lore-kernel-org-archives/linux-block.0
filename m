Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69EA175A62
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779930012; cv=none; b=TNHliJYmsIH/WKIRWjjYt2SohTT1FSwpvtm5wVgwimMbdiZqtWqpJW22ZTp7AiYOvwqyqJFlyBCAnFAHlzcPXDQjk1kYDFClOlYVhHTOnJzgln+FVd769KOMdi+wcsgpmzfkXf8xxZYUzFOHaSlQj+VgW9pAriXyAtkN848TfKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779930012; c=relaxed/simple;
	bh=rdtLjZRzzi4Hvfw3bGgNgmDgVfzp0+IJ1PQoZ22aJSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sc3GHmDvomeO+YVvwguu1/5WN5EJVX8KmDO3WEKdekOCxaAp12W3n5MjEAdxN/p77humQvNUFzpvYmOCYNTfwYPJnBRHAGJxj4JNx6k5zBYJ+3/Ellg1ngPuNvizU16/IZpXpm3JEkSl/mVRCtPAIMmB706mHqoyuqmTardIU84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6LIgsWw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6LIgsWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C401F000E9;
	Thu, 28 May 2026 01:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779930011;
	bh=rdtLjZRzzi4Hvfw3bGgNgmDgVfzp0+IJ1PQoZ22aJSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y6LIgsWwyumTRHyWeiBRdwhd1wLHcgb3ht+cRRsv1zQ64Sc27317bg7VgTuO5G32T
	 xhbEndXZ4yS4Wt0YC0RjjPcMosquUpM5balyoyNGloeXsWbf2Uq0inI9sXqMdzXaqO
	 M4L0kN+cheE/2n8ojtwex9BaKaEqOSf/C8kQJvMrJSgB09EG4drmsd2vd/jt6T5z2T
	 rUkjJ4LVsi8vhUcm/ukYJf0C1ha2NkFOs3rstZyJypeiMtAptZAz+8xzjUj/bXSKPn
	 K4xUjPEFs18dDmrei4zONI2gzVrwPF5+FpdCTMf2+528a51X+OeRRBhL/MX3DPH46n
	 U4j7nT4RGxGUA==
Date: Wed, 27 May 2026 19:00:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH] block, nvme: export and use passthrough stats
Message-ID: <aheTmeADV8aw8_iZ@kbusch-mbp>
References: <20260528005848.1517715-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528005848.1517715-1-kbusch@meta.com>

Sorry, please disregard. I pointed send-email to the v1 directory by
mistake.
