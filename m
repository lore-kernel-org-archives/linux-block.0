Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A7415B8D;
	Tue, 13 Oct 2026 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791935128; cv=none; b=taiRiszHAU3V6cSL3oYkbz9TFlKkCGSiaiyE673LmEJT5A0sGTpgZuuRdWNGgw9eJbThatqQE8cvW/uf/FekEJ0vGB/UqmmDSmTh4GcZG6AiS5Ab9JFHTEQhYnEk8D3d5KEs2NvrVJAuWnYRFZbJ8dx9sxhz32H0nHlDe/8oflo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791935128; c=relaxed/simple;
	bh=E2SRLwBhsoTVQCWZL9MswjQ51kFIU/xAiCTLUsPD7Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+n/ZaZ43QktNdh9xW9ovJ2TzufCkeb6u188MTH97IVbEw65AQaMQcd5S5/Ylx4ulcFETFpCPDk315ZbTtfvKX3MYhh+GVdFhKjUETvd4XLfctXTpTc3LarBarlOOrzXMbLfGr19cixb2pXkmdolo6uyFPd2bynhOrbncUwVgq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tctq7FOn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tctq7FOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7858E1F000FF;
	Tue, 13 Oct 2026 23:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791935127;
	bh=JRQcFAaXE42Q46CGG1OilPTqh1FMkeWmX+Y2cpDaarY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Tctq7FOn+6Xg6NQlBzkOcDB0HVNIPpSWP1EJFfv+RctMsN2cpMUeYozc0QNGe+pzb
	 XJfshPloZ/3riaPRoo1bIS5VburfYe4Kl4Y1QsudTwF4lS6pxfPMaDv9fIfVKI1UfW
	 x8WVRzKV/0Yon/bHTWnDpnOdkQ4ttZjBW9dSJmUSQGimADOF25XDtzYKJ9KZTBYDem
	 G/3RFWwAZPEmin9QaYAevEhFWwrRwFg7ROMr/4XjL75fjT79VrUOv7EaE2vyGh4ATz
	 BskbKlnkmnKPVrGhv7h5TsriDepQVYJaykDEAf0l50BPq1LwnDivHwUqpR7fJTpxec
	 y8wLbixFXThrQ==
Message-ID: <e68aba76-dc2e-4381-b0f4-846756611ffa@kernel.org>
Date: Tue, 13 Oct 2026 18:45:23 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nios2: fix __wsum type degradation in csum_fold()
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>
Cc: schuster.simon@siemens-energy.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, lftan@altera.com,
 kernel test robot <lkp@intel.com>
References: <20260922153416.730513-1-kbusch@meta.com>
 <as5I8gmaWXr5OUgb@kbusch-mbp>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <as5I8gmaWXr5OUgb@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/13/26 10:06, Keith Busch wrote:
> On Tue, Sep 22, 2026 at 08:34:16AM -0700, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> csum_fold() shifts a bitwise __wsum type, which sparse reports as
>> "restricted __wsum degrades to integer". Sparse only checks the body of
>> a static inline once something instantiates it, so this went unnoticed
>> until a recent block layer change added the first csum_fold() caller to
>> a file built on this architecture.
>>
>> Force cast to a __u32 for the shift, as the other architectures do.
> 
> Ping on this one?

Applied!

Sorry for the delay.

THanks,
Dinh
