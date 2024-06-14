Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB96FF503;
	Fri, 14 Jun 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718383080; cv=none; b=M/CcKBFrIFQuZbrg5yNvBnyFpj5GoDhEqnsDZjhXwtilyZCiy8uhQiWywaKFbQmx7CDbs6Xr8yLVKv4rzZgSzgO0GOvC8+vaJ9DpPSijaPVAITAaFmUp5tu2wzmMoMVpx9nTEcA/8CclD0Ma8pnYAKcWmDHemo/GZ/oyToLdXDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718383080; c=relaxed/simple;
	bh=rbI461EkY+O82rIdLacESjQh8e+TfXTNTovVptOP7fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNStWP6r9ZGpVsqspWCSGju2dY5fa34bXkZjMBh0Jqc4PotWekDSlmFn+MCdiCVbCGtJVZaqsJYxyWYvloiwPlwv8U+cWfTo+lPZ46Hmx/1xXlb83oK+s4ZICglOfxlKi5xz51BluHGks4+JpEZ7QCkg2xRErJzucrK1vWr45d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WJ7vDagc; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WJ7vDagc"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4W14hQ1VNgz6Cnk9T;
	Fri, 14 Jun 2024 16:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1718383075; x=1720975076; bh=rVAOoiL7T4sp9wV/qU37I9CI
	ad3CMpyP1RegUn37wuI=; b=WJ7vDagcJqVdIx5I/nK9aMkaSyq+Y+huyDTxVgus
	02/pGiwkSYs0z8f3lnM672oaCU6ma1CgCLv6T+687Dr07ptt+WKv74aF/pj7d/i7
	SYVtMD9ZXCAOib8zNRoWIlry/rzlRRHnP967/t2lJXjsxUQcuQNyC+a+zauvJGBi
	YShmbNcxHygeVduysRXQGv94LXR2kOmcDf5O7xJ2+tkfnFt56g5guxXNjY5wOcNY
	OfoB19+OXjzPHrsrZzrpDl36aBvW+ddFfLvITJgEx51Z6gO+W2+Fdo4yUES5ha4X
	N4oofHI9zyTLFYxZ5EqHoIgwWLNJPSjmP/XWYHz32Aj3QQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7p7AI90NQFEY; Fri, 14 Jun 2024 16:37:55 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4W14hL6KVSz6Cnk9B;
	Fri, 14 Jun 2024 16:37:54 +0000 (UTC)
Message-ID: <b628c844-1e3a-4c5f-9636-dad570a70517@acm.org>
Date: Fri, 14 Jun 2024 09:37:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block: BFQ: Refactor bfq_exit_icq() to silence sparse
 warning
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
 paolo.valente@unimore.it
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 jiapeng.chong@linux.alibaba.com, hch@lst.de
References: <20240614090345.655716-1-john.g.garry@oracle.com>
 <20240614090345.655716-4-john.g.garry@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240614090345.655716-4-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/24 2:03 AM, John Garry wrote:
> Currently building for C=1 generates the following warning:
> block/bfq-iosched.c:5498:9: warning: context imbalance in 'bfq_exit_icq' - different lock contexts for basic block
> 
> Refactor bfq_exit_icq() into a core part which loops for the actuators,
> and only lock calling this routine when necessary.

I like this patch because it makes the code easier to read.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

