Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C2613D89B
	for <linux-block@vger.kernel.org>; Thu,  1 Aug 2024 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529355; cv=none; b=tu5/LgE6LYTP0XB7Lfv9oaa4qjAQOuY8gt8RBU3nIkMvRI6BQF9d5bqiomv03ushQRNqJeTPi+LmyapzD2hZsBDILgdRzthVusgNBSQk1NxRaZgN6eEZ9z91eTiwZlBrUU+az3RKxuWyb4uaWcs29nJfZnDzF5eHieFgB6SSMHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529355; c=relaxed/simple;
	bh=NVFYPZ6EMEc945mjyF9ZIdWz5rT6O4WOScC8hIcNrDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dnV7028z1i1WCV2ShVB1Y+/CgRGfeqs8f3SXb2ZZpvFM5KUlYfQVRX0cTH53CwbDMk3npzguIEZGlsfIlBDDQJjy4c4PA4JXBUbwXltWLpiGEbBsF/+zOlwWlCzqDaMfTuIeR3XB7x7NPoaSbUw8OfPy9Rc3LBC4uez0zp7zlio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vIMBLsf0; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vIMBLsf0"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WZZ4T5157zlgT1H;
	Thu,  1 Aug 2024 16:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1722529351; x=1725121352; bh=myvGz5p+zZw0BkyTAHiOiqPT
	4LgTt+OhXWHCMR3dbqM=; b=vIMBLsf0b4kFKn+CavIR9nLAdj9F4b+sqBcCfNHN
	xXGu5mM4MmcoDn7PNouwell+n/zjIdaFWDmD+hXJoJQfCBoNGBcJ9rZzysNsRqJt
	KWHCeAbIpoWHa9LjMqbP6uEUCFAL8quUt3+wsBSordysAWuFt0XSyFBIJjuQPJxu
	+N/PSJwAhAbeDaCcLWeL0WGlBt7AtrQ4+ml/wUQQUWlRNZ+wb9Hg98m5iEN9bt86
	k3FAw8deKiAKS7TYVXjAKDocoOJ5De7Lmm6dvEoPw6t/yeFi4I1e45wx/d/OSNP1
	SC96vNoogBar1Bejd9e9fQ+o8eAMMyctIdrzwbANBNBaMA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7qL1I7PzuWKp; Thu,  1 Aug 2024 16:22:31 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2e14:8:b0e8:3901:a8d2:924f] (unknown [104.135.204.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WZZ4R1JwRzlgVnN;
	Thu,  1 Aug 2024 16:22:30 +0000 (UTC)
Message-ID: <932044b9-fd7b-44aa-a5df-ff6eedfb2aeb@acm.org>
Date: Thu, 1 Aug 2024 09:22:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 blktests] loop/011: skip if running on kernel older than
 v6.9.11
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: chrubis@suse.cz, shinichiro.kawasaki@wdc.com, gjoyce@linux.ibm.com
References: <20240801092904.1258520-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240801092904.1258520-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 2:28 AM, Nilay Shroff wrote:
> The loop/011 is regression test for commit 5f75e081ab5c ("loop: Disable
> fallocate() zero and discard if not supported") which requires minimum
> kernel version 6.9.11. So running this test on kernel version older than
> v6.9.11 would FAIL. This patch ensures that we skip running loop/011 if
> kernel version is older than v6.9.11.
> 
> Link: https://lore.kernel.org/all/20240731111804.1161524-1-nilay@linux.ibm.com/
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>    Changes from v1:
>      - loop/011 requires minimum kernel version 6.9.11 (Cyril, Shinichiro)
> ---
>   tests/loop/011 | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/loop/011 b/tests/loop/011
> index 35eb39b..a454848 100755
> --- a/tests/loop/011
> +++ b/tests/loop/011
> @@ -9,6 +9,7 @@
>   DESCRIPTION="Make sure unsupported backing file fallocate does not fill dmesg with errors"
>   
>   requires() {
> +	_have_kver 6 9 11
>   	_have_program mkfs.ext2
>   }

Please add a comment in tests/loop/011 that explains why the kernel
version check is present.

Thanks,

Bart.
