Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5713D19AA5D
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734628068; cv=none; b=kv/r5y8w7Mup4Pc8rC4lC9esicl/lz8mQucyjY3qKgOVEH28xD4aQWf9tpTADyIrJr1z5fSH4Lku7SMNhoA6phcJRmUDCna2fQbWr3UdmMU5Eje8JEmwJXT27d3A0oirwXR6oAMZp9KgOk+/GgPwOuJVHsNbCzl8n/CC9a7jBCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734628068; c=relaxed/simple;
	bh=FF5QLmEneZyTzQDJfO01wlK2VLVJNP5I3e7S5jBwGug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5EsdX2YUZ+XdSYQIBYbN9SYqiidzGoylGrwODWfHb768VNm9NbKD8zyiAlYawo0k9m5YH1n1uXF1Q3bicLqR7dArwUQ4PtrnDjfQHSHOWAXcX3pYGWGRN5Yoa2jQnXm04hXdCmN8FnK5csYC61Ej6XWeqNOiH8tp2rrBYYzmr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=bD4q6FCY; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="bD4q6FCY"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YDcS25Kr7zlff0M;
	Thu, 19 Dec 2024 17:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734628065; x=1737220066; bh=FF5QLmEneZyTzQDJfO01wlK2
	VLVJNP5I3e7S5jBwGug=; b=bD4q6FCYcLMUUDUTqNQ6EDLjttMtO0F+i4UgWwR+
	2WfL9ILJsguf+XwpyK1VICcxbzuJXMMjqg1gXIs+GeVqRu6DqtmcPceLPPaupq82
	k25rdr9UkcZMXnXN3hk+xAmtUs3XtGwL18uo9chq07UgmxM+clv1CZysW6Ef1TPC
	9l8GwG9BL6ZYEsfB0DINfXrNqtHQg+PwUIoIdTFZrKQKoeUICwTf5f3VhzVe4ThH
	UufTNr6c/kH6THNAm/I7Ek319VfuPkKJtksNX+yIo9RpVXhCvgAPU7Lx9W4bx+n2
	6m5Lh832zCCOFxhnZxaX0u192+pEtEC7Ww+p8QmUl/t4bQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8JfSuI6rg58t; Thu, 19 Dec 2024 17:07:45 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YDcS01Zs3zlff0K;
	Thu, 19 Dec 2024 17:07:43 +0000 (UTC)
Message-ID: <23eca555-9339-46e3-b0fc-5f20bb7f6584@acm.org>
Date: Thu, 19 Dec 2024 09:07:42 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <ed186d84-1652-4446-8da1-df2ed0d21566@kernel.org>
 <ba8caf98-8b09-4494-add8-31381b04cd33@acm.org>
 <3bc4b958-73ea-47d4-9b94-299db1f7ee3e@kernel.org>
 <955aacae-7dde-41a2-8eb9-3bbeae8c3d18@acm.org>
 <5534fce5-4fe3-4979-bb04-5cbddf613d0d@kernel.org>
 <20241219055518.GA19133@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241219055518.GA19133@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/24 9:55 PM, Christoph Hellwig wrote:
> Let me throw in the reminder that every experiment at forcing order
> has failed and I'm still more than just skeptical of Bart's hack.

Huh? This patch series only makes small changes to the non-zoned block
layer code and is working very reliable on my test setup and also in
tests with error injection enabled: "[PATCH v16 00/26] Improve write
performance for zoned UFS devices"
(https://lore.kernel.org/linux-block/20241119002815.600608-1-bvanassche@acm.org/).

Bart.


