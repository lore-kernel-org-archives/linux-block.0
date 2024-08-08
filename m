Received: from lounge.grep.be (lounge.grep.be [144.76.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E945228;
	Thu,  8 Aug 2024 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723100134; cv=none; b=dvRPRWOPT3gSvvFVRFbfJYDdywRHbrjO+DNpV3h9aKW30go0p+yaL18h5VNn14gb1rN7EfnQLD0JBkdMIjZMuNtvAfGdmkV6HGDlp5RwokyFE/+8ShyiLhe4g3Rr0WEiBS/6zWVvjqusT4FXw23ybbKsKr9aYTwKfXD9nmGLsbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723100134; c=relaxed/simple;
	bh=NnzCTWKFk4fMDzybs5ufDvwnluiHHkvq8tShRnEldW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEhVkAYaYmRM0Q185w+xgdWs2SCz56387aW518ld/SMSHRIZZQVmVHEtWoKArRXxreiRnBljLcYoQnqLN579meTEYQwwYgmEYL5U/bs/ODArlbsz/3JHY53L+T1kS3YBcL5+eLeY9mn1wt6zmSwE9DEljOonM8Fd7fW6NEAdN8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uter.be; spf=pass smtp.mailfrom=uter.be; dkim=pass (2048-bit key) header.d=uter.be header.i=@uter.be header.b=S0ZvMeNn; arc=none smtp.client-ip=144.76.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uter.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uter.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uter.be header.i=@uter.be header.b="S0ZvMeNn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=uter.be;
	s=2021.lounge; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CkNQ++hXOcHLfwKCSMCwfF8NRO3P+JNlXngejOjZghQ=; b=S0ZvMeNnnjtmOJADtybifiI/sS
	NcmG5eoqDLvMYm8Pve9jqUor6pEvq+5JApd46AyrJ6ugV/RT0O9HNmSsrbJWbyhog3RKe/G0GZS1S
	+WsS6u3Hr5pt/u6w7tvFDkrTLY8ZhefawnhsWZJxN0Mk1vIRcVxdoTe3/RPPALZdjOf5MgGKby+p0
	dXb0w2soa8Icto3I4Nuao+PRKGrrttX/HW2OMFCE0a7cdpAGBo066Xo6P+0RuIs3H7HoebMbeU+UD
	o7fO3YVdH2NTOABarSM/MZt8O8c7cHExrdWpT+tYIXdEl9BvWmeoD8fSd2LZDZU2hVDXH3oqo5fao
	iNqIIKJg==;
Received: from [102.39.154.62] (helo=pc220518)
	by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <w@uter.be>)
	id 1sbx3N-002Rr1-0o;
	Thu, 08 Aug 2024 08:55:17 +0200
Received: from wouter by pc220518 with local (Exim 4.98)
	(envelope-from <w@uter.be>)
	id 1sbx3F-000000001HC-21dN;
	Thu, 08 Aug 2024 08:55:09 +0200
Date: Thu, 8 Aug 2024 08:55:09 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] nbd: correct the maximum value for discard sectors
Message-ID: <ZrRrzTKiAVXNItFo@pc220518.home.grep.be>
References: <20240803130432.5952-1-w@uter.be>
 <20240806133058.268058-1-w@uter.be>
 <20240806133058.268058-3-w@uter.be>
 <20240807135625.GA242945@perftesting>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807135625.GA242945@perftesting>
X-Speed: Gates' Law: Every 18 months, the speed of software halves.
Organization: none

Hi Josef,

On Wed, Aug 07, 2024 at 09:56:25AM -0400, Josef Bacik wrote:
> We use 512 as the "sectors" measurement throughout the block layer, so our limit
> is actually
> 
> UINT32_MAX >> 9
> 
> since we can only send at most UINT32_MAX as our length.  Fix it to be that for
> both patches and you should be good.  Thanks,

My first stab actually used UINT32_MAX, but that didn't compile.

I investigated and found that for the kernel, UINT32_MAX and UINT_MAX
are actually the same, but in order for me to be able to use UINT32_MAX
(or U32_MAX, which is also defined to the same value), I would need
extra includes.

So I'll stick with the UINT_MAX >> SECTOR_SHIFT definition that Damien
suggested.

Thanks,

-- 
     w@uter.{be,co.za}
wouter@{grep.be,fosdem.org,debian.org}

I will have a Tin-Actinium-Potassium mixture, thanks.
