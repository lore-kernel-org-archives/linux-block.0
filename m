Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620F41DB12E
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490388; cv=none; b=m6Efp6lgrjEMueOpXnR75oLBcLw/f48vPF0rJepEJWOJIBvSdxWGfIzNT8YZkPMmlWW1nc+EW3/xns85NETkqkuT5OJeMupanw7UWnwALBvfqG+rnxdg2KvvXB+6ruZts7diqwdxye/LLdjgAjmIHUQGoNR2IZX4VM+kE0zV+Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490388; c=relaxed/simple;
	bh=8RMS2t7p+/DIKK+GQvm/T5hHts/G9Z9j0rQir9+Hhcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tPPQlMNKMmr/VJdyfiCmFITxtDxn91ltOhOQtZYppWopn9ZVp3/96JZW34ftvOB0v5VJ5K51xyJMahv+vJ+B1MDNbbIxhPLEVqeQ2fmhMB7ugHCLzHP24Nk4yj0iW5BuOOSMTA3EhlIgqggWxG1WebNhoeN5MqfPJOXHQROdewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=yEJBxbyB; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="yEJBxbyB"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bGJss30Rnzm0jw1;
	Mon,  9 Jun 2025 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1749490384; x=1752082385; bh=CNtjyNoqilv5LK+cwU5T8NS2
	WYDYNFsGH/Z2Sn1mrxE=; b=yEJBxbyBmVp0D+UynyDrrPLEGnxKAeYjaxADdCEu
	+ZD/g8Ti9sZQZ55frhumzcF2iGTgu6X0gxK1Z8S+uW+nMbVYgNqtGZUZ1CMwHo7C
	+eowvcPYfImFDWqe9eKeabSngmYY9JzlieJCT01S3C/x08y3ps9G1d+xf8liGjW1
	hLN7euzHT3jUjAINj4FQxDrmqzrNvqaKhzxlhAS9gNSyZRbWBKU5L/CSY7goHxxW
	qoSmEcYVDwv3Zk9balvUF0BCXYekgQCb80XpQkde3uEIsqHQSgaJmfrozCwvYUBT
	bTmtCTtUX0d1hu1CrxjqoCQZ1qgh0YETGcbN+6nldG8HTw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hNv61PzY72C9; Mon,  9 Jun 2025 17:33:04 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bGJsq2yBbzm0ysf;
	Mon,  9 Jun 2025 17:33:02 +0000 (UTC)
Message-ID: <b3d0e986-9e6a-434c-b73f-3801f0e8c49a@acm.org>
Date: Mon, 9 Jun 2025 10:33:00 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 1/2] check: allow strict error-checking by "set
 -e" in test cases
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <20250606035630.423035-1-shinichiro.kawasaki@wdc.com>
 <20250606035630.423035-2-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250606035630.423035-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/25 8:56 PM, Shin'ichiro Kawasaki wrote:
> In bash script development, it is a good practice to handle errors
> strictly using "set -e" or "set -o errexit". When this option is
> enabled, bash exits immediately upon encountering an error. There have
> been discussions about implementing this strict error-checking mechanism
> in blktests test cases [1]. Recently, these discussions were revisited,
> and it has been proposed to enable this strict error-checking for a
> limited subset of test cases [2].
> 
> However, the error-checking does not work as expected, even when each
> test case does "set -e", because the error-checking has certain
> exceptions relevant to execution contexts. According to the bash man
> page, "The shell doe not exit ... part of the test following the if or
> elif reserved words, ... or if the command's return value is being
> inverted with !". The blktests test case execution context applies to
> these exceptions.
> 
> To ensure that "set -e" behaves as intended in test cases, avoid the
> if statements and the return value inversions (!) in the test case
> execution context.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

