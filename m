Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6865015A8;
	Thu, 31 Jul 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753975455; cv=none; b=As8FbzP5pnJIiD7sEwdBcbuG8jBcGS7ZJEv6XiBmBzR8jB50jcJEsMVjG0rGaCWalYt8o1Ej8++jtqZrp2ObZowgWhGYrYPib9UT5bP7/U11mmf0kvwa298axAiVvqaAFYAnV9UYjSm4OHaG4Es7vDLnxNw3SoXgTePzgeOobrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753975455; c=relaxed/simple;
	bh=o1yFhBXe6Df7icg5S4t03u8nAe3RsB2OOTx7cXSxsKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQFm6AafodDHbgPHrSsAzobmttov9pU7UA0M6sHiKVrYOSoJR4xvnBBbcPDvm1XqS4swy9x5RNUSAGT/Y/eT6W7rSxhA8Xo0UG3df7jd1ZAOKRlciAzTlj1frUnrhwhhOpAx452v5g30M4/MoVVWa4Y/lo8+ryAS9N9MgfTltMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=arDw/OwB; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="arDw/OwB"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4btCY82LMFzlgqxq;
	Thu, 31 Jul 2025 15:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1753975450; x=1756567451; bh=o1yFhBXe6Df7icg5S4t03u8n
	Ae3RsB2OOTx7cXSxsKw=; b=arDw/OwBjKPG/IlbBBa0POdIU3kjKUJACJumsbkW
	uEaLuCG1VslvRaxLE5sr5BKH9A46j2S2ns0VEVFAvNYadcgrJns76QOACzmy3hrd
	A6LLC93g6/sll7uCsuZWwFsfOf/WJjcRd5OfGRSw4vwnf5XFUR/nNn57ddzxDNiH
	H0iYrSHUG/wS7pRGT8tY3KeKCu0Z3UcQzacZXOd3IG5gTgub6KyRdK8Wyhga/83/
	82+YhrzyXLAcPrXU8TyYmGsjXwglxS82cPHW+RGzt4ip5nM0n057qz2eIWlrbwpo
	m8Y2b0jA8Pjt8qLlPo9zE56sR38RD9JxgJLo5W3NLbFbTQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Et7EXzwhqAaU; Thu, 31 Jul 2025 15:24:10 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4btCXy6YhNzlgqxh;
	Thu, 31 Jul 2025 15:24:02 +0000 (UTC)
Message-ID: <46a544bd-a3dd-4a6f-967c-74c3bbe8f18c@acm.org>
Date: Thu, 31 Jul 2025 08:24:00 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] zram: add async writeback infrastructure
To: Richard Chang <richardycc@google.com>, Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: bgeffon@google.com, liumartin@google.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org
References: <20250731064949.1690732-1-richardycc@google.com>
 <20250731064949.1690732-3-richardycc@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250731064949.1690732-3-richardycc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 11:49 PM, Richard Chang wrote:
> Introduce the necessary infrastructure for performing writeback
> operations asynchronously.
> It adds a dedicated kernel thread (`zram_wb_thread`), a request queue
> for managing pending writebacks, and helper functions to deal with
> the writeback requests.

Why a new kernel thread instead of a workqueue? More memory (e.g. for
a stack) is required when a new kernel thread is created compared to
using the workqueue mechanism.

Bart.
