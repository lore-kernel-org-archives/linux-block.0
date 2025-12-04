Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C71D9663
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764855921; cv=none; b=lUGO5n36+n2GbhWaIY99tWVZpYKbLU/WFe+DzEEmdibqx5BSvOCXazm8mzRuQsQutlmYOSjBVuW1t72eaZBUaBTtFB9GrKx2/2k8TvkBhaIuWawCw8+d3+8UP/B+k2OGeTzBfb7v6JBBqcz1S0LhAPqb9LR7Fyiyj2GiLyAx7wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764855921; c=relaxed/simple;
	bh=CaDiRWR4pMSlQL1OngJdH7F/25v2TwRbP0pu1FcaDoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVZc04l6PrO6xoZjJmmGOn84nE762ugUreSNl+OFg0I7mZpLTsT2ZQLdjXnn6KkeR+SGbSpvAdNuNgBb0Ciz8DINpxEYOJDsBQSdvFqaX4M8vDuwVJW9mtJuCUdC8fn95Li6UZu5HaRoM/dnR2vxYhAZliO939MVBMwayaw3B4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXQYbmAK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXQYbmAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A776C4CEFB;
	Thu,  4 Dec 2025 13:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764855921;
	bh=CaDiRWR4pMSlQL1OngJdH7F/25v2TwRbP0pu1FcaDoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CXQYbmAKcBXD+cJ9Re3o11B77pS4WlXpLQRkFXt0r+Ntkhw3FcjqLHyNu0b+S1YRS
	 xQ2keINo9Gt3RBGOIPfZpPJRIF7jMaJ2wMVSP8kGaN3g/3f+XUUJTEd7YNa8hnuB2R
	 mXvu48mJlcDyOFDOLDui0wjUei/xENmVHEjiUY3BmPQigLUh0gKO5zNPN/159Sc3WX
	 GxFcB/gr3jZh1AW8NnJX8gSegSxvU7uAAjNXUmWX7Jffa14OzwVW2KDXPiTNLtIGsb
	 RGubTUi+NvRmav6DRj2yUjIEr9bJlsUbeDzdSKF9nB/59ksLVmLYXMM5LVuNZP4xWv
	 ElHSWlhYkqmGg==
Date: Thu, 4 Dec 2025 14:45:17 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Clear BLK_ZONE_WPLUG_PLUGGED when aborting
 plugged BIOs
Message-ID: <aTGQbae97JLxouuS@ryzen>
References: <20251204105952.178201-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204105952.178201-1-dlemoal@kernel.org>

On Thu, Dec 04, 2025 at 07:59:52PM +0900, Damien Le Moal wrote:
> Commit fe0418eb9bd6 ("block: Prevent potential deadlocks in zone write
> plug error recovery") added a WARN check in disk_put_zone_wplug() to
> verify that when the last reference to a zone write plug is dropped,
> this zone write plug does not have the BLK_ZONE_WPLUG_PLUGGED flag set,
> that is, that it is not plugged.
> 
> However, the function disk_zone_wplug_abort(), which is called for zone
> reset and zone finish operations, does not clear this flag after
> emptying a zone write plug BIO list. This can result in the
> disk_put_zone_wplug() warning to trigger if the user (erroneously as
> that is bad pratcice) issues zone reset or zone finish operations while

s/pratcice/practice/

Regardless:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
