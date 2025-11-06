Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470E2218596
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 04:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762403415; cv=none; b=qYT+y/Lw5YnBaga4HxnWlyDsSovEqXsWhQ6QQR4Z8+DjF6NTct+majoskCtqRYugZeKrZWqAohWgyOaTj8RsoZTEEFwwMIsjg3KNgV5SayCUrbbPpvTis95xu412UHhTBr2jRut4MpYEDZ4lEZEasncuHdhpBcxk9CinSXdINbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762403415; c=relaxed/simple;
	bh=Ad1bnRlHYMdyEjV3VVVx6AVKw4rjBrMqscqnbOUE17E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uj60D/1BYvQtUsu08LfAd98CwxyglbvKvEOd57XUiuUHtAtQsgI7n8bdnNaEiqWMSQKKNDZxmGP5+caa/Vc5OUNsA1jdtPE0rzBqwywQWZge1TYbG0R2nnn+3ME3uqoLgl3w+sQVOBX95c/nF3tolegv7B/jhS0OSaaq1FUm1Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObYaZ+/H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObYaZ+/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793F5C4CEF7;
	Thu,  6 Nov 2025 04:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762403415;
	bh=Ad1bnRlHYMdyEjV3VVVx6AVKw4rjBrMqscqnbOUE17E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ObYaZ+/H/e6aZwjN+/ZEpnvpOkV/xXrNOedVTgKrFmcsBdKhy/z2Oon4JG1TdfwtE
	 CPTf7oD4BWj7YsW6+/RJpTWS+07/+BeQWqxJ+4B9ceKnxAJIyThHVrJSyNnEtencI+
	 kW0yx+J5TFHjo9SzgqswsKzq3pKNXV8Q8Ubl9b7ch0eGpBu8SbsPZtU3VY3meNIhOB
	 5W2rVurmFeM5SQNtPuJmu3QI+5YzQEJCM9O76v2SMJDNtf3RXgOm0mWZ41DTbgy9lG
	 djVAC0KjqdYK4k6ufMZ5CvZh0TP03wOfjQxfhMXrxOa0MRLHXYVyytb5Nc1il4mEwI
	 Ef2Imo9aIeydA==
Message-ID: <96bf8c44-1b29-420f-ba99-856c00606000@kernel.org>
Date: Thu, 6 Nov 2025 13:26:21 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/4] null_blk: single kmap per bio segment
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
 axboe@kernel.dk, hans.holmberg@wdc.com
Cc: Keith Busch <kbusch@kernel.org>
References: <20251106015447.1372926-1-kbusch@meta.com>
 <20251106015447.1372926-4-kbusch@meta.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251106015447.1372926-4-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 10:54 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Rather than kmap the the request bio segment for each sector, do

One extra "the" above.

> the mapping just once.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Other than that, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
