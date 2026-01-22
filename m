Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2854934F265
	for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769061163; cv=none; b=GdgnEPQQJexKzObxEcrVfuMaj63vJMt5L8oC5n3zD1YI9SFyvk7ffrKpQ2upUcySJBiXvhUS05OQ+xizDRULZz2U2GAVSbGz8R2IpdaQ6uPX39cj9uXjE9Lsq4QvG3Eelkk1VTULcLwLWvFCScyxq8lqkMFPoJp2UmIFfucp83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769061163; c=relaxed/simple;
	bh=42URolF5j1UxfDtHhDYr0S0Ki6I2tWH7NhZqS4hCuJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVzD7ogMNaPC4rkhM9dwqt5GjduA7EAkqxAWsCTOLpx0LDUBYNPvy9q9kvrGGVyDhMdXKnV/05+7F/dsmyxhQwi+RrDLSc7S1RHcE+wqyR7S+/CfjNyzdea6L4kRhYTxXR2IfDF+0UHPg43yQVuQwQcCPUERThSNOuVqlUNxkSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5+pN1XO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5+pN1XO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEE0C116C6;
	Thu, 22 Jan 2026 05:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769061162;
	bh=42URolF5j1UxfDtHhDYr0S0Ki6I2tWH7NhZqS4hCuJc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y5+pN1XODin/jZFw1uB6rSN8B/0GvhmU3Agseb/M3ORkByYX4jFBsd2obLvZbJ8Qw
	 j7gwqRkBcWJDKlQlZ1GxsoUHiX3LFvDsg+WVw5s9ZNMZ6JiookEEzgTuuN424ApMFs
	 shMZchlEvt32zCYMA2rkTRg4Yj6EcfS2vJMXRAtKTJ/Dg0yKs1T2e0Q/cWaRxaNIpk
	 n6DaPPMVwAFb27sglEAjPPPDYW+32i3r9OG2XCh4r2djBIQMh2oaww0jvUpsCovCqb
	 KvOgX4Er6HypxOX9dnnqu4cx5IdrDQ3skSaTafKEIFHV/jf2zCfwVlIwJimTDyixqP
	 sqCaATLmeMuig==
Message-ID: <dd97dbe8-5f8a-4d05-adb0-00c0189132bc@kernel.org>
Date: Thu, 22 Jan 2026 16:52:39 +1100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.19] block: make the new blkzoned UAPI constants
 discoverable
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, aalbersh@redhat.com
References: <20260121073203.234429-1-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260121073203.234429-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/01/21 18:31, Christoph Hellwig wrote:
> The Linux 6.19 merge window added the new BLKREPORTZONESV2 ioctl, and
> with it the new BLK_ZONE_REP_CACHED and BLK_ZONE_COND_ACTIVE constants.
> 
> The two constants are defined as part of enums, which makes it very
> painful for userspace to discover if they are present in the installed
> system headers.
> 
> Use the #define to the same name trick to make them trivially
> discoverable using CPP directives.
> 
> Fixes: 0bf0e2e46668 ("block: track zone conditions")
> Fixes: b30ffcdc0c15 ("block: introduce BLKREPORTZONESV2 ioctl")
> Reported-by: Andrey Albershteyn <aalbersh@redhat.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
