Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4DD225D7
	for <linux-block@vger.kernel.org>; Tue, 23 Apr 2024 06:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713852732; cv=none; b=n7H208Vo8AUANYBkWXut149+9YMJdeOklZb5/eOL2fTo0CVSuw/Mxwcp3PyuVDuRht4tvL8pWJXubaJGrfP8dZu31gHwwnTrMHE4W0+V7zEPCpf/MPAUEQLAvEwESgtVubDzIpqT7OjXCICxIjEG870PfeDvAJhUKwkF8p9bbqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713852732; c=relaxed/simple;
	bh=wuqV8rFkwdVkKTQlLBV0Kl+PrVuGjqp2Oejqmd4bzw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4a7Rc4UKf3Zx/CYqZfD6UTG9uhU76slxKJ2ofqvemD9ip2ahOPUgP3rTJ9+emBjH9xEr9ou0baE1X6YS4slJOSC1NkHGEgxj8BiKe03MtWGCVm4ziiE4gBAqoTVlcAd9pSXieKS4DPsPMwxzIDzLfpFYV7dlhwDGu3zg39Y//c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWp8JfMz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWp8JfMz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28790C116B1;
	Tue, 23 Apr 2024 06:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713852731;
	bh=wuqV8rFkwdVkKTQlLBV0Kl+PrVuGjqp2Oejqmd4bzw8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oWp8JfMza6kX6ttzfRzRln6TaP9/i4lENZjOjqLwrSGev/+iqr0KevJnZ/FGfyatN
	 /nGaJysClhD2FMBCjlerQme4/3TNVuQsSDhgUKC4PCHRA5iOpDxzu/hueigNkkTIpF
	 45246GR1J2UyvoRFbLeHqEXKAj/9BlqtIv/iG7H2rzGCR17SBe7A/GJcGEnbkNnEbH
	 /tlYO9KkZeyUSifIKAF9EHajacSuXCzJ1kMcY0+GBTC1CxkCjwOiGENEWJPkqMwoGP
	 bNhSbJKkSnuN7URT1ZbisUwkzLFafEOlCVOZOmvdKyl80azTEUpNZRpJjDsxz8/Y/d
	 dAu6vMQt2H0yg==
Message-ID: <f5c36d0b-4d5a-47e2-8df1-66d3ee718ad2@kernel.org>
Date: Tue, 23 Apr 2024 16:12:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: prevent freeing a zone write plug too early
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240420075811.1276893-1-dlemoal@kernel.org>
 <20240420075811.1276893-2-dlemoal@kernel.org>
 <ZiYCfTVpPqIMv8iE@infradead.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZiYCfTVpPqIMv8iE@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/22 16:23, Christoph Hellwig wrote:
> On Sat, Apr 20, 2024 at 04:58:10PM +0900, Damien Le Moal wrote:
>> Avoid this by calling flush_work() from disk_free_zone_wplug_rcu().
> 
> Calling flush_work from a rcu callback is just asking for nasty
> deadlocks.
> 
> What prevents you from just holding an extra zwplug reference while
> blk_zone_wplug_bio_work is running?

Problem is that this extra reference needs to be released in
blk_zone_wplug_bio_work(), before that function returns, and that is still the
work thread context using zwplug->bio_work. So we always have a small window
between the ref drop and the zone BIO work thread completing (context switch).
If we get a BIO completion in that window and free the plug, then the BIO work
struct may go away while the work thread is still referencing it.

Given that freeing of plugs will happen only after the RCU grace periods
elapses, I think this is all very unlikely to happen, but at the same time, I do
not see any guarantee that this cannot happen...

-- 
Damien Le Moal
Western Digital Research

