Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A021991CB
	for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 05:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782538321; cv=none; b=ntSYt7FRXMRfsP3M06Tefm4G8JwPN/W9/8R7Y97Wj+MH8nfBLTHvuu3TZ+nRonqt2gHNUTu/lUQ+LQkZPRqUle6ARPVldBgGBjIqV+6dVux0Jc3aXrb1RxiN0EIXmNg8K1WFrT+3O8Re8Rd9urclNvQWCVUmoQS7/nBlwY4Hpfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782538321; c=relaxed/simple;
	bh=8+MwDwY+3N//de6DT0Prui1yUX8S5ksBqWPbD8cZDuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZV3MosFkNlXiN9Pfk1E/87pSweOvI2EGMOOmhzE+mNsEOepQUOjTk0QW9adrzlh3/Ill3IfsFvIrkVJo0mvoAKOJmhCDGkVYbnqhY8EOLnKhmrjCk3dBRsL3I9dez1yXjDh7TqLSTC8knBB1qWtVOBjE4mVxLA+dK6sZUsUAgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ocgZ3XnY; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ocgZ3XnY"
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662] ([10.64.95.103])
	by smtp.orange.fr with ESMTP
	id dLcuwbw3fDSdBdLcuwjDP3; Sat, 27 Jun 2026 07:30:48 +0200
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id dLckw7s7OZD99dLckwsGIO; Sat, 27 Jun 2026 07:30:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1782538240;
	bh=9MtTApikuDwgP7GBxSVbUkSkszDju+RzK8kE0nHF+h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ocgZ3XnYaLc7o8vSOTMYqU0nCFScKOVtscVYrKvv1gV6G8X+SuAkk2L+gElT11yxn
	 NpQATj3iMCFkdq0Reg+04dRByLufdFhbx4s90SQ57mDHf4vcSi71VPW9fBLGlxIwRc
	 wG0bmy//lOSUSsMjf8GrgtpiJQBiKr1aALzIEzIeJiVNXcw/CLhSN5kEJWvqOEibtL
	 Xsjuw2k7Qpa76/D5kvbD7AUlmvOTX2fsKyCZs+4T6A07Q67eBwI86igNT3VhHVtDWu
	 JuH7d5HIvX/pOdxq6NJewPJ7JX8vY+gMk52ezU29hvZVMJpZmzQBDYduBnFVwHyInV
	 HJfz6pF2ss2Pg==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 27 Jun 2026 07:30:40 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <630e1d4c-3302-4d2c-a90c-5b3aedfe8f6b@wanadoo.fr>
Date: Sat, 27 Jun 2026 07:30:37 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: block: partitions: Use seq_buf_putc() in cmdline_partition()
To: Markus Elfring <Markus.Elfring@web.de>, linux-block@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jens Axboe <axboe@kernel.dk>, Josh Law <objecting@objecting.org>,
 Kees Cook <kees@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
References: <59dfd2ef-2fda-4dd0-a288-52c35613e778@web.de>
 <196e07e8-aeb4-478d-bb05-1faaea976e08@web.de>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <196e07e8-aeb4-478d-bb05-1faaea976e08@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 26/06/2026 à 18:48, Markus Elfring a écrit :
>> All affected source code places could be adjusted at once
>> if the change acceptance would evolve accordingly.
>>
>> 18 source files are left over for similar development considerations.
>>
>>
>>   block/partitions/cmdline.c | 4 +---
> 
> Will development interests grow for remaining update candidates?

These changes are pointless and already performed by the compiler. See [1].
So from my PoV, they only trash git blame output and make future 
backport harder.

Just my 2c.

CJ


[1]: 
https://elixir.bootlin.com/linux/v7.1-rc6/source/include/linux/seq_file.h#L127

> 
> See also:
> Clarification approach “Using seq_buf_putc() calls more often?”
> https://lore.kernel.org/cocci/3455eaa7-297f-46c9-a8ab-91e5bfbe0105@web.de/
> https://sympa.inria.fr/sympa/arc/cocci/2026-06/msg00030.html
> 
> Regards,
> Markus
> 
> 

