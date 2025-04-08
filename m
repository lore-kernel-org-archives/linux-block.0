Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DCF1D61B9
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122812; cv=none; b=Pxunn/v6SIoQF6u3WRCijLOwrYBzrIOzSVh/xTcGRHAi7eW8cJcwbggib5KwMbk5lcWMWwX/dELMKutpspXRcCiUyfLFuW1DRpjRijOuaBqevVP/aaJaMtroeNtR1V3eta6c1tU/zofgIOX/sd7KgiotGUj7ieDaf66X/oc8KD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122812; c=relaxed/simple;
	bh=Pg6/6HQH/WJQOW7Hm4yg9XYPQcZuvvJ9b5Hb9Jlj6S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLfdw8IhdailK4LdmRIunK5SiI+e9VXxvokdDRFFDexAzOauedLMrexpN9XdN3RR6tHIceRrDxMU64sg+CsiWVwwZI0pyYfdEY4yYSeV+gx06zapl6J3phtS2PwPtF0y3Q1oRFdMKOG5Oj+0Qj/58t5knXGYflvXl399+xiZk8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T64H7E74; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T64H7E74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47617C4CEEA;
	Tue,  8 Apr 2025 14:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744122812;
	bh=Pg6/6HQH/WJQOW7Hm4yg9XYPQcZuvvJ9b5Hb9Jlj6S4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T64H7E742tnVBt1TEQZlnWSazJG6FFTRjQftaVvIjvGYP2ZL7MFmV3XodNTWUMHAU
	 RQtiwPai+rd69u0HuFG5FjwX8dLaGgXqvxnyDZv47CVg3aly0I5nZV/Ugjk3tnYiwK
	 AriXSICIesZ1qOswZgaJIonREHz9OqqYBtzB7aZUbqug5ZxGklf5gZWPUaLtjLgOAF
	 DI3Xz+xmdN9YVKlV+VeiA7VvZSpcE9xB/r/eqlOTwJo+SS1dI8wQwmt+Js272OPnF9
	 lywEOL3MTuYGgGe0Hte3jtc6B6Pm7a+Lv9ai7lYHGjygfVrTcckBJs4Wq/TTT8snIf
	 Nfr94i/BZLvSQ==
Date: Tue, 8 Apr 2025 15:33:27 +0100
From: Keith Busch <kbusch@kernel.org>
To: Sean Anderson <seanga2@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	Zhihao Cheng <chengzhihao1@huawei.com>
Subject: Re: bio segment constraints
Message-ID: <Z_Uzt423-H_YlO5u@kbusch-mbp>
References: <8dfd97ac-59e7-ae69-238a-85b7a2dae4f1@gmail.com>
 <8a232716-74f8-4bba-a514-d0f766492344@suse.de>
 <a0ffa9b9-8649-1b63-3d56-3fc45fdfda83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0ffa9b9-8649-1b63-3d56-3fc45fdfda83@gmail.com>

On Mon, Apr 07, 2025 at 10:14:28AM -0400, Sean Anderson wrote:
> On 4/7/25 03:10, Hannes Reinecke wrote:
> > 
> > The driver surely can. You should be able to set 'max_segment_size' to
> > the logical block size, and that should give you what you want.
> 
> But couldn't I get segments smaller than that? max_segment_size seems like
> it would only restrict the maximum size, leaving the possibility open for
> smaller segments.

If your driver never wants to see segments smaller than the logical
block, you could update your queue_limits dma_alignment to be
logical_block_size - 1. It is 511 by default so works for you only if
logical block size == SECTOR_SIZE.
