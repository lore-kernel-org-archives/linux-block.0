Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252A63CC7F5
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 22:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778710455; cv=none; b=BD15l5b959Hs+wvXg2560yXxVwchix5MM31FGVHyDs/gtd44oen4Lkt6fWwV5dxSf3nGh0hE0piFA9DfLBZ//tFJiG88xf0dvugc+xPQm0Cbbm37FPXr7jdBcwv41Woh2dEiXW1o2Ep7LiiZsGsFsOCBZT5i6zQL+extXWRjxa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778710455; c=relaxed/simple;
	bh=yyEH/U+g3fVcijk25ZndnGTGa52zozAJ+u2EftffBcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5jfaLSX3M+xEr3oEXtK/cLdbBvhKtD8bVdXZe3Mm6uRhcXaSomM0gZ8E2t/VKzJfRIxCJipTZ/N3PlQ3U0KqWI+lFQAVHx+thDsvHmrtVUEeEhzPVFnPrj+70/wNu0UVxhTJE/AhVxAJvUbIbNtScfGQ0MGtiRlwsCPUPypNes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Mbit0xHr; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Mbit0xHr"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gG7640sL5z1XM6JX;
	Wed, 13 May 2026 22:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778710439; x=1781302440; bh=91Wdd0jWJhPhn0Rw/F1nwHjW
	yxYaHuPlJw3w4bQOzLQ=; b=Mbit0xHrOBDdchcd3gSH6SzsXj/WSQ3lk63gIgKa
	OMH3bPj2FqXgY8MkUneYifmlRb878Y5U8ADYmiCI3kS7WFaExZjTqk8nDy1mCae3
	etqCOruvaGL5rxnHxQlINOyR4x14AzSfbjlZhIEGqwizK0NdiSew16i9jYavbzpO
	2Pwn1UV1MBQD6ljX9J/Mf2EG5UyaVjIJZrqJY0p+ciNr/o/ZntfvpoJY8DpgWKoK
	+GMW6D+MjWwo4mC0BPZqvD3lCNmo5vPozysK/kBzswKTXn//SfTiZRYiLY9kFmxE
	WAlQcU1aOJvsDRo1wxBrKMYrfnzow+Fcw//hCS3D1e/TSg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id kQO87Gw9rWrc; Wed, 13 May 2026 22:13:59 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gG75y3wzfz1XM6JP;
	Wed, 13 May 2026 22:13:58 +0000 (UTC)
Message-ID: <e6dbe36b-7bd3-4848-91e1-9c84d421e1ee@acm.org>
Date: Wed, 13 May 2026 15:13:57 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] block/bdev: Annotate the blk_holder_ops callback
 functions
To: Nathan Chancellor <nathan@kernel.org>, Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20260511163100.1887263-1-bvanassche@acm.org>
 <20260511163100.1887263-3-bvanassche@acm.org>
 <CANpmjNNMDY=gB23ejdDYZg5yYduup_iXE1FAWC-fghr2od7Hwg@mail.gmail.com>
 <56a1f905-2348-483b-a79e-5b3ebbd3482d@acm.org>
 <CANpmjNM_rCMzbz88SSmmQU2h0+OvjoyN=VapkBc4OEwF=fRcvA@mail.gmail.com>
 <20260513133614.GA703152@ax162>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260513133614.GA703152@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/26 6:36 AM, Nathan Chancellor wrote:
> While doing a dynamic check is more expensive than a version check, I
> would not worry much about that overhead if the check is worthwhile or
> valuable. In this case, I tend to agree with you that it would just be
> better to bump the minimum version of Clang required for context
> analysis because of the improvements (other than the function pointer
> support) that you have landed in main since release/22.x. While I am
> always sad to see support for older compilers dropped, I don't think
> clang-22 is widespread enough for that to really matter. On the other
> hand, I do worry that if we do not have a wide enough window of
> supported compilers for developers / maintainers to use, we won't be
> able to uncover potential problems to address in the compiler (I feel
> like getting __counted_by deployed was particular painful for this
> reason), if that makes sense.

It seems to me that increasing the required Clang version is the least
controversial approach. If nobody objects I will start testing the patch
below.

Thanks,

Bart.

Subject: [PATCH] lib/Kconfig.debug: Require Clang 23 for context analysis

Context annotations for function pointers will be supported by Clang 23
but are not supported by Clang 22. Bump the minimum required Clang
version in preparation of annotating the blk_holder_ops function pointer
members.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  lib/Kconfig.debug | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8ff5adcfe1e0..5b5d1d183618 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -630,7 +630,7 @@ config DEBUG_FORCE_WEAK_PER_CPU

  config WARN_CONTEXT_ANALYSIS
  	bool "Compiler context-analysis warnings"
-	depends on CC_IS_CLANG && CLANG_VERSION >= 220100
+	depends on CC_IS_CLANG && CLANG_VERSION >= 230000
  	# Branch profiling re-defines "if", which messes with the compiler's
  	# ability to analyze __cond_acquires(..), resulting in false positives.
  	depends on !TRACE_BRANCH_PROFILING
@@ -641,7 +641,7 @@ config WARN_CONTEXT_ANALYSIS
  	  and releasing user-definable "context locks".

  	  Clang's name of the feature is "Thread Safety Analysis". Requires
-	  Clang 22.1.0 or later.
+	  Clang 23.0 or later.

  	  Produces warnings by default. Select CONFIG_WERROR if you wish to
  	  turn these warnings into errors.



