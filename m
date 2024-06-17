Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0228FC;
	Mon, 17 Jun 2024 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664337; cv=none; b=Ijut+1oeUf1Bsp4glj8TveLqs+p3lxoley+VR3OFPuliJApukKuJHITaDpIwjcth6Uw+L0jTvtCLG/Eo1Lg7sOUbpRu7Jml3OdU1lAm7yIfEKi1PUdUS/Wte1JfvB0Y01LvfJJuRrb9HoB8wGxyETYQu4o0Z78A7pOFC7yY8h9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664337; c=relaxed/simple;
	bh=XXPh+b+++dVhoTHxaF7sRY419KZ6Oam8yn4/Xi2EX+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oTQq6nFLA0oZCCuvc3vmIBzbYcJZFr2TpcZmWo9UiEzbfJ6Uzag0JH6sjfeJ5LQMYqqlQkEcoW+kO/6ilbhM0CFYYr8Syo6/epEygKgXeYY+w8KkH1xb84bhrE9WLnI2WnzZTJBFsWmj2SbrFwpkMGrLClarrFF6f7DaUBRyUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=B0mxxXZv; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="B0mxxXZv"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D9C7347C44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718664336; bh=2v0i7aCz/JSP5fydA9TY+AwYLB7we72e/vB/TZTljrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=B0mxxXZvAwjlqjiaSAhWmdMlrvZZu3y3rEepkozx5BATCzc9ynJCFEhWFa6p1Pjbi
	 UJEpg9SXWBd8lnaJBJXvn7KyCqY83Ef8bvK2SleAa4WftS89ZiQjrEPuZBK2pl0aqO
	 wRIjbQbatnzUNaZl4GT+8cAxOxDzkUzIBvC0lTutRPMbshUxSKiYjhN7B9FM9Y4FZc
	 p2d8XClkCKDhDeEh4GcD8JIMucEJaCSGAHByECXsX2pIzSCYk7lNCXdROnUiRfdkv+
	 79z6y4w4KcuqHssNHttPGIAhXRkFQ+/6fbNJFO3YtYEC6C4VEBIO7BghZ9SyirZC06
	 Ixj5jJ//r97Lg==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D9C7347C44;
	Mon, 17 Jun 2024 22:45:35 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thomas Huth <thuth@redhat.com>, linux-doc@vger.kernel.org, Jens Axboe
 <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH] Documentation: Remove the unused "tp720" from
 kernel-parameters.txt
In-Reply-To: <20240617073322.40679-1-thuth@redhat.com>
References: <20240617073322.40679-1-thuth@redhat.com>
Date: Mon, 17 Jun 2024 16:45:35 -0600
Message-ID: <87v827fasw.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Huth <thuth@redhat.com> writes:

> The "tp720" switch once belonged to the ps2esdi driver, but this
> driver has been removed a long time ago in 2008 in the commit
> 2af3e6017e53 ("The ps2esdi driver was marked as BROKEN more than two years ago due to being no longer working for some time.")
> already, so let's remove it from the documentation now, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b75852f1a789..89b784ec5ab1 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6619,8 +6619,6 @@
>  	torture.verbose_sleep_duration= [KNL]
>  			Duration of each verbose-printk() sleep in jiffies.
>  
> -	tp720=		[HW,PS2]
> -

Applied, thanks.

jon
