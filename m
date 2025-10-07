Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28A72DF71B
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841847; cv=none; b=ASgb4EJqjubWJ6VB1ZyVQuQkRRZQDaA7X6gSP/kieUThHu6Z/h32p9PI+zqkPp5PleTelOiqaATrQO6Z7hPMTl551+qPhD98UcVEEKMRB2T5WjiBiFb4XnN35yp213ppUBG+O09O/aPgB8QyxN11tNEr7BgiTnXUxXzp39Wa8wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841847; c=relaxed/simple;
	bh=8ukafj+C98UXQyx8NHd6rjVR0LGybPvGtBeX2+E2aIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZ8XxMrV+e/GNBicWpK1cYhilzkF9m6cuYS75ayauNCZsyBRU59DdzAHGElua16CLf2ri+zKE0ZF+KWf7eL9tqFiTCkcSWyP4XedDYQ8KbY8fn3T1e6sCCbXv//USFbn78T1S+idQ3sYQPN4wgQYyZJphS0Emh69BanHncGryMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tvk8DAD2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tvk8DAD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27398C4CEF1;
	Tue,  7 Oct 2025 12:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759841847;
	bh=8ukafj+C98UXQyx8NHd6rjVR0LGybPvGtBeX2+E2aIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tvk8DAD2rtmfGAMGRP2cG9ORUN7Ih+jFtc5SOIwjMXLK7eJ0gciZzLQ0ClTfZUqGP
	 amwTANrc+mWlftHbG6f/jD0twP0dOZYZcnxpPyhxfOpm+v9uw2TAxTYRNJWUXC4OJR
	 J1IJC7ddVHkfNN8IyAQm+fI0oDThh0RCCZqNWxS1j7e/WuG2GPhXvf9VBvjODN8ySB
	 mWnGbd+3509HAHhkKAHYduWdA9B3H8yvx4EYetUUkdKDJMIlVqgyiehQssOB/i8d9R
	 jsFaverMYlym6cgu2A+tWXnR5/BuKB9+dIqIUOEGji1q/3E8n4i6flGE+QdQQjMIVA
	 s+85cAzUYqjUQ==
Date: Tue, 7 Oct 2025 06:57:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org, dennis.maisenbacher@wdc.com
Subject: Re: [PATCH 4/4] block: move bio_iov_iter_get_bdev_pages to
 block/fops.c
Message-ID: <aOUONb8jolseFiiT@kbusch-mbp>
References: <20251007090642.3251548-5-hch@lst.de>
 <2daafdb7aa00cc3b007e68ba146ba7ded2a2f7ca77422111d0f81eca6c751436@mailrelay.wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2daafdb7aa00cc3b007e68ba146ba7ded2a2f7ca77422111d0f81eca6c751436@mailrelay.wdc.com>

On Tue, Oct 07, 2025 at 04:57:40AM -0700, shinichiro.kawasaki@wdc.com wrote:
> Blktests CI has tested the following submission:
> Status:     FAILURE

...

> No failure

o_O
